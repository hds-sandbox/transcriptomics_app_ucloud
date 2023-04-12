# Transcriptomics Ucloud app

This repository contains the necessary materials to create a Docker container that will host the Transcriptomics app in UCloud. The app is created and maintained by the Center for Health Data Science (HeaDS), University of Copenhagen.

The Dockerfile will create two Environments, one for working with RNAseq data in [Rstudio](https://posit.co/downloads/) and another one to work with the single cell interactive browser [Cirrocumulus](https://cirrocumulus.readthedocs.io/en/latest/). In addition, it will gives the option to download course materials to run an [introductory workshop to bulk RNAseq](https://hds-sandbox.github.io/bulk_RNAseq_course/).

Documentation for the app can be found [here](./docs/README.md).

To start the docker container, make sure you have Docker installed and running. Then you can build an image and run the container using:

```bash
docker build -t transcriptomics_app:v2023.04 . --progress=plain

docker run --rm -it -p 8787:8787 --name app-test transcriptomics_app:v2023.04 start-app -c {OPTION} 
```
Where `{OPTION}` is either:

*   "RNAseq_in_Rstudio": This will start a Rstudio browser version with many RNAseq related packages
*   "Cirrocumulus": This will start a Cirrocumulus session
*   "Intro_bulk_RNAseq": This will start a Rstudio browser session with the materials to run the ["Introduction to bulk RNAseq"](https://hds-sandbox.github.io/bulk_RNAseq_course/) workshop.

You can find the interactive session at `localhost:8787`.

