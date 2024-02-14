from config import FLAGS
from saver import saver
from utils import load, get_root_path, get_src_path, _get_y_with_target, create_edge_index
from data import SAVE_DIR, read_gexf_file, encode_node_edge_dict, encode_X_torch, GEXF_FILES, create_dataloader
from model_factory import create_model
from parameter import DesignSpace, DesignPoint, get_default_point, topo_sort_param_ids, \
    compile_design_space, gen_key_from_design_point
from config_ds import build_config
from result import Result

import json
import os
from math import ceil, inf
from os.path import join, basename, dirname

import time
import torch
from torch_geometric.data import Data, DataLoader
from typing import Dict, List, Optional, Union, Generator, Any
import sys
import networkx as nx
from collections import OrderedDict
from glob import glob, iglob
import pickle
import shutil
import numpy as np
from harp_dse import HARPGNNModel
from database import create_database


class GNNModel():
    def __init__(self, dataset, path, first_dse=False, task='regression', pragma_dim=None, adapt_eval_dict=None,
                 kernel_name=None):

        self.log = saver
        self.path = path

        if task == 'regression':
            self.model_path = FLAGS.load_model
        else:
            self.model_path = FLAGS.class_model_path

        if adapt_eval_dict is not None:
            adapted_models = adapt_eval_dict.get('adapted_models_dict').get(kernel_name)
            if adapted_models is None:
                raise RuntimeError(
                    f'No adapted models in a non-None adapt_eval_dict for kernel {kernel_name}: {adapt_eval_dict}')

            chosen_model = adapted_models[0]  # TODO

            self.model = chosen_model
            saver.info(f'Chosen model from {len(adapted_models)} adapted models in adapt_eval_dict')
        else:

            self.model = create_model(dataset, pragma_dim)
            if first_dse:
                saver.log_model_architecture(self.model)

            # self.model.load_state_dict(torch.load(join(self.model_path), map_location=torch.device('cpu')))

            self.model, loaded_model_info = saver.load_trained_model(self.model_path, self.model)
            self.model.to(FLAGS.device)
            saver.info(f'Loaded from {self.model_path}; loaded_model_info:{loaded_model_info}')
        # self.encoder = load(self.encoder_path)
        self.encoder, self.preprocessors = dataset.encoders, dataset.preprocessors

    # def encode_node(self, g, point: DesignPoint):  ## prograML graph
    #     node_dict = _encode_X_dict(g, point=point)
    #     required_keys = ['X_contextnids', 'X_pragmanids', 'X_pseudonids', 'X_icmpnids', 'X_pragmascopenids',
    #                      'X_pragma_per_node']
    #
    #     enc_ntype = self.encoder['enc_ntype']
    #     enc_ptype = self.encoder['enc_ptype']
    #     enc_itype = self.encoder['enc_itype']
    #     enc_ftype = self.encoder['enc_ftype']
    #     enc_btype = self.encoder['enc_btype']
    #
    #     return _encode_X_torch(node_dict, enc_ntype, enc_ptype, enc_itype, enc_ftype, enc_btype), \
    #            {k: node_dict[k] for k in required_keys}
    #
    # def encode_edge(self, g):
    #     edge_dict = _encode_edge_dict(g)
    #     enc_ptype_edge = self.encoder['enc_ptype_edge']
    #     enc_ftype_edge = self.encoder['enc_ftype_edge']
    #
    #     return _encode_edge_torch(edge_dict, enc_ftype_edge, enc_ptype_edge)

    def perf_as_quality(self, new_result: Result) -> float:
        """Compute the quality of the point by (1 / latency).

        Args:
            new_result: The new result to be qualified.

        Returns:
            The quality value. Larger the better.
        """
        return 1.0 / new_result.perf

    def test(self, loader, data_list, config, mode='regression'):
        self.model.eval()

        i = 0
        results: List[Result] = []
        target_list = FLAGS.target
        if not isinstance(FLAGS.target, list):
            target_list = [FLAGS.target]

        for data in loader:
            data = data.to(FLAGS.device)
            with torch.no_grad():
                out_dict, loss, loss_dict_, _ = self.model(data, forward_pairwise=False, tvt='test', iter=-1,
                                                           test_name='')

            if mode == 'regression':
                for i in range(len(out_dict['perf'])):
                    curr_result = Result()
                    curr_result.point = data_list[i].point
                    for target_name in target_list:
                        out = out_dict[target_name]
                        out_value = out[i].item()
                        if target_name == 'perf':
                            curr_result.perf = out_value
                            if FLAGS.encode_log:
                                curr_result.actual_perf = 2 ** out_value
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
                        curr_result.valid = all(
                            [(utils[res] / FLAGS.util_normalizer) < max_utils[res] for res in max_utils])
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


