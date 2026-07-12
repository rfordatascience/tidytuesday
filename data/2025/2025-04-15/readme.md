# Base R Penguins

This week we're taking another look at penguins! 
The Palmer Penguins dataset first appeared in TidyTuesday back in [July of 2020](https://github.com/rfordatascience/tidytuesday/blob/main/data/2020/2020-07-28/readme.md).
We're using the dataset again because, as of R 4.5.0 (released this past Friday), the datasets are available in the base R datasets package!

> The Palmer Penguins data, contained in the palmerpenguins R package as the 
> penguins and penguins_raw data frames, have become popular for data 
> exploration and visualisation, particularly in an educational context. ...
> The data was originally published in Gorman et al. (2014). Their inclusion in 
> the datasets package included in the base R distribution was motivated by 
> Horst et al. (2022).

Also check out the [{basepenguins}](https://ellakaye.github.io/basepenguins/) R package to convert scripts that use {palmerpenguins} to use the base R versions of the datasets.

Questions:

1. If you participated in TidyTuesday in 2020, what have you learned since then that changes how you approach the data?
2. Search the internet for "palmerpenguins" to find examples of plots that use these datasets. Can you reproduce those plots? Can you improve them?


Thank you to [Jon Harmon](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-04-15')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 15)

penguins <- tuesdata$penguins
penguins_raw <- tuesdata$penguins_raw

# Option 2: Read directly from GitHub

penguins <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-15/penguins.csv')
penguins_raw <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-15/penguins_raw.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-04-15')

# Option 2: Read directly from GitHub and assign to an object

penguins = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-15/penguins.csv')
penguins_raw = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-15/penguins_raw.csv')
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

### `penguins.csv`

|variable    |class         |description                           |
|:-----------|:-------------|:-------------------------------------|
|species     |factor        |Penguin species (Adelie, Gentoo, Chinstrap). |
|island      |factor        |Island where recorded (Biscoe, Dream, Torgersen). |
|bill_len    |double        |Bill length in millimeters (also known as culmen length). |
|bill_dep    |double        |Bill depth in millimeters (also known as culmen depth). |
|flipper_len |integer       |Flipper length in mm. |
|body_mass   |integer       |Body mass in grams. |
|sex         |factor        |Sex of the animal (male, female, or NA if unknown). |
|year        |integer       |Year recorded. |

### `penguins_raw.csv`

|variable            |class     |description                           |
|:-------------------|:---------|:-------------------------------------|
|studyName           |character |Study name. |
|Sample Number       |double    |Sample id. |
|Species             |character |Species of penguin. |
|Region              |character |Region where recorded. |
|Island              |character |Island where recorded. |
|Stage               |character |Stage of egg. |
|Individual ID       |character |Individual penguin ID. |
|Clutch Completion   |character |Egg clutch completion. |
|Date Egg            |date      |Date of egg. |
|Culmen Length (mm)  |double    |culmen length in mm (beak length). |
|Culmen Depth (mm)   |double    |culmen depth in mm (beak depth). |
|Flipper Length (mm) |double    |Flipper length in mm. |
|Body Mass (g)       |double    |Body mass in g. |
|Sex                 |character |Sex of the penguin. |
|Delta 15 N (o/oo)   |double    |Blood isotopic Nitrogen - used for dietary comparison. |
|Delta 13 C (o/oo)   |double    |Blood isotopic Carbon - used for dietary comparison. |
|Comments            |character |Miscellaneous comments. |

## Cleaning Script

```r
# Clean data provided by the base R {datasets} package (version >=4.5.0). No 
# cleaning was necessary.
penguins <- datasets::penguins
penguins_raw <- datasets::penguins_raw

```
