#!/bin/bash
# Shell script for quantifying transcripts via salmon
# 03.30.2021 JR
#
# define variables
TOOLKIT=/usr/bin/salmon-latest_linux_x86_64/bin/
DIR_HOME=/mnt/e/other-projects/rnaseq/
DIR_DATA=${DIR_HOME}/data/
DIR_FASTQ=${DIR_DATA}/trimmomatic/
DIR_SAVE=${DIR_DATA}/salmon/
# 
# construct index from transcriptome
# 
if test -d "${DIR_SAVE}/mmusculus_index"; then
		echo "index already exists, skipping to quantification"
	else 
        echo "building index using ${DIR_SAVE}/mmusculus.fa.gz..."
        ${TOOLKIT}/salmon index \
                -t ${DIR_SAVE}/mmusculus.fa.gz \
                -i ${DIR_SAVE}/mmusculus_index
fi
# 
# run salmon on all fastq files + save count matrix