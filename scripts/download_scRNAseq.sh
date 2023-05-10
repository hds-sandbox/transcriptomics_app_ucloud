#!/bin/bash

# Folder structure
mkdir -p /work/Intro_scRNAseq_R
mkdir /work/Intro_scRNAseq_R/Results

## Data download
# download Data.zip to Data from zenodo and unzip
curl "https://zenodo.org/record/7835764/files/Data.zip?download=1" -o /work/Intro_scRNAseq_R/Data.zip
unzip /work/Intro_scRNAseq_R/Data.zip -d /work/Intro_scRNAseq_R/
rm /work/Intro_scRNAseq_R/Data.zip
rm -r /work/Intro_scRNAseq_R/__MACOSX

## Notebooks download
# download Notebooks.zip to Notebooks from zenodo and unzip
curl "https://zenodo.org/record/7920686/files/Notebooks.zip?download=1" -o /work/Intro_scRNAseq_R/Notebooks.zip
unzip /work/Intro_scRNAseq_R/Notebooks.zip -d /work/Intro_scRNAseq_R/
rm /work/Intro_scRNAseq_R/Notebooks.zip
rm -r /work/Intro_scRNAseq_R/__MACOSX