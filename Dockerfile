FROM dreg.cloud.sdu.dk/ucloud-apps/rstudio:4.2.0

LABEL software="Transcriptomics sandbox" \
    author="Jose Alejandro Romero Herrera  <jose.romero@sund.ku.dk>" \
    version="2023.03" \
    license="MIT" \
    description="Transcriptomics sandbox with modules and courses"

USER 0

## Update Python and pip from source
RUN apt-get update \
 && apt-get install --no-install-recommends -y software-properties-common \
 && add-apt-repository -y ppa:deadsnakes/ppa \
 && apt-get update \
 && apt-get install --no-install-recommends -y python3.10 \
 && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 \
 && apt-get install --no-install-recommends -y python3.10-distutils \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py \
 && python3.10 /tmp/get-pip.py \
 && rm /tmp/get-pip.py \
 && rm /opt/venv/reticulate/bin/pip \
 && ln -s /usr/local/bin/pip /opt/venv/reticulate/bin/pip \
 && rm /opt/venv/reticulate/bin/virtualenv \
 && ln -s /usr/local/bin/virtualenv /opt/venv/reticulate/bin/virtualenv \
 && chown -R ucloud:ucloud /opt/venv/

WORKDIR /tmp

## Rstudio environment
RUN mkdir -p /usr/RNAseq_in_Rstudio/renv/cache \
 && chown -R ucloud:ucloud /usr/RNAseq_in_Rstudio
COPY --chown=ucloud:ucloud ./scripts/set_Rprofile.R /usr/RNAseq_in_Rstudio/
COPY --chown=ucloud:ucloud ./scripts/welcome_message.md /usr/RNAseq_in_Rstudio/
COPY --chown=ucloud:ucloud ./scripts/download_bulkRNAseq.sh /usr/RNAseq_in_Rstudio/
COPY --chown=ucloud:ucloud ./scripts/download_scRNAseq.sh /usr/RNAseq_in_Rstudio/
COPY --chown=ucloud:ucloud ./scripts/install_renv.R /usr/RNAseq_in_Rstudio/

## Cirrocumulus test data
RUN mkdir -p /usr/Cirrocumulus/Data

USER 11042

COPY --chown=ucloud:ucloud ./pbmc3k /usr/Cirrocumulus/Data/pbmc3k

## Create renv and install packages
WORKDIR /usr/RNAseq_in_Rstudio/
RUN Rscript /usr/RNAseq_in_Rstudio/install_renv.R

## Install Cirrocumulus - Single Cell RNA seq data visualization
COPY --chown=ucloud:ucloud ./scripts/requirements.txt /tmp/requirements.txt
RUN virtualenv /opt/venv/cirrocumulus \
 && source /opt/venv/cirrocumulus/bin/activate \
 ## Update pip
 && curl -sS https://bootstrap.pypa.io/get-pip.py | python \
 ## Install dependencies
 && pip install --no-cache-dir -r /tmp/requirements.txt \
 && deactivate \
 && rm /tmp/requirements.txt 

## Add entrypoint script
COPY --chown=ucloud:ucloud ./scripts/start-app /usr/bin/start-app
RUN chmod +x /usr/bin/start-app

WORKDIR /work
