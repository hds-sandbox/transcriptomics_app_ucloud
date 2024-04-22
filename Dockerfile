FROM dreg.cloud.sdu.dk/ucloud-apps/rstudio:4.3.2

LABEL software="Transcriptomics sandbox" \
    author="Jose Alejandro Romero Herrera <jose.romero@sund.ku.dk>, Samuele Soraggi <samuele@birc.au.dk>, Alba Refoyo Martinez" \
    version="2024.04" \
    license="MIT" \
    description="Transcriptomics sandbox with modules and courses"

USER 0

COPY --chown=ucloud:ucloud ./scripts/download_bulkRNAseq.sh /tmp
COPY --chown=ucloud:ucloud ./scripts/download_scRNAseq.sh /tmp
COPY --chown=ucloud:ucloud ./scripts/install_renv.R /tmp
COPY --chown=ucloud:ucloud ./renv.lock /tmp
COPY --chown=ucloud:ucloud ./scripts/set_Rprofile.R /tmp

ARG GITHUB_PAT="None"
ENV GITHUB_PAT=$GITHUB_PAT
RUN echo "GITHUB_PAT is $GITHUB_PAT"

##Installations for usage in Rstudio
RUN apt-get update \
 && apt-get install --no-install-recommends -y libjpeg9 build-essential libcurl4-openssl-dev  libxml2-dev libssl-dev libicu-dev curl \
 && mkdir -p /opt/RNAseq_in_Rstudio/ \
 && chown -R ucloud:ucloud /opt \
 && chown -R ucloud:ucloud /tmp/ \
 && cp /tmp/renv.lock /opt/RNAseq_in_Rstudio/renv.lock \
 && R -e  "token <- Sys.getenv('GITHUB_PAT'); source(file='/tmp/install_renv.R')" \
 && R -e "remotes::install_version(\"renv\",\"0.15.5\")" \
 && cat /tmp/set_Rprofile.R > /home/ucloud/.Rprofile \
 && rm /opt/RNAseq_in_Rstudio/.Rprofile \
 && chown -R ucloud:ucloud /opt/RNAseq_in_Rstudio

##Correct CC for environment
COPY  --chown=ucloud:ucloud ./scripts/environment.yml /tmp
COPY  --chown=ucloud:ucloud scripts/external_packages_for_conda.R /tmp
ENV MAMBA_ROOT_PREFIX /opt/micromamba
ENV CC /opt/micromamba/envs/RNAseq_env/bin/x86_64-conda-linux-gnu-gcc

## Install micromamba and create environment for the modules
RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj -C /opt/ \
 && mkdir -p /opt/micromamba \
 && eval "$(/opt/bin/micromamba shell hook -s bash)" \
 && micromamba activate \
 && micromamba env create -y -vv -n RNAseq_env -f /tmp/environment.yml \
 && micromamba clean -y -a \
 ## pip installation and some other R packages
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
 && /opt/micromamba/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir jupyter_bokeh \
 && micromamba activate RNAseq_env \
 && /opt/micromamba/envs/RNAseq_env/bin/R -e  "token <- Sys.getenv('GITHUB_PAT'); source(file='/tmp/external_packages_for_conda.R')" \ 
 && mkdir -p /usr/Cirrocumulus/Data \
 && chown -R ucloud:ucloud /opt/micromamba

## cirrocumulus example data
COPY --chown=ucloud:ucloud ./pbmc3k /usr/Cirrocumulus/Data/pbmc3k
## entrypoint script
COPY --chown=ucloud:ucloud ./scripts/start-app /usr/bin/start-app
RUN chmod +x /usr/bin/start-app
WORKDIR /work
USER 11042