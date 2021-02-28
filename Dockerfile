# Docker image for RNA-seq workflow
# 02.28.2020 JR

# Use miniconda3 image
FROM continuumio/miniconda3:latest

# Install dependencies via miniconda
RUN conda config --add channels bioconda && \
    conda install \
        sra-tools \
        fastqc \
        trimmomatic \
        kallisto

# Copy local files to container
COPY ./* .

# Run master shell script for accession list
WORKDIR /rnaseq
CMD [ "scripts/run_pipeline", "SRR_Acc_List.txt" ]