from utils import check_prepend_root_folder, get_best_gpu
import argparse

parser = argparse.ArgumentParser()

model = 'our'

############ DSE Flags Part 1 #########################################
parser.add_argument('--model', type=str, default=model)
harp_only=False
parser.add_argument('--harp_only', type=bool, default=harp_only)

parser.add_argument('--dse_start_idx', type=int, default=0)
parser.add_argument('--dse_end_idx', type=int, default=42)

disable_src_code = False
parser.add_argument('--disable_src_code', type=bool, default=disable_src_code)
disable_gnn = False
parser.add_argument('--disable_gnn', type=bool, default=disable_gnn)

#############################################################################



################# Main flags define which task to run #################################################################

v_db = 'v21' # options: v18, v20, v21
parser.add_argument('--v_db', default=v_db)
if v_db != 'v18':
    parser.add_argument('--only_common_db', default=False)
    parser.add_argument('--test_extra', default=False)
    parser.add_argument('--only_new_points', default=False)
round_num = 1 if v_db == 'v21' else 3 if v_db == 'v20' else 13
parser.add_argument('--round_num', default=round_num) ## round number of retraining after data augmentation with DSE

#TASK = 'class'
TASK = 'regression'
parser.add_argument('--task', default=TASK)

# SUBTASK = 'dse'
# SUBTASK = 'train'
SUBTASK = 'inference'
parser.add_argument('--subtask', default=SUBTASK)
#########################################################################################################

##################### Flags for loading models #####################################################

load_model = 'None'
load_model = 'train_2024-03-26T19-12-18.035699_regression_scai5'
#load_model = ''#path to your downloaded trained model.


load_model_class = 'None'
load_keys = 'None'
load_db = 'None'
load_db_kernel = 'None'
run_kernel = 'None'

if load_model != 'None':
    load_model_weights = True
    # load_model_weights = False  # be careful! just load the architecture but still randomly initialized
    parser.add_argument('--load_model_weights', type=bool, default=load_model_weights)

if load_db != 'None':
    load_db = check_prepend_root_folder(load_db)
    parser.add_argument('--load_db_kernel', type=str, default=load_db_kernel)
parser.add_argument('--load_db', type=str, default=load_db)

if load_model != 'None':
    load_model = check_prepend_root_folder(load_model)
    if '.pth' not in load_model and 'pt' not in load_model:
        load_model += '/val_model_state_dict.pth'

# test_kernel = 'gesummv'

parser.add_argument('--load_model', type=str, default=load_model)

#######################################################################################################


############################# flags for model architecture #############################################
sequence_modeling = True
if model != 'our': # always True
    sequence_modeling = False
parser.add_argument('--sequence_modeling', type=bool, default=sequence_modeling)

replace_with_random_weights = None
combine_node_edge_labels = None
data_repr = None
code_encoder = None
chunk_offset = None

'''
03/30/2023: Multi modalities.
'''
multi_modality = True
combine_fashion = None
feed_p_to_tf = None
interleave_GNN_transformer = False
if model != 'our':
    multi_modality = False


# use_redis = True  # default
use_redis = False  # 05/29/2023: use our own database mimicking redis (allows parallel running without new port for redis)
parser.add_argument('--use_redis', type=bool, default=use_redis)

if sequence_modeling:
    data_repr = 'penhance'  # pragma-enhanced
    parser.add_argument('--data_repr', type=str, default=data_repr)

    code_encoder = 'codet5'  # codet5-small
    parser.add_argument('--code_encoder', type=str, default=code_encoder)

    chunk_emb = 'cls'
    parser.add_argument('--chunk_emb', type=str, default=chunk_emb)

    finetune_bert = True
    parser.add_argument('--finetune_bert', type=bool, default=finetune_bert)

    replace_with_random_weights = False  # default; esp for testing
    parser.add_argument('--replace_with_random_weights', type=bool, default=replace_with_random_weights)

    max_code_tokens_len = None  # use default MAX_LEN by the tokenizer (256 for codet5)
    
    # be efficient!
    max_code_tokens_len = 64

    add_edges_fc_graph = True
    parser.add_argument('--add_edges_fc_graph', type=bool, default=add_edges_fc_graph)

    chunk_offset = 16
    parser.add_argument('--chunk_offset', type=int, default=chunk_offset)

    parser.add_argument('--max_code_tokens_len', type=int, default=max_code_tokens_len)

    token_att_masking = True
    parser.add_argument('--token_att_masking', type=bool, default=token_att_masking)

    preserve_keywords = True
    parser.add_argument('--preserve_keywords', type=bool, default=preserve_keywords)

    if preserve_keywords:
        # version = 1
        version = 2
        parser.add_argument('--pk_version', type=int, default=version)

    if code_encoder in ['codet5', 'codet5-large']:
        bypass_tf_layers = False  # default
        # bypass_tf_layers = True # crazy: bypass some codet5 encoder layers
        parser.add_argument('--bypass_tf_layers', type=bool, default=bypass_tf_layers)

        if bypass_tf_layers:
            # keep_layers = [0]
            # keep_layers = [5]
            keep_layers = [0, 1, 2]
            # keep_layers = [] # crazy; no token-token attention at all; no encoder block used at all!
            parser.add_argument('--keep_layers', type=list, default=keep_layers)

    # apply_act_conv_first = True # default
    apply_act_conv_first = False
    parser.add_argument('--apply_act_conv_first', type=bool, default=apply_act_conv_first)

    vis_transformer_att = False  # default
    # vis_transformer_att = True # will run vis and exit()
    parser.add_argument('--vis_transformer_att', type=bool, default=vis_transformer_att)

