#!/opt/conda/bin/python
from config import FLAGS
from data import get_data_list, MyOwnDataset
from data import update_save_dir, update_save_dir_with_additional_str, update_gexf_folder_files
import data
from data_src_code import update_tokenizer
from dse import ExhaustiveExplorer
from train import train_main
from test import inference
from adapt import adapt_main
from saver import saver
from utils import OurTimer, load_replace_flags, get_root_path, slack_notify
# from rl import rl_main
import os
import os.path as osp
from utils import get_root_path, load
from os.path import join, basename

import torch, numpy as np, random
import traceback

if FLAGS.fix_randomness:
    saver.log_info('Critical! Fix random seed for torch and numpy')
    torch.manual_seed(FLAGS.random_seed)
    np.random.seed(FLAGS.random_seed)
    random.seed(FLAGS.random_seed)

    torch.backends.cudnn.deterministic = True
    torch.backends.cudnn.benchmark = False

    torch.cuda.manual_seed(FLAGS.random_seed)

from torch import softmax

import config

TARGETS = config.TARGETS
MACHSUITE_KERNEL = config.MACHSUITE_KERNEL
poly_KERNEL = config.poly_KERNEL


class HandleNodeAttention(object):
    def __call__(self, data):
        data.attn = softmax(data.x[:, 0], dim=0)
        data.x = data.x[:, 1:]
        return data


timer = OurTimer()


