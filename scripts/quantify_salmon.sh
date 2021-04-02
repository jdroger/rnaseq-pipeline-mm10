#!/bin/bash
# Shell script for quantifying transcripts via salmon
# 03.30.2021 JR

# define variables
# TOOLKIT=/usr/bin/salmon-latest_linux_x86_64/bin/
# DIR_HOME=/mnt/e/other-projects/rnaseq/
# DIR_DATA=${DIR_HOME}/data/
# DIR_FASTQ=${DIR_DATA}/trimmomatic/
# DIR_SAVE=${DIR_DATA}/salmon

# construct index from transcriptome (if doesn't exist) 
REFGENIE=${DIR_COUNT}/reference-genomes/genome_config.yaml

if test -d "${DIR_REF}"; then
        echo "index already exists, skipping to quantification"
else 
        echo "index does not exist, pulling index via refgenie..."
        refgenie pull mm10/salmon_partial_sa_index -c ${REFGENIE}
        ###### Old Method ######
        # # extract genome targets + save to decoys.txt
        # grep "^>" <(gunzip -c ${DIR_SAVE}/GRCm38.primary_assembly.genome.fa.gz) | cut -d " " -f 1 > ${DIR_SAVE}decoys.txt
        # sed -i.bak -e 's/>//g' ${DIR_SAVE}decoys.txt
        # # concatenate transcriptome and genome
        # cat \
        #         ${DIR_SAVE}/gencode.vM23.transcripts.fa.gz \
        #         ${DIR_SAVE}/GRCm38.primary_assembly.genome.fa.gz \
        #         > ${DIR_SAVE}/gentrome.fa.gz
        # # build salmon index
        # salmon index \
        #         -t ${DIR_SAVE}/gentrome.fa.gz \
        #         -d ${DIR_SAVE}/decoys.txt \
        #         -k 31 \                         # kmer size (default 31)
        #         -p ${NUM_THREADS} \             # threads used (default 2)
        #         -i ${DIR_SAVE}/mmusculus_index \
        #         --gencode
fi

# run salmon on all trimmed files + save count files
echo "starting transcript quantification via Salmon..."
for FILE in ${DIR_TRIM}/*.fastq.gz; do
        FILE_OUT=$(basename "${FILE}" .fastq.gz | sed 's/trimmed/count/');
        salmon quant \
                -i ${DIR_REF} \
                -l A \
                -p ${NUM_THREADS} \
                -r ${FILE} \
                --validateMappings \
                -o ${DIR_COUNT}/${FILE_OUT}


