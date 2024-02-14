from config import FLAGS
from saver import saver
from utils import check_any_in_str, NON_OPT_PRAGMAS, WITH_VAR_PRAGMAS, coo_to_sparse, load, create_edge_index, print_g
from torch_geometric.data import Data
from os.path import basename
from sklearn.preprocessing import OneHotEncoder
import networkx as nx
import random
import numpy as np
from collections import Counter, defaultdict, OrderedDict

from scipy.sparse import hstack, coo_matrix, csr_matrix

import torch

MASK_TOKEN = '[MASK]'


def init_preprocessors_programl():
    ntypes = Counter()
    ptypes = Counter()
    numerics = Counter()
    itypes = Counter()
    ftypes = Counter()
    btypes = Counter()
    ptypes_edge = Counter()
    ftypes_edge = Counter()

    if FLAGS.encoder_path != None:
        encoders = load(FLAGS.encoder_path)
        if 'preprocessors_programl' in encoders.keys():
            encoders = encoders['preprocessors_programl']['encoders']
        enc_ntype = encoders['enc_ntype']
        enc_ptype = encoders['enc_ptype']
        enc_itype = encoders['enc_itype']
        enc_ftype = encoders['enc_ftype']
        enc_btype = encoders['enc_btype']

        enc_ftype_edge = encoders['enc_ftype_edge']
        enc_ptype_edge = encoders['enc_ptype_edge']

    else:
        ## handle_unknown='ignore' is crucial for handling unknown variables of new kernels
        enc_ntype = OneHotEncoder(handle_unknown='ignore')
        enc_ptype = OneHotEncoder(handle_unknown='ignore')
        enc_itype = OneHotEncoder(handle_unknown='ignore')
        enc_ftype = OneHotEncoder(handle_unknown='ignore')
        enc_btype = OneHotEncoder(handle_unknown='ignore')

        enc_ftype_edge = OneHotEncoder(handle_unknown='ignore')
        enc_ptype_edge = OneHotEncoder(handle_unknown='ignore')

    X_ntype_all = []
    X_ptype_all = []
    X_itype_all = []
    X_ftype_all = []
    X_btype_all = []

    edge_ftype_all = []
    edge_ptype_all = []

    return {'counters': {'ntypes': ntypes, 'ptypes': ptypes, 'numerics': numerics, 'itypes': itypes, 'ftypes': ftypes,
                         'btypes': btypes, 'ptypes_edge': ptypes_edge, 'ftypes_edge': ftypes_edge, 'num_pragmas': []},
            'encoders': {'enc_ntype': enc_ntype, 'enc_ptype': enc_ptype, 'enc_itype': enc_itype, 'enc_ftype': enc_ftype,
                         'enc_btype': enc_btype, 'enc_ftype_edge': enc_ftype_edge, 'enc_ptype_edge': enc_ptype_edge},
            'X_all': {'X_ntype_all': X_ntype_all, 'X_ptype_all': X_ptype_all, 'X_itype_all': X_itype_all,
                      'X_ftype_all': X_ftype_all, 'X_btype_all': X_btype_all,
                      'edge_ftype_all': edge_ftype_all, 'edge_ptype_all': edge_ptype_all}}


diameters_list = []


def read_programl_graph(gexf_file):
    global diameters_list
    g = nx.read_gexf(gexf_file)
    g = nx.convert_node_labels_to_integers(g, ordering='sorted')
    g = _check_prune_non_pragma_nodes(g)
    gname = basename(gexf_file)
    g.gname = gname
    diameters_list.append(nx.diameter(nx.Graph(g)))  # turn into undirected for diameter computation

    if FLAGS.load_pretrained_GNN:
        flow = 0
        position = 0
    else:
        flow = -1
        position = -1

    if hasattr(FLAGS, 'pc_links_aug') and FLAGS.pc_links_aug in ['all_line_swp_grease', 'grease', 's_grease']:
        print_g('Before adding the psuedo node', g, print_func=saver.log_info)
        pnode_id = g.number_of_nodes()

        if FLAGS.load_pretrained_GNN:
            g.add_node(pnode_id, block=0, function=0, text='', type=0,
                       label=0)  # TODO: should be special but then cannot use
        else:
            g.add_node(pnode_id, block=-1, function=-1, text='global psuedo node', type=-1, label=-1)

        for nid, (node, ndata) in enumerate(
                sorted(g.nodes(data=True))):  # This will also add 2 self-edges for the pseudo node
            g.add_edge(nid, pnode_id, flow=flow, position=position)
            g.add_edge(pnode_id, nid, flow=flow, position=position)
        print_g('After adding the psuedo node', g, print_func=saver.log_info)
    return g


