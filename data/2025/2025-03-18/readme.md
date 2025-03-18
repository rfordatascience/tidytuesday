# Palm Trees

This week we're exploring [Palm Trees](https://www.nature.com/articles/s41597-019-0189-0)! 

The dataset comes from the [the PalmTraits 1.0 database](https://www.nature.com/articles/s41597-019-0189-0) via the [`palmtrees`](https://github.com/EmilHvitfeldt/palmtrees) R package by [Emil Hvitfeldt](https://github.com/EmilHvitfeldt).

> Plant traits are critical to plant form and function —including growth, survival and reproduction— and therefore shape fundamental aspects of population and ecosystem dynamics as well as ecosystem services. Here, we present a global species-level compilation of key functional traits for palms (Arecaceae), a plant family with keystone importance in tropical and subtropical ecosystems.

- How does the sizes of the different species of palms vary across sub families?

- Which fruit colors occur most often?


Thank you to [Lydia Gibson](https://github.com/lgibson7) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-03-18')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 11)

palmtrees <- tuesdata$palmtrees

# Option 2: Read directly from GitHub

palmtrees <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-18/palmtrees.csv')
```

```python
# Using Python
# Option 1: PyDyTuesday python library
## pip install PyDyTuesday

import PyDyTuesday

# Download files from the week, which you can then read in locally
PyDyTuesday.get_date('2025-03-18')

# Option 2: Read directly from GitHub and assign to an object

palmtrees = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-18/palmtrees.csv', encoding='windows-1252')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)  

## PydyTuesday: A Posit collaboration with TidyTuesday  

- Exploring the TidyTuesday data in Python?  Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.


### Data Dictionary

# `palmtrees.csv`

|variable                |class         |description                           |
|:-----------------------|:-------------|:-------------------------------------|
|spec_name               |character     |Taxonomic name of species (binomial nomenclature) following the World Checklist of palms. |
|acc_genus               |character     |Accepted genus name from the World Checklist of palms. |
|acc_species             |character     |Accepted species name from the World Checklist of palms. |
|palm_tribe              |character     |Name of palm tribe from the World Checklist of palms. |
|palm_subfamily          |character     |Name of palm subfamily from the World Checklist of palms. |
|climbing                |factor |Whether palm species has climbing habit or not, or both if populations vary in this trait. |
|acaulescent             |factor |Whether palm species has an acaulescent growth form (leaves and inflorescence rise from the ground, i.e. lacking a visible aboveground stem) or not, or both if populations vary in this trait. |
|erect                   |factor |Whether palm species has an erect stem (rather than an acaulescent or climbing growth form) or not, or both if local populations vary in this trait. |
|stem_solitary           |factor |Whether stems are solitary (single-stemmed) or clustered (with several stems), or both if populations vary in this trait. |
|stem_armed              |factor |Whether bearing some form of spines at the stem or not, or both if populations vary in this trait. |
|leaves_armed            |factor |Whether bearing some form of spines on the leaves or not, or both if populations vary in this trait. |
|max_stem_height_m       |double        |Maximum stem height. |
|max_stem_dia_cm         |double        |Maximum stem diameter. |
|understorey_canopy      |factor<27915> |Understory palms are defined as short-stemmed palms with a maximum stem height ≤5m or an acaulescent growth form, canopy palms with maximum stem height >5m. |
|max_leaf_number         |integer       |Maximum number of leaves. |
|max__blade__length_m    |double        |Maximum length of the blade (the flat expanded part of a leaf as distinguished from the petiole). |
|max__rachis__length_m   |double        |Maximum length of the rachis (the axis of the leaf beyond the petiole). |
|max__petiole_length_m   |double        |Maximum length of the petiole (the stalk of the leave). |
|average_fruit_length_cm |double        |Average length of the fruit as provided in a monograph or species description. |
|min_fruit_length_cm     |double        |Minimum fruit length as provided in a monograph or species description. |
|max_fruit_length_cm     |double        |Maximum fruit length as provided in a monograph or species description. |
|average_fruit_width_cm  |double        |Average width of the fruit as provided in a monograph or species description. |
|min_fruit_width_cm      |double        |Minimum fruit width as provided in a monograph or species description. |
|max_fruit_width_cm      |double        |Maximum fruit width as provided in a monograph or species description. |
|fruit_size_categorical  |factor |Species classified into small-fruited palms (fruits <4cm in length) and large-fruited palms (fruits ≥4cm in length). |
|fruit_shape             |factor |Description of fruit shape as provided in a monograph or species description. |
|fruit_color_description |character     |Verbatim description of fruit color (e.g. red to dark purple, green to orange to red, purple-brown) as provided in a monograph or species description. |
|main_fruit_colors       |character     |Main fruit colors summarized from fruit color descriptions (black, yellow, orange, red, purple etc.). |
|conspicuousness         |factor |Main fruit colors classified into conspicuous colors (e.g. orange, red, yellow, pink, crimson, scarlet) vs. cryptic colors (brown, black, green, blue, cream, grey, ivory, straw-coloured, white, purple). |

### Cleaning Script

```r
# Clean data provided by {palmtrees} R package. No cleaning was necessary.
# install.packages("devtools")

devtools::install_github("EmilHvitfeldt/palmtrees")
library(palmtrees)
library(dplyr)

palmtrees <- palmtrees::palmtrees |>
  dplyr::mutate(
    dplyr::across(
      "max_leaf_number",
      as.integer
    )
  )

```
