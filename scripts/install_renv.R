setwd('/opt/renv_transcriptomics')

Sys.setenv(RENV_PATHS_CACHE = '/opt/renv_transcriptomics/cache')

library(httr)

token = "None"
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

renv::init()

renv::restore(lockfile='/opt/renv_transcriptomics/renv.lock', 
             prompt=FALSE)



message("INSTALL GITHUB PACKAGES")

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

#15 3059.8 1: failed to resolve remote 'MacoskoLab/liger'; skipping 
#15 3059.8 2: failed to resolve remote 'hms-dbmi/conos'; skipping 
#15 3059.8 3: failed to resolve remote 'immunogenomics/harmony'; skipping 
#15 3059.8 4: failed to resolve remote 'satijalab/seurat-data'; skipping 
#15 3059.8 5: failed to resolve remote 'velocyto-team/velocyto.R'; skipping 
#15 3059.8 6: failed to resolve remote 'SaskiaFreytag/schex@031320d'; skipping 
#15 3059.8 7: failed to resolve remote 'cole-trapnell-lab/monocle3'; skipping 
#15 3059.8 8: failed to resolve remote 'mojaveazure/seurat-disk'; skipping 
#15 3059.8 9: failed to resolve remote 'YuLab-SMU/tidydr'; skipping 
#15 3059.8 10: failed to resolve remote 'GuangchuangYu/treeio'; skipping 