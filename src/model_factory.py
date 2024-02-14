from config import FLAGS
from model import Net
from model_multi_modality import MultiModalityNet
from pretrained_GNN_handler import create_and_load_zongyue_pretrained_GNN


def create_model(dataset, pragma_dim, task=FLAGS.task):
    # saver.log_info(f'edge_dim={edge_dim}')
    # if FLAGS.dataset == 'simple-programl' or FLAGS.target_kernel is not None:
    #     init_pragma_dict = {'all': [1, 21]}
    if FLAGS.model == 'code2vec':
        assert False
    else:
        assert FLAGS.model == 'our'
        if FLAGS.multi_modality:
            c = MultiModalityNet
        else:
            c = Net
    model = c(task=task, init_pragma_dict=pragma_dim, dataset=dataset).to(
        FLAGS.device)
    if FLAGS.load_pretrained_GNN:
        model.pretrained_GNN_encoder = create_and_load_zongyue_pretrained_GNN().to(FLAGS.device)
    return model
