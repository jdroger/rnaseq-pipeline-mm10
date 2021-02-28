# Docker image for RNA-seq workflow
# 02.28.2020 JR

# Use miniconda3 image
FROM continuumio/miniconda3:latest

# Install dependencies via miniconda
WORKDIR /
RUN conda config --add channels bioconda && \
    conda install -y \
        kallisto \
        fastqc
        # sra-tools \
        # fastqc \
        # trimmomatic \
        # kallisto

# Copy local files to container
RUN mkdir rnaseq && mkdir rnaseq/scripts
COPY ./SRR_Acc_List.txt /rnaseq/.
COPY ./scripts /rnaseq/scripts

# Run master shell script for accession list
WORKDIR /rnaseq
CMD [ "sh", "-c", "scripts/run_pipeline.sh SRR_Acc_List.txt" ]