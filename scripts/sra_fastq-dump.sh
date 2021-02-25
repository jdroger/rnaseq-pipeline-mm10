#!/bin/bash
# Shell script for downloading fastq files via SRA-toolkit
# 02.25.2021 JR
#
# define variables
TOOLKIT=/usr/bin/sratoolkit.2.10.9-ubuntu64/bin
DIR_HOME=/mnt/e/rnaseq/
DIR_DATA=${DIR_HOME}/data/
DIR_SAVE=${DIR_DATA}/sra/
#
# use fastq-dump to convert to fastq
for RUN in `cat ${DIR_DATA}SRR_Acc_List.txt`; 
do
	echo ${RUN};
	date;
	# ${TOOLKIT}/fastq-dump -X 5 -Z ${RUN}; # -O ${DIR_SAVE};
done
