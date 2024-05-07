#setHook("rstudio.sessionInit", function(newSession) {
#  if (newSession)
#    rstudioapi::navigateToFile('/opt/RNAseq_in_Rstudio/welcome_message.md', line = -1L, column = -1L)
#}, action = "append")


Sys.setenv(RENV_PATHS_CACHE = '/opt/renv_transcriptomics/cache')
suppressWarnings(renv::load('/opt/renv_transcriptomics'))
message("----------------------\n\033[1;34mWelcome to the Transcriptomics setup in the Rstudio development environment\033[0m\n----------------------\nIf you found this app useful for your own research, please ACKNOWLEDGE us by adding this prompt to your research:\n\tWe acknowledge assistance and support for computational resources and infrastructure\n\tvia the Health Data Science Sandbox (\033[4mhttps://hds-sandbox.github.io\033[24m), funded by the Novo Nordisk Foundation (NNF20OC0063268).\n----------------------\nWe also welcome suggestions and bug reports. Send an email to \033[4mNHDS_sandbox@sund.ku.dk\033[24m.\n----------------------\nThank you very much!\nThe NHDS Sandbox team.")