remotes::install_github("satijalab/sctransform",
    ref="develop", upgrade="always",
    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/")

remotes::install_github("jhrcook/ggasym", 
     upgrade="never", 
    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/")

remotes::install_github("YuLab-SMU/ggtree", 
     upgrade="always", 
    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/")

install.packages('GOplot', 
    repos='http://cran.us.r-project.org', 
    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/" )

install.packages('BiocManager', 
    repos='http://cran.us.r-project.org', 
    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/" )

BiocManager::install(update=FALSE, 
    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/")

BiocManager::install(c("clusterExperiment",
"Biobase",
"DESeq2", 
"GenomeInfoDb",
"clusterProfiler", 
"DOSE", 
"org.Hs.eg.db", 
"org.Mm.eg.db", 
"org.Dm.eg.db",
"pathview", 
"DEGreport", 
"tximport", 
"AnnotationHub", 
"ensembldb", 
"apeglm", 
"ggnewscale", 
"rhdf5", 
"slingshot", 
"gprofiler2",
"multtest",
"vsn",
"airway"), 
update=FALSE, 
lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/")

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

BiocManager::install(c("WGCNA", 
                    "igraph", 
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