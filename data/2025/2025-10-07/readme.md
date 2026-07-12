# EuroLeague Basketball

This week we’re exploring **EuroLeague Basketball**, the premier men’s club basketball competition in Europe.  

The dataset contains information on EuroLeague teams, including their country, home city, arena, seating capacity, and historical performance (Final Four appearances and titles won).  

The dataset is curated from publicly available sources such as Wikipedia and official EuroLeague records, and was packaged in the [EuroleagueBasketball R package](https://github.com/natanast/EuroleagueBasketball), with documentation available at [natanast.github.io/EuroleagueBasketball](https://natanast.github.io/EuroleagueBasketball/).

> "The EuroLeague is the top-tier European professional basketball club competition, widely regarded as the most prestigious competition in European basketball." — EuroLeague

Some questions you might explore with this dataset:  
- Which countries are most represented in the EuroLeague?  
- How do arena capacities compare across teams and countries?  In R, the `readr::parse_number()` function might be helpful here.
- Which clubs have been the most successful historically?

Thank you to [Natasa Anastasiadou](https://github.com/natanast) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-10-07')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 40)

euroleague_basketball <- tuesdata$euroleague_basketball

# Option 2: Read directly from GitHub

euroleague_basketball <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-07/euroleague_basketball.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-10-07')

# Option 2: Read directly from GitHub and assign to an object

euroleague_basketball = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-07/euroleague_basketball.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-10-07')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

euroleague_basketball = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-07/euroleague_basketball.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
euroleague_basketball = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-07/euroleague_basketball.csv", DataFrame)
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

### `euroleague_basketball.csv`

|variable                       |class     |description                                                                 |
|:------------------------------|:---------|:---------------------------------------------------------------------------|
|Team                           |character |Name of the basketball team.                                                 |
|Home city                      |character |City where the team is based.                                               |
|Arena                          |character |Name of the home arena.                                                     |
|Capacity                       |character |Seating capacity of the arena.                                              |
|Last season                    |character |Ranking of team in the 2024-25 season, including teams elevated to the Euroleague from the Eurocup in that season.|
|Country                        |character |Country where the team is based.                                            |
|FinalFour_Appearances          |integer    |Number of times the team has reached the EuroLeague Final Four.             |
|Titles_Won                     |integer    |Number of EuroLeague titles won by the team.                                |
|Years_of_FinalFour_Appearances |character |Years when the team reached the Final Four.                                 |
|Years_of_Titles_Won            |character |Years when the team won the EuroLeague championship.                        |

## Cleaning Script

```r
# Clean data provided by https://github.com/natanast/EuroleagueBasketball. 
# The data was already cleaned and curated in the EuroleagueBasketball R package.
# No cleaning was necessary.
euroleague_basketball <- readr::read_csv("https://raw.githubusercontent.com/natanast/EuroleagueBasketball/main/data-raw/euroleague_dataset.csv")

```
