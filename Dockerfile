FROM dreg.cloud.sdu.dk/ucloud-apps/rstudio:4.3.2

LABEL software="Transcriptomics sandbox" \
    author="Jose Alejandro Romero Herrera <jose.romero@sund.ku.dk>, Samuele Soraggi <samuele@birc.au.dk>, Alba Refoyo Martinez" \
    version="2024.02" \
    license="MIT" \
    description="Transcriptomics sandbox with modules and courses"

USER 0

## Copy files
COPY scripts/environment.yml /tmp
COPY --chown=ucloud:ucloud ./scripts/set_Rprofile.R /tmp
COPY --chown=ucloud:ucloud ./scripts/welcome_message.md /tmp
COPY --chown=ucloud:ucloud ./scripts/download_bulkRNAseq.sh /tmp
COPY --chown=ucloud:ucloud ./scripts/download_scRNAseq.sh /tmp

## Env variables for micromamba and for compiling of R packages
ENV MAMBA_ROOT_PREFIX /opt/micromamba
ENV R_HOME /opt/micromamba/envs/RNAseq_env/lib/R
ENV R_LIBS /opt/micromamba/envs/RNAseq_env/lib/R/library
ENV CC /opt/micromamba/envs/RNAseq_env/bin/x86_64-conda-linux-gnu-gcc

RUN apt-get update \
 && apt-get install --no-install-recommends -y libjpeg9 build-essential libcurl4-openssl-dev  libxml2-dev libssl-dev libicu-dev curl \
 && chown -R ucloud:ucloud /opt/ \
 && chown -R ucloud:ucloud /tmp/ \
## Install micromamba and create environment for the modules
 && curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj -C /opt/ \
 && mkdir -p /opt/micromamba \
 && eval "$(/opt/bin/micromamba shell hook -s bash)" \
 && micromamba activate \
 && micromamba create -y -vv -n RNAseq_env -f /tmp/environment.yml \
 && micromamba clean -y -a \
## pip installation and some other R packages
 && eval "$(/opt/bin/micromamba shell hook -s bash)" \
 && micromamba activate RNAseq_env \
 #zenodo plugin to download the latest version
 && /opt/micromamba/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir git+https://github.com/joseale2310/zenodo_get@patch-1 \
 #cirrocumulus installation
 && /opt/micromamba/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir cirrocumulus \  
 #jupyterlab plugins
 && /opt/micromamba/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir jupyterlab-quarto \  
 && /opt/micromamba/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir jupyterlab-code-formatter \
 && /opt/micromamba/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir black isort \
 && /opt/micromamba/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir jupyterlab-github \
 && /opt/micromamba/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir jupyter_bokeh 

COPY scripts/external_packages_for_conda.R /tmp

ARG MY_GITHUB_TOKEN="None"
ENV MY_GITHUB_TOKEN=$MY_GITHUB_TOKEN
RUN echo "MY_GITHUB_TOKEN is $MY_GITHUB_TOKEN"

RUN eval "$(/opt/bin/micromamba shell hook -s bash)" \
 && micromamba activate RNAseq_env \
 && /opt/micromamba/envs/RNAseq_env/bin/R -e  "token <- Sys.getenv('MY_GITHUB_TOKEN'); source(file='/tmp/external_packages_for_conda.R')" \
## R setup for usage in Rstudio 
 && mkdir -p /usr/RNAseq_in_Rstudio \
 && mv /usr/local/lib/R/site-library /opt/micromamba/envs/RNAseq_env/lib/R/ \
 && ln -s  /opt/micromamba/envs/RNAseq_env/lib/R/bin/R /opt/micromamba/envs/RNAseq_env/lib/R/R \
 && rm -rf /usr/local/lib/R \
 && ln -s /opt/micromamba/envs/RNAseq_env/lib/R/ /usr/local/lib/R \
 && mkdir -p /usr/Cirrocumulus/Data \
 && chown -R ucloud:ucloud /usr/RNAseq_in_Rstudio \
 && chown -R ucloud:ucloud /opt/micromamba


## cirrocumulus example data
COPY --chown=ucloud:ucloud ./pbmc3k /usr/Cirrocumulus/Data/pbmc3k
## entrypoint script
COPY --chown=ucloud:ucloud ./scripts/start-app /usr/bin/start-app
RUN chmod +x /usr/bin/start-app
WORKDIR /work
USER 11042