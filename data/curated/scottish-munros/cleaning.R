library(tidyverse)

raw_data <- read_csv("https://www.hills-database.co.uk/munrotab_v8.0.1.csv")

scottish_munros <- raw_data |>
  select(
    `DoBIH Number`, Name,
    `Height (m)`, `Height\n(ft)`, xcoord, ycoord,
    `1891`:`2021`, Comments
  ) |>
  drop_na(`DoBIH Number`) |> 
  rename(
    Height_m = `Height (m)`,
    Height_ft = `Height\n(ft)`,
    DoBIH_number = `DoBIH Number`
  ) |> 
  mutate(
    Comments = case_when(
      Comments %in% c("See named worksheet", "See named worksheet for old mapping") ~ NA_character_,
      TRUE ~ Comments
    )
  ) |> 
  mutate(
    across(`1891`:`2021`, ~case_when(
      .x == "MUN" ~ "Munro",
      .x == "TOP" ~ "Munro Top"
    ))
  ) 
