# ProgSG

## Trained Model

Download trained model from [here](https://drive.google.com/drive/folders/1ZsBiIxtMvSSNARVYoWuJ6l0ziEvRWbO6?usp=sharing)

This model is trained with all kernels using v21 data.

## Requirements and Dependencies

You can install the required packages for running this project using:

```
sudo apt-get install python3-venv
python3 -m venv venv
source venv/bin/activate
pip3 install --upgrade pip
pip3 install -r requirements.txt
```

## Running the Project

You can run the code with
```
python main.py
```

Edit *config.py* to change the code configuration.

When you run the code for the first time, set *force_regen* in *config.py* to True to convert data into pytorch format.

Most of flags in *config.py* do not need to be changed. Below are some flags you might want to change:

- **subtask**: "dse", "train", or "inference", specify which task you want to run.
- **load_model**: specify the path of the model you want to load. "None" if there is no trained model.
- **batch_size**: batch size of training.
- **epoch_num**: number of epochs to train.
- **test_kernels**: kernels not included during training. 
- **D**: dimensions of hidden features.


If you want to run **CodeT5** with our code, change the values of following flags:

- **disable_gnn**=True (line 18) 
- **feed_p_to_tf**=False (line 194)
- **pc_links_ug**=None (line 221)
- **node_token_interaction**=False (line 225)
