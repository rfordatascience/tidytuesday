# Roundabouts across the world

This week we are exploring data from the [`{roundabouts}` package](https://github.com/EmilHvitfeldt/roundabouts) by Emil Hvitfeldt. 
The roundabouts package provides an R friendly way to access the roundabouts database which is compiled by [Kittelson & Associates](https://roundabouts.kittelson.com/) 
and contains information about the location, configuration, and construction of roundabout intersections around the world. 

> “It started with an inventory of U.S. roundabouts that identified 150 sites,” Lee says. “One thing led to another, and now we’re at 
over 20,000 records in the database.”

- How has roundabout construction evolved over time? Are certain regions adopting them faster than others?
- What types of intersections are most commonly converted to roundabouts?
- Where are the roundabouts with the most unusual configurations (highest number of approaches/driveways)?

Thank you to [Jen Richmond](https://github.com/jenrichmond) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-12-16')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 50)

roundabouts_clean <- tuesdata$roundabouts_clean

# Option 2: Read directly from GitHub

roundabouts_clean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-16/roundabouts_clean.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-12-16')

# Option 2: Read directly from GitHub and assign to an object

roundabouts_clean = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-16/roundabouts_clean.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-12-16')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

roundabouts_clean = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-16/roundabouts_clean.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
roundabouts_clean = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-16/roundabouts_clean.csv", DataFrame)
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

### `roundabouts_clean.csv`

|variable              |class     |description                           |
|:---------------------|:---------|:-------------------------------------|
|name                  |character |Roundabout name |
|address               |character |Roundabout address |
|town_city             |character |Town/City |
|county_area           |character |County/Area |
|state_region          |character |State/Region |
|country               |character |Country |
|lat                   |double    |Latitude |
|long                  |double    |Longitude |
|type                  |character |Type, one of "roundabout", "traffic calming circle", "signalized roundabout/circle", "rotary", "other", "unknown"|
|status                |character |Status, one of "existing", "removed", "unknown" |
|year_completed        |integer   |Year construction completed |
|approaches            |integer   |Number of approaches |
|driveways             |integer   |Number of driveways |
|lane_type             |character |Lane type |
|functional_class      |character |Functional Class |
|control_type          |character |Control Type |
|other_control_type    |character |Other control type |
|previous_control_type |character |Previous control type |

## Cleaning Script

```r
# Data read in from roundabouts package, cleaning removes strange tags, separates country, town, county, and state columns. 
# Separates lat and long columns and fixes data types

roundabouts <- roundabouts::roundabouts

roundabouts_clean <- roundabouts |>
  dplyr::mutate(address = stringr::str_remove(address, stringr::fixed("<![CDATA["))) |>  # remove strange tags from address field
  dplyr::mutate(address = stringr::str_remove(address, stringr::fixed("]]>"))) |>
  dplyr::mutate(country = stringr::str_extract(address, "\\([^)]+\\)$"), # extract string within last bracket
                country = stringr::str_remove_all(country, "[\\(\\)]"),  # remove brackets
                address2 = stringr::str_remove(address, "\\s*\\([^)]+\\)$")) |>  # remove last () from original address
  tidyr::separate(address2, into = c("town_city", "county_area", "state_region"), sep = ",") |> # separate address by comma
  tidyr::separate(coordinates, into = c("lat", "long"), sep = ",") |> # separate latitude longitude by comma
  dplyr::select(name, address, town_city, county_area, state_region, country, lat, long, everything()) |> # reorder variables
  dplyr::mutate(lat = as.numeric(lat), long = as.numeric(long), # fix data types
                year_completed = as.integer(year_completed), 
                approaches = as.integer( approaches), 
                driveways = as.integer(driveways))

```