full_quadratic_attention = False
if multi_modality:
    what_modalities = 'programl+src_code'
    parser.add_argument('--what_modalities', type=str, default=what_modalities)
    if what_modalities == 'programl+src_code':
        assert sequence_modeling and data_repr == 'penhance'
    else:
        raise NotImplementedError()

    combine_fashion = 'share_final_MLPs'
    # combine_fashion = 'share_GNNs_MLPs'
    parser.add_argument('--combine_fashion', type=str, default=combine_fashion)

    if combine_fashion == 'share_GNNs_MLPs': # default False
        # add_pragma_links = False  # default
        add_pragma_links = True  #
        parser.add_argument('--add_pragma_links', type=bool, default=add_pragma_links)

        multi_glevel_embs = False  # default
        # multi_glevel_embs = True
        parser.add_argument('--multi_glevel_embs', type=bool, default=multi_glevel_embs)

    if combine_fashion == 'share_final_MLPs':
        freeze_code_encoder = False
        parser.add_argument('--freeze_code_encoder', type=bool, default=freeze_code_encoder)
        # feed_p_to_tf = False  # default
        #feed_p_to_tf = False
        feed_p_to_tf = True
        if disable_src_code == True:
            feed_p_to_tf = True
        parser.add_argument('--feed_p_to_tf', type=bool, default=feed_p_to_tf)

        if feed_p_to_tf:
            # which_pos_to_take = '0' # 0 indicates the programl (CDFG) summary embedding
            # which_pos_to_take = '1' # 1 indicates the <s> embedding
            which_pos_to_take = '0_and_1'  # both
            parser.add_argument('--which_pos_to_take', type=str, default=which_pos_to_take)
            two_modalities_interact_start_layer = 1
            parser.add_argument('--two_modalities_interact_start_layer', type=int, default=two_modalities_interact_start_layer)
            node_token_interact_start_layer = 5
            parser.add_argument('--node_token_interact_start_layer', type=int, default=node_token_interact_start_layer)

        # pc_links = False  # default
        pc_links = True
        if disable_src_code == True:
            pc_links = False
        parser.add_argument('--pc_links', type=bool, default=pc_links)

        if pc_links:
            alignment_decoder = 'concat_MLP'  # default
            # alignment_decoder = 'dot'
            # alignment_decoder = 'cosine'
            parser.add_argument('--alignment_decoder', type=str, default=alignment_decoder)

            #pc_links_aug = None  # only the specific token indicated by <line> <col>
            pc_links_aug = 'pseudo' # block node token interaction
            parser.add_argument('--pc_links_aug', type=str, default=pc_links_aug)

            #node_token_interaction = False # default
            node_token_interaction = True
            parser.add_argument('--node_token_interaction', type=bool, default=node_token_interaction)

            pc_links_holdout_ratio = 0  # default
            if pc_links_aug is not None and node_token_interaction:
                # pc_links_holdout_ratio = 0.4
                pc_links_holdout_ratio = 0  # critical: need to be tuned
                if pc_links_aug == 'grease':
                    pc_links_holdout_ratio = 0

            parser.add_argument('--pc_links_holdout_ratio', type=str, default=pc_links_holdout_ratio)

            if 'inference' in SUBTASK:
                pc_links_force_use_train_when_inference = False
                # pc_links_force_use_train_when_inference = True # be careful! This will use partial pc links
                parser.add_argument('--pc_links_force_use_train_when_inference', type=str,
                                    default=pc_links_force_use_train_when_inference)

            if node_token_interaction:
                # project_node_embs_before_align = False
                project_node_embs_before_align = True
                parser.add_argument('--project_node_embs_before_align', type=bool,
                                    default=project_node_embs_before_align)

                full_quadratic_attention = False # default
                # full_quadratic_attention = True # bypass message passing via bridge links -- instead performs full att
                parser.add_argument('--full_quadratic_attention', type=bool,
                                    default=full_quadratic_attention)


                actually_aggregate = True  # default
                # actually_aggregate = False
                parser.add_argument('--actually_aggregate', type=bool, default=actually_aggregate)

                collaboration_btw_modalities = None
                # collaboration_btw_modalities = 'edge_msgs'
                parser.add_argument('--collaboration_btw_modalities', type=str, default=collaboration_btw_modalities)

                # If inter-levae GNN and transformer layer by layer,
                # need to (1) do cross-modality exchange in both directions, and
                # (2) if further feed_p_to_tf, need to prepare the token ids by taking that fed CDFG embedding into
                # consideration.
                # interleave_GNN_transformer = False  # default
                interleave_GNN_transformer = True  # much fancier
                parser.add_argument('--interleave_GNN_transformer', type=bool, default=interleave_GNN_transformer)

                if interleave_GNN_transformer:
                    weight_tying_for_interaction_GNN = False
                    # weight_tying_for_interaction_GNN = True
                    parser.add_argument('--weight_tying_for_interaction_GNN', type=bool,
                                        default=weight_tying_for_interaction_GNN)

                    interact_after_all_layers = True  # just interact one more time (like an "encore") after all layers
                    # interact_after_all_layers = False # to be safe, no more interaction at the end
                    parser.add_argument('--interact_after_all_layers', type=bool, default=interact_after_all_layers)

                    apply_norm_after_interaction = True  # otherwise some nodes with bridge information may receive information iteratively, causing large embedding values
                    # apply_norm_after_interaction = False
                    parser.add_argument('--apply_norm_after_interaction', type=bool,
                                        default=apply_norm_after_interaction)

                    if apply_norm_after_interaction:
                        emb_norm_method = 'L2'
                        # emb_norm_method = 'graph'
                        parser.add_argument('--emb_norm_method', type=str, default=emb_norm_method)

                    apply_mlp_after_interaction = True
                    # apply_mlp_after_interaction = False
                    parser.add_argument('--apply_mlp_after_interaction', type=bool,
                                        default=apply_mlp_after_interaction)

            node_token_alignment_loss = False  # default; node-token level (fine-grained)
            # node_token_alignment_loss = True
            parser.add_argument('--node_token_alignment_loss', type=bool, default=node_token_alignment_loss)

            gs_alignment_loss = False  # default; graph-sequence level (coarse)
            # gs_alignment_loss = True
            parser.add_argument('--gs_alignment_loss', type=bool, default=gs_alignment_loss)

