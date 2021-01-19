![](https://shelkariuki.netlify.app/post/rkenyacensus/featured_hudf75701b5887d4f557a17652b4961ff5_197082_720x0_resize_q90_lanczos.jpg)

# Kenya Census

The data this week comes from [`rKenyaCensus`](https://github.com/Shelmith-Kariuki/rKenyaCensus) courtesy of [Shelmith Kariuki](https://twitter.com/Shel_Kariuki). Shelmith wrote about these datasets on her [blog](https://shelkariuki.netlify.app/post/rkenyacensus/).

> [rKenyaCensus](https://github.com/Shelmith-Kariuki/rKenyaCensus) is an R package that contains the 2019 Kenya Population and Housing Census results. The results were released by the [Kenya National Bureau of Statistics](https://twitter.com/KNBStats) in February 2020, and published in four different pdf files (Volume 1 - Volume 4).

> The 2019 Kenya Population and Housing Census was the eighth to be conducted in Kenya since 1948 and was conducted from the night of 24th/25th to 31st August 2019. Kenya leveraged on technology to capture data during cartographic mapping, enumeration and data transmission, making the 2019 Census the first paperless census to be conducted in Kenya

Additional details about Kenya can be found on [Wikipedia](https://en.wikipedia.org/wiki/Kenya).

> Kenya, officially the Republic of Kenya (Swahili: Jamhuri ya Kenya), is a country in Eastern Africa. At 580,367 square kilometres (224,081 sq mi), Kenya is the world's 48th largest country by total area. With a population of more than 47.6 million people in the 2019 census, Kenya is the 29th most populous country. Kenya's capital and largest city is Nairobi, while its oldest city and first capital is the coastal city of Mombasa.

To access ALL the data, install the package from Github:

(if needed, `install.packages("remotes")`)

`remotes::install_github("Shelmith-Kariuki/rKenyaCensus")`

She's also put together a [Shiny app to download](https://shel-kariuki.shinyapps.io/KenyaCensus2019/) various datasets!

I've taken 3 indicators below just as a teaser, but go ahead and try the package for ALL the data!

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-01-19')
tuesdata <- tidytuesdayR::tt_load(2021, week = 4)

gender <- tuesdata$gender

# Or read in the data manually

gender <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-19/gender.csv')
crops <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-19/crops.csv')
households <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-19/households.csv')

```
### Data Dictionary

# `gender.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|County   |character | County Name |
|Male     |double    | Population of Male identifying|
|Female   |double    |Population of Female identifying|
|Intersex |double    |Population of Interesex identifying|
|Total    |double    | Total population |

# `crops.csv`

> Distribution of Households Growing Permanent Crops by Type and County.

|variable     |class     |description |
|:------------|:---------|:-----------|
|SubCounty    |character | SubCounty name |
|Farming      |double    | Population growing farming crops |
|Tea          |double    | Population growing farming tea|
|Coffee       |double    | Population growing farming coffee|
|Avocado      |double    | Population growing farming avocado |
|Citrus       |double    | Population growing farming citrus |
|Mango        |double    | Population growing farming Mango |
|Coconut      |double    | Population growing farming Coconut |
|Macadamia    |double    | Population growing farming Macadamia |
|Cashew Nut   |double    | Population growing farming cashew nut |
|Khat (Miraa) |double    | Population growing farming Khat (Miraa) |

# `households.csv`

|variable             |class     |description |
|:--------------------|:---------|:-----------|
|County               |character | County Name |
|Population           |double    | Population |
|NumberOfHouseholds   |double    | Number of households |
|AverageHouseholdSize |double    | Average houshold size |

# Data Catalogue

Full catalogue from the package about all the available datasets!

|Dataset           |Volume |Table.No.in.PDFs |Dataset.Description                                                                                                                                                  |
|:-----------------|:------|:----------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|DataCatalogue     |       |                 |Shows the table number for each of the datasets                                                                                                                      |
|CountyGPS         |       |                 |Shows the County GPS centroids                                                                                                                                       |
|KenyaCounties_SHP |       |                 |Shapefiles of Kenya County boundaries                                                                                                                                |
|V1_T2.1           |V1     |Table 2. 1       |Census Indicators at a Glance, 2019                                                                                                                                  |
|V1_T2.2           |V1     |Table 2. 2       |Distribution of Population by Sex and County                                                                                                                         |
|V1_T2.3           |V1     |Table 2. 3       |Distribution of Population, Number of Households and Average                                                                                                         |
|V1_T2.4           |V1     |Table 2. 4       |Distribution of Population, Land Area and Population Density by County                                                                                               |
|V1_T2.5           |V1     |Table 2. 5       |Distribution of Population by Sex and Sub-County                                                                                                                     |
|V1_T2.6           |V1     |Table 2. 6       |Distribution of Population, Number of Households and Average Household Size by Sub- County                                                                           |
|V1_T2.7           |V1     |Table 2. 7       |Distribution of Population by Land Area and Population Density by Sub-County                                                                                         |
|V2_T1.1           |V2     |Table 1.1        |Summary of Census Counts in Kenya                                                                                                                                    |
|V2_T1.2           |V2     |Table 1.2        |List of Counties and Sub-Counties                                                                                                                                    |
|V2_T2.1           |V2     |Table 2.1        |Sub-locations with no People on the Census Night by Status/Reason                                                                                                    |
|V2_T2.2           |V2     |Table 2.2        |Distribution of Population by Sex, Number of Households, Land Area, Population Density and County                                                                    |
|V2_T2.2a          |V2     |Table 2.2a       |Distribution of Rural Population by Sex, Number of Households, Land Area, Population Density and County                                                              |
|V2_T2.2b          |V2     |Table 2.2b       |Distribution of Urban Population by Sex, Number of Households, Land Area, Population Density and County                                                              |
|V2_T2.3           |V2     |Table 2.3        |Distribution of Population by Sex, Number of Households, Land Area, Population Density and Sub County                                                                |
|V2_T2.5           |V2     |Table 2.5        |Distribution of Population by Urban Centres, Sex and County                                                                                                          |
|V3_T1.1           |V3     |Table 1.1        |Summary of Census Counts in Kenya                                                                                                                                    |
|V3_T1.2           |V3     |Table 1.2        |List of Counties and Sub-Counties                                                                                                                                    |
|V3_T2.1           |V3     |Table 2.1        |Sub-locations with no People on the Census Night by Status/Reason                                                                                                    |
|V3_T2.2           |V3     |Table 2.2        |Distribution of Population by Age and Sex, Kenya                                                                                                                     |
|V3_T2.2a          |V3     |Table 2.2a       |Distribution of Rural Population by Age and Sex, Kenya                                                                                                               |
|V3_T2.2b          |V3     |Table 2.2b       |Distribution of Urban Population by Age and Sex, Kenya                                                                                                               |
|V3_T2.3           |V3     |Table 2.3        |Distribution of Population by Age, Sex, County and Sub- County                                                                                                       |
|V3_T2.4a          |V3     |Table 2.4a       |Distribution of Rural Population by Age, Sex and County                                                                                                              |
|V3_T2.4b          |V3     |Table 2.4b       |Distribution of Urban Population by Age, Sex and County                                                                                                              |
|V4_T1.1           |V4     |Table 1. 1       |Summary of Census Counts in Kenya.                                                                                                                                   |
|V4_T1.9           |V4     |Table 1.9        |List of Counties and Sub-Counties                                                                                                                                    |
|V4_T2.2           |V4     |Table2.2         |Distribution of Population Aged 3 Years and Above by School Attendance Status, Area of Residence, Sex, County and SubCounty.                                         |
|V4_T2.3           |V4     |Table 2.3        |Distribution of Population Aged 3 Years and Above Currently Attending School/ Learning Institution by Education Level, Area of Residence, Sex, County and Sub-County |
|V4_T2.4           |V4     |Table 2.4        |Distribution of Population Aged 3 Years and Above by Highest Level of Education Reached, Area of Residence, Sex, County and Sub-County..                             |
|V4_T2.5           |V4     |Table 2.5        |Distribution of Population Aged 3 Years and Above by Highest Level of Education Completed, Area of Residence, Sex, County and Sub-County..                           |
|V4_T2.6a          |V4     |Table 2.6a       |Distribution of Population Aged 3 Years and Above by School Attendance Status, Sex and Special Age Groups                                                            |
|V4_T2.6b          |V4     |Table 2.6b       |Distribution of Population Aged 3 Years and Above by School Attendance Status, Sex, Special Age Groups and County..                                                  |
|V4_T2.7           |V4     |Table 2.7        |Distribution of Population Aged 15 years and Above by Sex and Main Training Acquired and Qualified for                                                               |
|V4_T2.8a          |V4     |Table 2.8a       |Distribution of Population Aged 5 Years and above by Activity Status, Sex, County and Sub-County                                                                     |
|V4_T2.8b          |V4     |Table 2.8b       |Distribution of Urban Population Aged 5 Years and above by Activity Status, Sex, County and Sub-County.....                                                          |
|V4_T2.8c          |V4     |Table 2.8c       |Distribution of Rural Population Aged 5 Years and above by Activity Status, Sex, County and Sub-County..                                                             |
|V4_T2.9a          |V4     |Table 2.9a       |Distribution of Population Aged 5 years and above by Activity Status, Broad Age Groups and County..                                                                  |
|V4_T2.9b          |V4     |Table 2.9b       |Distribution of Rural Population Aged 5 years and above by Activity Status, Broad Age Groups and County.......                                                       |
|V4_T2.9c          |V4     |Table 2.9c       |Distribution of Urban Population Aged 5 years and above by Activity Status, Broad Age Groups and County.......                                                       |
|V4_T2.10          |V4     |Table 2.10       |Distribution of Households and Tenure Status of Main Dwelling Unit by Area of Residence, County and Sub-County                                                       |
|V4_T2.11a         |V4     |Table 2.11a      |Distribution of Households Owning the Main Dwelling Unit by Mode of Acquisition, Area of Residence, County and Sub-County                                            |
|V4_T2.11b         |V4     |Table 2.11b      |Distribution of Households Renting/Provided with their Main Tenure Status of Main Dwelling Unit by Provider, Area of Residence, County and Sub- County..             |
|V4_T2.12          |V4     |Table 2.12       |Percentage Distribution of Conventional Households by Dominant Roofing Material of Main Dwelling Unit, Area of Residence, County and Sub-County.....                 |
|V4_T2.13          |V4     |Table 2.13       |Percentage Distribution of Conventional Households by Dominant Wall Material of Main Dwelling Unit, Area of Residence, County and Sub-County.......                  |
|V4_T2.14          |V4     |Table 2.14       |Percentage Distribution of Conventional Households by Dominant Floor Material of the Main Dwelling Unit, Area of Residence, County and Sub County......              |
|V4_T2.15          |V4     |Table 2.15       |Percentage Distribution of Conventional Households by Main Source of Drinking Water, Area of Residence, County and Sub-County..                                      |
|V4_T2.16          |V4     |Table 2.16       |Percentage Distribution of Conventional Households by Main Mode of Human Waste Disposal, Area of Residence, County and Sub-County..                                  |
|V4_T2.17          |V4     |Table 2.17       |Percentage Distribution of Conventional Households by Main Mode of Solid Waste Disposal, Area of Residence, County and Sub-County..                                  |
|V4_T2.18          |V4     |Table 2.18       |Percentage Distribution of Conventional Households by Main Type of Cooking Fuel, Area of Residence, County and Sub-County....                                        |
|V4_T2.19          |V4     |Table 2.19       |Percentage Distribution of Conventional Households by Main Type of Lighting Fuel, Area of Residence, County and Sub-County....                                       |
|V4_T2.20          |V4     |Table 2.20       |Distribution of households practicing Agriculture, Fishing and Irrigation by County and Sub County.                                                                  |
|V4_T2.21          |V4     |Table 2.21       |Distribution of Households Growing Permanent Crops by Type and County.                                                                                               |
|V4_T2.22          |V4     |Table 2.22       |Distribution of Households Growing Other Crops by Type, County and Sub County                                                                                        |
|V4_T2.23          |V4     |Table 2.23       |Distribution of Households Rearing Livestock and Fish by County and Sub County.                                                                                      |
|V4_T2.24          |V4     |Table 2.24       |Distribution of Livestock population by type, Fish Ponds and Fish Cages by County and Sub County..                                                                   |
|V4_T2.25          |V4     |Table 2.25       |Distribution of area (hectares) of Agricultural land and Farming Households by purpose of production, County and Sub-County..                                        |
|V4_T2.26          |V4     |Table 2.26       |Distribution of Population aged 5 years and above by Disability Status, Sex1, Area of Residence, County and Sub-County....                                           |
|V4_T2.27          |V4     |Table 2.27       |Distribution of Persons with Disability by Type of Disability, Sex1, Area of Residence, County and Sub County...                                                     |
|V4_T2.28          |V4     |Table 2.28       |Distribution of Persons with Albinism by Sex1, Area of Residence, County and Sub County..                                                                            |
|V4_T2.29          |V4     |Table 2.29       |Population of Street Persons/Outdoor Sleepers by Sex1, Area of Residence and County.                                                                                 |
|V4_T2.30          |V4     |Table 2.30       |Distribution of Population by Religious Affiliation and County                                                                                                       |
|V4_T2.31          |V4     |Table 2.31       |Distribution of Population by Ethnicity/Nationality                                                                                                                  |
|V4_T2.32          |V4     |Table 2.32       |Distribution of Population Age 3 years and Above Owning a Mobile Phone by Area of Residence, Sex, County and Sub County                                              |
|V4_T2.33          |V4     |Table 2.33       |Distribution of Population Age 3 Years and Above Using Internet and Computer/Laptop/Tablet by Area of Residence, Sex, County and Sub-County...                       |
|V4_T2.34          |V4     |Table 2.34       |Distribution of Population age 15 years and above who Searched and Bought Goods and Services Online by Area of Residence, Sex, County and Sub-County.                |
|V4_T2.35          |V4     |Table 2.35       |Distribution of Population Age 3 years and Above who owned and used Selected ICT Equipment and Service by Age, Area of Residence and County..                        |
|V4_T2.36          |V4     |Table 2.36       |Percentage Distribution of Conventional Households by Ownership of Selected Household Assets by Area of Residence, County and Sub County...                          |
|V4_T2.37          |V4     |Table 2.37       |Births in the Last 12 months* by place of Occurrence and County...                                                                                                   |
|V4_T2.38          |V4     |Table 2.38       |Births in the Last 5 Years* by place of Occurrence and County                                                                                                        |
|V4_T2.39          |V4     |Table 2.39       |Notified Births in the Last 12 months by County                                                                                                                      |
|V4_T2.40          |V4     |Table 2.40       |Notified Births in the Last 5 Years by County                                                                                                                        |

### Cleaning Script

No cleaning script today, enjoy the data!

This is how I got the three datasets for today.

```
library(rKenyaCensus)
library(tidyverse)

# create a markdown table for the readme
rKenyaCensus::DataCatalogue %>% 
  knitr::kable()

# grab 3 tables of interest
crops <- rKenyaCensus::V4_T2.21
gender <- rKenyaCensus::V1_T2.2
households <- rKenyaCensus::V1_T2.3

# write them out
households %>% 
  write_csv("2021/2021-01-19/households.csv")

gender %>% 
  write_csv("2021/2021-01-19/gender.csv")

crops %>% 
  write_csv("2021/2021-01-19/crops.csv")
  
```