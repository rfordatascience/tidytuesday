remotes::install_github("eringrand/astropic")

# Dataset inside the the {{astropic}} R package on GitHub.
library(astropic)
library(dplyr)
data("hist_apod")

# Remove one column with constant values
apod <- hist_apod
dataset <- apod |> 
  select(-service_version)