parser.add_argument('--multi_modality', type=bool, default=multi_modality)
parser.add_argument('--loss', type=str, default='MSE')

##############################################################################

################### flags for dataset, normally do not change ##############################

# dataset = 'vitis-cnn'

dataset = 'harp'

parser.add_argument('--dataset', default=dataset)

benchmark = ['machsuite', 'poly']
parser.add_argument('--benchmarks', default=benchmark)

# tag = 'only-vitis'
# tag = 'whole-machsuite'


tag = 'whole-machsuite-poly'  # 05/29/2023: NeurIPS 2023 main track
parser.add_argument('--tag', default=tag)

#check_release_db = False  # default
check_release_db = False  # for released version of the folder `dse_database`
parser.add_argument('--check_release_db', type=bool, default=check_release_db)

dse_database_name = 'dse_database'  # default
if check_release_db:
    dse_database_name = 'dse_database_06122023_v2'
parser.add_argument('--dse_database_name', type=str, default=dse_database_name)

from utils import get_user, get_host
import torch

decoder_arch = []
####
# updated-1 --> fine-tuned-dse1
# updated-2 --> common
# updated-3 --> fine-tune-dse2
# updated-4 --> fine-tune-dse3
# updated-5 --> fine-tune-dse4
# updated-old-5 --> fine-tune-oldspeed-fromv1-todse4
# updated-new-5 --> fine-tune-todse4-fromv1
# updated-new-6 --> fine-tune-todse5-fromv1
# updated-new-5-norm-util --> fine-tune-todse5-fromv1-norm-util
# updated-yizhou-5 --> fine-tune-dse4-fromv1-twosetp-yizhou
# updated-new-6 --> fine-tune-todse5-fromv1 with results of new-5
# updated-freeze4-5 --> fine-tune-todse4-fromv1-freeze4
# updated-freeze5-5 --> fine-tune-todse4-fromv1-freeze5
# updated-onlynew-tuneall-5 --> fine-tune-dse4-only-new-points-tune-all
####

TARGETS = ['perf', 'quality', 'util-BRAM', 'util-DSP', 'util-LUT', 'util-FF',
           'total-BRAM', 'total-DSP', 'total-LUT', 'total-FF']

MACHSUITE_KERNEL = ['aes', 'gemm-blocked', 'gemm-ncubed', 'spmv-crs', 'spmv-ellpack', 'stencil',
                    'nw', 'md', 'stencil-3d']

if tag == 'whole-machsuite-poly':  # 05/29/2023: NeurIPS 2023 main track
#    poly_KERNEL = ['2mm', '3mm', 'adi', 'atax', 'bicg', 'bicg-large', 'covariance', 'doitgen',
#                   'doitgen-red', 'fdtd-2d', 'fdtd-2d-large', 'gemm-p', 'gemm-p-large', 'gemver',
#                   'gesummv', 'heat-3d', 'jacobi-1d', 'jacobi-2d', 'mvt', 'seidel-2d', 'symm',
#                   'symm-opt', 'symm-opt-medium', 'syrk', 'syr2k', 'trmm', 'trmm-opt', 'mvt-medium', 'correlation',
#                   'atax-medium', 'bicg-medium', 'gesummv-medium']
#    if v_db == 'v20':
#        poly_KERNEL.remove('correlation')

    poly_KERNEL = ['2mm', '3mm', 'adi', 'atax', 'bicg', 'bicg-large', 'covariance', 'doitgen',
                   'doitgen-red', 'fdtd-2d', 'fdtd-2d-large', 'gemm-p', 'gemm-p-large', 'gemver',
                   'gesummv', 'heat-3d', 'jacobi-1d', 'jacobi-2d', 'mvt', 'seidel-2d', 'symm',
                   'symm-opt', 'syrk', 'syr2k', 'trmm', 'trmm-opt', 'mvt-medium', 'correlation',
                   'atax-medium', 'bicg-medium', 'gesummv-medium', 'symm-opt-medium',
                   'gemver-medium']

elif tag == 'wmp-d':  # 05/29/2023: NeurIPS 2023 dataset track
    poly_KERNEL = ['2mm', '3mm', 'adi', 'atax', 'bicg', 'bicg-large', 'covariance', 'doitgen',
                   'doitgen-red', 'fdtd-2d', 'fdtd-2d-large', 'gemm-p', 'gemm-p-large', 'gemver',
                   'gesummv', 'heat-3d', 'jacobi-1d', 'jacobi-2d', 'mvt', 'seidel-2d', 'symm',
                   'symm-opt', 'syrk', 'syr2k', 'trmm', 'trmm-opt', 'mvt-medium', 'correlation',
                   'atax-medium', 'bicg-medium', 'gesummv-medium', 'symm-opt-medium',
                   'gemver-medium']
