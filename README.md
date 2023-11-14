# Transcriptomics Ucloud app

This repository contains the necessary materials to create a Docker container that will host the Transcriptomics app in UCloud. The app is created and maintained by the Center for Health Data Science (HeaDS), University of Copenhagen.

The Dockerfile will create three Environments, one for working in the command line to create your own RNAseq pipelines with snakemake and jupyter, one with RNAseq data in [Rstudio](https://posit.co/downloads/) and another one to work with the single cell interactive browser [Cirrocumulus](https://cirrocumulus.readthedocs.io/en/latest/). In addition, it will gives the option to download course materials to run an [introductory workshop to bulk RNAseq](https://hds-sandbox.github.io/bulk_RNAseq_course/) or [introductory workshop to scRNAseq](https://hds-sandbox.github.io/scRNASeq_course/)

Documentation for the app can be found [here](./docs/README.md).

To start the docker container, make sure you have Docker installed and running. Then you can build an image and run the container using:

```bash
docker build -t transcriptomics_app:v2023.11 . --progress=plain

docker run --rm -it -p 8787:8787 --name app-test transcriptomics_app:v2023.11 start-app -c {OPTION} 
```

Where `{OPTION}` is either:

*   "RNAseq_in_Rstudio": This will start a Rstudio browser version with many RNAseq related packages
*   "Cirrocumulus": This will start a Cirrocumulus session
*   "Intro_bulk_RNAseq": This will start a Rstudio browser session with the materials to run the ["Introduction to bulk RNAseq"](https://hds-sandbox.github.io/bulk_RNAseq_course/) workshop.
*   "Intro_scRNAseq_R": This will start a Rstudio browser session with the materials to run the ["Introduction to single cell RNAseq"](https://hds-sandbox.github.io/scRNAseq_course/) workshop.
*   "RNAseq_CLI": This will start a jupyter lab session with a mamba environment with usual packages for RNAseq tools and snakemake, for those who want to build their own pipeline.

You can find the interactive session at `localhost:8787`.
