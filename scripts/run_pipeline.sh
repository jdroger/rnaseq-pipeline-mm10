#!/bin/bash
# Master script for RNA-seq pipeline
# 02.28.2021 JR
 
# (Test) print out files in arg
# (Should run checks for at least file extension and formatting later)

# setup conda environment
CONDA_PATH=/home/jdroger/miniconda3
if test -d !${CONDA_PATH}; then
    echo "Miniconda not installed on home directory. Please see 'https://docs.conda.io/en/latest/miniconda.html' for installation"
    exit
else
    ENVS=$(conda env list | awk '{print $1}' )
    if [[ $ENVS = *"rnaseq"* ]]; then
        echo "Activating conda environment 'rnaseq'"
        conda activate rnaseq
    else 
        echo "Conda environment 'rnaseq' does not exist--building from .yml file..."
        conda env create -f conda-rnaseq.yml
    fi;
fi

# setup global variables (assumes that directory tree is intact)
DIR_HOME=${PWD}
DIR_SCRIPTS=${DIR_HOME}/scripts/
DIR_DATA=${DIR_HOME}/data/

DIR_SRA=${DIR_DATA}/sra/
DIR_FASTQC=${DIR_DATA}/fastqc/
DIR_TRIM=${DIR_DATA}/trimmomatic/
DIR_COUNT=${DIR_DATA}/salmon/
DIR_REF=${DIR_COUNT}/reference-genomes/alias/mm10/salmon_partial_sa_index/default/

ACC_LIST=$1
NUM_THREADS=8

# run fastq-dump
echo "Running fastq-dump [1/4]"
source ${DIR_SCRIPTS}/preprocess_fastq-dump.sh ${ACC_LIST}

# run fastqc
echo "Running FastQC [2/4]"
source ${DIR_SCRIPTS}/preprocess_fastqc.sh

# run trimmomatic
echo "Running Trimmomatic [3/4]"
source ${DIR_SCRIPTS}/preprocess_trimmomatic.sh

# run salmon
echo "Running Salmon [4/4]"
source ${DIR_SCRIPTS}/quantify_salmon.sh