def main():
    if FLAGS.model == 'tfdse':
        from tfdse import main
        main()
        saver.log_info(f'Total time: {timer.time_and_clear()}')
        saver.close()
        exit()
    # from data import get_data_list, MyOwnDataset


    # path = osp.join(osp.dirname(osp.realpath(__file__)), '..', 'data', 'COLORS-3')
    # # dataset = TUDataset(path, 'COLORS-3', use_node_attr=True,
    # #                     transform=HandleNodeAttention())
    #
    # MACHSUITE_KERNEL = ['stencil', 'gemm-ncubed', 'nw', 'stencil', 'gemm-blocked', 'aes', 'spmv-crs', 'spmv-ellpack'
    #                     ]
    # POLLY_KERNEL = ['3mm', 'jacobi-1d', 'fdtd-2d', 'gemver', 'gemm-p', 'mvt', 'atax', 'doitgen', 'bicg', 'gesummv',
    #                 '2mm']  # , 'mvt'] # skipped 2mm

    # class HandleNodeAttention(object):
    #     def __call__(self, data):
    #         data.attn = torch.softmax(data.x[:, 0], dim=0)
    #         data.x = data.x[:, 1:]
    #         return data

    if FLAGS.load_model != 'None':
        # if FLAGS.atefeh_model:
        #     saver.log_info(f'Critical!!!!! Skipping flag loading!')
        # else:
        # assert FLAGS.subtask != 'train'
        saver.log_info(f'Loading model\'s config/FLAGS: {FLAGS.load_model}')
        load_replace_flags(FLAGS)
        saver.log_new_FLAGS_to_model_info()
        update_save_dir(FLAGS)
        update_gexf_folder_files()
        update_tokenizer()
        print(basename(saver.logdir))
        # pragma_dim_before = pragma_dim
        # pragma_dim = load(join(programl_data.SAVE_DIR, 'pragma_dim')) # tricky; need to update this variable too
        # saver.log_info(f'pragma_dim before: {pragma_dim_before}; pragma_dim now: {pragma_dim}')

    pragma_dim = None

    # # TODO: just debugging
    # from src_code_modeling import create_code_encoder
    # from utils import estimate_model_size
    # bert_model, _ = create_code_encoder()
    # saver.log_info('Created bert_model')
    # saver.log_info(estimate_model_size(bert_model, f'bert_model {FLAGS.code_encoder}'))
    # exit()

    if not FLAGS.force_regen:
        dataset = MyOwnDataset()
        pragma_dim = load(join(data.SAVE_DIR, 'pragma_dim'))
        print('read dataset')
    else:
        if FLAGS.sample_finetune:
            from sample_finetune import sample_data_list
            dataset = sample_data_list()
        else:
            # pragma_dim = 0
            dataset, pragma_dim = get_data_list()
    saver.log_info(f'pragma_dim: {pragma_dim}')

    if len(dataset) == 0:
        raise ValueError('Empty dataset! Check config.py; Maybe use force_regen')
    saver.log_info(f'Dataset contains {len(dataset)} designs ')

    

    try:
        saver.log_info(f'dataset[0].num_features={dataset[0].num_features}')
    except AttributeError as e:
        saver.log_info(f'AttributeError: {e}\nTry appending _scai')
        if '1' in FLAGS.hostname:
            h = 'scai1'
        elif '2' in FLAGS.hostname or '3' in FLAGS.hostname or '4' in FLAGS.hostname:
            h = 'scai2_3'
        else:
            raise NotImplementedError()
        update_save_dir_with_additional_str(h)
        dataset = MyOwnDataset()
        pragma_dim = load(join(data.SAVE_DIR, 'pragma_dim'))
        print('read dataset')
        try:
            saver.log_info(f'dataset[0].num_features={dataset[0].num_features}')
        except AttributeError as e:
            saver.log_info(f'AttributeError: {e}\nForce regenerate')
            setattr(FLAGS, 'force_regen', True)
            dataset, pragma_dim = get_data_list()

    if 'train' in FLAGS.subtask:
        train_main(dataset, pragma_dim)

    adapt_eval_dict = None
    if 'inference' in FLAGS.subtask:
        if FLAGS.adaptation_needed:
            adapt_eval_dict = adapt_main(dataset, pragma_dim)
        if 'dse' not in FLAGS.subtask:
            inference(dataset, pragma_dim)

    if 'dse' in FLAGS.subtask:
        if FLAGS.dataset == 'programl' or True:
            first_dse = True
            graph_types = [FLAGS.graph_type]

            # for dataset_str in ['machsuite', 'poly']:
            #     path = join(get_root_path(), 'dse_database', dataset_str, 'config')
            #     if dataset_str == 'machsuite':
            #         KERNELS = MACHSUITE_KERNEL
            #     elif dataset_str == 'poly':
            #         KERNELS = poly_KERNEL
            #     else:
            #         raise NotImplementedError()
            #     # kernel = "gemm-blocked"

            point = {'__PARA__L0': 2, '__PIPE__L0': 'off', '__TILE__L0': 1, '__PARA__L4': 32, \
                     '__PARA__L1': 1, '__PIPE__L1': 'flatten', '__TILE__L1': 1, '__PARA__L5': 1, '__PARA__L2': 1, \
                     '__PARA__L3': 8, '__PIPE__L3': '', '__TILE__L3': 1, '__PARA__L6': 16}
            # for kernel in MACHSUITE_KERNEL:
            KERNELS = poly_KERNEL + MACHSUITE_KERNEL 

            if hasattr(FLAGS, 'test_kernels') and FLAGS.test_kernels is not None:
                KERNELS = FLAGS.test_kernels
            KERNELS = KERNELS[FLAGS.dse_start_idx:FLAGS.dse_end_idx]
            saver.log_info(f'Doing dse for {len(KERNELS)} kernels: {KERNELS}')
            for kernel in KERNELS:
                if not FLAGS.all_kernels and not FLAGS.target_kernel in kernel:
                    continue
                # plot_data = {}
                for graph_type in graph_types:
                    saver.info('*****************************************************************')
                    saver.info(f'Now processing {graph_type}')
                    saver.info('#################################################################')
                    saver.info(f'Starting DSE for {kernel}')
                    saver.debug(f'Starting DSE for {kernel}')
                    FLAGS.target_kernel = kernel
                    if FLAGS.explorer == 'exhaustive':
                        explorer = ExhaustiveExplorer(dataset, kernel, first_dse=first_dse, prune_invalid = False,
                                                      point=point, pragma_dim=pragma_dim, adapt_eval_dict=adapt_eval_dict, harp_only=FLAGS.harp_only,
            #                                          input_pickle = f"logs/dse_2024-01-21T15-05-42.202284_regression_scai5/{kernel}.pickle",
                                                      input_pickle = f"dse_candidates/{kernel}.pickle",
                                                      )
                        # if FLAGS.plot_dse: plot_data[graph_type] = explorer.plot_data
                    else:
                        raise NotImplementedError()
                    saver.info('#################################################################')
                    saver.info(f'')
                    first_dse = False
    # else:
    #     train_main(dataset, pragma_dim)


if __name__ == '__main__':

    timer = OurTimer()

    try:
        main()
        status = 'Complete'
    except:
        traceback.print_exc()
        s = '\n'.join(traceback.format_exc(limit=-1).split('\n')[1:])
        saver.log_info(traceback.format_exc(), silent=True)
        saver.save_exception_msg(traceback.format_exc())
        status = 'Error'

    tot_time = timer.time_and_clear()
    saver.log_info(f'Total time: {tot_time}')
    saver.close()
#    if 'scai' in FLAGS.hostname.lower():
#        slack_notify(f'{FLAGS.user} at {FLAGS.hostname}: {status} {basename(saver.get_log_dir())} after {tot_time}')
