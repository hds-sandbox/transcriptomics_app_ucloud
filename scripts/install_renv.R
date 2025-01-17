setwd('/opt/renv_transcriptomics')

Sys.setenv(RENV_PATHS_CACHE = '/opt/renv_transcriptomics/cache')

options(renv.config.auto.snapshot = TRUE)

library(httr)

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
             prompt=TRUE)

message("INSTALL GITHUB PACKAGES")

remotes::install_github("NightingaleHealth/ggforestplot",
    upgrade = "never",
    quiet = TRUE)

renv::install(c(
    "satijalab/seurat-data",
    "mojaveazure/seurat-disk",
    "SamueleSoraggi/DoubletFinder",
    #"stephenturner/annotables", #problem in db loading when installed from github - installed from source below
    "cellgeni/sceasy",
    "cysouw/qlcMatrix",
    "satijalab/seurat-wrappers@community-vignette"
  ),
  upgrade = "never",
  quiet = TRUE
)

# Install some packages from a local zip file
renv_lib_path <- renv::paths$library()
install.packages("/tmp/annotables-0.2.0/annotables-0.2.0/", repos = NULL, type = "source", quiet=TRUE, lib=renv_lib_path)
install.packages("/tmp/hdwgcna/hdWGCNA-69110d0/", repos = NULL, type = "source", quiet=TRUE, lib=renv_lib_path)


#remotes::install_local('/tmp/hdWGCNA-69110d0.zip',
#                        upgrade="never",
#                        quiet=FALSE)

#remotes::install_github('smorabit/hdWGCNA', 
#                         ref='dev', 
#                         upgrade="never",
#                         quiet=FALSE )

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