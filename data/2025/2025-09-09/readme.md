# Henley Passport Index Data

This week we are exploring data from the [Henley Passport Index API](api.henleypassportindex.com/api/v3/countries). 
The [Henley Passport Index](https://www.henleyglobal.com/passport-index/about) is produced by Henley & Partners and captures 
the number of countries to which travelers in possession of each passport in the world may enter visa free. 


> For each travel destination, if no visa is required for passport holders from a country or territory, then a score with value = 1 is 
created for that passport. A score with value = 1 is also applied if passport holders can obtain a visa on arrival, a visitor’s permit, 
or an electronic travel authority (ETA) when entering the destination. These visa-types require no pre-departure government approval, 
because of the specific visa-waiver programs in place. Where a visa is required, or where a passport holder has to obtain a government-approved 
electronic visa (e-Visa) before departure, a score with value = 0 is assigned. A score with value = 0 is also assigned if passport 
holders need pre-departure government approval for a visa on arrival, a scenario we do not consider ‘visa-free’. The total score for 
each passport is equal to the number of destinations for which no visa is required (value = 1), under the conditions defined above.

Henley & Partners update the  [Global Passport Index rankings](https://www.henleyglobal.com/passport-index/ranking) each month 
and [changes to the US passport rank](https://edition.cnn.com/2025/07/22/travel/world-most-powerful-passports-july-2025) 
captured media attention recently. 

- Which countries have made the most dramatic improvements in passport power? Which passports have lost the most visa-free access?
- Do countries with stronger trade relationships tend to offer mutual visa-free access?
- Did the COVID-19 pandemic affect passport rankings, particularly for countries that implemented strict border controls?
- How does political instability or economic crisis impact passport strength?

Thank you to [Brenden Smith and Jen Richmond](https://github.com/brendensm @jenrichmond) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-09-09')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 36)

country_lists <- tuesdata$country_lists
rank_by_year <- tuesdata$rank_by_year

# Option 2: Read directly from GitHub

country_lists <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-09/country_lists.csv')
rank_by_year <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-09/rank_by_year.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-09-09')

# Option 2: Read directly from GitHub and assign to an object

country_lists = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-09/country_lists.csv')
rank_by_year = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-09/rank_by_year.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-09-09')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

country_lists = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-09/country_lists.csv")
rank_by_year = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-09/rank_by_year.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
country_lists = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-09/country_lists.csv", DataFrame)
rank_by_year = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-09/rank_by_year.csv", DataFrame)
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

### `country_lists.csv`

|variable                        |class     |description                           |
|:-------------------------------|:---------|:-------------------------------------|
|code                            |character |Two letter country code. |
|country                         |character |Full country name. |
|visa_required                   |json      |JSON data of code and name of the countries in which you need a traditional visa to enter these destinations, and you need to apply for it in person. |
|visa_online                     |json      |JSON data of code and name of the countries in which you need a visa to enter, but you can apply for it online, and the visa you receive is electronic (pre-departure approval necessary). |
|visa_on_arrival                 |json      |JSON data of code and name of the countries in which you need a visa to enter, but you can apply for and receive the visa upon arrival at the airport (no pre-departure approval necessary). |
|visa_free_access                |json      |JSON data of code and name of the countries in which you do not need a visa to enter. |
|electronic_travel_authorisation |json      |JSON data of code and name of the countries in which you do not need a visa to enter, but you must apply for a digital electronic travel authority before arrival. |

### `rank_by_year.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
|code            |character |Two letter country code. |
|country         |character |Full country name. |
|region          |character |Seven category country region. |
|rank            |integer   |Ranking of 'visa_free_count'. |
|visa_free_count |integer   |The number of countries that do not require a visa for the passport holder, or passport holders can obtain a visa on arrival, a visitor’s permit, or an electronic travel authority (ETA) when entering the destination. |
|year            |integer |Year of data. |

## Cleaning Script

```r
library(httr)
library(tidyverse)
library(jsonlite)

# first httr request to get ranking data

req <- GET("api.henleypassportindex.com/api/v3/countries")

parsed <- req$content |> 
  rawToChar() |> 
  fromJSON()

# Data by year was nested into a list. 
# Here we separate them out so that each year has its own row.

rank_by_year <- parsed$countries |> 
  filter(has_data) |> 
  tidyr::unnest_longer(col = data) |> 
  select(code, country, region, data, year = data_id) |> 
  unnest_wider(col = data)


# The data for country_lists is pulled in with multiple httr requests.
# We can run a query for a single country at a time, and we get back a list
# with the country's name and code, and several data frames that show the 
# names and codes of the countries a passport owner has different visa access to. 

# We can define a function to transform the list into a data frame with columns that contain 
# these additional data frames. In order to meet Tidy Tuesday requirements,
# this data was transformed into JSON to be saved into a csv file.

list_to_nested_df <- function(input_list) {
  processed_data <- lapply(input_list, function(x) {
    if(is.data.frame(x)) {
      toJSON(I(list(x)))
    } else {
      x 
    }
  })
  
  df <- data.frame(processed_data)
  
  return(df)
}


country_lists <- data.frame()

for (i in unique(rank_by_year$code)) {
  print(i)
  
  req2 <- GET(paste0("api.henleypassportindex.com/api/v3/visa-single/", i))
  parsed2 <- req2$content |> 
    rawToChar() |> 
    fromJSON()
  
  add <- list_to_nested_df(parsed2)
  country_lists <-  rbind(add, country_lists)
  
  Sys.sleep(2)
}

# After the data is loaded in, you can run the following code to 
# transform the JSON back into nested data frames or tibbles:
#
# country_lists |>
#   mutate(across(c(3:7),
#                 ~map(.x, ~fromJSON(.x)[[1]] |> tibble())))

```