def encode_feat_dict_programl(g, preprocessors, point=None):
    cs = preprocessors['counters']
    ntypes = cs['ntypes']
    ptypes = cs['ptypes']
    numerics = cs['numerics']
    itypes = cs['itypes']
    ftypes = cs['ftypes']
    btypes = cs['btypes']
    ptypes_edge = cs['ptypes_edge']
    ftypes_edge = cs['ftypes_edge']
    num_pragmas = cs['num_pragmas']

    X_ntype = []  # node type <attribute id="3" title="type" type="long" />
    X_ptype = []  # pragma type
    X_numeric = []
    X_itype = []  # instruction type (text) <attribute id="2" title="text" type="string" />
    X_ftype = []  # function type <attribute id="1" title="function" type="long" />
    X_btype = []  # block type <attribute id="0" title="block" type="long" />
    X_contextnids = []  # 0 or 1 showing context node
    X_pragmanids = []  # 0 or 1 showing pragma node
    X_pseudonids = []  # 0 or 1 showing pseudo node
    ## for pragma as MLP
    X_pragma_per_node = []  # for each node, a vector of [tile factor, pipeline type, parallel type, parallel factor]
    # pipeline type: 1: off, 5: cg, 10: flatten
    # parallel type: 1: normal, 2: reduction
    # if no pragma assigned to node, a vector of [0, 0, 0, 0]
    X_pragmascopenids = []  # 0 or 1 showing if previous vector is all zero or not

    # itype_mask_true_label = []
    # X_pragma_trans = defaultdict(list)
    X_pragma_dict_repr = {**point}
    X_pragma_nodes = {}
    X_pragma_ptext = {}

    key_to_grab = 'full_text'

    num_pragma_node = 0
    for nid, (node, ndata) in enumerate(sorted(g.nodes(data=True))):  # TODO: node ordering
        # print(node['type'], type(node['type']))
        assert nid == node
        if ntypes is not None:
            ntypes[ndata['type']] += 1
        if itypes is not None:
            itypes[ndata['text']] += 1
        if btypes is not None:
            btypes[ndata['block']] += 1
        if ftypes is not None:
            ftypes[ndata['function']] += 1

        pragma_vector = [0, 0, 0, 0]
        if 'pseudo' in ndata['text']:
            X_pseudonids.append(1)
            ## for pragma as MLP
            if FLAGS.pragma_scope == 'block':
                ## check if the block incules any pragma nodes
                neighbor_pragmas = _find_pragma_node(g, node)
                if len(neighbor_pragmas) == 0:
                    X_pragmascopenids.append(0)
                else:
                    X_pragmascopenids.append(1)
                    pragma_vector = _fill_pragma_vector(g, neighbor_pragmas, pragma_vector, point, node)
            else:  ## other pragma scopes are not implemented yet
                raise NotImplementedError()
        else:
            X_pseudonids.append(0)
            X_pragmascopenids.append(0)
        ## for pragma as MLP: a vector of [tile factor, pipeline type, parallel type, parallel factor]
        X_pragma_per_node.append(pragma_vector)

        numeric = 0

        if FLAGS.gtype == 'programl' and FLAGS.encode_full_text == 'word2vec':
            # text_encoder.add_sentence(ndata.get('full_text', ''))
            pass  # do nothing for programl's full text

        if key_to_grab in ndata and 'pragma' in ndata[key_to_grab]:
            # print(ndata['content'])
            p_text = ndata[key_to_grab].rstrip()
            X_pragma_ptext[node] = p_text
            assert p_text[0:8] == '#pragma '
            p_text_type = p_text[8:].upper()
            X_pragma_dict_repr[node] = p_text

            if check_any_in_str(NON_OPT_PRAGMAS, p_text_type):
                p_text_type = 'None'
            else:
                if check_any_in_str(WITH_VAR_PRAGMAS, p_text_type):
                    # HLS DEPENDENCE VARIABLE=CSIYIY ARRAY INTER FALSE
                    # HLS DEPENDENCE VARIABLE=<> ARRAY INTER FALSE
                    t_li = p_text_type.split(' ')
                    for i in range(len(t_li)):
                        if 'VARIABLE=' in t_li[i]:
                            t_li[i] = 'VARIABLE=<>'
                        elif 'DEPTH=' in t_li[i]:
                            t_li[i] = 'DEPTH=<>'  # TODO: later add back
                        elif 'DIM=' in t_li[i]:
                            numeric = int(t_li[i][4:])
                            t_li[i] = 'DIM=<>'
                        elif 'LATENCY=' in t_li[i]:
                            numeric = int(t_li[i][8:])
                            t_li[i] = 'LATENCY=<>'
                    p_text_type = ' '.join(t_li)

                pragma_shortened = []
                if point is not None:
                    t_li = p_text_type.split(' ')
                    skip_next_two = 0
                    for i in range(len(t_li)):
                        if skip_next_two == 2:
                            if t_li[i] == '=':
                                skip_next_two = 1
                                continue
                            else:
                                skip_next_two = 0
                        elif skip_next_two == 1:
                            skip_next_two = 0
                            continue
                        if 'REDUCTION' in t_li[
                            i]:  ### NEW: use one type for all reductions (previously reduction=D and reduction=C were different)
                            # saver.info(t_li[i])
                            pragma_shortened.append('REDUCTION')
                            skip_next_two = 2
                        # elif 'PARALLEL' in t_li[i]:
                        #     pragma_shortened.append('PRALLEL REDUCTION')
                        elif 'AUTO{' in t_li[i]:
                            # print(t_li[i])
                            auto_what = _in_between(t_li[i], '{', '}')
                            numeric = point[auto_what]
                            X_pragma_nodes[node] = auto_what
                            if type(numeric) is not int:
                                t_li[i] = numeric
                                pragma_shortened.append(numeric)
                                numeric = 0  # TODO: ? '', 'off', 'flatten'
                            else:
                                t_li[i] = 'AUTO{<>}'
                                pragma_shortened.append('AUTO{<>}')
                            break
                        else:
                            pragma_shortened.append(t_li[i])
                    # p_text_type = ' '.join(t_li)
                    # if len(t_li) != len(pragma_shortened): saver.log_info(f'{t_li} vs {pragma_shortened}')
                    p_text_type = ' '.join(pragma_shortened)
                else:
                    assert 'AUTO' not in p_text_type
                # t = ' '.join(t.split(' ')[0:2])
            # print('@@@@@', t)
            ptype = p_text_type
            X_pragmanids.append(1)
            X_contextnids.append(0)
            # if FLAGS.ptrans:
            #     if FLAGS.pragma_scope == 'pragma_self':
            #         X_pragma_trans[ptype].append(nid)
            #         scope = [nid]
            #     elif FLAGS.pragma_scope == 'bnb':
            #         block = _find_block_node(g, nid)
            #         next_block = _find_block_node(g, block)
            #         X_pragma_trans[ptype].append(block)
            #         X_pragma_trans[ptype].append(next_block)
            #         scope = [block, next_block]
            #     else:
            #         raise NotImplementedError()
            #     for s in scope:
            #         nx.set_node_attributes(g, {s: 1}, name=f'ptrans_{ptype}_scope')
            num_pragma_node += 1
        else:
            ptype = 'None'
            X_pragmanids.append(0)
            ## exclude pseudo nodes from context nodes
            if 'pseudo' in ndata['text']:
                X_contextnids.append(0)
            else:
                X_contextnids.append(1)

        if ptypes is not None:
            ptypes[ptype] += 1
        if numerics is not None:
            numerics[numeric] += 1

        X_ntype.append([ndata['type']])
        X_ptype.append([ptype])
        X_numeric.append([numeric])
        X_itype.append([ndata['text']])
        X_ftype.append([ndata['function']])
        X_btype.append([ndata['block']])

    num_pragmas.append(num_pragma_node)

    # vname = key

    node_dict = {'X_ntype': X_ntype, 'X_ptype': X_ptype, 'X_numeric': X_numeric, 'X_itype': X_itype, 'X_ftype': X_ftype,
                 'X_btype': X_btype, 'X_contextnids': torch.FloatTensor(np.array(X_contextnids)),
                 'X_pragmanids': torch.FloatTensor(np.array(X_pragmanids)),
                 'X_pseudonids': torch.FloatTensor(np.array(X_pseudonids)),
                 # 'X_pragma_trans': {},
                 'X_pragma_dict_repr': X_pragma_dict_repr,
                 'X_pragma_nodes': X_pragma_nodes,
                 'X_pragma_ptext': X_pragma_ptext,
                 'X_pragma_per_node': _transform_X_torch(X_pragma_per_node),
                 'X_pragmascopenids': torch.FloatTensor(np.array(X_pragmascopenids)),
                 }

    # if FLAGS.ptrans:
    #     for tstype, tnids in X_pragma_trans.items():
    #         node_dict['X_pragma_trans'][tstype] = torch.LongTensor(np.array(tnids))
    if not hasattr(g, 'has_plotted'):
        p = f'{saver.get_obj_dir()}/{g.gname}'
        nx.write_gexf(g, p)
        g.has_plotted = True
        saver.log_info(f'Saved gexf to {p}')

    # def encode_edge_dict_programl(g):
    X_ftype = []  # flow type <attribute id="5" title="flow" type="long" />
    X_ptype = []  # position type <attribute id="6" title="position" type="long" />

    if not FLAGS.multi_modality:
        assert not FLAGS.sequence_modeling
    for nid1, nid2, edata in g.edges(data=True):  # TODO: node ordering
        X_ftype.append([edata['flow']])
        X_ptype.append([edata['position']])
        ftypes_edge[edata['flow']] += 1
        ptypes_edge[edata['position']] += 1

    edge_dict = {'X_ftype': X_ftype, 'X_ptype': X_ptype}

    preprocessors['X_all']['X_ntype_all'] += node_dict['X_ntype']
    preprocessors['X_all']['X_ptype_all'] += node_dict['X_ptype']
    preprocessors['X_all']['X_itype_all'] += node_dict['X_itype']
    preprocessors['X_all']['X_ftype_all'] += node_dict['X_ftype']
    preprocessors['X_all']['X_btype_all'] += node_dict['X_btype']

    preprocessors['X_all']['edge_ftype_all'] += edge_dict['X_ftype']
    preprocessors['X_all']['edge_ptype_all'] += edge_dict['X_ptype']

    return node_dict, edge_dict


