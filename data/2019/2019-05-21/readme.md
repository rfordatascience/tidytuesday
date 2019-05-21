# Global Plastic Waste

Plastic pollution is a major and growing problem, negatively affecting oceans and wildlife health. [Our World in Data](https://ourworldindata.org/plastic-pollution) has a lot of great data at the various levels including globally, per country, and over time. 

Additionally, National Geographic is running a dataviz communication contest on plastic waste as seen [here](https://t.co/OQHxuFyDTL).

I intentionally left the datasets "uncleaned" this week as they are already in good shape minus the column names. I would suggest trying the `janitor` package, where `janitor::clean_names()` or `purrr::set_names()` can come in handy to clean up the names quickly!

# Get the data!

```
coast_vs_waste <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-21/coastal-population-vs-mismanaged-plastic.csv")

mismanaged_vs_gdp <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-21/per-capita-mismanaged-plastic-waste-vs-gdp-per-capita.csv")

waste_vs_gdp <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-21/per-capita-plastic-waste-vs-gdp-per-capita.csv")
```

# Data Dictionary


### `coast_vs_waste.csv`

|variable             |class     |description |
|:---|:---|:-----------|
|Entity | Character | Country Name |
| Code | Character | 3 Letter country code |
| Year | Integer (date) | Year |
| Mismanaged plastic waste (tonnes) | double | Tonnes of mismanaged plastic waste |
| Coastal population | Double | Number of individuals living on/near coast |
| Total Population | double | Total population according to Gapminder |


### `mismanaged_vs_gdp.csv`

|variable             |class     |description |
|:---|:---|:-----------|
|Entity | Character | Country Name |
| Code | Character | 3 Letter country code |
| Year | Integer (date) | Year |
| Per capita mismanaged plastic waste (kg per day) | double | Amount of mismanaged plastic waste per capita in kg/day |
| GDP per capita | Double | GDP per capita constant 2011 international $, rate  |
| Total Population | double | Total population according to Gapminder |

### `waste_vs_gdp.csv`

|variable             |class     |description |
|:---|:---|:-----------|
|Entity | Character | Country Name |
| Code | Character | 3 Letter country code |
| Year | Integer (date) | Year |
| Per capita plastic waste (kg per person per day) | double | Amount of  plastic waste per capita in kg/day |
| GDP per capita | Double | GDP per capita constant 2011 international $, rate  |
| Total Population | double | Total population according to Gapminder |