class Explorer():
    def __init__(self, dataset, kernel_name: str, first_dse: bool = False,
                 prune_invalid=False, pragma_dim=None, adapt_eval_dict=None, harp_only=False):
        """Constructor.

        Args:
            ds: DesignSpace
        """
        self.log = saver
        self.kernel_name = kernel_name
        self.harp_only = harp_only

        config_path = None
        for dataset_str in ['machsuite', 'poly']:
            path_kernel = join(get_root_path(), 'dse_database', dataset_str, 'config')
            cp = join(path_kernel, f'{kernel_name}_ds_config.json')
            print(cp)
            if os.path.exists(cp):
                if config_path is None:
                    config_path = cp
                else:
                    raise RuntimeError(f'Duplicate config paths for kernel {kernel_name}: {config_path} and {cp}')

        self.config_path = config_path
        self.config = self.load_config()

        # self.timeout = self.config['timeout']['exploration']
        # self.timeout = float(inf)
        self.timeout = 30 * 60
        self.hls_timeout = 40
        self.ds, self.ds_size = compile_design_space(
            self.config['design-space']['definition'],
            None,
            self.log)

        self.batch_size = 1
        # Status checking
        self.num_top_designs = 10
        self.key_perf_dict = OrderedDict()
        self.best_results_dict = {}
        self.best_result: Result = Result()
        self.explored_point = 0
        self.ordered_pids = self.topo_sort_param_ids(self.ds)
        self.ensemble_GNNmodels = []  ## list of GNN models for regression. if ensemble is not used, only has one entry
        # self.ordered_pids = FLAGS.ordered_pids

        if harp_only == False:
            self.GNNmodel = GNNModel(dataset, SAVE_DIR, first_dse=first_dse, task='regression', pragma_dim=pragma_dim,
                                 adapt_eval_dict=adapt_eval_dict, kernel_name=kernel_name)
        else:
            self.GNNmodel = HARPGNNModel(SAVE_DIR, self.log, multi_target=True, task='regression', num_layers = 6, D = 64, pragma_dim = pragma_dim)
        self.dataset = dataset
        self.ensemble_GNNmodels.append(self.GNNmodel)

        found_file = None
        for gexf_file in GEXF_FILES:
            bn = basename(gexf_file)
            if '_processed_result' in bn:#, f'bn={bn}\ngexf_file={gexf_file}'
                kn = bn.split('_processed_result')[0]
            else:
                assert '.gexf' in bn
                kn = bn.split('.gexf')[0]
            if kn == 'stencil_stencil2d':
                kn = 'stencil'
            if kernel_name == kn:
                if found_file is None:
                    found_file = gexf_file
                else:
                    raise RuntimeError(
                        f'Already found file {found_file} but another file {gexf_file} -- check {kernel_name}')

        print(found_file)
        self.graph_path = found_file
        saver.info(f'graph path {self.graph_path}')
        self.graph = read_gexf_file(self.graph_path)
        self.class_graph = nx.read_gexf(self.graph_path)

        ## for ploting one of the objectives (all points)
        self.plot_data = {k: [] for k in FLAGS.target}

        self.prune_invalid = prune_invalid
        if self.prune_invalid:
            #raise NotImplementedError()
            ## FPGA'22
            # self.GNNmodel_valid = GNNModel(SAVE_DIR_CLASS, self.log, multi_target=False, task='class', num_layers = 8, D = 128)
            ## DAC'22
            ###TODO change SAVE_DIR to the path to encoders
            ###TODO load pragma dim from saved file: if FLAGS.v_db == 'v21': pragma_dim = load(join(dirname(FLAGS.encoder_path), 'v21_pragma_dim'))
            self.GNNmodel_valid = HARPGNNModel(SAVE_DIR, self.log, multi_target=False, task='class', num_layers = 6, D = 64, pragma_dim = pragma_dim)  # 6, 64
            #### prev class config ####
            # self.GNNmodel_valid = GNNModel(SAVE_DIR_CLASS, self.log, multi_target=False, task='class', num_layers = 8, D = 64)

    def load_config(self) -> Dict[str, Any]:
        """Load the DSE configurations.

        Returns:
            A dictionary of configurations.
        """

        try:
            if not os.path.exists(self.config_path):
                self.log.error(('Config JSON file not found: %s', self.config_path))
                raise RuntimeError()

            self.log.info('Loading configurations')
            with open(self.config_path, 'r', errors='replace') as filep:
                try:
                    user_config = json.load(filep)
                except ValueError as err:
                    self.log.error(('Failed to load config: %s', str(err)))
                    raise RuntimeError()

            config = build_config(user_config, self.log)
            if config is None:
                self.log.error(('Config %s is invalid', self.config_path))
                raise RuntimeError()
        except RuntimeError:
            sys.exit(1)

        return config

    def get_pragmas(self, point: DesignPoint) -> List[int]:
        pragmas = []
        for _, value in sorted(point.items()):
            if type(value) is str:
                if value.lower() == 'flatten':
                    value = 100  # 2
                elif value.lower() == 'off':
                    value = 1
                elif value.lower() == '':
                    value = 50  # 3
                else:
                    print(value)
                    raise ValueError()
            elif type(value) is int:
                pass
            else:
                raise ValueError()
            pragmas.append(value)
        return pragmas
    
    def apply_design_point_harp(self, g, point: DesignPoint, mode = 'regression', model=None) -> Data:
        if model is None: 
            if self.harp_only:
                model = self.GNNmodel
            else:
                model = self.GNNmodel_valid

        X, d_node = model.encode_node(g, point)
        edge_attr = model.encode_edge(g)
        
        g = nx.convert_node_labels_to_integers(g, ordering='sorted')
        edge_index = torch.LongTensor(list(g.edges)).t().contiguous() # critical tn ensure g.edges ordering agrees with edge_attr generation code
        pragmas = self.get_pragmas(point)
        if FLAGS.separate_T and FLAGS.pragma_uniform_encoder:
            pragmas.extend([0] * (self.max_pragma_length - len(pragmas)))

        # d_node = dict()
        resources = ['BRAM', 'DSP', 'LUT', 'FF']
        keys = ['perf', 'actual_perf', 'quality']
        d_node['pragmas'] = torch.FloatTensor(np.array([pragmas]))
        # d_node['X_contextnids'] = X_contextnids
        # d_node['X_pragmanids'] = X_pragmanids
        # d_node['X_pseudonids'] = X_pseudonids
        # d_node['X_icmpnids'] = X_icmpnids
        for r in resources:
            keys.append('util-' + r)
            keys.append('total-' + r)
        for key in keys:
            d_node[key] = 0
        if mode == 'class': ## default: point is valid
            d_node['perf'] = 1
        
        if 'regression' in mode:
            data = Data(
                X_contextnids=d_node['X_contextnids'],
                X_pragmanids=d_node['X_pragmanids'],                    
                X_pragmascopenids=d_node['X_pragmascopenids'],                    
                X_pseudonids=d_node['X_pseudonids'],    
                X_icmpnids=d_node['X_icmpnids'],    
                X_pragma_per_node=d_node['X_pragma_per_node'],                   
                x=X,
                edge_index=edge_index,
                pragmas=d_node['pragmas'],
                perf=d_node['perf'],
                actual_perf=d_node['actual_perf'],
                quality=d_node['quality'],
                util_BRAM=d_node['util-BRAM'],
                util_DSP=d_node['util-DSP'],
                util_LUT=d_node['util-LUT'],
                util_FF=d_node['util-FF'],
                total_BRAM=d_node['total-BRAM'],
                total_DSP=d_node['total-DSP'],
                total_LUT=d_node['total-LUT'],
                total_FF=d_node['total-FF'],
                point=point,
                edge_attr=edge_attr
            )
        elif 'class' in mode:
            data = Data(
                x=X,
                edge_index=edge_index,
                pragmas=d_node['pragmas'],
                perf=d_node['perf'],
                edge_attr=edge_attr,
                point=point,
                X_contextnids=d_node['X_contextnids'],
                X_pragmanids=d_node['X_pragmanids'],                    
                X_pragmascopenids=d_node['X_pragmascopenids'],                    
                X_pseudonids=d_node['X_pseudonids'],    
                X_icmpnids=d_node['X_icmpnids'],    
                X_pragma_per_node=d_node['X_pragma_per_node']
            )
        else:
            raise NotImplementedError()
        
        return data

    def apply_design_point(self, g, point: DesignPoint, mode='regression') -> Data:
        d_node, edge_dict = encode_node_edge_dict(g, self.dataset.preprocessors, point)

        # X, d_node = model.encode_node(g, point)
        # edge_attr = model.encode_edge(g)
        # edge_index = create_edge_index(g)
        pragmas = self.get_pragmas(point)

        # d_node = dict()
        resources = ['BRAM', 'DSP', 'LUT', 'FF']
        keys = ['perf', 'actual_perf', 'quality']
        d_node['pragmas'] = torch.FloatTensor(np.array([pragmas]))

        d_node['kernel_speedup'] = torch.FloatTensor(np.array([-1]))  # unknown

        # d_node['X_contextnids'] = X_contextnids
        # d_node['X_pragmanids'] = X_pragmanids
        # d_node['X_pseudonids'] = X_pseudonids
        # d_node['X_icmpnids'] = X_icmpnids
        for r in resources:
            keys.append('util-' + r)
            keys.append('total-' + r)
        for key in keys:
            d_node[key] = 0
        if mode == 'class':  ## default: point is valid
            d_node['perf'] = 1

        d_node['point'] = point
        data = encode_X_torch(g, d_node, edge_dict, self.dataset.preprocessors, '', '')
        # if 'regression' in mode:
        #     data = Data(
        #         X_contextnids=d_node['X_contextnids'],
        #         X_pragmanids=d_node['X_pragmanids'],
        #         X_pragmascopenids=d_node['X_pragmascopenids'],
        #         X_pseudonids=d_node['X_pseudonids'],
        #         X_icmpnids=d_node['X_icmpnids'],
        #         X_pragma_per_node=d_node['X_pragma_per_node'],
        #         x=X,
        #         edge_index=edge_index,
        #         pragmas=d_node['pragmas'],
        #         perf=d_node['perf'],
        #         actual_perf=d_node['actual_perf'],
        #         quality=d_node['quality'],
        #         util_BRAM=d_node['util-BRAM'],
        #         util_DSP=d_node['util-DSP'],
        #         util_LUT=d_node['util-LUT'],
        #         util_FF=d_node['util-FF'],
        #         total_BRAM=d_node['total-BRAM'],
        #         total_DSP=d_node['total-DSP'],
        #         total_LUT=d_node['total-LUT'],
        #         total_FF=d_node['total-FF'],
        #         point=point,
        #         edge_attr=edge_attr
        #     )
        # elif 'class' in mode:
        #     data = Data(
        #         x=X,
        #         edge_index=edge_index,
        #         pragmas=d_node['pragmas'],
        #         perf=d_node['perf'],
        #         edge_attr=edge_attr,
        #         point=point,
        #         X_contextnids=d_node['X_contextnids'],
        #         X_pragmanids=d_node['X_pragmanids'],
        #         X_pragmascopenids=d_node['X_pragmascopenids'],
        #         X_pseudonids=d_node['X_pseudonids'],
        #         X_icmpnids=d_node['X_icmpnids'],
        #         X_pragma_per_node=d_node['X_pragma_per_node']
        #     )
        # else:
        #     raise NotImplementedError()
        data.point = point
        return data

    def update_best(self, result: Result) -> None:
        """Keep tracking the best result found in this explorer.

        Args:
            result: The new result to be checked.

        """
        # if result.valid and result.quality > self.best_result.quality:
        if 'speedup' in FLAGS.norm_method:
            REF = min
        else:
            REF = max
        if self.key_perf_dict and len(self.key_perf_dict) >= self.num_top_designs:
            key_refs_perf = REF(self.key_perf_dict, key=(lambda key: self.key_perf_dict[key]))
            refs_perf = self.key_perf_dict[key_refs_perf]
        else:
            if REF == min:
                refs_perf = float(-inf)
            else:
                refs_perf = float(inf)
        point_key = gen_key_from_design_point(result.point)
        updated = False
        if point_key not in self.key_perf_dict and result.valid and REF(result.perf,
                                                                        refs_perf) != result.perf:  # if the new result is better than the references designs
            ## use the below condition when all the perf numbers are the same, such as for aes
            # if result.valid and (REF(result.perf, refs_perf) != result.perf or refs_perf == result.perf): # if the new result is better than the references designs
            # if result.valid and (not self.key_perf_dict or self.key_perf_dict[max(self.key_perf_dict, key=(lambda key: self.key_perf_dict[key]))] < result.perf): # if the new result is better than the references designs
            self.best_result = result
            self.log.info(('Found a better result at {}: Quality {:.1e}, Perf {:.1e}'.format(
                self.explored_point, result.quality, result.perf)))
            if len(self.key_perf_dict.keys()) >= self.num_top_designs:
                ## replace maxmimum performance value
                key_refs_perf = REF(self.key_perf_dict, key=(lambda key: self.key_perf_dict[key]))
                self.best_results_dict.pop((self.key_perf_dict[key_refs_perf], key_refs_perf))
                self.key_perf_dict.pop(key_refs_perf)

            attrs = vars(result)
            self.log.info(', '.join("%s: %s" % item for item in attrs.items()))

            self.key_perf_dict[point_key] = result.perf
            self.best_results_dict[(result.perf, point_key)] = result
            updated = True

        if self.key_perf_dict.values():
            reward = REF([-p for p in self.key_perf_dict.values()])
            return reward, updated
        else:
            return 0, updated

    def gen_options(self, point: DesignPoint, pid: str, default=False) -> List[Union[int, str]]:
        """Evaluate available options of the target design parameter.

        Args:
            point: The current design point.
            pid: The target design parameter ID.

        Returns:
            A list of available options.
        """
        if default:
            dep_values = {dep: point[dep].default for dep in self.ds[pid].deps}
        else:
            dep_values = {dep: point[dep] for dep in self.ds[pid].deps}
        options = eval(self.ds[pid].option_expr, dep_values)
        if options is None:
            self.log.error(f'Failed to evaluate {self.ds[pid].option_expr} with dep {str(dep_values)}')
            print('Error: failed to manipulate design points')
            sys.exit(1)

        return options

    def get_order(self, point: DesignPoint, pid: str) -> int:
        """Evaluate the order of the current value.

        Args:
            point: The current design point.
            pid: The target design parameter ID.

        Returns:
            The order.
        """

        if not self.ds[pid].order:
            return 0

        order = eval(self.ds[pid].order['expr'], {self.ds[pid].order['var']: point[pid]})
        if order is None or not isinstance(order, int):
            self.log.warning(f'Failed to evaluate the order of {pid} with value {str(point[pid])}: {str(order)}')
            return 0

        return order

    def update_child(self, point: DesignPoint, pid: str) -> None:
        """Check values of affected parameters and update them in place if it is invalid.

        Args:
            point: The current design point.
            pid: The design parameter ID that just be changed.
        """

        pendings = [child for child in self.ds[pid].child if self.validate_value(point, child)]
        for child in pendings:
            self.update_child(point, child)

    def validate_point(self, point: DesignPoint) -> bool:
        """Check if the current point is valid and set it to the closest value if not.

        Args:
            point: The current design point.
            pid: The design parameter ID that just be changed.

        Returns:
            True if the value is changed.
        """

        changed = False
        for pid in point.keys():
            options = self.gen_options(point, pid)
            value = point[pid]
            if not options:  # All invalid (something not right), set to default
                self.log.warning(f'No valid options for {pid} with point {str(point)}')
                point[pid] = self.ds[pid].default
                changed = True
                continue

            if isinstance(value, int):
                # Note that we assume all options have the same type (int or str)
                cand = min(options, key=lambda x: abs(int(x) - int(value)))
                if cand != value:
                    point[pid] = cand
                    changed = True
                    continue

            if value not in options:
                point[pid] = self.ds[pid].default
                changed = True
                continue

        return changed

    def validate_value(self, point: DesignPoint, pid: str) -> bool:
        """Check if the current value is valid and set it to the closest value if not.

        Args:
            point: The current design point.
            pid: The design parameter ID that just be changed.

        Returns:
            True if the value is changed.
        """

        options = self.gen_options(point, pid)
        value = point[pid]
        if not options:  # All invalid (something not right), set to default
            self.log.warning(f'No valid options for {pid} with point {str(point)}')
            point[pid] = self.ds[pid].default
            return False

        if isinstance(value, int):
            # Note that we assume all options have the same type (int or str)
            cand = min(options, key=lambda x: abs(int(x) - int(value)))
            if cand != value:
                point[pid] = cand
                return True

        if value not in options:
            point[pid] = self.ds[pid].default
            return True
        return False

    def move_by(self, point: DesignPoint, pid: str, step: int = 1) -> int:
        """Move N steps of pid parameter's value in a design point in place.

        Args:
            point: The design point to be manipulated.
            pid: The target design parameter.
            step: The steps to move. Note that step can be positive or negatie,
                  but we will not move cirulatory even the step is too large.

        Returns:
            The actual move steps.
        """

        try:
            options = self.gen_options(point, pid)
            idx = options.index(point[pid])
        except (AttributeError, ValueError) as err:
            self.log.error(
                f'Fail to identify the index of value {point[pid]} of parameter {pid} at design point {str(point)}: {str(err)}')
            print('Error: failed to manipulate design points')
            sys.exit(1)

        target = idx + step
        if target >= len(options):
            target = len(options) - 1
        elif target < 0:
            target = 0

        if target != idx:
            point[pid] = options[target]
            self.update_child(point, pid)
        return target - idx

    def get_results(self, next_points: List[DesignPoint]) -> List[Result]:
        data_list = []
        if self.prune_invalid:
            for point in next_points:
                data_list.append(self.apply_design_point_harp(self.class_graph, point, mode='class', model=None))

            test_loader = create_dataloader(data_list, shuffle=False,
                                            batch_size = self.batch_size,
                                            num_workers = 0,
                                            is_file_li=False, multi_modality=False)  
            #test_loader = DataLoader(data_list, batch_size=self.batch_size)  # TODO
            valid = self.GNNmodel_valid.test(test_loader, self.config['evaluate'], mode='class')
            if valid == 0:
                # stop if the point is invalid
                self.log.debug(f'invalid point {point}')
                return [float(inf)]  # TODO: add batch processing

        data_list = []
        for point in next_points:
            if self.harp_only == False:
                data_list.append(self.apply_design_point(self.graph, point))
            else:
                data_list.append(self.apply_design_point_harp(self.class_graph, point, mode='regression', model=None))

        test_loader = create_dataloader(data_list, shuffle=False,
                                        batch_size = self.batch_size,
                                        num_workers = 0,
                                        is_file_li=False, multi_modality = FLAGS.multi_modality and not self.harp_only) 
        if self.harp_only == False:
            #test_loader = create_dataloader(data_list, shuffle=False,
            #                            is_file_li=False, multi_modality = FLAGS.multi_modality and not self.harp_only)  # DataLoader(data_list, batch_size=self.batch_size)  # TODO
            results = self.GNNmodel.test(test_loader, data_list, self.config['evaluate'], mode='regression')
        else:
            #test_loader = DataLoader(data_list, batch_size=self.batch_size)  # TODO
            results = self.GNNmodel.test(test_loader, self.config['evaluate'], mode='regression')
        return results

    def topo_sort_param_ids(self, space: DesignSpace) -> List[str]:
        return topo_sort_param_ids(space)

    def traverse(self, point: DesignPoint, idx: int) -> Generator[DesignPoint, None, None]:
        """DFS traverse the design space and yield leaf points.

        Args:
            point: The current design point.
            idx: The current manipulated parameter index.

        Returns:
            A resursive generator for traversing.
        """

        if idx == len(self.ordered_pids):
            # Finish a point
            yield point
        else:
            yield from self.traverse(point, idx + 1)

            # Manipulate idx-th point
            new_point = self.clone_point(point)
            while self.move_by(new_point, self.ordered_pids[idx]) == 1:
                yield from self.traverse(new_point, idx + 1)
                new_point = self.clone_point(new_point)

    @staticmethod
    def clone_point(point: DesignPoint) -> DesignPoint:
        return dict(point)

    def run(self) -> None:
        """The main function of the explorer to launch the search algorithm.

        Args:
            algo_name: The corresponding algorithm name for running this exploration.
            algo_config: The configurable values for the algorithm.
        """
        raise NotImplementedError()


