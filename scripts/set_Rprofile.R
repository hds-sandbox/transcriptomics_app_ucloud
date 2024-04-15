#setHook("rstudio.sessionInit", function(newSession) {
#  if (newSession)
#    rstudioapi::navigateToFile('/opt/RNAseq_in_Rstudio/welcome_message.md', line = -1L, column = -1L)
#}, action = "append")


Sys.setenv(RENV_PATHS_CACHE = '/opt/RNAseq_in_Rstudio/cache')
suppressWarnings(renv::load('/opt/RNAseq_in_Rstudio'))
message("----------------------\nWelcome to the Transcriptomcis setup in the Rstudio development environment.\n----------------------\nIf you found this app useful for your own research, please ACKNOWLEDGE us by adding this prompt to your research:\n\tWe acknowledge assistance and support for computational resources and infrastructure\n\tvia the Health Data Science Sandbox (https://hds-sandbox.github.io), funded by the Novo Nordisk Foundation (NNF20OC0063268).\n----------------------\nWe also welcome suggestions and bug reports. Send an email to NHDS_sandbox@sund.ku.dk.\n----------------------\nThank you very much!\nThe NHDS Sandbox team. https://hds-sandbox.github.io\n----------------------\n")
