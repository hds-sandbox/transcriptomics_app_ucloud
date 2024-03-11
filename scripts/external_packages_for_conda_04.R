BiocManager::install(c("WGCNA", 
                    "igraph", 
                    "devtools", 
                    "GeneOverlap", 
                    'ggrepel'),
                    update=FALSE, 
                    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/")

remotes::install_github("NightingaleHealth/ggforestplot", 
    upgrade="never", 
    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/")

remotes::install_github('smorabit/hdWGCNA', 
    ref='dev', 
    upgrade="never", 
    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/")