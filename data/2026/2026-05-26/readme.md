# Sustainable Energy for All

This week we're exploring Sustainable Energy for all! Beyond the raw metrics, this dataset offers a window into how nations are balancing growth with green initiatives, challenging us to visualize the actual momentum behind the global energy transition.     

> The “**Sustainable Energy for all** (**SE4ALL**)” initiative, launched in 2010 by the UN Secretary General, established three global objectives to be accomplished by 2030: to ensure universal access to modern energy services, to double the global rate of improvement in global energy efficiency, and to double the share of renewable energy in the global energy mix. SE4ALL database supports this initiative and provides country level historical data for access to electricity and non-solid fuel; share of renewable energy in total final energy consumption by technology; and energy intensity rate of improvement.  

Some questions to get you going:  

* Which countries have the lowest capacity for solar energy?    
* What form of renewable energy has, on average, experienced the fasted rate of adoption?

Thank you to [Ntobeko Sosibo, Data Analyst and CG Hobbyist](https://github.com/afrikaniz3d-za) for curating this week's dataset.

## Creating the sample plot
```r
library(dplyr)
library(tidyplots)
library(ggplot2)
library(ggtext)

# framing: of 3 windy countries, which one has consumed the most wind power?
# A quick Google search suggested Denmark, Ireland, and Norway
target_countries <- c("Denmark", "Ireland", "Norway")
the_windies <- energy_cleaned |>
filter(country_name %in% target_countries) |>
select(
country_name,
yr,
wind_energy_consumption_tfec_pct
)
the_windies <- the_windies |>
mutate(yr = as.numeric(yr))

# creating the plot
sample_plot <- the_windies |>
tidyplot(x = yr, y = wind_energy_consumption_tfec_pct, color = country_name, fill = country_name) |>
add(
ggplot2::geom_area(position = "identity")
) |>
adjust_x_axis_title("Year") |>
adjust_y_axis_title("Wind energy consumption (% in TFEC)") |>
add_title("Wind Power Consumed by Population and Industry (%)") |>
add_caption("Denmark and Ireland maintained an upward trend upto 2010, but
Norway's consumption **levels out from 2007**."
) |>
adjust_size(width = 140, height = 120) |>
theme_tidyplot() +
theme(
plot.title = element_text(family = "roboto",size = 16, face = "bold", vjust = 10, margin = margin(t = 10)),
axis.title.y = element_text(size = 14, margin = margin(r = 18)),
axis.title.x = element_text(size = 14, margin = margin(t = 18)),
axis.text.x  = element_text(size = 11),
axis.text.y  = element_text(size = 11),
plot.caption = element_markdown(size = 12, hjust = 0, margin = margin(t = 20), lineheight = 1.5),
legend.position = "top",
legend.title = element_blank(),
legend.text = element_text(size = 9)
) +
scale_fill_manual(values = c("#009e73", "#56b4e9", "#d55e00")) +
scale_color_manual(values = c("#009e73", "#56b4e9", "#d55e00"))

# saving the plot image
ggsave(
"sample_plot.png",
sample_plot,
width = 10,
height = 8,
limitsize = FALSE
)
```

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-05-26')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 21)

energy_cleaned <- tuesdata$energy_cleaned

# Option 2: Read directly from GitHub

energy_cleaned <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-26/energy_cleaned.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-05-26')

# Option 2: Read directly from GitHub and assign to an object

energy_cleaned = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-26/energy_cleaned.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-05-26")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

energy_cleaned = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-26/energy_cleaned.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
energy_cleaned = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-26/energy_cleaned.csv", DataFrame)
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.

## Data Dictionary

### `energy_cleaned.csv`

|variable                                                           |class     |description                                                                                                                                                                                                                                 |
|:------------------------------------------------------------------|:---------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|country_name                                                       |character |Name of country.                                                                                                                                                                                                                            |
|country_code                                                       |character |Three-letter country code defined by the International Organization for Standardization (ISO) to represent countries, dependent territories, and special areas of geographical interest.                                                    |
|yr                                                                 |integer   |The year.                                                                                                                                                                                                                                       |
|access_non_solid_fuel_rural_pop_pct                                |double    |Percentage of rural population with access to Non-Solid fuel like Natural Gas, LPG, Electricity, and Ethanol.                                                                                                                               |
|access_non_solid_fuel_total_pop_pct                                |double    |Percentage of total population with access to Non-Solid fuel like Natural Gas, LPG, Electricity, and Ethanol.                                                                                                                               |
|access_non_solid_fuel_urban_pop_pct                                |double    |Percentage of urban population with access to Non-Solid fuel like Natural Gas, LPG, Electricity, and Ethanol.                                                                                                                               |
|access_electricity_rural_pop_pct                                   |double    |Percentage of rural population with access to electricity.                                                                                                                                                                                  |
|access_electricity_total_pop_pct                                   |double    |Percentage of total population with access to electricity.                                                                                                                                                                                  |
|access_electricity_urban_pop_pct                                   |double    |Percentage of urban population with access to electricity.                                                                                                                                                                                  |
|biogas_consumption_tfec_pct                                        |double    |Percentage of energy that was Biogas consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                                          |
|biogas_consumption_terajoules                                      |double    |Terajoules of Biogas energy consumed.                                                                                                                                                                                                       |
|divisia_decomp_analysis_activity_component_index                   |double    |Changes in energy use caused by the size of the economy.                                                                                                                                                                                    |
|divisia_decomp_analysis_energy_intensity_component_index           |double    |Changes caused by efficiency.                                                                                                                                                                                                               |
|divisia_decomp_analysis_structure_component_index                  |double    |Changes caused by shifts in the economy.                                                                                                                                                                                                    |
|energy_intensity_level_final_energy_megajoules_per_usd_2005_ppp    |double    |Purchasing Power Parity for comparing final energy Megajoules per 2005 Dollar needed by other sectors to produce 1 dollar of GDP (adjusted to 2005 prices) with other countries .                                                           |
|energy_intensity_level_primary_energy_megajoules_per_usd_2005_ppp  |double    |Purchasing Power Parity for comparing primary energy Megajoules per 2005 Dollar needed by other sectors to produce 1 dollar of GDP (adjusted to 2005 prices) with other countries .                                                         |
|energy_intensity_agricultural_sector_megajoules_per_usd_2005       |double    |Megajoules per 2005 Dollar needed by agricultural sector to produce 1 dollar of GDP (adjusted to 2005 prices).                                                                                                                              |
|energy_intensity_industrial_sector_megajoules_per_usd_2005         |double    |Megajoules per 2005 Dollar needed by industrial sector to produce 1 dollar of GDP (adjusted to 2005 prices).                                                                                                                                |
|energy_intensity_other_sectors_megajoules_per_usd_2005             |double    |Megajoules per 2005 Dollar needed by other sectors to produce 1 dollar of GDP (adjusted to 2005 prices).                                                                                                                                    |
|energy_savings_primary_energy_terajoules                           |double    |Terajoules of primary energy savings.                                                                                                                                                                                                       |
|final_to_primary_energy_ratio_pct                                  |double    |Percentage ratio of final energy to primary energy.                                                                                                                                                                                         |
|geothermal_energy_consumption_tfec_pct                             |double    |Percentage of energy that was Geothermal consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                                      |
|geothermal_energy_consumption_terajoules                           |double    |Terajoules of Geothermal energy consumed.                                                                                                                                                                                                   |
|hydro_energy_consumption_tfec_pct                                  |double    |Percentage of energy that was Hydro consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                                           |
|hydro_energy_consumption_terajoules                                |double    |Terajoules of Hydro energy consumed.                                                                                                                                                                                                        |
|liquid_biofuels_energy_consumption_tfec_pct                        |double    |Percentage of energy that was Liquid biofuels consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                                 |
|liquid_biofuels_consumption_terajoules                             |double    |Terajoules of Liquid biofuels consumed.                                                                                                                                                                                                     |
|marine_energy_consumption_tfec_pct                                 |double    |Percentage of energy that was Marine energy consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                                   |
|marine_consumption_terajoules                                      |double    |Terajoules of Marine energy consumed.                                                                                                                                                                                                       |
|modern_biomass_energy_consumption_tfec_pct                         |double    |Percentage of energy that was Modern biomass consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                                  |
|modern_biomass_consumption_terajoules                              |double    |Terajoules of Modern biomass consumed.                                                                                                                                                                                                      |
|perc_renewable_of_total_electricity_output                         |double    |Renewable energy percentage of total electricity output.                                                                                                                                                                                    |
|renewable_energy_consumption_terajoules                            |double    |Terajoules of Renewable energy consumed.                                                                                                                                                                                                    |
|renewable_energy_consumption_tfec_pct                              |double    |Percentage of energy that was Renewable consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                                       |
|renewable_energy_electricity_output_gigawatt_hours                 |double    |Renewable energy output in Gigawatt-hours.                                                                                                                                                                                                  |
|renewable_energy_installed_capacity_gigawatts                      |double    |Renewable energy installed capacity in Gigawatts.                                                                                                                                                                                           |
|share_of_renewable_capacity_in_total_capacity_pct                  |double    |Percentage share of installed capacity of Renewable energy.                                                                                                                                                                                 |
|solar_energy_consumption_tfec_pct                                  |double    |Percentage of energy that was Solar consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                                           |
|solar_energy_consumption_terajoules                                |double    |Terajoules of Solar energy consumed.                                                                                                                                                                                                        |
|thermal_efficiency_in_power_supply_pct                             |double    |Percentage of Thermal efficiency in power supply                                                                                                                                                                                            |
|total_electricity_output_gigawatt_hours                            |double    |Total electricity output in Gigawatt-hours.                                                                                                                                                                                                 |
|total_final_consumption_terajoules                                 |double    |Terajoules of Total final energy consumed.                                                                                                                                                                                                  |
|total_final_energy_consumption_tfec                                |double    |Total final energy consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                                                            |
|total_installed_generation_capacity_gigawatts                      |double    |Total installed generation capacity in Gigawatts                                                                                                                                                                                            |
|total_primary_energy_supply_terajoules                             |double    |Terajoules of Total primary energy supply.                                                                                                                                                                                                  |
|traditional_biomass_consumption_tfec_pct                           |double    |Percentage of energy that was Traditional biomass consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                             |
|traditional_biomass_consumption_terajoules                         |double    |Terajoules of Traditional biomass consumed.                                                                                                                                                                                                 |
|transmission_and_distribution_losses_pct                           |double    |Percentage of power lost in transmission and distribution                                                                                                                                                                                   |      
|waste_energy_consumption_tfec_pct                                  |double    |Percentage of energy that was Waste energy consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                                    |
|waste_energy_consumption_terajoules                                |double    |Terajoules of Waste energy consumed.                                                                                                                                                                                                        |
|wind_energy_consumption_tfec_pct                                   |double    |Percentage of energy that was Wind consumed by end-users (households, industry, agriculture), excluding energy used by the energy sector itself.                                                                                            |
|wind_energy_consumption_terajoules                                 |double    |Terajoules of Wind energy consumed.                                                                                                                                                                                                         |

## Cleaning Script

```r
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

```
