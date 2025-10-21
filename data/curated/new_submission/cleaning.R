
## Diabetes data from medicaldata package by Peter Higgins

# Install medicaldata package
#remotes::install_github("higgi13425/medicaldata")
library(medicaldata)
library(tidyverse)

# Load diabetes data
diabetes = medicaldata::diabetes

# No data cleaning needed
# For more information and background on the data: https://pmc.ncbi.nlm.nih.gov/articles/PMC4418458/