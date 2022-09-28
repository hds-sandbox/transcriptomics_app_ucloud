install.packages(c("BiocManager", "tidyverse", "RColorBrewer", 
    "pheatmap", "ggrepel", "cowplot", "Seurat", "patchwork", "sctransform"))

devtools::install_github('satijalab/seurat-wrappers')
devtools::install_github('satijalab/seurat-data')
devtools::install_github("stephenturner/annotables")
devtools::install_github("mojaveazure/seurat-disk")

BiocManager::install(c("DESeq2", "clusterProfiler", "DOSE", "org.Hs.eg.db", "org.Mm.eg.db", "org.Dm.eg.db",  "pathview", "DEGreport", 
                       "tximport", "AnnotationHub", "ensembldb","apeglm","ggnewscale","rhdf5", "slingshot", "gprofiler2"))



setRepositories(ind=1:3) # needed to automatically install Bioconductor dependencies
install.packages("Signac")