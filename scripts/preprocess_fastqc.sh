#!/bin/bash
# Shell script for assessing read quality via FastQC
# 02.26.2021 JR
#
# define variables
TOOLKIT=/usr/bin/FastQC/
DIR_HOME=/mnt/e/rnaseq/
DIR_DATA=${DIR_HOME}/data/
DIR_FASTQ=${DIR_DATA}/sra/
DIR_SAVE=${DIR_DATA}/fastqc/
#
# save names of fastq files to txt file for passing to FastQC
for FILE in ${DIR_FASTQ}/*.fastq;
do
    echo ${FILE} > ${DIR_SAVE}/SRR_FastQC_List.txt
done
#
# run FastQC on each fastq file + save html files
${TOOLKIT}/fastqc ${DIR_SAVE}/SRR_FastQC_List.txt --outdir=${DIR_SAVE}