else:
    raise NotImplementedError()

#include_kernels = poly_KERNEL
#parser.add_argument('--include_kernels', default=poly_KERNEL)

simple_KERNEL = ['reduction', 'relu', 'mat-vec-sub-add', 'vec-mul-add-dep',
                 '3vec-mul-add-stencil', 'messy-stencil-1d', 'unrolled-vec-add',
                 'dot', '3vec-mul-element', '3vec-add-element', 'vec-mul', 'max-vec',
                 'vec-mul-add', '2vec-add', 'cond-vec-mul-add', 'non-zero-vec']  # '1d-conv

# graph_type = ''  # original DAC22 graph
# graph_type = 'extended-pseudo-block-base' ## check that the connected ones are not used
# graph_type = 'extended-pseudo-block-connected'
graph_type = 'extended-pseudo-block-connected-hierarchy'
#graph_type = ''
# if sequence_modeling:
#     graph_type = ''
parser.add_argument('--graph_type', default=graph_type)
#######################################################################################################

graph_transformer_option = None
# graph_transformer_option = True
if graph_transformer_option:
    graph_transformer_option = {
        'graph_encoding': ['degree', 'Laplacian'],
        'Laplacian_K': 20,
        'is_undirected': False,
    }
    # conv_type = 'mha'
    conv_type = 'gps_conv'  # slow and memory-heavy
    graph_transformer_option['conv_type'] = conv_type
    if conv_type == 'mha':
        graph_transformer_option['num_heads'] = 1
        graph_transformer_option['attention_map_aug'] = 'proximity'
    elif conv_type == 'gps_conv':
        graph_transformer_option['num_heads'] = 2
        graph_transformer_option['need_local_mpnn'] = True
    else:
        assert False
if sequence_modeling:
    graph_transformer_option = None
parser.add_argument('--graph_transformer_option', type=dict, default=graph_transformer_option)

## graph auto encoder
# gae_T = True
gae_T = False
if sequence_modeling:
    gae_T = False
gae_T = False
parser.add_argument('--gae_T', default=gae_T)
gae_P = False
parser.add_argument('--gae_P', default=gae_P)
if gae_P:
    parser.add_argument('--input_encode', default=False)
    # d_type = 'None'
    # d_type = 'type1'
    d_type = 'type1'
    parser.add_argument('--decoder_type', default=d_type)

## self-supervised learning
SSL = False
parser.add_argument('--SSL', default=SSL)

# load_pretrained_GNN = False  # default
load_pretrained_GNN = False
if SUBTASK == 'train':
    load_pretrained_GNN = True

load_pretrained_GNN = False # should be always False for now

    # load_pretrained_GNN = False
# if sequence_modeling and not multi_modality:
#     load_pretrained_GNN = False
if TASK == 'class':
    load_pretrained_GNN = False
if graph_transformer_option is not None:
    load_pretrained_GNN = False  # may have additional node positional encoding (shape mismatch)
parser.add_argument('--load_pretrained_GNN', type=bool, default=load_pretrained_GNN)

if load_pretrained_GNN:
    pretrained_GNN_name = 'our'
    # pretrained_GNN_name = 'GraphMAE'
    parser.add_argument('--pretrained_GNN_name', type=str, default=pretrained_GNN_name)
guide_loss_w = 0.003
parser.add_argument('--guide_loss_w', type=float, default=guide_loss_w)

load_guidance_emb = True
parser.add_argument('--load_guidance_emb', type=bool, default=load_guidance_emb)
guidance_emb_path = "pretrain_gnn/zongyue_code/pretrained_guide_emb.pth"
parser.add_argument('--guidance_emb_path', type=str, default=guidance_emb_path)

class_model_path = None
parser.add_argument('--class_model_path', default=class_model_path)

all_kernels = True
parser.add_argument('--all_kernels', type=bool, default=all_kernels)
parser.add_argument('--sample_finetune', type=bool, default=False)

FT_extra = False
parser.add_argument('--FT_extra', default=FT_extra)  ## fine-tune only on the new data points

parser.add_argument('--new_speedup', default=True)  # new_speedup: same reference point across all,
# old_speedup: base is the longest latency and different per kernel

feature_extract = False
parser.add_argument('--feature_extract',
                    default=feature_extract)  # if set to true GNN part will be fixed and only MLP will be trained
if feature_extract:
    parser.add_argument('--random_MLP', default=False)  # true: initialize MLP randomly
    fix_gnn_layer = None  ## if none, all layers will be fixed
    fix_gnn_layer = 5  ## number of gnn layers to freeze, feature_extract should be set to True
    parser.add_argument('--fix_gnn_layer', default=fix_gnn_layer)  # if not set to none, feature_extract should be True


test_kernels = None
#test_kernels = ['correlation', '3mm', 'fdtd-2d', 'adi', 'gemver', 'trmm-opt']
#test_kernels += ['stencil-3d', 'jacobi-1d', 'mvt', '2mm', 'fdtd-2d-large', 'gemm-ncubed']
ignore_kernels = []



parser.add_argument('--ignore_kernels', type=list, default=ignore_kernels)

