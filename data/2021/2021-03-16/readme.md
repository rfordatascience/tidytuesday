![Picture of controllers](https://images.unsplash.com/photo-1580327344181-c1163234e5a0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1494&q=80)

# Video Games and Sliced

The data this week comes from [Steam](https://www.kaggle.com/michau96/popularity-of-games-on-steam) by way of Kaggle and originally came from [SteamCharts](https://steamcharts.com/). The data was scraped and uploaded to Kaggle.

Note there is a different dataset based on video games from 2019's TidyTuesday, check it out [here](https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-07-30), there's a possibility that some of the data could be joined on "name".

Additionally we are doing a crossover with the "Sliced" data science challenge this week!

Make sure to tune in to "Sliced" on Nick Wan's Twitch [stream](https://twitch.tv/nickwan_datasci), Tuesday March 16th at 8:30 pm ET!

What is Sliced? It's like Chopped but for Data Science!

> Data scientists get data they have never seen and have 2 hours to make a predictive model. Create the best data science or be sliced!

This is inline with the TidyTuesday efforts, and I look forward to seeing what they do with the stream.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-03-16')
tuesdata <- tidytuesdayR::tt_load(2021, week = 12)

games <- tuesdata$games

# Or read in the data manually

games <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-16/games.csv')

```
### Data Dictionary

# `games.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|gamename      |character | Name of video games |
|year          |double    | Year of measure |
|month         |character | Month of measure |
|avg           |double    | Average number of players at the same time|
|gain          |double    | Gain (or loss) Difference in average compared to the previous month (NA = 1st month) |
|peak          |double    | Highest number of players at the same time |
|avg_peak_perc |character | Share of the average in the maximum value (avg / peak) in % |

### Cleaning Script

No cleaning this week!