def _transform_X_torch(X):
    X = torch.FloatTensor(np.array(X))
    X = coo_matrix(X)
    X = _coo_to_sparse(X)
    X = X.to_dense()
    return X


def _coo_to_sparse(coo):
    values = coo.data
    indices = np.vstack((coo.row, coo.col))

    i = torch.LongTensor(indices)
    v = torch.FloatTensor(values)
    shape = coo.shape

    rtn = torch.sparse.FloatTensor(i, v, torch.Size(shape))
    return rtn


def _find_pragma_node(g, nid):
    pragma_nodes = {}
    nid_to_use = nid
    if nid_to_use not in g.nodes():
        raise RuntimeError(f'nid_to_use {nid_to_use} ({type(nid_to_use)}) not in g.nodes(): {list(g.nodes())[0:10]}')
    for neighbor in g.neighbors(nid_to_use):
        for pragma in ['pipeline', 'parallel', 'tile']:
            if g.nodes[neighbor]['text'].lower() == pragma:
                pragma_nodes[pragma] = neighbor
                break

    return pragma_nodes

def find_pragma_node(g, nid):
    pragma_nodes = {}
#    for neighbor in g.neighbors(str(nid)):
    for neighbor in g.neighbors(nid):

        for pragma in ['pipeline', 'parallel', 'tile']:
            if g.nodes[neighbor]['text'].lower() == pragma:
                pragma_nodes[pragma] = neighbor
                break
    
    return pragma_nodes


