# Lisa's Vegetable Garden Data

We're exploring Lisa Lendway's vegetable garden from summer 2020 and summer 2021, from her [{gardenR} package](https://github.com/llendway/gardenR).
Thank you to Lisa for [suggesting this dataset back in 2021](https://github.com/rfordatascience/tidytuesday/issues/358)!

> The gardenR package contains data collected by Lisa Lendway from her vegetable garden, starting in the summer of 2020. Data from the summer of 2021 was added 2022-01-29 (finally!). The data were used in her Introduction to Data Science course at Macalester College to introduce many concepts. For examples, see the [tutorials for the course](https://ds112-lendway.netlify.app/).

Lisa also has a [YouTube video with a visual tour of the garden](https://www.youtube.com/embed/iGMgLFIiSxo).

What changed between 2020 and 2021?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-05-28')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 22)

harvest_2020 <- tuesdata$harvest_2020
harvest_2021 <- tuesdata$harvest_2021
planting_2020 <- tuesdata$planting_2020
planting_2021 <- tuesdata$planting_2021
spending_2020 <- tuesdata$spending_2020
spending_2021 <- tuesdata$spending_2021


# Option 2: Read directly from GitHub

harvest_2020 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/harvest_2020.csv')
harvest_2021 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/harvest_2021.csv')
planting_2020 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/planting_2020.csv')
planting_2021 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/planting_2021.csv')
spending_2020 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/spending_2020.csv')
spending_2021 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-28/spending_2021.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `planting_2020.csv`

|variable             |class     |description          |
|:--------------------|:---------|:--------------------|
|plot                 |character |label of plot where vegetables were planted - see garden_coords dataset (in the package) for more info |
|vegetable            |character |type of vegetable planted |
|variety              |character |variety of vegetable planted, usually according to the information on the seed package, but sometimes inferred by Lisa and sometimes unknown or reseeded from last year's plants |
|number_seeds_planted |numeric   |the exact number or a guess at how many seeds/plants were planted |
|date                 |Date      |date the vegetable was planted |
|number_seeds_exact   |logical   |if number_seeds_planted is exact, this is TRUE; if it was a guess, then this is FALSE |
|notes                |character |mostly missing but intially created just in case |

# `planting_2021.csv`

|variable             |class     |description          |
|:--------------------|:---------|:--------------------|
|date                 |Date      |date the vegetable was planted |
|vegetable            |character |type of vegetable planted |
|variety              |character |variety of vegetable planted, usually according to the information on the seed package, but sometimes inferred by Lisa and sometimes unknown or reseeded from last year's plants |
|plot                 |character |label of plot where vegetables were planted - see garden_coords dataset (in the package) for more info |
|number_seeds_planted |numeric   |the exact number or a guess at how many seeds/plants were planted |
|number_seeds_exact   |logical   |if number_seeds_planted is exact, this is TRUE; if it was a guess, then this is FALSE |
|notes                |character |mostly missing but intially created just in case |

# `harvest_2020.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|vegetable |character |type of vegetable planted |
|variety   |character |variety of vegetable planted, usually according to the information on the seed package, but sometimes inferred by Lisa and sometimes unknown or reseeded from last year's plants |
|date      |Date      |date the vegetable was harvested |
|weight    |numeric   |weight harvested in grams |
|units     |character |all "grams" - this variable was originally created in case larger vegetables were weighed in other units but there was no need |

# `harvest_2021.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|vegetable |character |type of vegetable planted |
|variety   |character |variety of vegetable planted, usually according to the information on the seed package, but sometimes inferred by Lisa and sometimes unknown or reseeded from last year's plants |
|date      |Date      |date the vegetable was harvested |
|weight    |numeric   |weight harvested in grams |
|units     |character |all "grams" - this variable was originally created in case larger vegetables were weighed in other units but there was no need |

# `spending_2020.csv`

|variable             |class     |description          |
|:--------------------|:---------|:--------------------|
|vegetable            |character |type of vegetable planted |
|variety              |character |variety of vegetable planted, usually according to the information on the seed package, but sometimes inferred by Lisa and sometimes unknown or reseeded from last year's plants |
|brand                |character |brand of seed or plant |
|eggplant_item_number |numeric   |item number of item at Eggplant, the store where most of the seeds were purchased |
|price                |numeric   |raw price - no taxes |
|price_with_tax       |numeric   |price with taxes |

# `spending_2021.csv`

|variable       |class     |description    |
|:--------------|:---------|:--------------|
|vegetable      |character |type of vegetable planted |
|variety        |character |variety of vegetable planted, usually according to the information on the seed package, but sometimes inferred by Lisa and sometimes unknown or reseeded from last year's plants |
|brand          |character |brand of seed or plant |
|price          |numeric   |raw price - no taxes |
|price_with_tax |numeric   |price with taxes |


### Cleaning Script

No data cleaning. Datasets are from the [{gardenR} package](https://github.com/llendway/gardenR).
