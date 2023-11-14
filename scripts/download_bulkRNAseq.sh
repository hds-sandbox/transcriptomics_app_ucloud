#!/bin/bash

# Folder structure
mkdir -p /work/Intro_to_bulkRNAseq
mkdir /work/Intro_to_bulkRNAseq/Results
mkdir /work/Intro_to_bulkRNAseq/Notebooks

# Download notebooks from zenodo
zenodo_get 10.5281/zenodo.7462749  -o /work/Intro_to_bulkRNAseq/
unzip "/work/Intro_to_bulkRNAseq/bulk_RNAseq_course*" -d /work/Intro_to_bulkRNAseq
mv "/work/Intro_to_bulkRNAseq/hds-sandbox"*"/Notebooks/"* "/work/Intro_to_bulkRNAseq/Notebooks"
rm /work/Intro_to_bulkRNAseq/bulk_RNAseq_course*
rm -r "/work/Intro_to_bulkRNAseq/hds-sandbox"*

## Data download
# download Data.zip to Data from zenodo and unzip
zenodo_get 10.5281/zenodo.7116370 -o /work/Intro_to_bulkRNAseq/ -w download.txt
grep "Data" /work/Intro_to_bulkRNAseq/download.txt > /work/Intro_to_bulkRNAseq/data_download.txt 
wget -i /work/Intro_to_bulkRNAseq/data_download.txt -O /work/Intro_to_bulkRNAseq/Data.zip
unzip /work/Intro_to_bulkRNAseq/Data.zip -d /work/Intro_to_bulkRNAseq/
rm /work/Intro_to_bulkRNAseq/Data.zip
rm -r /work/Intro_to_bulkRNAseq/download.txt
rm -r /work/Intro_to_bulkRNAseq/data_download.txt
rm -r /work/Intro_to_bulkRNAseq/__MACOSX

rm /work/Intro_to_bulkRNAseq/md5sums.txt
