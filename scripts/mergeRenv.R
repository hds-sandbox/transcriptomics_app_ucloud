# Load necessary library
library(jsonlite)

# Define file paths
file1 <- "renvOldest.lock"
file2 <- "renvNewest.lock"

# Read renv.lock files
renv1 <- fromJSON(file1, simplifyVector = TRUE)
renv2 <- fromJSON(file2, simplifyVector = TRUE)

# Extract package information
packages1 <- renv1$Packages
packages2 <- renv2$Packages

# Combine and keep the most updated version of each package
merged_packages <- packages1

for (pkg in names(packages2)) {
  if (pkg %in% names(packages1)) {
    # Compare versions and keep the higher one
    version1 <- packages1[[pkg]]$Version
    version2 <- packages2[[pkg]]$Version
    
    if (compareVersion(version2, version1) > 0) {
      merged_packages[[pkg]] <- packages2[[pkg]]
    }
  } else {
    # Add package if it is not in the first list
    merged_packages[[pkg]] <- packages2[[pkg]]
  }
}

# Update the merged renv.lock structure
merged_renv <- renv1
merged_renv$Packages <- merged_packages

# Save the merged renv.lock file
output_file <- "./renv.lock"
write_json(merged_renv, output_file, pretty = TRUE, auto_unbox = TRUE)

cat("Merged renv.lock file saved to:", output_file, "\n")
