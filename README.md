# ProgSG

[![DOI](https://zenodo.org/badge/757747904.svg)](https://zenodo.org/doi/10.5281/zenodo.13323521)


## Trained Model

Download trained model from [here](https://drive.google.com/file/d/1_-dmgzBdcpGkYLUXjsXQ2CL5f9wNDrJa/view?usp=drivesdk)

This model is trained with all kernels using v21 data.

You need to unzip the downloaded .tar file in the *src/logs* folder. 

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

After decompressing the trained model, you can run the inference to reproduce our RMSE result via
```
python main.py --force_regen True
```

Notice that you only need to add "--force\_regen True" the first time you run our code to encode the dataset. Later you can simply run via
```
python main.py
```

Edit *config.py* to change the code configuration.


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
