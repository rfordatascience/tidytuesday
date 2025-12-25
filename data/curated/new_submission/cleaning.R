
# Install package
#remotes::install_github("emilhvitfeldt/ferriswheels")


# Load packages
library(ferriswheels)
library(tidyverse)


wheels_clean <- ferriswheels::wheels |>
  mutate(
    construction_cost_million_usd = construction_cost |>
      str_replace("Estimated Between \\$650 and \\$750 million USD", "650-750") |>
      str_extract("[0-9,-]+") |>
      str_replace_all(",", "")
  ) |>
  select(
    -closed,
    -official_website,
    -design_manufacturer,
    -type,
    -vip_area,
    -ticket_cost_to_ride,
    -turns,
    -construction_cost
  )


wheels_clean <- wheels_clean |>
  mutate(
    climate_controlled = case_when(
      str_to_lower(climate_controlled) == "yes" ~ "Yes",
      str_to_lower(climate_controlled) == "no" ~ "No",
      str_to_lower(climate_controlled) == "sometimes" ~ "Sometimes",
      TRUE ~ NA_character_
    )
  )
wheels_clean <- wheels_clean |>
  mutate(
    country = case_when(
      country == "Tailand" ~ "Thailand",
      country == "Phillippines" ~ "Philippines",
      country == "S Korea" ~ "South Korea",
      country == "UK" ~ "United Kingdom",
      country == "UAE" ~ "United Arab Emirates",
      country == "Dubai" ~ "United Arab Emirates",
      TRUE ~ country
    )
  )
