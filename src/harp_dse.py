from config import FLAGS
from glob import glob, iglob
from utils import get_src_path,  _get_y_with_target, load
from os.path import join, basename, dirname
import shutil
from harp_model import Net as HARP_Net
import torch
from result import Result
from parameter import DesignPoint
from typing import Deque, Dict, List, Optional, Set, Union, Generator, Any

from math import ceil, inf, exp, log2
import math

from data_programl import _encode_edge_dict, _encode_edge_torch, _encode_X_torch, _encode_X_dict


class HARPGNNModel():
    def __init__(self, path, saver, first_dse = False, multi_target = True, task = 'regression', num_layers = FLAGS.num_layers, D = FLAGS.D, target = FLAGS.target, model_path = None, model_id = 0, model_name = f'{FLAGS.model_tag}_model_state_dict.pth', encoder_name = 'encoders', pragma_dim = None):
        """
        >>> self.encoder.keys()
        dict_keys(['enc_ntype', 'enc_ptype', 'enc_itype', 'enc_ftype', 'enc_btype', 'enc_ftype_edge', 'enc_ptype_edge'])

        """
        ## up3 regression and up class
        if task == 'class': model_name = 'model_state_dict.pth' # layer: 8, D: 128, up-True
        elif task == 'regression_perf': model_name = f'perf_{{FLAGS.model_tag}}_model_state_dict.pth' ## layer:8, D:64, up3-false

        # if task == 'class': model_name = 'DAC-Trans-JKN-node-att-train_model_state_dict.pth' # layer: 6, D: 64, up4-True
        # elif task == 'regression': model_name = 'Trans-JKN-node-att-train_model_state_dict.pth' # layer: 8, D: 64, up4-False
        self.log = saver
        self.path = path
        self.path = path
        #assert task == 'class'
        """
        if 'hierarchy' in FLAGS.graph_type:
            base_path = 'logs/auto-encoder/hierarchy/**'
        elif 'connected' in FLAGS.graph_type:
            base_path = 'logs/auto-encoder/extended-graph-db/**'
        else:
            base_path = 'logs/auto-encoder/all-data-sepPT/**'    
        model = [f for f in iglob(join(get_src_path(), base_path), recursive=True) if f.endswith('.pth') and 'val' in f and f'gae-T-{FLAGS.gae_T}-gae-P-{FLAGS.gae_P}' in f and task in f and 'dse' not in f and f'SSL-{FLAGS.SSL}' in f and 'norm' in f and 'attr-True' in f and 'wrong' not in f and f'{num_layers}L' in f and 'range' not in f and 'round8' in f and 'sepPTB-' in f and f'position-{FLAGS.encode_edge_position}' in f and 'epoch10' not in f] # and 'fine-tune' in f and (FLAGS.all_kernels or FLAGS.target_kernel in f)
        if model_path:
            if type(model_path) is list:
                self.model_path = model_path[0]
            else:
                self.model_path = model_path
        else:
            if task == 'regression':
                if FLAGS.sample_finetune:
                    # model = [f for f in iglob(join(get_src_path(), 'logs/dac/spread-ds/**'), recursive=True) if f.endswith('.pth') and FLAGS.target_kernel in f and 'BRAM' not in f]
                    # model = ['/share/atefehSZ/RL/original-software-gnn/software-gnn/save/programl/with-updated-up4-tile-regression_with-invalid_False-normalization_speedup-log2_no_pragma_False_tag_whole-machsuite-poly_perfutil-DSPutil-BRAMutil-LUTutil-FF/Trans-JKN-node-att-train_model_state_dict.pth']
                    ## FPGA'22
                    model = ['/share/atefehSZ/RL/original-software-gnn/software-gnn//save/programl/with-updated-up3-tile-regression_with-invalid_False-normalization_speedup-log2_no_pragma_False_tag_whole-machsuite-poly_perfutil-DSPutil-BRAMutil-LUTutil-FF/test_model_state_dict.pth']
                    assert len(model) == 1
                    self.model_path = model[0]
                else:
                    if FLAGS.model_path == None:
                        print(model, FLAGS.gae_T, task, FLAGS.target_kernel)
                        assert len(model) == 1
                        self.model_path = model[0]
                        # self.model_path = join(self.path, model_name)
                    else:
                        if type(FLAGS.model_path) is list:
                            self.model_path = FLAGS.model_path[0]
                        else:
                            self.model_path = FLAGS.model_path
            else:
                if FLAGS.class_model_path == None:
                    # model = [f for f in iglob(join(get_src_path(), base_path), recursive=True) if f.endswith('.pth') and 'val' in f and f'gae-{FLAGS.gae_T}' in f and task in f and 'dse' not in f] 
                    assert len(model) == 1
                    self.model_path = model[0]
                    # self.model_path = join(self.path, model_name)
                else:
                    self.model_path = FLAGS.class_model_path
        """
        if task == 'class':
            self.model_path = '../models/class_val_42kernel_45k_90percent_scratch_2lp-2lm.pth'
            self.encoder_path = '../models/pragma_as_MLP-encoders.klepto'
        else: #task is regression
            #self.model_path = '../models/regression_val_42kernel_11k_95percent_v20pretrained_2lp-2lm.pth'
            self.model_path =  '../models/regression_val_42kernel_11k_95percent_scratch_2lp-2lm.pth'
            self.encoder_path = '../models/regression-pragma_as_MLP-encoders.klepto-0.klepto'
            
        #if FLAGS.encoder_path == None:
        #self.encoder_path = join(self.path, encoder_name)
        #else:
        #self.encoder_path = FLAGS.encoder_path

        print(self.model_path)
        shutil.copy(self.model_path, join(saver.logdir, f'{task}-{basename(self.model_path)}-{model_id}'))
        shutil.copy(f'{self.encoder_path}', join(saver.logdir, f'{task}-{basename(self.encoder_path)}-{model_id}.klepto'))

        self.num_features = 153 # FLAGS.num_features # 124
        self.model = HARP_Net(in_channels = self.num_features, edge_dim = 335, init_pragma_dict=pragma_dim, task = task, num_layers = num_layers, D = D, target = target).to(FLAGS.device)
        if first_dse:
            saver.log_model_architecture(self.model)

        self.model.load_state_dict(torch.load(join(self.model_path), map_location=torch.device('cpu')), strict=True)
        saver.info(f'loaded {self.model_path}')
        self.encoder = load(self.encoder_path)

          
    
    def encode_node(self, g, point: DesignPoint): ## prograML graph
        node_dict = _encode_X_dict(g, point=point)
        required_keys = ['X_contextnids', 'X_pragmanids', 'X_pseudonids', 'X_icmpnids', 'X_pragmascopenids', 'X_pragma_per_node']
        
        enc_ntype = self.encoder['enc_ntype']
        enc_ptype = self.encoder['enc_ptype']
        enc_itype = self.encoder['enc_itype']
        enc_ftype = self.encoder['enc_ftype']
        enc_btype = self.encoder['enc_btype']
        
        return _encode_X_torch(node_dict, enc_ntype, enc_ptype, enc_itype, enc_ftype, enc_btype), \
            {k: node_dict[k] for k in required_keys}
        
        
    def encode_edge(self, g):
        edge_dict = _encode_edge_dict(g)
        enc_ptype_edge = self.encoder['enc_ptype_edge']
        enc_ftype_edge = self.encoder['enc_ftype_edge']
        #print(self.encoder['enc_ptype_edge'])
        #print(self.encoder['enc_ftype_edge'])
        #print(len(self.encoder['enc_ptype_edge'].categories_[0]))
        #print(len(self.encoder['enc_ftype_edge'].categories_[0]))
        
        return _encode_edge_torch(edge_dict, enc_ftype_edge, enc_ptype_edge)
    
    def perf_as_quality(self, new_result: Result) -> float:
        """Compute the quality of the point by (1 / latency).

        Args:
            new_result: The new result to be qualified.

        Returns:
            The quality value. Larger the better.
        """
        return 1.0 / new_result.perf

    def finte_diff_as_quality(self, new_result: Result, ref_result: Result) -> float:
        """Compute the quality of the point by finite difference method.

        Args:
            new_result: The new result to be qualified.
            ref_result: The reference result.

        Returns:
            The quality value (negative finite differnece). Larger the better.
        """

        def quantify_util(result: Result) -> float:
            """Quantify the resource utilization to a float number.

            util' = 5 * ceil(util / 5) for each util,
            area = sum(2^1(1/(1-util))) for each util'

            Args:
                result: The evaluation result.

            Returns:
                The quantified area value with the range (2*N) to infinite,
                where N is # of resources.
            """

            # Reduce the sensitivity to (100 / 5) = 20 intervals
            utils = [
                5 * ceil(u * 100 / 5) / 100 for k, u in result.res_util.items()
                if k.startswith('util')
            ]

            # Compute the area
            return sum([2.0**(1.0 / (1.0 - u)) for u in utils])

        ref_util = quantify_util(ref_result)
        new_util = quantify_util(new_result)

        if (new_result.perf / ref_result.perf) > 1.05:
            # Performance is too worse to be considered
            return -float('inf')

        if new_util == ref_util:
            if new_result.perf < ref_result.perf:
                # Free lunch
                return float('inf')
            # Same util but slightly worse performance, neutral
            return 0

        return -(new_result.perf - ref_result.perf) / (new_util - ref_util)

    def eff_as_quality(self, new_result: Result, ref_result: Result) -> float:
        """Compute the quality of the point by resource efficiency.

        Args:
            new_result: The new result to be qualified.
            ref_result: The reference result.

        Returns:
            The quality value (negative finite differnece). Larger the better.
        """
        if (new_result.perf / ref_result.perf) > 1.05:
            # Performance is too worse to be considered
            return -float('inf')

        area = sum([u for k, u in new_result.res_util.items() if k.startswith('util')])

        return 1 / (new_result.perf * area)
    
    def test(self, loader, config, mode = 'regression'):
        self.model.eval()

        i = 0
        results: List[Result] = []
        target_list = FLAGS.target
        if not isinstance(FLAGS.target, list):
            target_list = [FLAGS.target]

        for data in loader:
            data = data.to(FLAGS.device)
            out_dict, loss, loss_dict, _ = self.model(data)
            
            if mode == 'regression':
                for i in range(len(out_dict['perf'])):
                    curr_result = Result()
                    curr_result.point = data[i].point
                    for target_name in target_list:
                        out = out_dict[target_name]
                        out_value = out[i].item()
                        if target_name == 'perf':
                            curr_result.perf = out_value
                            if FLAGS.encode_log:
                                curr_result.actual_perf = 2**out_value
                            else:
                                curr_result.actual_perf = out_value
                        elif target_name in curr_result.res_util.keys():
                            curr_result.res_util[target_name] = out_value
                        else:
                            raise NotImplementedError()
                    curr_result.quality = self.perf_as_quality(curr_result)
                    
                    # prune if over-utilizes the board
                    max_utils = config['max-util']
                    utils = {k[5:]: max(0.0, u) for k, u in curr_result.res_util.items() if k.startswith('util-')}
                    # utils['util-LUT'] = 0.0
                    # utils['util-FF'] = 0.0
                    # utils['util-BRAM'] = 0.0
                    if FLAGS.prune_util:
                        curr_result.valid = all([(utils[res] / FLAGS.util_normalizer )< max_utils[res] for res in max_utils])
                        # curr_result.valid = all([(utils[res] / FLAGS.util_normalizer )< 0.74 for res in max_utils])
                    else:
                        curr_result.valid = True
                    results.append(curr_result)
            elif mode == 'class':
                _, pred = torch.max(out_dict['perf'], 1)
                labels = _get_y_with_target(data, 'perf') 
                return (pred == labels)
            else:
                raise NotImplementedError()
                    

        return results
  
  
