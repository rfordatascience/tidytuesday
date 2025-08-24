library(tidyverse)
library(here)

# download and clean frogID data
frogID <- here("frog_data.csv")

download.file("https://d2pifd398unoeq.cloudfront.net/FrogID6_final_dataset.csv",
              destfile = frogID, mode = "wb")

frogID_data <- read_csv("frog_data.csv") %>%
  # remove columns containing only one unique value and other unnecessary columns
  select(-c(datasetName, basisOfRecord, dataGeneralizations,
            sex, lifestage, behavior, samplingProtocol, country,
            machineObservation, geoprivacy,
            modified)) %>%
  # restrict to 2023 data only to reduce file size
  filter(format(eventDate, "%Y") == "2023") %>%
  # split time column into time and timezone
  separate_wider_regex(eventTime,
    patterns = c(eventTime = "^\\d{2}:\\d{2}:\\d{2}", timezone   = ".*$")) %>%
  mutate(timezone = ifelse(grepl("^[+-]", timezone), paste0("GMT", timezone), timezone))


# read and tidy frog name and common name data
download.file("https://raw.githubusercontent.com/jessjep/Frogs/main/frog_names.xlsx",
              destfile = "frog_names.xlsx", mode = "wb")

frog_names <- readxl::read_xlsx("frog_names.xlsx") %>%
  select(1:4) %>%
  separate_wider_delim(`GROUP, FAMILY, SUBFAMILY, TRIBE`, delim = ",",
                       names = c("family", "subfamily", "tribe")) %>%
  rename(scientificName = `GENUS SPECIES SUBSPECIES`,
         commonName = `COMMON NAME`,
         secondary_commonNames = `SECONDARY COMMON NAMES`) %>%
  select(-1)

frog_names[frog_names == "—"] <- NA


