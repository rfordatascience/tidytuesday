# Bird Sightings at Sea

This week we're exploring Bird Sightings at Sea! The data this week comes from Te Papa Tongarewa, The Museum of New Zealand. It consists of log book entries of bird sightings at sea near New Zealand, from 1969 to 1990.

Thank you to [David Hood](https://bsky.app/profile/thoughtfulnz.bsky.social) for the [dataset suggestion](https://bsky.app/profile/thoughtfulnz.bsky.social/post/3mdp6dzuaks2d).

> The data was recorded using guidelines for the Australasian Seabird Mapping Scheme and counts seabirds seen from a ship during a 10 minute period. The data includes geolocations of the sightings, bird species, numbers and behaviour, observer and ship name, and observation date and time.

- The data was recorded by hand and split into standardized columns. Do the logbook entries in `species_common_name` in the `birds` dataset always match up with the split columns such as `species_scientific_name`, `age`, `wan_plumage_phase`, `plumage_phase`, and `sex`.

Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-04-14')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 15)

beaufort_scale <- tuesdata$beaufort_scale
birds <- tuesdata$birds
sea_states <- tuesdata$sea_states
ships <- tuesdata$ships

# Option 2: Read directly from GitHub

beaufort_scale <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/beaufort_scale.csv')
birds <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/birds.csv')
sea_states <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/sea_states.csv')
ships <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/ships.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-04-14')

# Option 2: Read directly from GitHub and assign to an object

beaufort_scale = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/beaufort_scale.csv')
birds = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/birds.csv')
sea_states = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/sea_states.csv')
ships = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/ships.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-04-14")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

beaufort_scale = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/beaufort_scale.csv")
birds = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/birds.csv")
sea_states = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/sea_states.csv")
ships = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/ships.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
beaufort_scale = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/beaufort_scale.csv", DataFrame)
birds = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/birds.csv", DataFrame)
sea_states = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/sea_states.csv", DataFrame)
ships = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/ships.csv", DataFrame)
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

### `beaufort_scale.csv`

|variable             |class   |description                                                                                           |
|:--------------------|:-------|:-----------------------------------------------------------------------------------------------------|
|wind_speed_class     |integer |Beaufort scale class (0--12), corresponding to `ships$wind_speed_class`.                              |
|wind_description     |ordered |Text description of the wind conditions, ordered from `"calm"` (class 0) to `"hurricane"` (class 12). |
|wind_speed_knots_min |integer |Minimum wind speed in knots for this class.                                                           |
|wind_speed_knots_max |integer |Maximum wind speed in knots for this class. `NA` for class 12 (hurricane), which has no upper bound.  |

### `birds.csv`

|variable                |class     |description                                                                                                                                                                                                                                                      |
|:-----------------------|:---------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|bird_observation_id     |integer   |Identifier for this bird observation record, corresponding to the original record order in the source data.                                                                                                                                                      |
|record_id               |integer   |Record identifier. Links to `ships$record_id`. One observation (record_id 1184009, bird_observation_id 974) has no corresponding ship record in the source data.                                                                                                 |
|species_common_name     |character |The original log entry as recorded in the source data. May encode species, age, sex, and plumage phase in a single string. `NA` indicates a census period with no birds recorded (converted from the sentinel value `"[NO BIRDS RECORDED]"` in the source data). |
|species_scientific_name |character |Scientific name, derived from `species_common_name` by Te Papa staff. May represent a species aggregate if the log entry could not be identified to a single species.                                                                                            |
|species_abbreviation    |character |Abbreviated species name (mostly the first three letters of the genus and species), derived from `species_common_name` by Te Papa staff.                                                                                                                         |
|age                     |ordered   |Age class, derived from `species_common_name`. One of `"juvenile"`, `"immature"`, `"subadult"`, or `"adult"`.                                                                                                                                                    |
|wan_plumage_phase       |ordered   |Wandering albatross plumage phase, derived from `species_common_name`. One of `"all brown"`, `"brown plumage breaking"`, `"white patch on wing"`, `"wing patch breaking"`, or `"white"`.                                                                         |
|plumage_phase           |ordered   |Plumage phase for species other than wandering albatross, derived from `species_common_name`. One of `"dark"`, `"intermediate"`, `"light"`, or `"white"`.                                                                                                        |
|sex                     |factor    |Sex, derived from `species_common_name`. One of `"female"` or `"male"`.                                                                                                                                                                                          |
|count                   |integer   |Total number of birds counted in this observation. `99999` is used for counts estimated to be over 100,000.                                                                                                                                                      |
|n_feeding               |integer   |Number of birds observed feeding (unspecified whether actively or passively). `99999` is used for counts estimated to be over 100,000.                                                                                                                           |
|feeding                 |logical   |Whether any birds were observed feeding.                                                                                                                                                                                                                         |
|n_sitting_on_water      |integer   |Number of birds sitting on water.                                                                                                                                                                                                                                |
|sitting_on_water        |logical   |Whether any birds were sitting on water.                                                                                                                                                                                                                         |
|n_sitting_on_ice        |integer   |Number of birds sitting on ice.                                                                                                                                                                                                                                  |
|sitting_on_ice          |logical   |Whether any birds were sitting on ice.                                                                                                                                                                                                                           |
|sitting_on_ship         |logical   |Whether any birds were sitting on the ship.                                                                                                                                                                                                                      |
|in_hand                 |logical   |Whether any birds were held in hand (i.e., captured).                                                                                                                                                                                                            |
|n_flying_past           |integer   |Number of birds flying past. `99999` is used for counts estimated to be over 100,000.                                                                                                                                                                            |
|flying_past             |logical   |Whether any birds were flying past.                                                                                                                                                                                                                              |
|n_accompanying          |integer   |Number of birds accompanying the ship (flying alongside).                                                                                                                                                                                                        |
|accompanying            |logical   |Whether any birds were accompanying the ship.                                                                                                                                                                                                                    |
|n_following_ship        |integer   |Number of birds following the ship's wake.                                                                                                                                                                                                                       |
|following_ship          |logical   |Whether any birds were following the ship's wake.                                                                                                                                                                                                                |
|moulting                |logical   |Whether any birds were observed moulting.                                                                                                                                                                                                                        |
|naturally_feeding       |logical   |Whether any birds were naturally feeding (i.e., not feeding on ship discards).                                                                                                                                                                                   |

### `sea_states.csv`

|variable              |class     |description                           |
|:---------------------|:-------|:-------------------------------------------------------------------------------------------------------|
|sea_state_class       |integer |Sea state class (0--6), corresponding to `ships$sea_state_class`.                                       |
|sea_state_description |ordered |Text description of the sea state, ordered from `"calm, glassy"` (class 0) to `"very rough"` (class 6). |
|wave_meters_min       |double  |Minimum wave height in meters for this class.                                                           |
|wave_meters_max       |double  |Maximum wave height in meters for this class.                                                           |

### `ships.csv`

|variable                |class     |description                           |
|:-----------------------|:---------|:-------------------------------------|
|record_id        |integer |Record identifier. Links to `birds$record_id`.                                                                                                                                                                                                                                          |
|date                    |date    |Observation date.                                                                                                                                                                                                                                                                       |
|time                    |time    |Local time at the start of the 10-minute count.                                                                                                                                                                                                                                         |
|latitude                |double  |Decimal latitude (negative values indicate southern hemisphere).                                                                                                                                                                                                                        |
|longitude               |double  |Decimal longitude.                                                                                                                                                                                                                                                                      |
|hemisphere              |factor  |East/West hemisphere: `"E"` or `"W"`.                                                                                                                                                                                                                                                   |
|activity                |factor  |Ship activity during the count period. One of `"steaming, sailing"`, `"dropping trash"`, `"trawling"`, `"oceanography"`, `"potting"`, `"line fishing"`, `"cleaning fish"`, `"stationary"`, `"flying helicopters"`, or `"whaling"`. Recoded from numeric codes 1--10 in the source data. |
|speed                   |double  |Ship speed in knots.                                                                                                                                                                                                                                                                    |
|direction               |integer |Ship direction in degrees.                                                                                                                                                                                                                                                              |
|cloud_cover             |ordered |Cloud cover: `"clear"`, `"partially cloudy"`, or `"overcast"`. Recoded from codes 0--2 in the source data.                                                                                                                                                                              |
|precipitation           |factor  |Precipitation type: `"none"`, `"squalls"`, `"fog"`, `"drizzle"`, `"rain"`, `"showers"`, `"snow showers"`, or `"continuous snow"`. Recoded from numeric codes in the source data.                                                                                                        |
|wind_speed_class        |integer |Wind speed on the Beaufort scale (0--12). Join to [beaufort_scale] for descriptions and knot ranges.                                                                                                                                                                                    |
|wind_direction          |integer |Wind direction in degrees.                                                                                                                                                                                                                                                              |
|air_temperature         |double  |Air temperature in degrees Celsius.                                                                                                                                                                                                                                                     |
|pressure                |integer |Atmospheric sea-level pressure in millibars.                                                                                                                                                                                                                                            |
|sea_state_class         |integer |Sea state class (0--6). Join to [sea_states] for descriptions and wave height ranges.                                                                                                                                                                                                   |
|sea_surface_temperature |double  |Sea surface temperature in degrees Celsius.                                                                                                                                                                                                                                             |
|depth                   |integer |Sea floor depth in meters.                                                                                                                                                                                                                                                              |
|observer                |factor  |Name of the observer, decoded from a 4-letter code in the source data.                                                                                                                                                                                                                  |
|census_method           |ordered |Count method: `"partial"` indicates a count lasting less than 10 minutes or a casual observation; `"full"` indicates a complete 10-minute count. Recoded from `"P"` and `"F"` in the source data.                                                                                       |
|season                  |ordered |Southern hemisphere season: `"summer"`, `"autumn"`, `"winter"`, or `"spring"`. Recorded directly in the source data (but likely derived rather than being entered directly in the log book data).                                                                                       |

## Cleaning Script

```r
# Clean data provided by the seabirddata package
# (https://jonthegeek.github.io/seabirddata/index.html). Full cleaning scripts
# are available on GitHub at
# https://github.com/jonthegeek/seabirddata/blob/main/data-raw/
beaufort_scale <- seabirddata::beaufort_scale
birds <- seabirddata::birds
ships <- seabirddata::ships
sea_states <- seabirddata::sea_states

```
