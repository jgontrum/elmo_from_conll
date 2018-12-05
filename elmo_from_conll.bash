#!/bin/bash

CONLLFILE=$1
HDF5OUTPUT=$2

# Specify the path to the model here (or leave blank for default)
ELMO_WEIGHTS=$3
ELMO_OPTIONS=$4

# Define arguments for the ELMo tool.
ARGS="--all"

if test "$#" -ne 4; then
    echo "Usage: <CONLL FILE> <OUTPUT HDF5 FILE> <ELMO OPTIONS> <ELMO WEIGHTS>"
    exit
fi

echo "Extracting sentences from CoNLL file..."
python conll_parser.py $CONLLFILE > sentences.txt

echo "Running ELMo..."

if [ -n "$ELMO_OPTIONS" ]; then
    ELMO_OPTIONS="--options-file $ELMO_OPTIONS"
fi

if [ -n "$ELMO_WEIGHTS" ]; then
    ELMO_WEIGHTS="--weight-file $ELMO_WEIGHTS"
fi

# The actual ELMo command. Edit things here, if needed.
allennlp elmo sentences.txt $HDF5OUTPUT $ARGS $ELMO_OPTIONS $ELMO_WEIGHTS

rm sentences.txt

echo "Finished"
