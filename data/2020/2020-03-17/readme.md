![Schrute R package - image of a beet](https://raw.githubusercontent.com/bradlindblad/schrute/master/man/figures/logo.png)

# The Office - Words and Numbers 

The data this week comes from the [`schrute` R package](https://bradlindblad.github.io/schrute/index.html) for The Office transcripts and [data.world](https://data.world/anujjain7/the-office-imdb-ratings-dataset) for IMDB ratings of each episode.

If you'd like to use the `schrute` R package for ALL the lines/dialogue from the show - please install it from CRAN via `install.packages("schrute")`. A quick example from the vignette can be found [here](https://bradlindblad.github.io/schrute/articles/theoffice.html).

If you want to do text analysis - make sure to check out the `tidytext` package - a vignette can be found [here](https://cran.r-project.org/web/packages/tidytext/vignettes/tidytext.html) and the *Tidy Text Mining with R* book can be found freely online [here](https://www.tidytextmining.com/). 

Lastly - the pudding analyzed *The Office* dialogue across a few charts - their article is [here](https://pudding.cool/2017/08/the-office/).

### Get the data here

```{r}
# Get the Data

office_ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-17/office_ratings.csv')

# Or read in with tidytuesdayR package (https://github.com/dslc-io/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO USE tidytuesdayR version ? from GitHub

# Either ISO-8601 date or year/week works!

# Install via pak::pak("dslc-io/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-03-17')
tuesdata <- tidytuesdayR::tt_load(2020, week = 12)


office_ratings <- tuesdata$office_ratings
```
### Data Dictionary


# `office_ratings.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|season      |double    | Season number |
|episode     |double    | Episode number |
|title       |character | Title of episode |
|imdb_rating |double    | IMDB Rating (10 is best) |
|total_votes |double    | Total votes by users |
|air_date    |date | Original air date|

# `schrute` data

|variable         |class     |description |
|:----------------|:---------|:-----------|
|index            |integer   | Index |
|season           |character | Season Number |
|episode          |character | Season episode |
|episode_name     |character | Episode title |
|director         |character | Episode Director |
|writer           |character | Episode Writer|
|character        |character | Episode Character |
|text             |character | Dialogue as text |
|text_w_direction |character | Dialogue as text with direction |

### Cleaning Script

No cleaning this week!
