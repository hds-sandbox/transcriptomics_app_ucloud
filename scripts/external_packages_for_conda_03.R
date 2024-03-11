remotes::install_github(c("satijalab/seurat-wrappers",
                         "satijalab/seurat-data",
                          "stephenturner/annotables"), 
                          upgrade="never", 
                          lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/")


remotes::install_github("mojaveazure/seurat-disk", 
    upgrade="never", 
    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/")

remotes::install_github("SamueleSoraggi/DoubletFinder", 
    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/", 
    upgrade="never")