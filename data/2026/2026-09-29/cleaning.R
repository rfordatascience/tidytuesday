# Packages 
library(readr)
library(dplyr)
library(tidyr)

url <- "https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_UCDB_GLOBE_R2024A/GHS_UCDB_THEME_GLOBE_R2024A/GHS_UCDB_THEME_HEALTH_GLOBE_R2024A/V1-2/GHS_UCDB_THEME_HEALTH_GLOBE_R2024A_V1_2.zip"

# let's set the path as a .zip 
zip_path <- tempfile(fileext = ".zip")

# mode = "wb" is essential on Windows to download the file, harmless elsewhere
download.file(url, 
              zip_path, 
              mode = "wb")   # uses fs 

# This creates a temporary file so the .zip file is stored there
(exdir <- tempfile())
unzip(zip_path, exdir = exdir)

list.files(exdir, recursive = TRUE)
# Now let's open the actual file we need. 
# Copy .csv from list.files() in the console
health <- readr::read_csv(file.path(exdir, 'GHS_UCDB_THEME_HEALTH_GLOBE_R2024A.csv'), 
                          na = '-')

# Let's check how many NAs each column has
health |>
  summarise(across(everything(), \(x) sum(is.na(x)))) |> 
  pivot_longer(everything(), names_to = "column", values_to = "n_missing") |>
  mutate(n_rows = nrow(health)) |>
  arrange(desc(n_missing))

