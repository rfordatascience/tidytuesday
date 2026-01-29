library(tidyverse)
library(RODBC)

raw_data <- odbcConnectAccess2007("tt_submission//plant1.accdb")
plants <- sqlFetch(raw_data, "Edible plants")
edible_plants <- plants |>
  as_tibble() |>
  select(
    taxonomic_name = `Full taxonomic name`,
    common_name = `Common name`,
    cultivation = `Cultivation group (Rotational information)`,
    # Requirements
    sunlight = `Sunlight requirements`,
    water = `Water Requirements`,
    preferred_ph = `Preferred pH`,
    nutrients = `Nutrient requirements`,
    soil = Soil,
    season = `Descriptive Growing Season`,
    temperature_class = `Temperature class`,
    temperature_germination = `Optimum Germination Temerature`,
    temperature_growing = `Plant growing ideal temperature`,
    days_germination = `Days to germination at optimum temperature`,
    days_harvest = `Length of gorwing to harvest`,
    # Info
    nutritional_info = `Nutritional information`,
    energy = `Energy Value per 100g raw Kcal`,
    sensitivities = Sensitivities,
    description = `General Description`,
    requirements = `Plant Requirements`
  ) |>
  mutate(
    across(where(is.character), ~ na_if(.x, "Currently no data available."))
  ) |>
  mutate(soil = str_trim(soil)) |>
  mutate(energy = if_else(
    is.na(nutritional_info) & energy == 0, NA, energy
  )) |>
  separate(preferred_ph, into = c("preferred_ph_lower", "preferred_ph_upper"), sep = "-|–", fill = "right") |>
  mutate(
    across(starts_with("preferred"), as.numeric)
  ) |>
  mutate(temperature_growing = str_remove_all(temperature_growing, " ")) |>
  mutate(across(where(is.character), ~str_squish(.x)))

odbcCloseAll()
