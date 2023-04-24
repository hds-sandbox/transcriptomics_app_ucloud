setwd('/usr/RNAseq_in_Rstudio/renv')

Sys.setenv(RENV_PATHS_CACHE = '/usr/RNAseq_in_Rstudio/renv/cache')

renv::init()

print("Installing CRAN packages")

renv::install(c("BiocManager", 
                "markdown",
                "tidyverse", 
                "RColorBrewer", 
                "pheatmap", 
                "ggrepel", 
                "cowplot", 
                "Seurat", 
                "patchwork", 
                "sctransform",
                "R.utils",
                "ggbeeswarm"))

print("Installing Bioconductor packages")

renv::install(c("bioc::DESeq2", 
                "bioc::GenomeInfoDb",
                "bioc::clusterProfiler", 
                "bioc::DOSE", 
                "bioc::org.Hs.eg.db", 
                "bioc::org.Mm.eg.db", 
                "bioc::org.Dm.eg.db",
                "bioc::pathview", 
                "bioc::DEGreport", 
                "bioc::tximport", 
                "bioc::AnnotationHub", 
                "bioc::ensembldb", 
                "bioc::apeglm", 
                "bioc::ggnewscale", 
                "bioc::rhdf5", 
                "bioc::slingshot", 
                "bioc::gprofiler2"))

print("Installing github packages")

renv::update("Matrix")
renv::install(c("satijalab/seurat-wrappers","satijalab/seurat-data","stephenturner/annotables","mojaveazure/seurat-disk","theislab/kBET"))

# setRepositories(ind=1:3) # needed to automatically install Bioconductor dependencies
renv::install("Signac")

renv::snapshot()