def _fill_pragma_vector(g, neighbor_pragmas, pragma_vector, point, node):
    '''
        # for each node, a vector of [tile factor, pipeline type, parallel type, parallel factor]
        # pipeline type: 1: off, 5: cg, 10: flatten
        # parallel type: 1: normal, 2: reduction
        # if no pragma assigned to node, a vector of [0, 0, 0, 0]
    '''
    vector_id = {'pipeline': 1, 'parallel': 3, 'tile': 0}
    for pragma in ['pipeline', 'parallel', 'tile']:
        if pragma in neighbor_pragmas:
            nid = neighbor_pragmas[pragma]
            pragma_text = g.nodes[nid]['full_text']
            reduction, numeric = _get_pragma_numeric(pragma_text, point, pragma_type=pragma)
            pragma_vector[vector_id[pragma]] = numeric
            if pragma == 'parallel':
                if reduction == 0:
                    pragma_vector[vector_id[pragma] - 1] = 1
                else:
                    pragma_vector[vector_id[pragma] - 1] = 2
    # saver.log_info(f'point: {point}')
    # saver.log_info(f'{node}, {pragma_vector}')
    return pragma_vector


def _get_pragma_numeric(pragma_text, point, pragma_type):
    t_li = pragma_text.split(' ')
    reduction = 0
    for i in range(len(t_li)):
        if 'REDUCTION' in t_li[i].upper():
            reduction = 1
        elif 'AUTO{' in t_li[i].upper():
            # print(t_li[i])
            auto_what = _in_between(t_li[i], '{', '}')
            numeric = point[auto_what]
            if type(numeric) is not int:  ## '', 'off', 'flatten'
                assert pragma_type.lower() == 'pipeline'
                if numeric == 'flatten':
                    numeric = 10
                elif numeric == 'off':
                    numeric = 1
                else:
                    numeric = 5

    return reduction, numeric


def fit_preprocessors_programl(preprocessors):
    if FLAGS.encoder_path != None:
        saver.log_info(f'FLAGS.encoder_path != None so encoders are assumed to be already fitted -- skip fitting')
        preprocessors['itype_vocab'] = {}
        return

    itype_vocab = {}

    preprocessors['encoders']['enc_ntype'].fit(preprocessors['X_all']['X_ntype_all'])
    preprocessors['encoders']['enc_ptype'].fit(preprocessors['X_all']['X_ptype_all'])
    if FLAGS.itype_mask_perc > 0:
        preprocessors['X_all']['X_itype_all'] += [[MASK_TOKEN]]
    preprocessors['encoders']['enc_itype'].fit(preprocessors['X_all']['X_itype_all'])
    for itype in preprocessors['X_all']['X_itype_all']:
        assert len(itype) == 1
        itype = itype[0]
        if itype not in itype_vocab:
            itype_vocab[itype] = len(itype_vocab) + 1
    preprocessors['encoders']['enc_ftype'].fit(preprocessors['X_all']['X_ftype_all'])
    preprocessors['encoders']['enc_btype'].fit(preprocessors['X_all']['X_btype_all'])

    if len(preprocessors['X_all']['edge_ftype_all']) != 0:
        preprocessors['encoders']['enc_ftype_edge'].fit(preprocessors['X_all']['edge_ftype_all'])
    if len(preprocessors['X_all']['edge_ptype_all']) != 0:
        preprocessors['encoders']['enc_ptype_edge'].fit(preprocessors['X_all']['edge_ptype_all'])

    preprocessors['itype_vocab'] = itype_vocab


