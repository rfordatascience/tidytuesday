![Image of a person watching Netflix on their couch, with their feet propped up on the coffee table](https://images.unsplash.com/photo-1586899028174-e7098604235b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1351&q=80)

# Netflix Shows

The data this week comes from [Kaggle](https://www.kaggle.com/shivamb/netflix-shows?select=netflix_titles.csv) w/ credit to Shivam Bansal.

> This dataset consists of tv shows and movies available on Netflix as of 2019. The dataset is collected from Flixable which is a third-party Netflix search engine.
> 
> In 2018, they released an interesting report which shows that the number of TV shows on Netflix has nearly tripled since 2010. The streaming service’s number of movies has decreased by more than 2,000 titles since 2010, while its number of TV shows has nearly tripled. It will be interesting to explore what all other insights can be obtained from the same dataset.
> 
> Integrating this dataset with other external datasets such as IMDB ratings, rotten tomatoes can also provide many interesting findings.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-04-20')
tuesdata <- tidytuesdayR::tt_load(2021, week = 17)

netflix <- tuesdata$netflix

# Or read in the data manually

netflix_titles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-20/netflix_titles.csv')

```
### Data Dictionary

# `netflix_titles.csv`

|variable     |class     |description |
|:------------|:---------|:-----------|
|show_id      |character | Unique ID for every Movie / Tv Show |
|type         |character | Identifier - A Movie or TV Show |
|title        |character | Title of the Movie / Tv Show |
|director     |character | Director of the Movie/Show |
|cast         |character | Actors involved in the movie / show |
|country      |character | Country where the movie / show was produced |
|date_added   |character | Date it was added on Netflix |
|release_year |double    | Actual Release year of the movie / show|
|rating       |character | TV Rating of the movie / show|
|duration     |character | Total Duration - in minutes or number of seasons|
|listed_in    |character | Genre |
|description  |character | Summary description of the film/show |

### Cleaning Script

No cleaning script this week, enjoy!