class ExhaustiveExplorer(Explorer):
    def __init__(self, dataset, kernel_name: str, first_dse: bool = False,
                 prune_invalid=False, point: DesignPoint = None, pragma_dim=None, adapt_eval_dict=None, harp_only=False, input_pickle = None):
        """Constructor.

        Args:
            ds: Design space.
        """
        super(ExhaustiveExplorer, self).__init__(dataset, kernel_name, first_dse,
                                                 prune_invalid, pragma_dim, adapt_eval_dict, harp_only)
        self.batch_size = 1
        self.log.info('Done init')
        if input_pickle is not None:
            with open(input_pickle, 'rb') as f:
                design_candidates = pickle.load(f)
                design_candidates = list(design_candidates.items())
                design_candidates.sort(key=lambda x: x[0][0], reverse=True)
                self.design_candidates = design_candidates
        else:
            self.design_candidates = None

        self.run()
        # attrs = vars(self.best_result)
        self.log.info('Best Results Found:')
        i = 1
        with open(join(saver.logdir, f'{kernel_name}.pickle'), 'wb') as handle:
            pickle.dump(self.best_results_dict, handle, protocol=pickle.HIGHEST_PROTOCOL)
            handle.flush()
        for _, result in sorted(self.best_results_dict.items()):
            attrs = vars(result)
            self.log.info(f'Design {i}')
            self.log.info(', '.join("%s: %s" % item for item in attrs.items()))
            i += 1

    def gen(self) -> Generator[List[DesignPoint], Optional[Dict[str, Result]], None]:
        # pylint:disable=missing-docstring

        self.log.info('Launch exhaustive search algorithm')

        traverser = self.traverse(get_default_point(self.ds), 0)
        iter_cnt = 0
        while True:
            next_points: List[DesignPoint] = []
            try:
                iter_cnt += 1
                self.log.debug(f'Iteration {iter_cnt}')
                while len(next_points) < self.batch_size:
                    next_points.append(next(traverser))
                    self.log.debug(f'Next point: {str(next_points[-1])}')
                yield next_points
            except StopIteration:
                if next_points:
                    yield next_points
                break

        self.log.info('No more points to be explored, stop.')

    def run(self) -> None:
        # pylint:disable=missing-docstring

        # Create a search algorithm generator
        gen_next = self.gen()

        timer = time.time()
        """
        db_file = f"../dse_database/poly/databases/v21/one-db/one-db-extended-round1/{self.kernel_name}_result_updated-0.db"
        #db_file = f"../dse_database/machsuite/databases/v21/original-size/one-db-extended-round1/{self.kernel_name}_result_updated-0.db"
        database = create_database()
        database.flushdb()
        with open(db_file, 'rb') as f:
            data = pickle.load(f)
        database.hmset(0, data)
        keys = [k.decode('utf-8') for k in database.hkeys(0)]
        test_points = []
        test_y = []
        import random
        random.shuffle(keys)
        neg_cnt = 0
        pos_cnt = 0
        for key in keys:
            pickle_obj = database.hget(0, key)
            obj = pickle.loads(pickle_obj)
            if type(obj) is int or type(obj) is dict:
                continue
            if obj.point == {}:
                continue
            
            key = str(key)
            if 'lv1' in key:
                lv2_key = key.replace('lv1', 'lv2')
                if lv2_key in keys:
                    continue
                else:
                    y = 0
            else:
                y = 0 if obj.perf < FLAGS.min_allowed_latency else 1
            
            test_points.append(obj.point)
            test_y.append(y)

        print(pos_cnt, neg_cnt)
        tp = 0
        fp = 0
        fn = 0
        tn = 0
        cnt = 0
        self.log.info('Done getting labelled data')
        """
        cnt = 0
        while (time.time() - timer) < self.timeout and self.explored_point < 75000:
            try:
                # Generate the next set of design points
                if self.design_candidates is None:
                    next_points = next(gen_next)
                else:
                    if cnt >= len(self.design_candidates):
                        break
                    #print(self.design_candidates[cnt])
                    #print(self.design_candidates[cnt][1].point)
                    point = self.design_candidates[cnt][1].point
                    for key in point.keys():
                        if isinstance(point[key], torch.Tensor):
                            point[key] = point[key].item()
                    #xxx = input()
                    next_points = [point]
                    cnt += 1
                #next_points, y = test_points[cnt], test_y[cnt]
                #next_points = [next_points]
                self.log.debug(f'The algorithm generates {len(next_points)} design points')
            except StopIteration:
                break

            results = self.get_results(next_points)
            #valid = isinstance(results[0], Result)
            
            #if y == 0 and valid == True:
            #    fp += 1
            #elif y == 1 and valid == False:
            #    fn += 1
            #elif y == 1 and valid == True:
            #    tp += 1
            #else:
            #    tn += 1
            for r in results:
                if isinstance(r, Result):
                    attrs = vars(r)
                    self.log.debug(f'Evaluating Design')
                    self.log.debug(', '.join("%s: %s" % item for item in attrs.items()))
                    _, updated = self.update_best(r)
            self.explored_point += len(results)

        self.log.info(f'Explored {self.explored_point} points')
        #self.log.info(f"Precision {tp/(tp+fp)}, Recall {tp/(tp+fn)}")
        
