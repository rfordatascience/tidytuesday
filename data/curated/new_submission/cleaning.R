# Data downloaded manually from
# https://www.eia.gov/dnav/pet/xls/PET_PRI_GND_DCUS_NUS_W.xls to tempdir.
file_path <- fs::path_temp("PET_PRI_GND_DCUS_NUS_W.xls")

weekly_gas_prices <- readxl::read_xls(file_path, sheet = "Data 1", skip = 2) |>
  dplyr::select(
    date = "Date",
    gasoline.all.all = "Weekly U.S. All Grades All Formulations Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.all.conventional = "Weekly U.S. All Grades Conventional Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.all.reformulated = "Weekly U.S. All Grades Reformulated Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.regular.all = "Weekly U.S. Regular All Formulations Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.regular.conventional = "Weekly U.S. Regular Conventional Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.regular.reformulated = "Weekly U.S. Regular Reformulated Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.midgrade.all = "Weekly U.S. Midgrade All Formulations Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.midgrade.conventional = "Weekly U.S. Midgrade Conventional Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.midgrade.reformulated = "Weekly U.S. Midgrade Reformulated Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.premium.all = "Weekly U.S. Premium All Formulations Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.premium.conventional = "Weekly U.S. Premium Conventional Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.premium.reformulated = "Weekly U.S. Premium Reformulated Retail Gasoline Prices  (Dollars per Gallon)",
    diesel.all = "Weekly U.S. No 2 Diesel Retail Prices  (Dollars per Gallon)",
    diesel.ultra_low_sulfur = "Weekly U.S. No 2 Diesel Ultra Low Sulfur (0-15 ppm) Retail Prices  (Dollars per Gallon)",
    diesel.low_sulfur = "Weekly U.S. No 2 Diesel Low Sulfur (15-500 ppm) Retail Prices  (Dollars per Gallon)"
  ) |>
  dplyr::mutate(date = as.Date(date)) |>
  tidyr::pivot_longer(
    cols = -date,
    names_to = "fuel_spec",
    values_to = "price"
  ) |>
  dplyr::filter(!is.na(price)) |>
  tidyr::separate_wider_delim(
    cols = fuel_spec,
    delim = ".",
    names = c("fuel", "grade", "formulation"),
    too_few = "align_start"
  ) |>
  dplyr::mutate(
    dplyr::across(c(fuel, grade, formulation), as.factor)
  )
