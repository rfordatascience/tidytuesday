library(tidyverse)
library(readxl)


# Download files ----------------------------------------------------------

download.file("https://seriestoriche.istat.it/fileadmin/documenti/Table_14.4.xls", "italian-industry-production/Table_14.4.xls")
download.file("https://seriestoriche.istat.it/fileadmin/documenti/Table_14.5.xls", "italian-industry-production/Table_14.5.xls")
download.file("https://seriestoriche.istat.it/fileadmin/documenti/Table_14.6.xls", "italian-industry-production/Table_14.6.xls")


# Food and beverages ------------------------------------------------------

raw_data1 <- read_xls("italian-industry-production/Table_14.4.xls",
                      skip = 5, sheet = 1)
raw_data2 <- read_xls("italian-industry-production/Table_14.4.xls",
                      skip = 5, sheet = 2)
data1 <- raw_data1 |>
  drop_na(YEARS) |>
  rename(Year = YEARS,
         Sugar = `Sugar (tons)`,
         Glucose = `Glucose, maltose, invert sugar \n(quintals)`,
         Coffee_substitute = `Coffee substitute (quintals)`,
         Seed_oil = `Seed oil (quintals)`,
         Ethyl_alcohol_1 = `Ethyl alcohol  (ettanidri) (c)`,
         Ethyl_alcohol_2 = `...11`,
         Beer = `Beer (hectolitres)`
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year)

data2 <- raw_data2 |>
  rename(Year = YEARS,
         Sugar = `Sugar (tons)`,
         Glucose = `Glucose, maltose, invert sugar\n (quintals)`,
         Coffee_substitute = `Coffee substitute (quintals)`,
         Seed_oil = `Seed oil \n(quintals)`,
         Ethyl_alcohol_1 = `Ethyl alcohol  (ettanidri) (c)`,
         Ethyl_alcohol_2 = `...11`,
         Beer = `Beer \n(hectolitres)`
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year)
food_beverages <- rbind(data1, data2) |>
  mutate(across(
    everything(), as.integer
  ))
write_csv(food_beverages, "italian-industry-production/food_beverages.csv")


# Textiles ----------------------------------------------------------------

raw_data1 <- read_xls("italian-industry-production/Table_14.5.xls",
                      skip = 6, sheet = 1)
raw_data2 <- read_xls("italian-industry-production/Table_14.5.xls",
                      skip = 7, sheet = 2)

data1 <- raw_data1 |>
  rename(Year = "...1",
         Raw_silk = "...12",
         Cotton_yarn = Cotton...2,
         Flock_yarn = Flock...3,
         Other_yarn = `Other fibres and fibre blend...4`,
         Total_yarn = Total...5,
         Cotton_textiles = Cotton...7,
         Flock_textiles = Flock...8,
         Other_textiles = `Other fibres and fibre blend...9`,
         Total_textiles = Total...10
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year)

data2 <- raw_data2 |>
  rename(Year = "...1",
         Raw_silk = "...12",
         Cotton_yarn = Cotton...2,
         Flock_yarn = Flock...3,
         Other_yarn = `Other fibres and fibre blend...4`,
         Total_yarn = Total...5,
         Cotton_textiles = Cotton...7,
         Flock_textiles = Flock...8,
         Other_textiles = `Other fibres and fibre blend...9`,
         Total_textiles = Total...10
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year)

textiles <- rbind(data1, data2) |>
  mutate(across(
    everything(), as.integer
  ))
write_csv(textiles, "italian-industry-production/textiles.csv")


# Transport ---------------------------------------------------------------

raw_data1 <- read_xls("italian-industry-production/Table_14.6.xls",
                      skip = 7, sheet = 1)
raw_data2 <- read_xls("italian-industry-production/Table_14.6.xls",
                      skip = 7, sheet = 2)

data1 <- raw_data1 |>
  rename(Year = "...1",
         Ships_launched = Number,
         Ships_weight  = `Tons of gross\n tonnage`
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year) |>
  pivot_longer(-Year) |>
  mutate(name = str_remove(name, "\\(c\\)"),
         name = str_trim(name),
         name = str_replace_all(name, "\n", ""),
         name = str_replace_all(name, " ", "_")) |>
  pivot_wider()

data2 <- raw_data2 |>
  rename(Year = "...1",
         Ships_launched = Number,
         Ships_weight  = `Tons of gross tonnage`
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year) |>
  pivot_longer(-Year) |>
  mutate(name = str_remove(name, "\\(c\\)"),
         name = str_trim(name),
         name = str_replace_all(name, "\n", ""),
         name = str_replace_all(name, " ", "_")) |>
  pivot_wider()

transport <- rbind(data1, data2) |>
  mutate(across(
    everything(), as.integer
  ))
write_csv(transport, "italian-industry-production/transport.csv")

