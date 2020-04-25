#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

mkdir -p $data

tools=$base/tools

# link default training data for easier access

mkdir -p $data/wikitext-2

for corpus in train valid test; do
    absolute_path=$(realpath $tools/pytorch-examples/word_language_model/data/wikitext-2/$corpus.txt)
    ln -snf $absolute_path $data/wikitext-2/$corpus.txt
done

# download a different interesting data set!

mkdir -p $data/tales

mkdir -p $data/tales/raw

mv 27200.txt $data/tales/raw

# preprocess slightly

cat $data/tales/raw/27200.txt | python $base/scripts/preprocess_raw.py > $data/tales/raw/tales_hca.cleaned.txt

# tokenize, fix vocabulary upper bound

cat $data/tales/raw/tales_hca.cleaned.txt | python $base/scripts/preprocess.py --vocab-size 5000 --tokenize --lang "en" > \
    $data/tales/raw/tales_hca.preprocessed.txt

# split into train, valid and test

head -n 2000 $data/tales/raw/tales_hca.preprocessed.txt > $data/tales/valid.txt
head -n 4000 $data/tales/raw/tales_hca.preprocessed.txt | tail -n 2000 > $data/tales/test.txt
tail -n 13040 $data/tales/raw/tales_hca.preprocessed.txt > $data/tales/train.txt
