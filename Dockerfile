# Rstudio test
FROM dreg.cloud.sdu.dk/ucloud-apps/rstudio:4.2.0

USER 0

LABEL software="Transcriptomics sandbox" \
    author="Jose Alejandro Romero Herrera  <jose.romero@sund.ku.dk>" \
    version="v2022.09" \
    license="MIT" \
    description="Transcriptomics sandbox with modules and courses"

## Intro to bulkRNAseq (KU Heads) - release 2022.09
RUN mkdir -p /usr/Intro_to_bulkRNAseq \
    && mkdir /usr/Intro_to_bulkRNAseq/Scripts \
    && mkdir -p /usr/Intro_to_bulkRNAseq/Data

WORKDIR /usr/Intro_to_bulkRNAseq

RUN git init \
    && git remote add origin https://github.com/hds-sandbox/bulk_RNAseq_course.git \
    && git config core.sparseCheckout true \
    && echo "Notebooks/" >> .git/info/sparse-checkout \
    && git pull --depth=1 origin spring_2022 \
    ## Data download
    && curl https://zenodo.org/record/7116371/files/Mov10_full_counts.txt?download=1 -o /usr/Intro_to_bulkRNAseq/Data/Mov10_full_counts.txt \
    && curl https://zenodo.org/record/7116371/files/Mov10_full_meta.txt?download=1 -o /usr/Intro_to_bulkRNAseq/Data/Mov10_full_meta.txt 


## Create renv and install packages
RUN mkdir -p /opt/app_renv

COPY ./install_renv.R /usr/Intro_to_bulkRNAseq/Scripts

RUN Rscript /usr/Intro_to_bulkRNAseq/Scripts/install_renv.R
RUN chown -R ucloud:ucloud /opt/app_renv/

WORKDIR /work

# # UPDATE python and pip from source
# RUN apt-get update \
#  && apt-get install -y software-properties-common \
#  && add-apt-repository -y ppa:deadsnakes/ppa \
#  && apt-get update \
#  && apt-get install -y python3.10 \
#  && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 \
#  && apt-get install -y python3.10-distutils \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/* \
#  && curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py \
#  && python3.10 /tmp/get-pip.py \
#  && rm /tmp/get-pip.py \
#  && rm /opt/venv/reticulate/bin/pip \
#  && ln -s /usr/local/bin/pip /opt/venv/reticulate/bin/pip \
#  && rm /opt/venv/reticulate/bin/virtualenv \
#  && ln -s /usr/local/bin/virtualenv /opt/venv/reticulate/bin/virtualenv

# ###### Cirrocumulus - Single Cell RNA seq data visualization
# COPY requirements.txt /usr/requirements.txt
# RUN pip install -r /usr/requirements.txt

## Set startup script in the PATH
# COPY --chown="${NB_USER}":"${NB_GID}" start-app /usr/bin/

COPY start-app /usr/bin/

RUN chmod +x /usr/bin/start-app

USER 11042
