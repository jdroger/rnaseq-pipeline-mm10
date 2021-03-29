#!/bin/bash
# Shell script for downloading fastq files via SRA-toolkit
# 02.25.2021 JR
# 
# Usage: `sh preprocess_fastq-dump.sh <list_of_sra_accessions>`
#   - Uses sratoolkit to download all fastq files specified by list_of_sra_accessions
#   - Stores all fastq files in data/sra/ directory
# 
# Example: `sh preprocess_fastq-dump.sh SRR_Acc_List.txt` downloads 2 fastq files to data/sra/
#
# define variables
TOOLKIT=/usr/bin/sratoolkit.2.10.9-ubuntu64/bin
DIR_HOME=/mnt/e/other-projects/rnaseq/
DIR_DATA=${DIR_HOME}/data/
DIR_SAVE=${DIR_DATA}/sra/
#
# check if fastq files are already stored in save directory
for RUN in `cat $1`;
do
	FILE=${DIR_SAVE}/$RUN.fastq
	if test -f "$FILE"; then
		echo "$FILE already exists"
	else
		echo "downloading $RUN.fastq..."
		${TOOLKIT}/fastq-dump ${RUN} -O ${DIR_SAVE};
		echo "fastq saved to $FILE"
	fi
done
# use fastq-dump to convert to fastq
# for RUN in `cat $1`; 
# do
# 	echo ${RUN};
# 	date;
# 	${TOOLKIT}/fastq-dump ${RUN} -O ${DIR_SAVE};
# done
