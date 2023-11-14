#!/bin/bash

# Folder structure
mkdir -p /work/Intro_scRNAseq_R
mkdir /work/Intro_scRNAseq_R/Results

## Download and unzip

zenodo_get 10.5281/zenodo.7827898 -o /work/Intro_scRNAseq_R/ -w download.txt
grep -E "Data|Notebooks" /work/Intro_scRNAseq_R/download.txt > /work/Intro_scRNAseq_R/data_download.txt 
wget -i /work/Intro_scRNAseq_R/data_download.txt -P /work/Intro_scRNAseq_R/
unzip /work/Intro_scRNAseq_R/Data.zip -d /work/Intro_scRNAseq_R/
unzip /work/Intro_scRNAseq_R/Notebooks.zip -d /work/Intro_scRNAseq_R/

rm /work/Intro_scRNAseq_R/Data.zip
rm /work/Intro_scRNAseq_R/Notebooks.zip
rm /work/Intro_scRNAseq_R/download.txt
rm /work/Intro_scRNAseq_R/data_download.txt
rm /work/Intro_scRNAseq_R/md5sums.txt

rm -r /work/Intro_scRNAseq_R/__MACOSX