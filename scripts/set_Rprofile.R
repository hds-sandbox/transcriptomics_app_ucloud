#setHook("rstudio.sessionInit", function(newSession) {
#  if (newSession)
#    rstudioapi::navigateToFile('/opt/RNAseq_in_Rstudio/welcome_message.md', line = -1L, column = -1L)
#}, action = "append")


Sys.setenv(RENV_PATHS_CACHE = '/opt/RNAseq_in_Rstudio/cache')
suppressWarnings(renv::load('/opt/RNAseq_in_Rstudio'))
message("WELCOME to the Rstudio setup of the Transcriptomics Sandbox. For more information, visit our page https://hds-sandbox.github.io")
