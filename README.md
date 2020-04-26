# Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model).

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/bernai/pytorch-rnn-lm.git
    cd pytorch-rnn-lm

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/install_packages.sh

Preprocess data (Fairy Tales of Hans Christian Andersen, Project Gutenberg):

    ./scripts/download_data.sh

Train a model (training script settings: 40 epochs, emsize 200, nhid 200, dropout 0.4):

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Generate (sample) some text from a trained model with:

    ./scripts/generate.sh

#Changes
download_data.sh: 
* changed paths
* changed size of train, test, valid

generate.sh:
* changed paths
* set temperature
* changed length of text

train.sh:
* changed paths
* changed dropout

27200.txt:
* added; data for preprocessing


#Training Results

I decided to change dropout and got the best result for 0.4. A value between 0.35 and 0.5 would be ideal for my data set according to the table below.
Still, the perplexity seems very high in general, even for the lowest value:

| dropout | test ppl |
|---------|----------------|
| 0.2     | 129.62         |
| 0.35    | 115.80         |
| 0.4     | 114.39         |
| 0.5     | 114.78         |
| 0.65    | 115.80         |
| 0.85    | 168.99         |

I noticed that even though my text file was 2 MB, the train file was about 200 KB, which seemed small compared to the trump speech train file. 
That's why I changed download_data.sh slightly. After that, train.txt was about 800 KB and the results were much better:

| dropout | test ppl |
|---------|----------------|
| 0.2     | 75.46         |
| 0.35    | 71.89         |
| 0.4     | 71.26         |
| 0.5     | 71.76         |
| 0.65    | 77.96         |
| 0.85    | 129.70         |

This table shows that more training data leads to lower perplexity, too high dropout leads to bad performance and that 0.4 is still the best option out of this table for my data, so I used that model to generate a sampled text and set --temperature to 2.5 and words to 200.