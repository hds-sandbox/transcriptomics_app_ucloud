#!/bin/bash

docker build -t transcriptomics_app:v2022.10 .
docker run --rm -it -p 8787:8787 --name app-test transcriptomics_app:v2022.10 start-app -c "Intro_to_bulkRNAseq"