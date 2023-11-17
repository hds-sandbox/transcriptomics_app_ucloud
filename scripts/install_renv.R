setwd('/usr/RNAseq_in_Rstudio/renv')

Sys.setenv(RENV_PATHS_CACHE = '/usr/RNAseq_in_Rstudio/renv/cache')

renv::init()

options(renv.config.dependencies.limit = Inf)

print("Installing CRAN packages")

renv::install("BiocManager")
renv::install("bioc::Biobase")
renv::install("markdown")
renv::install("tidyverse")
renv::install("RColorBrewer")
renv::install("pheatmap")
renv::install("ggrepel")
renv::install("cowplot")
renv::install("Seurat")
renv::install("patchwork")
renv::install("sctransform")
renv::install("R.utils")
renv::install("ggbeeswarm")
renv::install("factoextra")
renv::install("FactoMineR")
renv::install("NMF")
renv::install("hexbin")
renv::install("statmod")
renv::install("GOplot")
renv::install("ggpubr")
renv::install("ggsci")

print("Installing Bioconductor packages")

renv::install(c("bioc::Biobase",
                "bioc::DESeq2", 
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
                "bioc::gprofiler2",
                "bioc::multtest",
                "bioc::vsn",
                "bioc::airway"))

print("Installing github packages")

renv::update("Matrix")
renv::install(c("satijalab/seurat-wrappers","satijalab/seurat-data","stephenturner/annotables","mojaveazure/seurat-disk"))

# setRepositories(ind=1:3) # needed to automatically install Bioconductor dependencies
renv::install(c("Signac","metap"))

renv::snapshot()