# test_kernels1 = ['jacobi-1d', '3mm', 'fdtd-2d', 'gemm-p', 'gemver']
# test_kernels2 = ['fdtd-2d', 'jacobi-2d', 'trmm-opt'] ## to be used to split the kernels between training and testing. this is the list of test kernels
# test_kernels = list(set(test_kernels1 + test_kernels2))
# test_kernels = test_kernels2

# if 'vpn' in get_host():
#     # local machine
#     test_kernels = None  # will be fast
# # test_kernels = None # will be fast

if test_kernels is not None:
    tvt_split_by = 'kernels_inductive'
    parser.add_argument('--test_kernels', default=test_kernels)
    parser.add_argument('--val_ratio_in_test_kernels', type=float,
                        default=0)  # what percentage to allocate for validation
    parser.add_argument('--val_ratio_in_train_kernels', type=float,
                        default=0.15)  # what percentage to allocate for validation
    parser.add_argument('--test_ratio_in_train_kernels', type=float,
                        default=0.15)  # what percentage to allocate for additional transductive testing
    # shuffle_val_test = False
    # shuffle_val_test = True
    # parser.add_argument('--shuffle_val_test', type=bool, default=shuffle_val_test)
else:
    tvt_split_by = 'designs_transductive'
    parser.add_argument('--val_ratio', type=float, default=0.15)  # ratio of database for validation set
parser.add_argument('--tvt_split_by', type=str, default=tvt_split_by)

itype_mask_perc = 0
# itype_mask_perc = 0.15
parser.add_argument('--itype_mask_perc', type=float, default=itype_mask_perc)

gtype = 'programl'
parser.add_argument('--gtype', default=gtype)

# only_pragma_nodes = True # dangerous; will only keep pragma nodes and no edge_index
only_pragma_nodes = False
parser.add_argument('--only_pragma_nodes', type=bool, default=only_pragma_nodes)

# encode_full_text = 'word2vec'
# encode_full_text = 'roberta'
encode_full_text = 'None'
parser.add_argument('--encode_full_text', default=encode_full_text)

fulltext_dim = None
if encode_full_text == 'word2vec':
    # fulltext_dim = 8
    fulltext_dim = 16
    # fulltext_dim = 32
    # fulltext_dim = 64
    # fulltext_dim = 128
parser.add_argument('--fulltext_dim', type=int, default=fulltext_dim)

# parser.add_argument('--fix_tile_bug', type=bool, default=True)

if 'dse' in SUBTASK:

    explorer = 'exhaustive'
    parser.add_argument('--explorer', default=explorer)
    parser.add_argument('--dist_parent', default=True)
    parser.add_argument('--dist_child', default=True)

    parser.add_argument('--prune_util', default=True)  # only DSP and BRAM
    parser.add_argument('--prune_class', default=False)

    pids = ['__PARA__L3', '__PIPE__L2', '__PARA__L1', '__PIPE__L0', '__TILE__L2', '__TILE__L0', '__PARA__L2',
            '__PIPE__L0']
    parser.add_argument('--ordered_pids', default=pids)

    parser.add_argument('--separate_perf', type=bool, default=False)
    # dse_mode = 'gen_embeddings'
    dse_mode = 'real_dse'
    parser.add_argument('--dse_mode', type=str, default=dse_mode)

    if run_kernel == 'None':
        run_kernel = '3mm'
        # run_kernel = 'fdtd-2d'
        # run_kernel = 'jacobi-1d'
        # run_kernel = 'gemm-p'
        # run_kernel = 'gemver'

        # run_kernel = 'doitgen'
        # run_kernel = 'bicg'
        # run_kernel = 'gesummv'
        # run_kernel = '2mm'

    parser.add_argument('--run_kernel', type=str, default=run_kernel)
    parser.add_argument('--collect_embs', type=bool, default=True)
    # prune_invalid = True
    prune_invalid = False
    parser.add_argument('--prune_invalid', type=bool, default=prune_invalid)

    # if load_model_class == 'None':
    #     load_model_class = 'src/logs/class_train_whole-machsuite-polly_2022-05-24T21-43-37.521335_15_hours_MAML-'
    # if '.pth' not in load_model_class:
    #     load_model_class += '/maml_model_state_dict.pth'
    parser.add_argument('--load_model_class', type=str,
                        default=check_prepend_root_folder(load_model_class))


# force_regen = True
force_regen = False
parser.add_argument('--force_regen', type=bool, default=force_regen)

# if force_regen:
load_encoders_label = None
#encoder_path = '../save/harp/r13-ifdb-epbch-regression_ep-False_nowi_False-n_speedup-log2_np_False_whole-machsuite-poly_programl_False_False_None_None_nosplit_regular_encoder_True_s_penhance_codet5_64_tm_pk_v2_fc_co16_programl+src_code_feed_pclcc_pseudo_ntic_igt/encoders.klepto'
#encoder_path = 'None'
encoder_path = 'logs/train_2024-03-26T19-12-18.035699_regression_scai5/progsg_preprocessors.klepto'


if load_pretrained_GNN: # should be False
    #encoder_path = '../../file/zongyue_pretrain/v18_v20_encoders.klepto'
    encoder_path = '../../file/zongyue_pretrain/harp_encoders.klepto'
    load_encoders_label = 'zongyue_04272023'

if encoder_path != 'None' and (not (encoder_path is None)):
    encoder_path = check_prepend_root_folder(encoder_path)
    parser.add_argument('--load_encoders_label', type=str, default=load_encoders_label)

