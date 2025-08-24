# The xkcd Color Survey Results

In 2010, the [xkcd Color Survey](https://blog.xkcd.com/2010/05/03/color-survey-results/) asked hundreds of thousands of people to name colors they saw, revealing the different ways in which people perceive and label colors.

> Color is a really fascinating topic, especially since we’re taught so many 
> different and often contradictory ideas about rainbows, different primary 
> colors, and frequencies of light.

* Which types of users were most accurate in naming colors?
* Which colors are mentioned most in the top 100 ranked color names?
* Which types of users are least likely to be spam users?

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-07-08')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 27)

answers <- tuesdata$answers
color_ranks <- tuesdata$color_ranks
users <- tuesdata$users

# Option 2: Read directly from GitHub

answers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/answers.csv')
color_ranks <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/color_ranks.csv')
users <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/users.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-07-08')

# Option 2: Read directly from GitHub and assign to an object

answers = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/answers.csv')
color_ranks = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/color_ranks.csv')
users = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/users.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-07-08')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

answers = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/answers.csv")
color_ranks = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/color_ranks.csv")
users = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/users.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
answers = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/answers.csv", DataFrame)
color_ranks = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/color_ranks.csv", DataFrame)
users = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-08/users.csv", DataFrame)
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

### `answers.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|user_id  |double    |The id of the user who gave the answer. |
|hex      |character |Hex code of the color shown to a user. |
|rank     |double    |The rank of the color that the user gave as the name of the color they were shown (join with `color_ranks`to get the color name answer given by the user). Note that this table is a subset of the full answers data where the `color_name_answer` was one of the names of the 5 top ranked colors in the `color_ranks` data. |

### `color_ranks.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|color    |character |The name of the color (for the 954 most common RGB monitor colors only). |
|rank     |double    |The rank of the color. |
|hex      |character |The hex code of the color. |

### `users.csv`

|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|user_id      |double    |The id of the user. |
|monitor      |character |The user's monitor type. |
|y_chromosome |double    |Whether or not the user reported having a Y chromosome. The data was recorded in this way since chromosomal sex is related to colorblindness. |
|colorblind   |double    |Whether or not the user reported being colorblind. |
|spam_prob    |double    |Probability of the user being a spam user. |

## Cleaning Script

```r
# Clean data provided by https://github.com/nrennie/xkcd-color-survey/. No further cleaning was necessary.
color_ranks <- readr::read_csv("https://raw.githubusercontent.com/nrennie/xkcd-color-survey/main/data/clean/color_ranks.csv")
answers <- readr::read_csv("https://raw.githubusercontent.com/nrennie/xkcd-color-survey/main/data/clean/answers.csv")
users <- readr::read_csv("https://raw.githubusercontent.com/nrennie/xkcd-color-survey/main/data/clean/users.csv")

```
