library(tidyverse)

# 1. Download Grambank v1.0.3 zip directly from Zenodo
zip_url  <- "https://zenodo.org/records/7844558/files/grambank/grambank-v1.0.3.zip?download=1"
temp_zip <- tempfile(fileext = ".zip")
temp_extract <- file.path(tempdir(), "grambank_extracted")

message("Downloading Grambank release v1.0.3...")
download.file(zip_url, destfile = temp_zip, mode = "wb", quiet = TRUE)

# 2. Extract contents to an isolated temporary folder
message("Unzipping repository contents...")
unzip(temp_zip, exdir = temp_extract)

# 3. Locate the 'cldf' directory dynamically
extracted_files <- list.files(temp_extract, recursive = TRUE, full.names = TRUE)
values_path     <- grep("cldf/values\\.csv$", extracted_files, value = TRUE)
languages_path  <- grep("cldf/languages\\.csv$", extracted_files, value = TRUE)
parameters_path <- grep("cldf/parameters\\.csv$", extracted_files, value = TRUE)

# 4. Import the raw CLDF files
message("Importing CLDF tables...")
values_raw     <- read_csv(values_path, show_col_types = FALSE)
languages_raw  <- read_csv(languages_path, show_col_types = FALSE)
parameters_raw <- read_csv(parameters_path, show_col_types = FALSE)

# 5. Clean & subset datasets

# 5.1 Fact Table: Core coded observations
grambank_values <- values_raw |>
  filter(!is.na(Value), Value != "?") |>
  select(
    language_id = Language_ID,
    parameter_id = Parameter_ID,
    value = Value,
    code_id = Code_ID
  ) |>
  mutate(
    value = as.integer(value)
  )

# 5.2 Dimension Table: Language geographic & genealogical metadata
grambank_languages <- languages_raw |>
  select(
    language_id = ID,
    language_name = Name,
    glottocode = Glottocode,
    macroarea = Macroarea,
    latitude = Latitude,
    longitude = Longitude,
    family_name = Family_name,
    lineage
  ) |>
  mutate(
    across(c(latitude, longitude), as.numeric)
  )

# 5.3 Dimension Table: Typological feature look-up
grambank_parameters <- parameters_raw |>
  select(
    parameter_id = ID,
    feature_name = Name,
    feature_description = Description,
    word_order = Word_Order,
    locus_of_marking = Locus_of_Marking
  ) 

# 6. Clean up temporary download artifacts
unlink(temp_zip)
unlink(temp_extract, recursive = TRUE)

message("Success. Grambank datasets ('grambank_values', 'grambank_languages', 'grambank_parameters') are loaded and ready in the environment.")
