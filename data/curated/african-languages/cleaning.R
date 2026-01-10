#########################################################################
# Author: Muwanga Robert                                                #
# Date: 24 December 2025                                                #
# License : Creative Commons (CC-BY)                                    #
# Purpose: Scrapes data from Wikipedia on popular languages in Africa.  #
#########################################################################

require(tidyr)
require(stringr)
require(dplyr)
require(purrr)
require(rvest)

# Let's get a list of African countries that we shall use in our data cleaning
# process 

african_countries <- 
  rvest::read_html('https://www.worldometers.info/geography/how-many-countries-in-africa/') |> 
  rvest::html_table() |> 
  purrr::pluck(1) |> 
  pull('Country') %>% 
  c(., 'Ivory Coast', 'Cape Verde')

# Let's extract the table of interest from Wikipedia
dataset <- 
  rvest::read_html("https://en.wikipedia.org/wiki/Languages_of_Africa") |> 
  rvest::html_table() |> 
  purrr::pluck(5) |> 
  dplyr::select(
    language = Language,
    family = Family,
    native_speakers = `Native speakers within Africa (L1)`, 
    country = `Official status per country`
  ) 

# Clean up the family and native speaker columns, and extract the countries
# from the country column
dt <- dataset |> 
  mutate(
    family = str_split_i(family, " ", 1), 
    native_speakers = str_split_i(native_speakers, " ", 1),
    country = str_extract_all(
      country, str_c(african_countries, collapse = "|"), simplify = TRUE))

# From the country column, we "expand" the cells that have vectors, creating 
# a "wider" tibble
countries <- 
  dataset |> 
  select(country) |> 
  map(.f = function(x) str_extract_all(
    x, str_c(
      african_countries, collapse = "|"), 
    simplify = TRUE)) |> 
  as.data.frame()

# We binding columns between the two datasets, make the dataset longer, and 
# remove rows that have blank entries in the country column
africa <- bind_cols(dt, countries) |> 
  select(-country) |> 
  pivot_longer(
    cols = contains("country"),
    names_to = 'country_index', values_to = 'country') |> 
  mutate(
    country = na_if(country, "")) |> 
  drop_na()

# We then clean up the native_speakers column and prepare our final dataset 
# by removing the unwanted country_index column
africa <- africa |> 
  mutate(native_speakers = str_split_i(native_speakers, pattern = '\\[|-', i = 1), 
         native_speakers = str_remove_all(native_speakers, pattern = ','), 
         native_speakers = as.integer(native_speakers)) |> 
  filter(!is.na(native_speakers)) |> 
  select(-country_index)