# Rstudio test
FROM  dreg.cloud.sdu.dk/ucloud-apps/rstudio:4.2.0

USER 0

LABEL software="Transcriptomics sandbox" \
    author="Jose Alejandro Romero Herrera  <jose.romero@sund.ku.dk>" \
    version="v2022.09" \
    license="MIT" \
    description="Transcriptomics sandbox with modules and courses"


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

COPY ./packages.R /usr/Intro_to_bulkRNAseq/Scripts

RUN Rscript /usr/Intro_to_bulkRNAseq/Scripts/packages.R

WORKDIR /work

# RUN pip install jupyter-lab
RUN pip install cirrocumulus

USER 11042

## Set startup script in the PATH
COPY --chown="${NB_USER}":"${NB_GID}" start_app /usr/bin/
RUN chmod +x /usr/bin/start_app