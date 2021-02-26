# Bulk RNA-seq Analysis Pipeline
02.25.2021 JR

This pipeline processes RNA-seq data obtained from GEO for downstream analyses including differential expression analysis, pathway analysis, etc. Preprocessing is conducted via FastQC/Trimmomatic, pseudoalignment/quantification via Kallisto, and differential expression via EdgeR. This is intended to be a simple starting point for linking the functionalities of each program and does not contain robust testing at this stage.

## System/Software Requirements
- WSL-Ubuntu 20.04
- SRA toolkit 2.10.9-ubuntu64
- FastQC with default JRE
- Kallisto

## Script Functionalities
- `preprocess_fastq-dump.sh`: shell script for downloading fastq files from SRA. Uses specified list of SRA accession numbers generated via SRA Run Selector.
- `preprocess_fastqc.sh`: shell script for running FastQC for files. Saves results to `~/data/fastqc/` directory.

## Usage
- Download accession list via SRA Run Selector and save to `~/data/` directory.
- Run `preprocess_fastq-dump.sh` for given list, which saves (unzipped) fastq files to `~/data/sra/` directory.
- Run `preprocess_fastqc.sh`, which saves HTML reports to `~/data/fastqc/` directory.