#encoder_path = '../save/harp/r13-ifdb-epbch-regression_ep-False_nowi_False-n_speedup-log2_np_False_whole-machsuite-poly_programl_False_False_None_None_nosplit_regular_encoder_True_s_penhance_codet5_64_tm_pk_v2_fc_co16_programl+src_code_feed_pclcc_pseudo_ntic_igt/preprocessors.klepto'
encoder_path = 'logs/train_2024-03-26T19-12-18.035699_regression_scai5/progsg_preprocessors.klepto'
parser.add_argument('--encoder_path', type=str, default=encoder_path)

# outlier_removal = None
# outlier_removal = '0'
# parser.add_argument('--outlier_removal', default=outlier_removal)


model_tag = 'test'
parser.add_argument('--model_tag', default=model_tag)

parser.add_argument('--activation', default='elu')

outlier_removal = None
# outlier_removal = '50'
parser.add_argument('--outlier_removal', default=outlier_removal)

parser.add_argument('--no_pragma', type=bool, default=False)

# if load_model != 'None' and 'atefeh' in load_model:
#     if sequence_modeling:
#         if combine_node_edge_labels:
#             num_layers = 8
#         else:
#             num_layers = 0
#     else:
#         num_layers = 8
# else:
if sequence_modeling:
    if combine_node_edge_labels:
        num_layers = 8
    else:
        # num_layers = 0 # default; fast
        # num_layers = 4
        num_layers = 8
        if interleave_GNN_transformer:  # TODO: tune it
            # num_layers = 0
            # num_layers = 6
            num_layers = 8
else:
    if graph_transformer_option:
        # num_layers = 2
        num_layers = 8
    else:
        num_layers = 2

        # num_layers = 8
parser.add_argument('--num_layers', type=int, default=num_layers)  ### regression num_layer: 6, class: 8

# D = 64
D = 512
if multi_modality and combine_fashion == 'share_final_MLPs' and feed_p_to_tf:
    D = 512

if code_encoder in ['codebert', 'graphcodebert']:
    D = 768

if code_encoder == 'codellama':
    D = 3072 


parser.add_argument('--D', type=int, default=D)

# if TASK == 'regression':
# target = 'quality'
# target = 'util-BRAM'
# target = 'util-DSP'
# target = 'util-LUT'
# target = 'util-FF'
# multi_target = ['perf', 'util-DSP']
multi_target = ['perf', 'util-LUT', 'util-FF', 'util-DSP', 'util-BRAM']
## DAC'22
# multi_target = ['perf', 'util-LUT', 'util-FF', 'util-DSP']
# multi_target = ['util-DSP', 'util-BRAM', 'util-LUT', 'util-FF']
# multi_target = ['util-DSP', 'util-BRAM', 'util-FF']
# multi_target = ['util-BRAM']
# multi_target = ['perf', 'util-DSP', 'util-BRAM']
target = 'perf'
CLASSIFICATION_TARGETS = ['perf']
REGRESSION_TARGETS = ['perf', 'util-DSP', 'util-BRAM', 'util-LUT', 'util-FF']
parser.add_argument('--target', default=multi_target)

if graph_transformer_option is None:
    # gnn_type = 'gcn'
    # gnn_type = 'gat'
    gnn_type = 'transformer'
    parser.add_argument('--gnn_type', type=str, default=gnn_type)

parser.add_argument('--min_allowed_latency', type=float,
                    default=100.0)  ## if latency is less than this, prune the point (used when synthesis is not valid)

encode_edge = True
if sequence_modeling and not multi_modality:
    encode_edge = False

parser.add_argument('--encode_edge', type=bool, default=encode_edge)
encode_edge_position = False
parser.add_argument('--encode_edge_position', type=bool, default=encode_edge_position)


# jkn_mode = 'lstm'
jkn_mode = 'max'
parser.add_argument('--jkn_mode', type=str, default=jkn_mode)

jkn_enable = True
# jkn_enable = False
parser.add_argument('--jkn_enable', type=bool, default=jkn_enable)

node_attention = True
# if sequence_modeling:
#     node_attention = False
parser.add_argument('--node_attention', type=bool, default=node_attention)


pragma_as_MLP, type_parallel, type_merge = True, '2l', '2l' # keep both as 2l
pragma_as_MLP = True
parser.add_argument('--pragma_as_MLP', type=bool, default=pragma_as_MLP)
gnn_layer_after_MLP = 1
pragma_MLP_hidden_channels, merge_MLP_hidden_channels = None, None
if pragma_as_MLP:
    if gnn_layer_after_MLP == 1: model_ver = 'best_post-gnn-2l'

    if type_parallel == '2l':
        pragma_MLP_hidden_channels = '[in_D // 2]'
    elif type_parallel == '3l':
        pragma_MLP_hidden_channels = '[in_D // 2, in_D // 4]'

    if type_merge == '2l':
        merge_MLP_hidden_channels = '[in_D // 2]'
    elif type_merge == '3l':
        merge_MLP_hidden_channels = '[in_D // 2, in_D // 4]'
    else:
        raise NotImplementedError()
    gae_T, P_use_all_nodes, separate_pseudo, separate_T, dropout, num_features, edge_dim = False, True, True, False, 0.1, 153, 335
else:
    gae_T, P_use_all_nodes, separate_pseudo, separate_T, dropout, num_features, edge_dim = True, False, False, True, 0.1, 156, 335
    model_ver = 'hierarchy-PT'
