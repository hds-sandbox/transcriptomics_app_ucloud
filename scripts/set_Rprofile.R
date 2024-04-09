setHook("rstudio.sessionInit", function(newSession) {
  if (newSession)
    rstudioapi::navigateToFile('/opt/RNAseq_in_Rstudio/welcome_message.md', line = -1L, column = -1L)
}, action = "append")


Sys.setenv(RENV_PATHS_CACHE = '/opt/RNAseq_in_Rstudio/cache')
renv::load(project = '/opt/RNAseq_in_Rstudio')

#Sys.setenv(R_HOME='/opt/micromamba/envs/RNAseq_env/lib/R')
#Sys.setenv(R_LIBS='/opt/micromamba/envs/RNAseq_env/lib/R/library')
#Sys.setenv(LD_LIBRARY_PATH='/opt/micromamba/envs/RNAseq_env/lib/R/lib/libR.so')
#Sys.setenv(R_LD_LIBRARY_PATH='/opt/micromamba/envs/RNAseq_env/lib/R/lib/libR.so')
