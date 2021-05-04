![Logo for the Water Point Data Exchange](https://www.waterpointdata.org/wp-content/uploads/2020/09/wpdxlogo2020.png)

# Water Sources

The data this week comes from [Water Point Data Exchange](https://data.waterpointdata.org/dataset/Water-Point-Data-Exchange-WPDx-Basic-/jfkt-jmqa). Note that the data is limited to some core columns as the full dataset is ~300 Mb. Also data is largely filtered down to African sources.

Katy Sill and Adam Kariv are speaking about this data source at [csv,conf](https://csvconf.com/speakers/#katy-sill-adam-kariv).

Per [WPDX](https://www.waterpointdata.org/)

> The amount of water point data being collected is growing rapidly as governments and development partners increasingly monitor water points over time. Without harmonization among these different data sources, the opportunity for learning will be limited, with the true potential of this information remaining untapped. 

> By establishing a platform for sharing water point data throughout the global water sector, WPDx adds value to the data already being collected. By bringing together diverse data sets, the water sector can establish an unprecedented understanding of water services.

> Sharing this data has the potential to improve water access for millions of people as a result of better information available to governments, service providers, researchers, NGOs, and others.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-05-04')
tuesdata <- tidytuesdayR::tt_load(2021, week = 19)

water <- tuesdata$water

# Or read in the data manually

water <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-05-04/water.csv')

```
### Data Dictionary

# `water.csv`

|variable           |class     |description |
|:------------------|:---------|:-----------|
|row_id             |double    | Unique ID |
|lat_deg            |double    | Latitude |
|lon_deg            |double    | Longitude |
|report_date        |character | Date water source was reported on |
|status_id          |character | Identify if any water is available on the day of the visit, recognizing that it may be a limited flow |
|water_source_clean |character | Describe the water source (e.g. shallow well, spring, borehole, river, pond, etc.) |
|water_tech   |character | Describe the system being used to transport the water from the source to the point of collection (e.g. Handpump (include manufacturer, i.e. Afridev, IndiaMark II, Malda,etc.),Kiosk, Tapstand,etc.) |
|facility_type      |character | Categorized facility type based on JMP definitions |
|country_name       |character | Country name |
|install_year       |double    | Install year |
|installer          |character | Installer |
|pay                |character | Provide the payment amount and basis (e.g. monthly, per jerry can, when broken,etc.). If no amount is provided, the basis can be provided alone. An amount without a payment basis cannot be included|
|status             |character | Provide a status of the physical/mechanical condition of thewater point |

### Cleaning Script

```
library(tidyverse)

raw_df <- read_csv("2021/2021-05-04/Water_Point_Data_Exchange__WPDx-Basic_.csv")

clean_df <- raw_df %>% 
  janitor::clean_names() %>%
  rename_with(~str_remove(.x, "number_")) %>% 
  select(
    row_id:status_id, water_source_clean:subjective_quality,rehab_year,
    install_year,
    -contains("adm"), -contains("rehab"), -contains("fecal"),
    -count, -new_georeferenced_column, -source, -management,-subjective_quality
      ) %>% 
  mutate(
    status_id = case_when(
      status_id == "Yes"~ "y",
      status_id == "No" ~ "n",
      status_id == "Unknown" ~ "u"
    ),
    report_date = str_sub(report_date, 1, 10)
    ) %>% 
  filter(
    !country_name %in% c(
      "NA", "Slovenia", "El Salvador", "Iraq", "Malawi", "Bangladesh",
      "Benin", "India", "Bolivia", "Honduras", "Guatemala", "Nicaragua",
      "Afghanistan", "Nepal", "Haiti", "Mexico", "Indonesia", "Sri Lanka",
      "Dominican Republublic", "Belize", "Myanmar", "Vanuatu", "Jordan"
      )
    ) %>% 
  select(-water_tech) %>% 
  rename(water_source = water_source_clean, water_tech = water_tech_clean)

clean_df %>% 
  write_csv("2021/2021-05-04/water.csv")


```