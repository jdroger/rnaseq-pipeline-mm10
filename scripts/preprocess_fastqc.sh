#!/bin/bash
# Shell script for assessing read quality via FastQC
# 02.26.2021 JR
#
# define variables
# TOOLKIT=/usr/bin/FastQC/
# DIR_HOME=/mnt/e/other-projects/rnaseq/
# DIR_DATA=${DIR_HOME}/data/
# DIR_FASTQ=${DIR_DATA}/sra/
# DIR_SAVE=${DIR_DATA}/fastqc/
#
# save names of fastq files to txt file for passing to FastQC
# ls ${DIR_FASTQ}/*.fastq > ${DIR_SAVE}/SRR_FastQC_List.txt
# cat ${DIR_SAVE}/SRR_FastQC_List.txt
# 
# run FastQC on each fastq file + save html files
# sudo ${TOOLKIT}/fastqc ${DIR_SAVE}/SRR_FastQC_List.txt --outdir=${DIR_SAVE}
for FILE in ${DIR_SRA}/*.fastq.gz; do
    fastqc ${FILE} 
        --threads ${NUM_THREADS} 
        --outdir=${DIR_FASTQC};
done