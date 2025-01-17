# Clean data compiled from code referenced in article (https://waterdata.usgs.gov/blog/acs-maps/). 
# Code was revised to pull data for all US counties for years 2022 - 2023.

# Load packages -----
library(tidycensus)
library(sf) 
library(janitor) 
library(tidyverse)

# Helper functions -----
get_census_data <- function(geography, var_names, year, proj, survey_var) {
  df <- get_acs(
    geography = geography,
    variable = var_names,
    year = year,
    geometry = TRUE,
    survey = survey_var) |>
    clean_names() |>
    st_transform(proj) |>
    mutate(year = year)
  
  return(df) 
}

# Grab relevant variables - B01003_001: total population, B25049_004: households lacking plumbing----
vars <- c("B01003_001", "B25049_004")

# Pull data for 2023 and 2022 for all US counties ------
water_insecurity_2023 <- get_census_data(
  geography = 'county', 
  var_names = vars, 
  year = "2023", 
  proj = "EPSG:5070", 
  survey_var = "acs1"
) |>
  mutate(
    variable_long = case_when(
      variable == "B01003_001" ~ "total_pop",
      variable == "B25049_004" ~ "plumbing",
      .default = NA_character_  
    )
  ) |> 
  select(geoid, name, variable_long, estimate, geometry, year) |> 
  pivot_wider(
    names_from = variable_long,
    values_from = estimate
  ) |> 
  mutate(
    percent_lacking_plumbing = (plumbing / total_pop) * 100
  )

water_insecurity_2022 <- get_census_data(
  geography = 'county', 
  var_names = vars, 
  year = "2022", 
  proj = "EPSG:5070", 
  survey_var = "acs1"
) |>
  mutate(
    variable_long = case_when(
      variable == "B01003_001" ~ "total_pop",
      variable == "B25049_004" ~ "plumbing",
      .default = NA_character_  
    )
  ) |> 
  select(geoid, name, variable_long, estimate, geometry, year) |> 
  pivot_wider(
    names_from = variable_long,
    values_from = estimate
  ) |> 
  mutate(
    percent_lacking_plumbing = (plumbing / total_pop) * 100
  )

# Combine 2022 and 2023 water insecurity data------
water_insecurity_2022_2023 <- water_insecurity_2023 |>
  bind_rows(water_insecurity_2022)