def encode_X_torch_programl(g, d_node, d_edge, preprocessors, gname, vname, return_Data=True):
    """
    x_dict is the returned dict by _encode_X_dict()
    """
    enc_ntype = preprocessors['encoders']['enc_ntype']
    enc_ptype = preprocessors['encoders']['enc_ptype']
    enc_itype = preprocessors['encoders']['enc_itype']
    itype_vocab = preprocessors['itype_vocab']
    enc_ftype = preprocessors['encoders']['enc_ftype']
    enc_btype = preprocessors['encoders']['enc_btype']

    X_ntype = enc_ntype.transform(d_node['X_ntype'])
    X_ptype = enc_ptype.transform(d_node['X_ptype'])
    x_itype_li = d_node['X_itype']
    itype_true_labels = []
    if FLAGS.itype_mask_perc > 0:
        for x in x_itype_li:
            assert len(x) == 1
            prob = random.random()
            if prob < FLAGS.itype_mask_perc:
                itype_true_label = itype_vocab[x[0]]
                x[0] = MASK_TOKEN
            else:
                itype_true_label = 0
            itype_true_labels.append(itype_true_label)
    itype_true_labels = torch.LongTensor(itype_true_labels)
    X_itype = enc_itype.transform(x_itype_li)
    X_ftype = enc_ftype.transform(d_node['X_ftype'])
    X_btype = enc_btype.transform(d_node['X_btype'])
    X_numeric = d_node['X_numeric']

    if FLAGS.no_pragma:
        X = X_ntype
        X = X.toarray()
        X_node = torch.FloatTensor(X)
    else:
        X = hstack((X_ntype, X_ptype, X_numeric, X_itype, X_ftype, X_btype))
        # zzz = np.array(X.todense())
        X = coo_to_sparse(X)
        X_node = X.to_dense()

    # def _encode_edge_torch(edge_dict, enc_ftype, enc_ptype):
    """
    edge_dict is the dictionary returned by _encode_edge_dict
    """
    X_ftype = preprocessors['encoders']['enc_ftype_edge'].transform(d_edge['X_ftype'])
    X_ptype = preprocessors['encoders']['enc_ptype_edge'].transform(d_edge['X_ptype'])

    X_edge = hstack((X_ftype, X_ptype))
    X_edge = coo_to_sparse(X_edge)
    X_edge = X_edge.to_dense()

    edge_index = create_edge_index(g)

    if return_Data:
        d_node.pop('X_pragma_nodes')  # somehow affects data loading with a key error, so remove it
        d_node.pop('X_pragma_ptext')

        if FLAGS.task == 'regression':
            return Data(
                gname=gname,
                key=vname,
                X_contextnids=d_node['X_contextnids'],
                X_pragmanids=d_node['X_pragmanids'],
                X_pseudonids=d_node['X_pseudonids'],
                x=X_node,
                edge_index=edge_index,
                pragmas=d_node['pragmas'],
                perf=d_node['perf'],
                actual_perf=d_node['actual_perf'],
                kernel_speedup=d_node['kernel_speedup'],  # base is different per kernel
                quality=d_node['quality'],
                util_BRAM=d_node['util-BRAM'],
                util_DSP=d_node['util-DSP'],
                util_LUT=d_node['util-LUT'],
                util_FF=d_node['util-FF'],
                total_BRAM=d_node['total-BRAM'],
                total_DSP=d_node['total-DSP'],
                total_LUT=d_node['total-LUT'],
                total_FF=d_node['total-FF'],
                edge_attr=X_edge,
                xy_dict_programl=d_node,
                itype_true_labels=itype_true_labels,

                X_pragma_per_node=d_node['X_pragma_per_node'],
                X_pragmascopenids=d_node['X_pragmascopenids'],

                # **d_node['X_pragma_trans']
            )
        elif FLAGS.task == 'class':
            return Data(
                gname=gname,
                key=vname,
                X_contextnids=d_node['X_contextnids'],
                X_pragmanids=d_node['X_pragmanids'],
                X_pseudonids=d_node['X_pseudonids'],
                x=X_node,
                edge_index=edge_index,
                pragmas=d_node['pragmas'],
                perf=d_node['perf'],
                edge_attr=X_edge,
                xy_dict_programl=d_node,
                itype_true_labels=itype_true_labels,

                X_pragma_per_node=d_node['X_pragma_per_node'],
                X_pragmascopenids=d_node['X_pragmascopenids'],

                # **d_node['X_pragma_trans']
            )
        else:
            raise NotImplementedError()

    else:
        return {'X_node': X_node, 'itype_true_labels': itype_true_labels, 'X_edge': X_edge, 'edge_index': edge_index,
                'd_node': d_node}

    # return X_node, itype_true_labels, X_edge


