
setHook("rstudio.sessionInit", function(newSession) {
  if (newSession)
    rstudioapi::navigateToFile('/usr/RNAseq_in_Rstudio/welcome_message.md', line = -1L, column = -1L)
}, action = "append")

Sys.setenv(RENV_PATHS_CACHE = '/usr/RNAseq_in_Rstudio/renv/cache')
renv::load(project = '/usr/RNAseq_in_Rstudio/renv')
