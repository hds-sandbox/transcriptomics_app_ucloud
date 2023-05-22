#!/bin/bash

# Folder structure
mkdir -p /work/Intro_to_bulkRNAseq
mkdir /work/Intro_to_bulkRNAseq/Results
mkdir /work/Intro_to_bulkRNAseq/Notebooks

# Download notebooks from zenodo
curl "https://zenodo.org/record/7956067/files/hds-sandbox/bulk_RNAseq_course-v3.0.1.zip?download=1" -o /work/Intro_to_bulkRNAseq/archive.zip
unzip /work/Intro_to_bulkRNAseq/archive.zip -d /work/Intro_to_bulkRNAseq/
mv "/work/Intro_to_bulkRNAseq/hds-sandbox"*"/Notebooks/"* "/work/Intro_to_bulkRNAseq/Notebooks"
rm -r "/work/Intro_to_bulkRNAseq/hds-sandbox"*
rm /work/Intro_to_bulkRNAseq/archive.zip

## Data download
# download Data.zip to Data from zenodo and unzip
curl "https://zenodo.org/record/7802718/files/Data.zip?download=1" -o /work/Intro_to_bulkRNAseq/Data.zip
unzip /work/Intro_to_bulkRNAseq/Data.zip -d /work/Intro_to_bulkRNAseq/
rm /work/Intro_to_bulkRNAseq/Data.zip
rm -r /work/Intro_to_bulkRNAseq/__MACOSX