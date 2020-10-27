![](https://www.nationalobserver.com/sites/nationalobserver.com/files/styles/nat_header_full_size/public/img/2020/10/22/mooselake.jpg?itok=m3LaBMvd)

# Canadian Wind Turbines

The data this week comes from the [Government of Canada](https://open.canada.ca/data/en/dataset/79fdad93-9025-49ad-ba16-c26d718cc070). 

H/t to [Will Noel](https://twitter.com/OneWindyBoy), [Tim Weis](https://twitter.com/TimWeisAB/status/1277767327744811010?s=20) and [Andrew Leach](https://twitter.com/andrew_leach/status/1277785178891448320?s=20) for collecting the data. [Blake Shaffer](https://twitter.com/bcshaffer/status/1319662302254092290) and [Alyssa Goldberg](https://twitter.com/WireMonkey) for visualizing and sharing!

Canada's National Observer [Article](https://www.nationalobserver.com/2020/10/23/news/wind-turbine-database-canada) on this dataset.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-10-27')
tuesdata <- tidytuesdayR::tt_load(2020, week = 44)

wind_turbine <- tuesdata$wind-turbine

# Or read in the data manually

wind_turbine <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-10-27/wind-turbine.csv')

```
### Data Dictionary

# `wind-turbine.csv`

|variable                   |class     |description |
|:--------------------------|:---------|:-----------|
|objectid                   |double    | Unique ID |
|province_territory         |character | Province/territory |
|project_name               |character | Project name |
|total_project_capacity_mw  |double    | Electrical capacity in megawatts |
|turbine_identifier         |character | Turbine ID |
|turbine_number_in_project  |character | Turbine number in project|
|turbine_rated_capacity_k_w |double    | Turbine capacity in kilowatts |
|rotor_diameter_m           |double    | Rotor diameter in meters |
|hub_height_m               |double    | Hub height in meters |
|manufacturer               |character | Manufacturer |
|model                      |character | Model ID |
|commissioning_date         |character | Commission date|
|latitude                   |double    | Latitude |
|longitude                  |double    | Longitude |
|notes                      |character | Notes about the data|

### Cleaning Script

No cleaning!

