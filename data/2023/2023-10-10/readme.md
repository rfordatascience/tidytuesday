# Haunted Places in the United States

Halloween is coming soon, so we're exploring a spooky dataset: a compilation of Haunted Places in the United States. 
The dataset was [compiled by Tim Renner](https://github.com/timothyrenner/shadowlands-haunted-places), using [The Shadowlands Haunted Places Index](https://www.theshadowlands.net/places/), and [shared on data.world](https://data.world/timothyrenner/haunted-places).

We're also using this dataset as a reminder that [several R packages for spatial data are heading to the graveyard next week](https://geocompx.org/post/2023/rgdal-retirement/index.html).
Don't be tricked by their demise!

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-10-10')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 41)

haunted_places <- tuesdata$haunted_places

# Option 2: Read directly from GitHub

haunted_places <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-10/haunted_places.csv')

```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.


### Data Dictionary

# `haunted_places.csv`

|variable       |class     |description    |
|:--------------|:---------|:--------------|
|city           |character |The city where the place is located. |
|country        |character |The country where the place is located (always "United States") |
|description    |character |A text description of the place. The amount of detail in these descriptions is highly variable. |
|location       |character |A title for the haunted place. |
|state          |character |The US state where the place is located. |
|state_abbrev   |character |The two-letter abbreviation for the state. |
|longitude      |double    |Longitude of the place. |
|latitude       |double    |Latitude of the place. |
|city_longitude |double    |Longitude of the city center. |
|city_latitude  |double    |Latitude of the city center. |

### Cleaning Script

Data downloaded directly from https://query.data.world/s/glc736mqf4dxrqe6nbsamblqndemb6?dws=00000
