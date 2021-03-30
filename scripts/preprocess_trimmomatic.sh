#!/bin/bash
# Shell script for trimming adapters + low-quality reads via trimmomatic
# 03.30.2021 JR
#
# define variables
TOOLKIT=/usr/bin/Trimmomatic-0.39/
DIR_HOME=/mnt/e/other-projects/rnaseq/
DIR_DATA=${DIR_HOME}/data/
DIR_FASTQ=${DIR_DATA}/sra/
DIR_SAVE=${DIR_DATA}/trimmomatic/
# 
# run trimmomatic on each fastq file + save trimmed fastq files
for FILE_IN in ${DIR_FASTQ}/*.fastq.gz;
do
    # modify file name for save location
    FILE_OUT=$(basename "${FILE_IN}" | awk -F\. -v OFS=\. '$1=$1"_trimmed"');
    # echo ${DIR_SAVE}/${FILE_OUT};
    # run trimmomatic (default settings, single end mode)
    java -jar ${TOOLKIT}/trimmomatic-0.39.jar SE \
        ${FILE_IN} \
        ${DIR_SAVE}/${FILE_OUT} \
        ILLUMINACLIP:${TOOLKIT}/adapters/TruSeq3-SE.fa:2:30:10 \
        LEADING:3 \
        TRAILING:3 \
        SLIDINGWINDOW:4:15
done