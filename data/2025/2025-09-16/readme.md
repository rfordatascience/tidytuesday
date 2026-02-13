# Allrecipes

This week we're exploring a curated collection of recipes collected from Allrecipes.com!
The data this week comes from the [tastyR package](https://cran.r-project.org/package=tastyR) (a dataset assembled from Allrecipes.com) and was prepared for analysis in R. Fields have been cleaned and standardized where possible to make comparisons and visual exploration straightforward.

> A collection of recipe datasets scraped from https://www.allrecipes.com/, containing two complementary datasets: `allrecipes` with 14,426 general recipes, and `cuisines` with 2,218 recipes categorized by country of origin. Both datasets include comprehensive recipe information such as ingredients, nutritional facts (calories, fat, carbs, protein), cooking times (preparation and cooking), ratings, and review metadata. All data has been cleaned and standardized, ready for analysis.

- Which authors are most successful: who is most prolific, who has the highest average ratings or popularity, and do top authors specialize by cuisine, ingredient, or recipe length?
- Is there a relationship between prep/cook time and average rating?
- Which recipe categories or cuisines tend to have the highest average ratings and review counts?
- Which recipes are the most "actionable" — high rating with low total time?

Thank you to [Brian Mubia](https://github.com/owlzyseyes) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-09-16')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 37)

all_recipes <- tuesdata$all_recipes
cuisines <- tuesdata$cuisines

# Option 2: Read directly from GitHub

all_recipes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-16/all_recipes.csv')
cuisines <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-16/cuisines.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-09-16')

# Option 2: Read directly from GitHub and assign to an object

all_recipes = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-16/all_recipes.csv')
cuisines = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-16/cuisines.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-09-16')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

all_recipes = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-16/all_recipes.csv")
cuisines = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-16/cuisines.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
all_recipes = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-16/all_recipes.csv", DataFrame)
cuisines = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-16/cuisines.csv", DataFrame)
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

### `all_recipes.csv`

| variable       | class     | description                                                                |
|:---------------|:----------|:---------------------------------------------------------------------------|
| name           | character | Name of the recipe.                                                        |
| url            | character | Link to the recipe.                                                        |
| author         | character | Author of the recipe.                                                      |
| date_published | date      | When the recipe was published/updated.                                     |
| ingredients    | character | The ingredients of the recipe.                                             |
| calories       | integer   | Calories per serving.                                                      |
| fat            | integer   | Fat per serving.                                                           |
| carbs          | integer   | Carbs per serving.                                                         |
| protein        | integer   | Proteins per serving.                                                      |
| avg_rating     | double    | Average rating out of 5 stars.                                             |
| total_ratings  | integer   | Number of ratings received. NOTE: These values are erroneously truncated to the thousands, unless there were less than 1000 ratings total. |
| reviews        | integer   | Number of written reviews. NOTE: These values are erroneously truncated to the thousands, unless there were less than 1000 ratings total. |
| prep_time      | integer   | Preparation time in minutes.                                               |
| cook_time      | integer   | Cooking time in minutes.                                                   |
| total_time     | integer   | Prep + cook time in minutes. Note that this value may not always match the actual total effort required, as other time-related fields (such as refrigeration, marination, fry time or additional wait periods) have been excluded due to inconsistent availability across recipes.|
| servings       | integer   | Number of servings.                                                        |

### `cuisines.csv`

| variable       | class     | description                                                                 |
|:---------------|:----------|:----------------------------------------------------------------------------|
| name           | character | Name of the recipe.                                                         |
| country        | character | The country/region the cuisine is from.                                     |
| url            | character | Link to the recipe.                                                         |
| author         | character | Author of the recipe.                                                       |
| date_published | date      | When the recipe was published/updated.                                      |
| ingredients    | character | The ingredients of the recipe.                                              |
| calories       | integer   | Calories per serving.                                                       |
| fat            | integer   | Fat per serving.                                                            |
| carbs          | integer   | Carbs per serving.                                                          |
| protein        | integer   | Proteins per serving.                                                       |
| avg_rating     | double    | Average rating out of 5 stars.                                              |
| total_ratings  | integer   | Number of ratings received. NOTE: These values are erroneously truncated to the thousands, unless there were less than 1000 ratings total. |
| reviews        | integer   | Number of written reviews. NOTE: These values are erroneously truncated to the thousands, unless there were less than 1000 ratings total. |
| prep_time      | integer   | Preparation time in minutes.                                                |
| cook_time      | integer   | Cooking time in minutes.                                                    |
| total_time     | integer   | Prep + cook time in minutes. Note that this value may not always match the actual total effort required, as other time-related fields (such as refrigeration, marination, fry time, or additional wait periods) have been excluded due to inconsistent availability across recipes.|
| servings       | integer   | Number of servings.                                                         |

## Cleaning Script

```r
# Clean data provided by owlzyseyes. No cleaning was necessary.
all_recipes <- readr::read_csv("https://raw.githubusercontent.com/owlzyseyes/tastyR/refs/heads/main/data-raw/allrecipes.csv")
cuisines <- readr::read_csv("https://raw.githubusercontent.com/owlzyseyes/tastyR/refs/heads/main/data-raw/cuisines.csv")

```
