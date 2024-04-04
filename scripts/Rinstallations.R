setwd('/opt/RNAseq_in_Rstudio/renv')

Sys.setenv(RENV_PATHS_CACHE = '/opt/RNAseq_in_Rstudio/renv/cache')

renv::init()

renv::install("remotes")
renv::install("gitcreds")
renv::install("httr")

library(httr)

# Your personal access token
if(token != "None"){
    print("##########")
    print("Your GITHUB token is")
    print(token)

    # Create a config with your token
    print("Your GITHUB token configuration is")
    response <- GET("https://api.github.com/rate_limit",
                add_headers(Authorization = paste("token", token, sep = " ")))

    # Extract the rate limit data
    rate_limit_data <- content(response)

    # Print the rate limit data
    print(rate_limit_data)
    print("###################")
    }

#Sys.setenv("GITHUB_PAT", token)

remotes::install_version("SeuratObject", "4.1.4", repos = c("https://satijalab.r-universe.dev", getOption("repos")))
remotes::install_version("Seurat", "4.4.0", repos = c("https://satijalab.r-universe.dev", getOption("repos")))

install.packages('BiocManager')

#renv::install("Matrix@1.6-1")
renv::install("Matrix")

remotes::install_github("cran/howmany")



renv::install(c(
"bioc::airway",
"bioc::AnnotationHub",
"bioc::apeglm",
"bioc::batchelor",
"bioc::clusterExperiment",
"bioc::clusterProfiler",
"bioc::DEGreport",
"bioc::DESeq2",
"bioc::DOSE",
"bioc::ensembldb",
"bioc::GeneOverlap",
"bioc::GenomeInfoDb",
"bioc::ggtree",
"bioc::impute",
"bioc::limma",
"bioc::LoomExperiment",
"bioc::MAST",
"bioc::multtest",
"bioc::pathview",
"bioc::rhdf5",
"bioc::SingleCellExperiment",
"bioc::slingshot",
"bioc::tximport",
"bioc::vsn",
"bioc::org.Hs.eg.db",
"bioc::org.Mm.eg.db",
"bioc::org.Dm.eg.db"
))



renv::install(c(
  "stringi",
  "GOplot",
  "cluster",
  "clusterSim",
  "cowplot",
  "doFuture",
  "factoextra",
  "FactoMineR",
  "fossil",
  "fpc",
  "ggbeeswarm",
  "ggnewscale",
  "ggpubr",
  "ggrepel",
  "ggsci",
  "globals",
  "parallelly",
  "gprofiler2",
  "hexbin",
  "httr",
  "igraph",
  "knitr",
  "markdown",
  "metap",
  "NMF",
  "patchwork",
  "pheatmap",
  "R.utils",
  "RColorBrewer",
  "readxl",
  "remotes",
  "reticulate",
  "Rfast",
  "sctransform",
  "Signac",
  "statmod",
  "tidyr",
  "tidyverse",
  "WGCNA"
))

renv::install(c(
    "satijalab/seurat-data",
    "mojaveazure/seurat-disk",
    "SamueleSoraggi/DoubletFinder",
    "stephenturner/annotables",
    "cellgeni/sceasy",
    "cysouw/qlcMatrix",
    "satijalab/seurat-wrappers@community-vignette"
  ),
  upgrade = "never",
  quiet = FALSE
)

remotes::install_github('smorabit/hdWGCNA', 
                         ref='dev', 
                         upgrade="never",
                         quiet=FALSE )