def _check_prune_non_pragma_nodes(g):
    if FLAGS.only_pragma_nodes:
        to_remove = []
        for node, ndata in g.nodes(data=True):
            x = ndata.get('full_text')
            if x is None:
                x = ndata['type']
            if type(x) is not str or (not 'Pragma' in x and not 'pragma' in x):
                to_remove.append(node)
        before = g.number_of_nodes()
        g.remove_nodes_from(to_remove)
        saver.log_info(f'Removed {len(to_remove)} non-pragma nodes from G -'
                       f'- {before} to {g.number_of_nodes()}')
        assert g.number_of_nodes() + len(to_remove) == before
    return g


def _find_block_node(g, nid):
    block_nodes = []
    for neighbor in g.neighbors(nid):
        if g.nodes[neighbor]['text'] == 'pseudo_block':
            block_nodes.append((g.nodes[neighbor]['block'], neighbor))
    if not block_nodes:
        raise ValueError(f'No neighboring pseudo_block node for node {nid}')
    block_nodes.sort()
    return block_nodes[-1][1]


def _in_between(text, left, right):
    # text = 'I want to find a string between two substrings'
    # left = 'find a '
    # right = 'between two'
    return text[text.index(left) + len(left):text.index(right)]

def get_pragma_numeric(pragma_text, point, pragma_type):
    t_li = pragma_text.split(' ')
    reduction = 0
    for i in range(len(t_li)):
        if 'REDUCTION' in t_li[i].upper(): 
            reduction = 1
        elif 'AUTO{' in t_li[i].upper():
            # print(t_li[i])
            auto_what = _in_between(t_li[i], '{', '}')
            numeric = point[auto_what]
            if type(numeric) is not int: ## '', 'off', 'flatten'
                assert pragma_type.lower() == 'pipeline'
                if numeric == 'flatten':
                    numeric = 10
                elif numeric == 'off':
                    numeric = 1
                else:
                    numeric = 5
            
    return reduction, numeric

def fill_pragma_vector(g, neighbor_pragmas, pragma_vector, point, node):
    '''
        # for each node, a vector of [tile factor, pipeline type, parallel type, parallel factor] 
        # pipeline type: 1: off, 5: cg, 10: flatten
        # parallel type: 1: normal, 2: reduction
        # if no pragma assigned to node, a vector of [0, 0, 0, 0]
    '''
    vector_id = {'pipeline': 1, 'parallel': 3, 'tile': 0}
    for pragma in ['pipeline', 'parallel', 'tile']:
        if pragma in neighbor_pragmas:
            nid = neighbor_pragmas[pragma]
            pragma_text = g.nodes[nid]['full_text']
            reduction, numeric = get_pragma_numeric(pragma_text, point, pragma_type=pragma)
            pragma_vector[vector_id[pragma]] = numeric
            if pragma == 'parallel':
                if reduction == 0:
                    pragma_vector[vector_id[pragma] - 1] = 1
                else:
                    pragma_vector[vector_id[pragma] - 1] = 2
    # saver.log_info(f'point: {point}')
    # saver.log_info(f'{node}, {pragma_vector}')
    return pragma_vector


def _check_any_in_str(li, s):
    for li_item in li:
        if li_item in s:
            return True
    return False