if pragma_as_MLP:
    assert graph_type == 'extended-pseudo-block-connected-hierarchy'
    assert multi_modality, 'Not implemented yet for basic non-multi_modality (need to do that in model.oy\'s Net'
    parser.add_argument('--gnn_layer_after_MLP', default=gnn_layer_after_MLP) ## number of message passing layers after MLP (pragma as MLP)
    pragma_as_MLP_list = ['tile', 'pipeline', 'parallel']
    parser.add_argument('--pragma_as_MLP_list', default=pragma_as_MLP_list)
    pragma_scope = 'block'
    parser.add_argument('--pragma_scope', default=pragma_scope)
    keep_pragma_attribute = False if pragma_as_MLP else True
    parser.add_argument('--keep_pragma_attribute', default=keep_pragma_attribute)
    pragma_order = 'sequential'
    pragma_order = 'parallel_and_merge' # best result
    parser.add_argument('--pragma_order', default=pragma_order)
    # pragma_MLP_hidden_channels = None
    # pragma_MLP_hidden_channels = '[in_D // 2]'
    parser.add_argument('--pragma_MLP_hidden_channels', default=pragma_MLP_hidden_channels)
    # merge_MLP_hidden_channels = '[in_D // 2]'
    parser.add_argument('--merge_MLP_hidden_channels', default=merge_MLP_hidden_channels)
    parser.add_argument('--num_conv_layers_for_MLP_pragma', default=1)


parser.add_argument('--MLP_common_lyr', default=0)

if node_attention:
    parser.add_argument('--node_attention_MLP', type=bool, default=False)

    # separate_P_T = True
    separate_P_T = False  # critical: for NeurIPS 2023, consistently turn off P/T separation for all models
    if sequence_modeling:
         separate_P_T = False
    parser.add_argument('--separate_P_T', type=bool, default=separate_P_T)

    #if separate_P_T:
    #    parser.add_argument('--P_use_all_nodes', type=bool, default=True)

    separate_P = True
    parser.add_argument('--separate_P', type=bool, default=separate_P)
    separate_icmp = False
    parser.add_argument('--separate_icmp', type=bool, default=separate_icmp)
    parser.add_argument('--separate_T', type=bool, default=separate_T)
    parser.add_argument('--separate_pseudo', type=bool, default=separate_pseudo)

    if separate_P:
        parser.add_argument('--P_use_all_nodes', type=bool, default=P_use_all_nodes)
 


encoder = True
parser.add_argument('--pragma_encoder', type=bool, default=encoder)
parser.add_argument('--pragma_uniform_encoder', type=bool, default=True)

# separate_pseudo = True
# parser.add_argument('--separate_pseudo', type=bool, default=separate_pseudo)

EPSILON = 1e-3
parser.add_argument('--epsilon', default=EPSILON)
NORMALIZER = 1e7
parser.add_argument('--normalizer', default=NORMALIZER)
parser.add_argument('--util_normalizer', default=1)
# MAX_NUMBER = 3464510.00
MAX_NUMBER = 1e10
parser.add_argument('--max_number', default=MAX_NUMBER)

norm = 'speedup-log2'  # 'const' 'log2' 'speedup' 'off' 'speedup-const' 'const-log2' 'none' 'speedup-log2'
parser.add_argument('--norm_method', default=norm)

target_preproc = 'None'
# target_preproc = 'minmax'
# target_preproc = 'z-score'
parser.add_argument('--target_preproc', type=str, default=target_preproc)

parser.add_argument('--target_convert_back', type=bool, default=True)

parser.add_argument('--invalid', type=bool, default=False)  # False: do not include invalid designs

parser.add_argument('--multi_target', type=bool, default=True)

parser.add_argument('--activation_type', default='elu')

# For ranking.
# margin_loss = True
margin_loss = False
parser.add_argument('--margin_loss', type=bool, default=margin_loss)

save_model = True
parser.add_argument('--save_model', type=bool, default=save_model)

if save_model:
    parser.add_argument('--save_every_epoch', type=int, default=10000)  # do not save too many models!

parser.add_argument('--encode_log', type=bool, default=False)

target_factor = 1
# target_factor = 100
# target_factor = 1e-7
# target_factor = 1e-5
parser.add_argument('--target_factor', type=int, default=target_factor)

target_transform = None
# target_transform = 'log'
parser.add_argument('--target_transform', type=str, default=target_transform)

loss_scale = {'perf': 1.0, 'util-DSP': 1.0, 'util-BRAM': 1.0,
              'util-LUT': 1.0, 'util-FF': 1.0}
# loss_scale = None
parser.add_argument('--loss_scale', type=dict, default=loss_scale)

if TASK in ['regression', 'class']:
    pairwise_class = False
    # pairwise_class = True
    parser.add_argument('--pairwise_class', type=bool, default=pairwise_class)

    if pairwise_class:
        # force_regen_pairwise_data = False
        force_regen_pairwise_data = True
        parser.add_argument('--force_regen_pairwise_data', type=bool, default=force_regen_pairwise_data)

        comp_ops = ['hadamard', 'diff']
        parser.add_argument('--comp_ops', type=list, default=comp_ops)

        loss_components = 'both'
        # loss_components = 'regression_only'
        # loss_components = 'class_only'
        parser.add_argument('--loss_components', type=str, default=loss_components)

        if loss_components == 'both':
            fix_encoder_classMLPs = False
            # fix_encoder_classMLPs = True
            parser.add_argument('--fix_encoder_classMLPs', type=bool, default=fix_encoder_classMLPs)

        if SUBTASK == 'train':
            # both_train_loaders = False
            both_train_loaders = True
            parser.add_argument('--both_train_loaders', type=bool, default=both_train_loaders)

