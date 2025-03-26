# Pokemon

This week we are exploring Pokemon! This dataset is sourced from {pokemon} ([CRAN](https://cran.r-project.org/package=pokemon) | [github](https://github.com/williamorim/pokemon)), an R package which provides Pokemon information in both English and Brazilian Portuguese.

> This package provides a dataset of Pokemon information in both English and Brazilian Portuguese. The dataset contains 949 rows and 22 columns, including information such as the Pokemon’s name, ID, height, weight, stats, type, and more.


Thank you to [Frank Hull](https://github.com/frankiethull) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-04-01')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 13)

pokemon_df <- tuesdata$pokemon_df

# Option 2: Read directly from GitHub

pokemon_df <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-01/pokemon_df.csv')
```

```python
# Using Python
# Option 1: PyDyTuesday python library
## pip install PyDyTuesday

import PyDyTuesday

# Download files from the week, which you can then read in locally
PyDyTuesday.get_date('2025-04-01')

# Option 2: Read directly from GitHub and assign to an object

pokemon_df = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-01/pokemon_df.csv')
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

# `pokemon_df.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
|id              |integer   |The unique ID of each Pokemon.|
|pokemon         |character |The name of each pokemon.|
|species_id      |integer   |The species ID of each Pokemon.|
|height          |double    |The height of each pokemon.|
|weight          |double    |The weight of each pokemon. |
|base_experience |integer   |The base experience of each Pokemon. |
|type_1          |character |The primary type. |
|type_2          |character |The secondary type. |
|hp              |integer   |The HP (hit points). |
|attack          |integer   |The attack points. |
|defense         |integer   |The defense points. |
|special_attack  |integer   |The special attack points. |
|special_defense |integer   |The special defense points. |
|speed           |integer   |The speed. |
|color_1         |character |The primary color of each pokemon. |
|color_2         |character |The secondary color of each pokemon. |
|color_f         |character |The final color of each pokemon. |
|egg_group_1     |character |The primary egg group. |
|egg_group_2     |character |The secondary egg group. |
|url_icon        |character |The URL for the icon of each Pokemon (if available). Note that these are missing the starting "https:". |
|generation_id   |integer   |The generation ID of each Pokemon. |
|url_image       |character |The URL for the image of each Pokemon. |

### Cleaning Script

```r
# Clean data provided by https://github.com/williamorim/pokemon. No cleaning was necessary.

# install.packages("pokemon")
pokemon_df <- pokemon::pokemon

```
