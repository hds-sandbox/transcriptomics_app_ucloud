ARG BASE_IMAGE

FROM $BASE_IMAGE

LABEL software="Transcriptomics sandbox" \
    author="Samuele Soraggi <samuele@birc.au.dk>, Alba Refoyo Martinez" \
    license="MIT" \
    description="Transcriptomics sandbox with modules and courses"

USER $USERID

ENV G_SLICE always-malloc

## Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

## Copy files
COPY --chown=$USERID:$GROUPID ./scripts/environment.yml /tmp
COPY --chown=$USERID:$GROUPID ./scripts/Rinstallations.R /tmp
COPY --chown=$USERID:$GROUPID ./scripts/set_Rprofile.R /tmp
COPY --chown=$USERID:$GROUPID ./scripts/external_packages_for_conda.R /tmp
COPY --chown=$USERID:$GROUPID ./scripts/doubletfinder.zip /tmp

ARG GITHUB_PAT

RUN sudo apt-get update \
 && sudo apt-get install --no-install-recommends -y build-essential libjpeg9 libcurl4-openssl-dev libxml2-dev libssl-dev libicu-dev \
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/* \
 && sudo mkdir -p /opt/miniconda \
 && sudo chown -R "$USERID":"$GROUPID" /opt/miniconda \
 && wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt/miniconda/miniconda.sh \
 && bash /opt/miniconda/miniconda.sh -b -u -p /opt/miniconda \
 && rm -rf /opt/miniconda/miniconda.sh \
 && eval "$(/opt/miniconda/bin/conda shell.bash hook)" \
 && conda config --set channel_priority flexible \
 && conda install -n base --yes conda-libmamba-solver conda-forge::mamba \
 && conda config --set solver libmamba \
 && conda env create -vv -p /opt/miniconda/envs/RNAseq_env -f /tmp/environment.yml \
 && conda clean -y -a

 ## pip installation and some other R packages
 RUN eval "$(/opt/miniconda/bin/conda shell.bash hook)" \
  && conda activate /opt/miniconda/envs/RNAseq_env \
  && /opt/miniconda/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir git+https://github.com/hds-sandbox/zenodo_get@patch-1 \
  # cirrocumulus installation
  && /opt/miniconda/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir cirrocumulus \
  # jupyterlab plugins
  && /opt/miniconda/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir jupyterlab-quarto \
  && /opt/miniconda/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir jupyterlab-code-formatter \
  && /opt/miniconda/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir black isort \
  && /opt/miniconda/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir jupyterlab-github \
  && /opt/miniconda/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir jupyter_bokeh \
  && /opt/miniconda/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir plotly \
  && /opt/miniconda/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir ipywidgets \
  && export GITHUB_PAT="$GITHUB_PAT" \
  && /opt/miniconda/envs/RNAseq_env/bin/R -e "token <- Sys.getenv('GITHUB_PAT'); source(file='/tmp/external_packages_for_conda.R')"

## Installations for usage in Rstudio
## dev libraries needed for Rhtslib, RcppGSL, hdf5r, libfftw installations
## Some changes in the C compiler flags (CFLAGS) for compatibility with R packages from bioconductor

COPY --chown=$USERID:$GROUPID ./renv.lock /tmp
COPY --chown=$USERID:$GROUPID ./scripts/install_renv.R /tmp
COPY --chown=$USERID:$GROUPID ./scripts/hdWGCNA-69110d0.zip /tmp
COPY --chown=$USERID:$GROUPID ./scripts/annotables-0.2.0.zip /tmp

RUN sudo apt-get update && sudo apt-get install -y software-properties-common \
 && sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu jammy main universe" \ && sudo apt-get update \
 && sudo apt-get install -y libfftw3-double3=3.3.8-2ubuntu8 libfftw3-long3=3.3.8-2ubuntu8 libfftw3-single3=3.3.8-2ubuntu8 \
 && sudo apt-get install -y libhdf5-dev libgsl27 liblzma-dev libdeflate-dev zlib1g-dev libbz2-dev \
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/* \
 && sudo mkdir -p /opt/renv_transcriptomics/ \
 && mkdir -p ~/.R \
 && echo "CFLAGS= -fpic  -g -O2 -fstack-protector-strong -Wformat -Wdate-time -D_FORTIFY_SOURCE=2 -g -std=gnu99" > ~/.R/Makevars \
 && sudo chown -R "$USERID":"$GROUPID" /opt/renv_transcriptomics/ \
 && cp /tmp/renv.lock /opt/renv_transcriptomics/renv.lock \
 && export GITHUB_PAT="$GITHUB_PAT" \
 && unzip /tmp/hdWGCNA-69110d0.zip -d /tmp/hdwgcna \
 && unzip /tmp/annotables-0.2.0.zip -d /tmp/annotables-0.2.0 \
 && /usr/local/bin/R -e "token <- Sys.getenv('GITHUB_PAT'); options(install.opts = '--no-data'); source(file='/tmp/install_renv.R')" \
 && cat /tmp/set_Rprofile.R > "/home/$USER/.Rprofile" \
 && rm /opt/renv_transcriptomics/.Rprofile 

## cirrocumulus example data
COPY --chown=$USERID:$GROUPID ./pbmc3k /usr/Cirrocumulus/Data/pbmc3k

## entrypoint script
COPY --chown=$USERID:$GROUPID ./scripts/start-app /usr/bin/start-app
RUN chmod 755 /usr/bin/start-app

WORKDIR /work