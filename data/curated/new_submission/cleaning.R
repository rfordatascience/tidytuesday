
# This data is a subset of WHO TB data via the getTBinR package (Sam Abbott)

# Import libraries
library(tidyverse)
library(devtools)

# Install getTBinR package
#devtools::install_github("seabbs/getTBinR")
library(getTBinR)

# Load WHO TB burden data
tb_burden <- get_tb_burden()

# Create a vector of variable of interest
vars_of_interest <- c(
  "country",
  "g_whoregion",
  "iso_numeric",
  "iso2",
  "iso3",
  "year",
  "c_cdr",
  "c_newinc_100k",
  "cfr",
  "e_inc_100k",
  "e_inc_num",
  "e_mort_100k",
  "e_mort_exc_tbhiv_100k",
  "e_mort_exc_tbhiv_num",
  "e_mort_num",
  "e_mort_tbhiv_100k",
  "e_mort_tbhiv_num",
  "e_pop_num"
)

# Subset the dataset 
who_tb_data <- tb_burden %>%
  select(all_of(vars_of_interest))

# No data cleaning needed
