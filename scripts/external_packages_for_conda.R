library(httr, lib.loc="/opt/miniconda/envs/RNAseq_env/lib/R/library/")

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

install.packages('stringi', 
    repos='http://cran.us.r-project.org', 
    lib="/opt/miniconda/envs/RNAseq_env/lib/R/library/",
    quiet=FALSE )

#remotes::install_local("/tmp/ggforestplot.zip", lib="/opt/miniconda/envs/RNAseq_env/lib/R/library/")

#remotes::install_version('Matrix','1.6-4', upgrade = 'never', lib.loc='/opt/miniconda/envs/RNAseq_env/lib/R/library/')
#remotes::install_version('irlba','2.3.5.1', upgrade = 'never', lib.loc='/opt/miniconda/envs/RNAseq_env/lib/R/library/')
#remotes::install_version('ggplot2','3.4.4', upgrade = 'never', lib.loc='/opt/miniconda/envs/RNAseq_env/lib/R/library/')
#remotes::install_version("patchwork", "1.1.3", upgrade="never", lib.loc='/opt/miniconda/envs/RNAseq_env/lib/R/library/')

remotes::install_github("NightingaleHealth/ggforestplot",
    upgrade="never", 
    lib="/opt/miniconda/envs/RNAseq_env/lib/R/library/",
    quiet=FALSE )

remotes::install_github("jhrcook/ggasym", 
    upgrade="never", 
    lib="/opt/miniconda/envs/RNAseq_env/lib/R/library/",
    quiet=FALSE )

install.packages('GOplot', 
    repos='http://cran.us.r-project.org', 
    lib="/opt/miniconda/envs/RNAseq_env/lib/R/library/",
    quiet=FALSE )

install.packages('BiocManager', 
    repos='http://cran.us.r-project.org', 
    lib="/opt/miniconda/envs/RNAseq_env/lib/R/library/",
    quiet=FALSE )

BiocManager::install(c("org.Hs.eg.db", "org.Mm.eg.db", "org.Dm.eg.db"),
    update=FALSE, 
    lib="/opt/miniconda/envs/RNAseq_env/lib/R/library/",
    quiet=FALSE )

remotes::install_github(c("satijalab/seurat-data",
                          "mojaveazure/seurat-disk"),
                          upgrade="never",
                          lib="/opt/miniconda/envs/RNAseq_env/lib/R/library/",
                          quiet=FALSE )

#remotes::install_local("/tmp/doubletfinder.zip", 
#    lib="/opt/miniconda/envs/RNAseq_env/lib/R/library/")

#remotes::install_github("mojaveazure/seurat-disk", 
#    upgrade="never", 
#    lib="/opt/micromamba/envs/RNAseq_env/lib/R/library/",
#    quiet=FALSE )

remotes::install_github("SamueleSoraggi/DoubletFinder", 
    lib="/opt/miniconda/envs/RNAseq_env/lib/R/library/", 
    upgrade="never",
    quiet=FALSE )

remotes::install_github('smorabit/hdWGCNA@6bb2fc9fd31338b12bb6b68d2f8f90080d532a4e', 
    ref='dev', 
    upgrade="never", 
    lib="/opt/miniconda/envs/RNAseq_env/lib/R/library/",
    quiet=FALSE)