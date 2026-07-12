# Data provided by Energy Data. Some* cleaning was necessary.

# ----
# Downloading the data
energy <- readr::read_csv("https://energydata.info/dataset/538a3ba2-f218-42b2-a79c-3a5b7603556e/resource/f779714e-d97f-4f57-a61f-057f5496d06f/download/se4alldata.csv")

# ----
#  Figuring out which columns to exclude

# Pivoting table to longer format so that the metrics and their units are 
# better exposed [ This is the initial process. Final cleaning follows it.]
tidy_test_df <- energy |>
  # 0. Excluding the `Period 1990-2000`,	`Period 1990-2010`,	`Period 2000-2010`
    # because they're aggregations that will confuse the pivot.
    # The indicator codes column is also dropped 
  dplyr::select(
    -c(
      `Period 1990-2000`, 
      `Period 1990-2010`,
      `Period 2000-2010`,
      `Indicator_Code`
      )
  ) |>
  # 1. Standard pivot to get years in one column
  tidyr::pivot_longer(
    cols = matches("^[0-9]{4}$"), 
    names_to = "Year", 
    values_to = "Value"
  ) |>
  # 2. We want the Indicator_Name to become the headers.
  tidyr::pivot_wider(
    id_cols = c(Country_Name, Country_Code, Year),
    names_from = Indicator_Name,
    values_from = Value
    )

# A quick check of the new columns tied to those earlier periods reveals blank
# columns:
  # > unique(tidy_test_df$`Final energy intensity -Compound Annual Growth Rate (%)`)
  # [1] NA
  # > unique(tidy_test_df$`Divisia Decomposition Analysis - Activity component  -Compound Annual Growth Rate (%)`)
  # [1] NA

# Going back and looking at the original table to see which indicator codes 
  # indicator names correspond with, the following can be safely removed:
    # 8.1_FINAL.ENER.INTENS.RATE
    # 16.4_DECOMP.EFFICIENCY.RATE
    # 16.5_DECOMP.ACTIVITY.RATE
    # 16.6_DECOMP.STRUCTURE.RATE

# ----
# Creating the final cleaned table

# removing the rows with the associated indicator codes mentioned above that
# were associated with those year period columns
to_remove <- c(
  "8.1_FINAL.ENER.INTENS.RATE", 
  "16.4_DECOMP.EFFICIENCY.RATE",
  "16.5_DECOMP.ACTIVITY.RATE",
  "16.6_DECOMP.STRUCTURE.RATE"
  )

energy_clean <- energy[!(energy$Indicator_Code %in% to_remove), ] |>
  dplyr::select(
    -c(
      `Period 1990-2000`, 
      `Period 1990-2010`,
      `Period 2000-2010`,
      `Indicator_Code`
    )
  ) |>
  # 1. Standard pivot to get years in one column
  tidyr::pivot_longer(
    cols = matches("^[0-9]{4}$"), 
    names_to = "Year", 
    values_to = "Value"
  ) |>
  # 2. To keep Indicator_Code as a column, it MUST be in id_cols.
  # But we want the Indicator_Name to become the headers.
  tidyr::pivot_wider(
    id_cols = c(Country_Name, Country_Code, Year),
    names_from = Indicator_Name,
    values_from = Value
  )

# checking for empty columns
# energy_clean[, colSums(is.na(energy_clean)) == nrow(energy_clean)]

