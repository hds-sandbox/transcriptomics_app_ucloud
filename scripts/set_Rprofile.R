
setHook("rstudio.sessionInit", function(newSession) {
  if (newSession)
    rstudioapi::navigateToFile('/usr/RNAseq_in_Rstudio/welcome_message.md', line = -1L, column = -1L)
}, action = "append")

#Sys.setenv(RENV_PATHS_CACHE = '/usr/RNAseq_in_Rstudio/renv/cache')
#renv::load(project = '/usr/RNAseq_in_Rstudio/renv')

Sys.setenv(R_HOME='/opt/micromamba/envs/RNAseq_env/lib/R')
Sys.setenv(R_LIBS='/opt/micromamba/envs/RNAseq_env/lib/R/library')
Sys.setenv(LD_LIBRARY_PATH='/opt/micromamba/envs/RNAseq_env/lib/R/lib/libR.so')
Sys.setenv(R_LD_LIBRARY_PATH='/opt/micromamba/envs/RNAseq_env/lib/R/lib/libR.so')