if TASK == 'rl':
    parser.add_argument('--num_envs', type=int, default=2)

# batch_size = 2
# batch_size = 128
# batch_size = 64
data_loader_num_workers = 0  # default; 0 means that the data will be loaded in the main process
batch_size=24
parser.add_argument('--batch_size', type=int, default=batch_size)

parser.add_argument('--data_loader_num_workers', type=int, default=data_loader_num_workers)

gpu = 'auto'
# gpu = '0'
#gpu = 'user_input'
if gpu in ['auto', 'user_input']:
    gpu = get_best_gpu(gpu)

device = str('cuda:{}'.format(gpu) if torch.cuda.is_available() and gpu != -1
             else 'cpu')
parser.add_argument('--device', default=device)

if TASK == 'regression':
    # epoch_num = 1 # debugging
    # epoch_num = 800
    epoch_num = 1000
else:
    epoch_num = 200
if 'vpn' in get_host():
    epoch_num = 1
    if force_regen:
        epoch_num = 0

parser.add_argument('--epoch_num', type=int, default=epoch_num)


max_stagnant_epochs = 100
parser.add_argument('--max_stagnant_epochs', type=int, default=max_stagnant_epochs)

debug_iter = -1  # no debugging
# debug_iter = 2
# debug_iter = 9999
parser.add_argument('--debug_iter', type=int, default=debug_iter)

if 'train' in SUBTASK:
    # ignore_testing = False # default; slow
    ignore_testing = True
    parser.add_argument('--ignore_testing', type=bool, default=ignore_testing)

    ignore_validation = False  # default; slow
    if 'vpn' in get_host():
        ignore_validation = True
    parser.add_argument('--ignore_validation', type=bool, default=ignore_validation)

if 'inference' in SUBTASK:
    assert replace_with_random_weights in [None, False]

    save_emb = False  # default
    # save_emb = True
    parser.add_argument('--save_emb', type=bool, default=save_emb)

    #adaptation_needed = False  # default
    adaptation_needed = False
    parser.add_argument('--adaptation_needed', type=bool, default=adaptation_needed)

    if adaptation_needed:
        test_holdout_ratio = 0.3
        parser.add_argument('--test_holdout_ratio', type=float, default=test_holdout_ratio)

        adaptation_valid_num = 40
        parser.add_argument('--adaptation_valid_num', type=int, default=adaptation_valid_num)

        repeat_times = 1
        if 'vpn' in get_host():  # local
            repeat_times = 1
        if 'dse' in SUBTASK:
            repeat_times = 1
        parser.add_argument('--repeat_times', type=int, default=repeat_times)

        adaptation_num_dp = 300
        parser.add_argument('--adaptation_num_dp', type=int, default=adaptation_num_dp)

        # num_mini_epochs = 10
        num_mini_epochs = 30
        if 'vpn' in get_host():  # local
            num_mini_epochs = 1
        parser.add_argument('--num_mini_epochs', type=int, default=num_mini_epochs)

        if num_mini_epochs <= 10:
            test_which_adapted_model = 'last_epoch'
        else:
            test_which_adapted_model = 'best_train'
        if adaptation_num_dp > 50:
            test_which_adapted_model = 'best_valid'
        parser.add_argument('--test_which_adapted_model', type=str, default=test_which_adapted_model)

shuffle = True  # default
# shuffle = False
parser.add_argument('--shuffle', type=bool, default=shuffle)

weight_switch = False
parser.add_argument('--weight_switch', type=bool, default=weight_switch)
# opt_type = 'Adam'
opt_type = 'AdamW'
#opt_type = 'Sep_LR_AdamW'
parser.add_argument('--opt_type', type=str, default=opt_type)

# lr = 0.001
# lr = 1e-4
# lr = 1e-5
if sequence_modeling:
    # lr = 1e-5
    lr = 1e-5
    #lr = 1e-4
    # lr = 1e-4
    # lr = 1e-6
else:
    if graph_transformer_option is None:
        # lr = 5e-4
        # lr = 0.5e-3
        # lr = 1e-3
        lr = 1e-4
    else:
        lr = 1e-4
parser.add_argument('--lr', type=float, default=lr)

max_grad_norm = None
# max_grad_norm = 1.0
parser.add_argument('--max_grad_norm', type=float, default=max_grad_norm)

if 'AdamW' in opt_type:
    weight_decay = 0.01  # default of Adam
else:
    weight_decay = 0
#elif opt_type == 'AdamW':
#    weight_decay = 0.01  # default of AdamW
#else:
#    assert False
# weight_decay = 0.1 # be careful; large L2 regularization

parser.add_argument('--weight_decay', type=float, default=weight_decay)

plot = True
if SSL: plot = False
parser.add_argument('--plot_pred_points', type=bool, default=plot)

fix_randomness = True  # TODO: may have issue with result
# fix_randomness = False
parser.add_argument('--fix_randomness', type=bool, default=fix_randomness)

if fix_randomness:
    seed = 123
    # seed = 777
    parser.add_argument('--random_seed', type=int, default=seed)

"""
Other info.
"""
parser.add_argument('--user', default=get_user())

parser.add_argument('--hostname', default=get_host())

exp_name = ''
parser.add_argument('--exp_name', default=exp_name)

FLAGS = parser.parse_args()