# dropping the final rogue columns
energy_cleaned <- energy_clean |>
  dplyr::select(
    -any_of(c(
      "Divisia Decomposition Analysis - Activity component  -Compound Annual Growth Rate (%)",
      "Primary energy intensity -Compound Annual Growth Rate (%)"
    ))
  ) |>
  dplyr::rename(
    country_name = Country_Name,
    country_code = Country_Code,
    yr = Year,
    access_non_solid_fuel_rural_pop_pct = `Access to Non-Solid Fuel (% of rural population)`,
    access_non_solid_fuel_total_pop_pct = `Access to Non-Solid Fuel (% of total population)`,
    access_non_solid_fuel_urban_pop_pct = `Access to Non-Solid Fuel (% of urban population)`,
    access_electricity_rural_pop_pct = `Access to electricity (% of rural population)`,
    access_electricity_total_pop_pct = `Access to electricity (% of total population)`,
    access_electricity_urban_pop_pct = `Access to electricity (% of urban population)`,
    biogas_consumption_tfec_pct = `Biogas consumption (% in TFEC)`,
    biogas_consumption_terajoules = `Biogas consumption (TJ)`,
    divisia_decomp_analysis_activity_component_index = `Divisia Decomposition Analysis - Activity component Index`,
    divisia_decomp_analysis_energy_intensity_component_index = `Divisia Decomposition Analysis - Energy Intensity component Index`,
    divisia_decomp_analysis_structure_component_index = `Divisia Decomposition Analysis - Structure Component Index`,
    energy_intensity_level_final_energy_megajoules_per_usd_2005_ppp = `Energy intensity level of final energy (MJ/$2005 PPP)`,
    energy_intensity_level_primary_energy_megajoules_per_usd_2005_ppp = `Energy intensity level of primary energy (MJ/$2005 PPP)`,
    energy_intensity_agricultural_sector_megajoules_per_usd_2005 = `Energy intensity of agricultural sector (MJ/$2005)`,
    energy_intensity_industrial_sector_megajoules_per_usd_2005 = `Energy intensity of industrial sector (MJ/$2005)`,
    energy_intensity_other_sectors_megajoules_per_usd_2005 = `Energy intensity of other sectors (MJ/$2005)`,
    energy_savings_primary_energy_terajoules = `Energy savings of primary energy (TJ)`,
    final_to_primary_energy_ratio_pct = `Final to primary energy ratio (%)`,
    geothermal_energy_consumption_tfec_pct = `Geothermal energy consumption (% in TFEC)`,
    geothermal_energy_consumption_terajoules = `Geothermal energy consumption (TJ)`,
    hydro_energy_consumption_tfec_pct = `Hydro energy consumption (% in TFEC)`,
    hydro_energy_consumption_terajoules = `Hydro energy consumption (TJ)`,
    liquid_biofuels_energy_consumption_tfec_pct = `Liquid biofuels consumption (% in TFEC)`,
    liquid_biofuels_consumption_terajoules = `Liquid biofuels consumption (TJ)`,
    marine_energy_consumption_tfec_pct = `Marine energy consumption (% in TFEC)`,
    marine_consumption_terajoules = `Marine energy consumption (TJ)`,
    modern_biomass_energy_consumption_tfec_pct = `Modern biomass consumption (% in TFEC)`,
    modern_biomass_consumption_terajoules = `Modern biomass consumption (TJ)`,
    perc_renewable_of_total_electricity_output = `Renewable electricity (% in total electricity output)`,
    renewable_energy_consumption_terajoules = `Renewable energy consumption (TJ)`,
    renewable_energy_consumption_tfec_pct = `Renewable energy consumption(% in TFEC)`,
    renewable_energy_electricity_output_gigawatt_hours = `Renewable energy electricity output (GWh)`,
    renewable_energy_installed_capacity_gigawatts = `Renewable energy installed capacity (GW)`,
    share_of_renewable_capacity_in_total_capacity_pct = `Share of renewable capacity in total capacity (%)`,
    solar_energy_consumption_tfec_pct = `Solar energy consumption (% in TFEC)`,
    solar_energy_consumption_terajoules = `Solar energy consumption (TJ)`,
    thermal_efficiency_in_power_supply_pct = `Thermal efficiency (%) in power supply`,
    total_electricity_output_gigawatt_hours = `Total electricity output (GWh)`,
    total_final_consumption_terajoules = `Total final consumption (TJ)`,
    total_final_energy_consumption_tfec = `Total final energy consumtion (TFEC)`, #also correcting typo in consumption
    total_installed_generation_capacity_gigawatts = `Total installed generation capacity (GW)`,
    total_primary_energy_supply_terajoules = `Total primary energy supply (TJ)`,
    traditional_biomass_consumption_tfec_pct = `Traditional biomass consumption (% in TFEC)`,
    traditional_biomass_consumption_terajoules = `Traditional biomass consumption (TJ)`,
    transmission_and_distribution_losses_pct = `Transmission and distribution losses (%)`,
    waste_energy_consumption_tfec_pct = `Waste energy consumption (% in TFEC)`,
    waste_energy_consumption_terajoules = `Waste energy consumption (TJ)`,
    wind_energy_consumption_tfec_pct = `Wind energy consumption (% in TFEC)`,
    wind_energy_consumption_terajoules = `Wind energy consumption (TJ)`
    )

