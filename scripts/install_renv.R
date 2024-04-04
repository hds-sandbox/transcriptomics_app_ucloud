#setwd('/opt/RNAseq_in_Rstudio/renv')

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

renv::restore(lockfile='/opt/RNAseq_in_Rstudio/renv')

print("hello")