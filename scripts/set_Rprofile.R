setHook("rstudio.sessionInit", function(newSession) {
  if (newSession)
    rstudioapi::navigateToFile('/opt/RNAseq_in_Rstudio/welcome_message.md', line = -1L, column = -1L)
}, action = "append")


Sys.setenv(RENV_PATHS_CACHE = '/opt/RNAseq_in_Rstudio/cache')
try( renv::load('/opt/RNAseq_in_Rstudio') )
message("IGNORE the error message above. It is expected due to a bug in renv.")
