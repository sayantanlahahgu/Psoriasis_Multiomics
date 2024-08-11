# Analysis Pipeline of RNA-sequencing, small RNA-sequencing and Illumina Infinium Human Methylation 450k BeadChip data

## 1. RNA-sequencing

The steps involved in the RNA-seq analysis pipleline are given below. The detailed commands used in each step are present in (.....txt)

### • Generating sequencing quality reports of raw fastq.gz files

Requirements: 
FastQC (https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

### • Adapter and quality trimming of raw reads

Requirements: 
Cutadapt (https://cutadapt.readthedocs.io/en/stable/)

### • Generating sequencing quality reports of trimmed fastq.gz files

Requirements: 
FastQC (https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

### • Indexing the reference genome

Requirements:
STAR (https://github.com/alexdobin/STAR)
Refernce genome fasta file (https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_46/GRCh37_mapping/GRCh37.primary_assembly.genome.fa.gz)

### • Alignment of reads to the reference genome

Requirements: 
STAR (https://github.com/alexdobin/STAR)
Regerence genome annotation file (https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_46/GRCh37_mapping/gencode.v46lift37.annotation.gtf.gz)

### • Transcript assembly of aligned reads

Requirements:
StringTie (https://ccb.jhu.edu/software/stringtie/)

### • Generation of raw read counts for all annotated genes

Rquirements:
Python 2.7 or Python 3.0
preDE.py (https://ccb.jhu.edu/software/stringtie/dl/prepDE.py)

### • Differential expression analysis

Requirements: 
R
Bioconductor package 'edgeR' in R
The detailed script for differential expression analysis using 'edgeR' is provided in the file 'edgeR.R'

## 1. RNA-sequencing




edgeR.R - This file includes ...

RNA-Seq - This file includes ...

small-RNAseq - This file includes ...
