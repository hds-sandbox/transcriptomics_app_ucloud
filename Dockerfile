FROM dreg.cloud.sdu.dk/ucloud-apps/rstudio:4.4.0

LABEL software="Transcriptomics sandbox" \
    author="Samuele Soraggi <samuele@birc.au.dk>, Alba Refoyo Martinez, Jose Alejandro Romero Herrera" \
    version="2024.05" \
    license="MIT" \
    description="Transcriptomics sandbox with tools and courses for bulk-RNA and single-cell transcriptomics analysis"

USER 0

COPY --chown=ucloud:ucloud ./scripts/download_bulkRNAseq.sh /tmp
COPY --chown=ucloud:ucloud ./scripts/download_scRNAseq.sh /tmp
ENV G_SLICE always-malloc
COPY  --chown=ucloud:ucloud ./scripts/environment.yml /tmp
COPY  --chown=ucloud:ucloud scripts/external_packages_for_conda.R /tmp
ARG GITHUB_PAT="None"
ENV GITHUB_PAT=$GITHUB_PAT
RUN echo "GITHUB_PAT is $GITHUB_PAT"

RUN apt-get update \
 && apt-get install --no-install-recommends -y libjpeg9 build-essential libcurl4-openssl-dev  libxml2-dev libssl-dev libicu-dev \
 && mkdir -p /opt/miniconda \
 && chown -R ucloud:ucloud /opt/miniconda \
 && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt/miniconda/miniconda.sh \
 && bash /opt/miniconda/miniconda.sh -b -u -p /opt/miniconda \
 && rm -rf /opt/miniconda/miniconda.sh \
 && eval "$(/opt/miniconda/bin/conda shell.bash hook)" \
 && conda config --set channel_priority flexible \
 && conda install -n base --yes conda-libmamba-solver \
 && conda config --set solver libmamba \
 && conda env create -vv -p /opt/miniconda/envs/RNAseq_env -f /tmp/environment.yml \
 && conda clean -y -a

 ## pip installation and some other R packages
 RUN eval "$(/opt/miniconda/bin/conda shell.bash hook)" \
 && conda activate /opt/miniconda/envs/RNAseq_env \
 && /opt/miniconda/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir git+https://github.com/joseale2310/zenodo_get@patch-1 \
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
 && /opt/miniconda/envs/RNAseq_env/bin/R -e  "token <- Sys.getenv('GITHUB_PAT'); source(file='/tmp/external_packages_for_conda.R')" \ 
 && chown -R ucloud:ucloud /opt/miniconda

COPY --chown=ucloud:ucloud ./scripts/install_renv.R /tmp
COPY --chown=ucloud:ucloud ./scripts/set_Rprofile.R /tmp
COPY --chown=ucloud:ucloud ./renv.lock /tmp

##Installations for usage in Rstudio
##dev libraries needed for Rhtslib installations
##Some changes in the C compiler flags (CFLAGS) for compatibility with R packages from bioconductor 
RUN apt-get update \
 && apt-get install --no-install-recommends -y liblzma-dev libdeflate-dev zlib1g-dev libbz2-dev \
 && mkdir -p /opt/renv_transcriptomics/ \
 && mkdir -p ~/.R \
 && echo "CFLAGS= -fpic  -g -O2 -fstack-protector-strong -Wformat -Wdate-time -D_FORTIFY_SOURCE=2 -g -std=gnu99" > ~/.R/Makevars \
 && chown -R ucloud:ucloud /opt/renv_transcriptomics/ \
 && chown -R ucloud:ucloud /tmp \
 && cp /tmp/renv.lock /opt/renv_transcriptomics/renv.lock \
 && /usr/local/bin/R -e  "token <- Sys.getenv('GITHUB_PAT'); source(file='/tmp/install_renv.R')" \
 && cat /tmp/set_Rprofile.R > /home/ucloud/.Rprofile \
 && rm /opt/renv_transcriptomics/.Rprofile \
 && chown -R ucloud:ucloud /opt/renv_transcriptomics

 
##&& /usr/local/bin/R -e "remotes::install_version(\"renv\",\"0.15.5\")" \

## cirrocumulus example data
#mkdir -p /usr/Cirrocumulus/Data \
COPY --chown=ucloud:ucloud ./pbmc3k /usr/Cirrocumulus/Data/pbmc3k
## entrypoint script
COPY --chown=ucloud:ucloud ./scripts/start-app /usr/bin/start-app
RUN chmod +x /usr/bin/start-app
WORKDIR /work
USER 11042