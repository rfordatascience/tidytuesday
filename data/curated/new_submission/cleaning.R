# Paste code used to create the curated dataset here. Include comments as
# necessary. If you did not need to clean the data, use a comment like the one
# below, but also load the data with readr::read_csv() to ensure the data can be
# loaded, and to use with `saving.R`. Delete this block of comments.

# The data is part of the supplemental material released with the paper
# Paper: https://onlinelibrary.wiley.com/doi/10.1111/ele.70296
# Data and code: https://figshare.com/articles/journal_contribution/Sex_ratio_bias_triggers_demographic_suicide_in_a_dense_tortoise_population/30752687
# It seems it is not possible to download programatically,
# therefore I am downloading and unziping the file in data-raw

# The raw is in the folder 
# data-raw/Sex_ratio_bias_triggers_demographic_suicide-main/R/input
# in two files body_condition.csv and clutch_size.csv


library(dplyr)
library(readr)
library(tidytuesdayR)

# Clean body_condition.csv
tortoise_body_condition <- readr::read_csv("data-raw/Sex_ratio_bias_triggers_demographic_suicide-main/R/input/body_condition.csv")

# The dataset is not documented within the released zip file 

tortoise_body_condition_cleaned <- tortoise_body_condition |> 
  # remove the column that seems like a row number
  # remove the column that is probably a modeling residual,,
  # the column that is pasting together location and sex,
  # and the log_BCI column
  dplyr::select(-c(...1, res, log_BCI, loc_sex_cohort)) |> 
  # gruoup by individual and arrange by year_recode which 
  # increments for every measurement of the individual
  dplyr::group_by(ind) |> 
  dplyr::arrange(year_recode, .by_group = TRUE) |> 
  dplyr::ungroup()  |> 
  # rename columns so it's clearer what they mean
  dplyr::rename(straight_carapace_length_mm =  SCL,
                body_mass_grams = BM,# we are assuming it's grams
                body_condition_index = BCI,
                individual = ind,
                locality = loc) |> 
  # arrange column in more meaningful order
  dplyr::relocate(individual, year, year_recode, season, locality, sex,
                  body_mass_grams, body_condition_index, straight_carapace_length_mm,
                  ) |> 
  # add more then initial so some columns
  dplyr::mutate(locality = locality |> 
                  dplyr::recode_values(
                  "b" ~ "Beach",
                  "p" ~ "Plateau",
                  "k" ~ "Konjsko"
  )) |> 
  dplyr::mutate(season = season |> 
                  dplyr::recode_values(
                    "sum" ~ "Summer",
                    "sp" ~ "Spring"
                  ))
  
tidytuesdayR::tt_save_dataset(tortoise_body_condition_cleaned)

# Clean body_condition.csv
clutch_size <- readr::read_csv("data-raw/Sex_ratio_bias_triggers_demographic_suicide-main/R/input/clutch_size.csv")

# Smaller and easier dataset to clean 
# with excel dates the only major issue.
clutch_size_cleaned <- clutch_size |> 
  dplyr::rename(
    individual =     ind,
    locality = Locality,
    straight_carapace_length_mm = SCL,
    body_mass_grams = BM,
    eggs = Eggs,
    date = Date,
    age = Age
  ) |> 
  dplyr::mutate(date = as.Date(date, origin = "1899-12-30")) |> 
  dplyr::relocate(individual, age, date, locality, eggs,
                  body_mass_grams, straight_carapace_length_mm)
  

tidytuesdayR::tt_save_dataset(clutch_size_cleaned)

tidytuesdayR::tt_intro()

tidytuesdayR::tt_meta()

tidytuesdayR::tt_submit()