def _encode_X_dict(g, ntypes=None, ptypes=None, numerics=None, itypes=None, ftypes=None, btypes=None, point=None):
    X_ntype = [] # node type <attribute id="3" title="type" type="long" />
    X_ptype = [] # pragma type
    X_numeric = []
    X_itype = [] # instruction type (text) <attribute id="2" title="text" type="string" />
    X_ftype = [] # function type <attribute id="1" title="function" type="long" />
    X_btype = [] # block type <attribute id="0" title="block" type="long" />
    X_contextnids = [] # 0 or 1 showing context node
    X_pragmanids = [] # 0 or 1 showing pragma node
    X_pseudonids = [] # 0 or 1 showing pseudo node
    X_icmpnids = [] # 0 or 1 showing icmp node
    ## for pragma as MLP
    X_pragma_per_node = [] # for each node, a vector of [tile factor, pipeline type, parallel type, parallel factor] 
                           # pipeline type: 1: off, 5: cg, 10: flatten
                           # parallel type: 1: normal, 2: reduction
                           # if no pragma assigned to node, a vector of [0, 0, 0, 0]
    X_pragmascopenids = [] # 0 or 1 showing if previous vector is all zero or not
    

    
    #g = nx.convert_node_labels_to_integers(g, ordering='sorted')  
    for nid, (node, ndata) in enumerate(g.nodes(data=True)):  # TODO: node ordering
        # print(node['type'], type(node['type']))
        assert nid == int(node), f'{nid} {node}'
        # print(node['type'], type(node['type']))
        if ntypes is not None:
            ntypes[ndata['type']] += 1
        if itypes is not None:
            itypes[ndata['text']] += 1
        if btypes is not None:
            btypes[ndata['block']] += 1
        if ftypes is not None:
            ftypes[ndata['function']] += 1
            
        pragma_vector = [0, 0, 0, 0]
        if 'pseudo' in ndata['text']:
            X_pseudonids.append(1)
            ## for pragma as MLP
            if FLAGS.pragma_scope == 'block':
                ## check if the block incules any pragma nodes
                neighbor_pragmas = find_pragma_node(g, node)
                if len(neighbor_pragmas) == 0:
                    X_pragmascopenids.append(0)
                else:
                    X_pragmascopenids.append(1)
                    pragma_vector = fill_pragma_vector(g, neighbor_pragmas, pragma_vector, point, node)
            else: ## other pragma scopes are not implemented yet
                raise NotImplementedError()
        else:
            X_pseudonids.append(0)
            X_pragmascopenids.append(0)
        ## for pragma as MLP: a vector of [tile factor, pipeline type, parallel type, parallel factor]
        X_pragma_per_node.append(pragma_vector)

        numeric = 0

        if 'full_text' in ndata and 'icmp' in ndata['full_text']:
            cmp_t = ndata['full_text'].split(',')[-1]
            cmp_t = cmp_t.strip()
            if cmp_t.isdigit():
                cmp_t = eval(cmp_t)
                # saver.log_info(cmp_t)
                numeric = cmp_t
                X_icmpnids.append(1)
            else:
                X_icmpnids.append(0)
                pass
        else:
            X_icmpnids.append(0)

        if 'full_text' in ndata and 'pragma' in ndata['full_text']:
            # print(ndata['content'])
            p_text = ndata['full_text'].rstrip()
            assert p_text[0:8] == '#pragma '
            p_text_type = p_text[8:].upper()

            if _check_any_in_str(NON_OPT_PRAGMAS, p_text_type):
                p_text_type = 'None'
            else:
                if _check_any_in_str(WITH_VAR_PRAGMAS, p_text_type):
                    # HLS DEPENDENCE VARIABLE=CSIYIY ARRAY INTER FALSE
                    # HLS DEPENDENCE VARIABLE=<> ARRAY INTER FALSE
                    t_li = p_text_type.split(' ')
                    for i in range(len(t_li)):
                        if 'VARIABLE=' in t_li[i]:
                            t_li[i] = 'VARIABLE=<>'
                        elif 'DEPTH=' in t_li[i]:
                            t_li[i] = 'DEPTH=<>'  # TODO: later add back
                        elif 'DIM=' in t_li[i]:
                            numeric = int(t_li[i][4:])
                            t_li[i] = 'DIM=<>'
                        elif 'LATENCY=' in t_li[i]:
                            numeric = int(t_li[i][8:])
                            t_li[i] = 'LATENCY=<>'
                    p_text_type = ' '.join(t_li)

                pragma_shortened = []
                if point is not None:
                    t_li = p_text_type.split(' ')
                    skip_next_two = 0
                    for i in range(len(t_li)):
                        if skip_next_two == 2:
                            if t_li[i] == '=':
                                skip_next_two = 1
                                continue
                            else:
                                skip_next_two = 0
                        elif skip_next_two == 1:
                            skip_next_two = 0
                            continue
                        if 'REDUCTION' in t_li[i]: ### NEW: use one type for all reductions (previously reduction=D and reduction=C were different)
                            # saver.info(t_li[i])
                            if FLAGS.keep_pragma_attribute: ## see reduction as a different kind of parallelization
                                pragma_shortened.append('REDUCTION')
                            skip_next_two = 2
                        # elif 'PARALLEL' in t_li[i]:
                        #     pragma_shortened.append('PRALLEL REDUCTION')
                        elif not FLAGS.keep_pragma_attribute and 'PIPELINE' in t_li[i]: ## see all the pipeline option as the same
                            pragma_shortened.append(t_li[i])
                            break
                        elif 'AUTO{' in t_li[i]:
                            # print(t_li[i])
                            auto_what = _in_between(t_li[i], '{', '}')
                            numeric = point[auto_what]
                            if type(numeric) is not int:
                                t_li[i] = numeric
                                pragma_shortened.append(numeric)
                                numeric = 0  # TODO: ? '', 'off', 'flatten'
                            else:
                                t_li[i] = 'AUTO{<>}'
                                pragma_shortened.append('AUTO{<>}')
                            break
                        else:
                            pragma_shortened.append(t_li[i])
                    # p_text_type = ' '.join(t_li)
                    # if len(t_li) != len(pragma_shortened): saver.log_info(f'{t_li} vs {pragma_shortened}')
                    p_text_type = ' '.join(pragma_shortened)
                else:
                    assert 'AUTO' not in p_text_type
                # t = ' '.join(t.split(' ')[0:2])
            # print('@@@@@', t)
            if not FLAGS.keep_pragma_attribute: ## see all the pragma options as the same
                numeric = 1
            ptype = p_text_type
            X_pragmanids.append(1)
            X_contextnids.append(0)
        else:
            ptype = 'None'
            X_pragmanids.append(0)
            ## exclude pseudo nodes from context nodes
            if 'pseudo' in ndata['text']:
                X_contextnids.append(0)
            else:
                X_contextnids.append(1)
                
        if ptypes is not None:
            ptypes[ptype] += 1
        if numerics is not None:
            numerics[numeric] += 1

        X_ntype.append([ndata['type']])
        X_ptype.append([ptype])
        X_numeric.append([numeric])
        X_itype.append([ndata['text']])
        X_ftype.append([ndata['function']])
        X_btype.append([ndata['block']])
        
    # vname = key

    X_pragma_per_node = transform_X_torch(X_pragma_per_node)
    return {'X_ntype': X_ntype, 'X_ptype': X_ptype,
            'X_numeric': X_numeric, 'X_itype': X_itype,
            'X_ftype': X_ftype, 'X_btype': X_btype,
            'X_contextnids': torch.FloatTensor(np.array(X_contextnids)),
            'X_pragmanids': torch.FloatTensor(np.array(X_pragmanids)),
            'X_pragmascopenids': torch.FloatTensor(np.array(X_pragmascopenids)),
            'X_pseudonids': torch.FloatTensor(np.array(X_pseudonids)),
            'X_icmpnids': torch.FloatTensor(np.array(X_icmpnids)),
            'X_pragma_per_node': X_pragma_per_node
            }

