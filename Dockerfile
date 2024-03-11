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
COPY scripts/external_packages_for_conda.R /tmp

## Env variables for micromamba and for compiling of R packages
ENV MAMBA_ROOT_PREFIX /opt/micromamba
ENV R_HOME /opt/micromamba/envs/RNAseq_env/lib/R
ENV R_LIBS /opt/micromamba/envs/RNAseq_env/lib/R/library
ENV CC /opt/micromamba/envs/RNAseq_env/bin/x86_64-conda-linux-gnu-gcc

RUN apt-get update \
 && apt-get install --no-install-recommends -y libjpeg9 \
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
 && /opt/micromamba/envs/RNAseq_env/bin/pip install --no-input --no-cache-dir jupyter_bokeh \
 && /opt/micromamba/envs/RNAseq_env/bin/R -e  "source(file='/tmp/external_packages_for_conda.R')" \
## R setup for usage in Rstudio 
 && mkdir -p /usr/RNAseq_in_Rstudio \
 && ln -s  /opt/micromamba/envs/RNAseq_env/lib/R/bin/R /opt/micromamba/envs/RNAseq_env/lib/R/R \
 && rm -rf /usr/local/lib/R \
 && ln -s /opt/micromamba/envs/RNAseq_env/lib/R/ /usr/local/lib/R \
 && mkdir -p /usr/Cirrocumulus/Data \
 && chown -R ucloud:ucloud /usr/RNAseq_in_Rstudio \
 && chown -R ucloud:ucloud /opt/micromamba 


## entrypoint script
COPY --chown=ucloud:ucloud ./scripts/start-app /usr/bin/start-app

RUN chmod +x /usr/bin/start-app

WORKDIR /work

USER 11042


#COPY scripts/external_packages_for_conda_02.R /tmp

#RUN eval "$(/opt/bin/micromamba shell hook -s bash)" \
# && micromamba activate RNAseq_env \
# && /opt/micromamba/envs/RNAseq_env/bin/R -e  "source(file='/tmp/external_packages_for_conda_02.R')"

#COPY scripts/external_packages_for_conda_03.R /tmp

#RUN eval "$(/opt/bin/micromamba shell hook -s bash)" \
# && micromamba activate RNAseq_env \
# && /opt/micromamba/envs/RNAseq_env/bin/R -e  "source(file='/tmp/external_packages_for_conda_03.R')"

#COPY scripts/external_packages_for_conda_04.R /tmp

#RUN eval "$(/opt/bin/micromamba shell hook -s bash)" \
# && micromamba activate RNAseq_env \
# && micromamba install -n RNAseq_env -y --no-deps conda-forge::jpeg \
# && /opt/micromamba/envs/RNAseq_env/bin/pip install git+https://github.com/joseale2310/zenodo_get@patch-1 \
# && /opt/micromamba/envs/RNAseq_env/bin/R -e  "source(file='/tmp/external_packages_for_conda_04.R')"






## Cirrocumulus test data
#RUN mkdir -p /usr/Cirrocumulus/Data





# Set R_HOME environment variable
#ENV R_HOME /path/to/your/conda/environment/bin
# Update PATH to include R_HOME
#ENV PATH "$R_HOME:$PATH"

# Create a working directory


# Copy the environment YAML file to the working directory
#COPY scripts/baged-bulk.yml /tmp
#COPY scripts/conda-R.yml /tmp
#COPY scripts/external_packages_for_conda.R /tmp

# Create a Conda environment from the YAML file
#RUN ./bin/micromamba shell init -s bash -p /home/ucloud/micromamba \
#    && source ~/.bashrc \
#    && micromamba activate \
#    && micromamba env create -p /opt/RNAseq_env -f /tmp/conda-R.yml
#RUN /opt/conda/bin/conda env create -vv -p /opt/conda/envs/RNAseq_CLI -f conda-R.yml \
#    && rm conda-R.yml \
#    && mamba clean --all -f -y 

#RUN chmod +x external_packages_for_conda.R \
#    && /opt/conda/envs/RNAseq_CLI/bin/Rscript external_packages_for_conda.R



#COPY --chown=ucloud:ucloud ./pbmc3k /usr/Cirrocumulus/Data/pbmc3k

## Create renv and install packages
#COPY --chown=ucloud:ucloud ./scripts/install_renv.R /usr/RNAseq_in_Rstudio/
#WORKDIR /usr/RNAseq_in_Rstudio/
#RUN Rscript /usr/RNAseq_in_Rstudio/install_renv.R



## Install Cirrocumulus - Single Cell RNA seq data visualization
#COPY --chown=ucloud:ucloud ./scripts/requirements.txt /tmp/requirements.txt
#RUN pip install --no-cache-dir virtualenv \
# && /home/ucloud/.local/bin/virtualenv /opt/venv/cirrocumulus \
# && source /opt/venv/cirrocumulus/bin/activate \
# ## Update pip
# && curl -sS https://bootstrap.pypa.io/get-pip.py | python \
# ## Install dependencies
# && pip install --no-cache-dir -r /tmp/requirements.txt \
# && deactivate \
# && rm /tmp/requirements.txt 

## Add entrypoint script
