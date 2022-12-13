FROM dreg.cloud.sdu.dk/ucloud-apps/rstudio:4.2.0

LABEL software="Transcriptomics sandbox" \
    author="Jose Alejandro Romero Herrera  <jose.romero@sund.ku.dk>" \
    version="2022.09" \
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
COPY --chown=ucloud:ucloud ./set_Rprofile /usr/RNAseq_in_Rstudio/
COPY --chown=ucloud:ucloud ./welcome_message.md /usr/RNAseq_in_Rstudio/

## Intro to bulkRNAseq (KU Heads) - release 2022.09
RUN mkdir -p /usr/Intro_to_bulkRNAseq \
 && mkdir /usr/Intro_to_bulkRNAseq/Scripts \
 && mkdir /usr/Intro_to_bulkRNAseq/Data \
 && chown -R ucloud:ucloud /usr/Intro_to_bulkRNAseq 

## Cirrocumulus test data
RUN mkdir -p /usr/Cirrocumulus/Data

USER 11042

COPY --chown=ucloud:ucloud ./pbmc3k /usr/Cirrocumulus/Data/pbmc3k
COPY --chown=ucloud:ucloud ./install_renv.R /usr/Intro_to_bulkRNAseq/Scripts

WORKDIR /usr/Intro_to_bulkRNAseq

RUN git init \
 && git remote add origin https://github.com/hds-sandbox/bulk_RNAseq_course.git \
 && git config core.sparseCheckout true \
 && echo "Notebooks/" >> .git/info/sparse-checkout \
 && git pull --depth=1 origin spring_2022 \
 ## Data download
 && curl https://zenodo.org/record/7116371/files/Mov10_full_counts.txt?download=1 -o /usr/Intro_to_bulkRNAseq/Data/Mov10_full_counts.txt \
 && curl https://zenodo.org/record/7116371/files/Mov10_full_meta.txt?download=1 -o /usr/Intro_to_bulkRNAseq/Data/Mov10_full_meta.txt \
 ## Create renv and install packages
 && Rscript /usr/Intro_to_bulkRNAseq/Scripts/install_renv.R

## Install Cirrocumulus - Single Cell RNA seq data visualization
COPY --chown=ucloud:ucloud requirements.txt /tmp/requirements.txt
RUN virtualenv /opt/venv/cirrocumulus \
 && source /opt/venv/cirrocumulus/bin/activate \
 ## Update pip
 && curl -sS https://bootstrap.pypa.io/get-pip.py | python \
 ## Install dependencies
 && pip install --no-cache-dir -r /tmp/requirements.txt \
 && deactivate \
 && rm /tmp/requirements.txt 

## Add entrypoint script
COPY --chown=ucloud:ucloud start-app /usr/bin/start-app
RUN chmod +x /usr/bin/start-app

WORKDIR /work