def transform_X_torch(X):
    X = torch.FloatTensor(np.array(X))
    X = coo_matrix(X)
    X = _coo_to_sparse(X)
    X = X.to_dense()
    return X


def _encode_X_torch(x_dict, enc_ntype, enc_ptype, enc_itype, enc_ftype, enc_btype):
    """
    x_dict is the returned dict by _encode_X_dict()
    """
    X_ntype = enc_ntype.transform(x_dict['X_ntype'])
    X_ptype = enc_ptype.transform(x_dict['X_ptype'])
    X_itype = enc_itype.transform(x_dict['X_itype'])
    X_ftype = enc_ftype.transform(x_dict['X_ftype'])
    X_btype = enc_btype.transform(x_dict['X_btype'])

    X_numeric = x_dict['X_numeric']
    # print(len(enc_ntype.categories_[0]))
    # print(len(X_numeric))
    # saver.log_info(X_ntype.shape(0), X_ptype.shape(0), X_itype.shape(0), X_ftype.shape(0), X_btype.shape(0)) #X_numeric.shape(0))
    if FLAGS.no_pragma:
        X = X_ntype
        X = X.toarray()
        X = torch.FloatTensor(X)
    else:
        X = hstack((X_ntype, X_ptype, X_numeric, X_itype, X_ftype, X_btype))
        X = _coo_to_sparse(X)
        X = X.to_dense()

    return X


def _encode_edge_dict(g, ftypes=None, ptypes=None):
    X_ftype = [] # flow type <attribute id="5" title="flow" type="long" />
    X_ptype = [] # position type <attribute id="6" title="position" type="long" />    
      
    for nid1, nid2, edata in g.edges(data=True):  # TODO: node ordering
        X_ftype.append([edata['flow']])
        X_ptype.append([edata['position']])

    return {'X_ftype': X_ftype, 'X_ptype': X_ptype}

    
def _encode_edge_torch(edge_dict, enc_ftype, enc_ptype):
    """
    edge_dict is the dictionary returned by _encode_edge_dict
    """
    X_ftype = enc_ftype.transform(edge_dict['X_ftype'])
    X_ptype = enc_ptype.transform(edge_dict['X_ptype'])

    if FLAGS.encode_edge_position or True:
        X = hstack((X_ftype, X_ptype))
    else:
        X = coo_matrix(X_ftype)
    if isinstance(X, csr_matrix):
        # Convert CSR to COO
        X = X.tocoo()
    X = _coo_to_sparse(X)
    X = X.to_dense()
#    print(X.size())
#    xxx = input()

    return X
