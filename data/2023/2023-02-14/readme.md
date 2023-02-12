### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here’s a simple formula for writing alt text for data visualization:
> ### Chart type
> It’s helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you’re including this visual. What does it show that’s meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don’t include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Hollywood Age Gaps

The data this week comes from [Hollywood Age Gap](https://hollywoodagegap.com/) via [Data Is Plural](https://www.data-is-plural.com/archive/2018-02-07-edition/).

> An informational site showing the age gap between movie love interests.

The data follows certain rules:

> The two (or more) actors play actual love interests (not just friends, coworkers, or some other non-romantic type of relationship)

> The youngest of the two actors is at least 17 years old

> Not animated characters

We previously provided a dataset about the [Bechdel Test](https://tidytues.day/2021/2021-03-09). It might be interesting to see whether there is any correlation between these datasets! The Bechdel Test dataset also included additional information about the films that were used in that dataset.

Note: The age gaps dataset includes "gender" columns, which always contain the values "man" or "woman". These values appear to indicate how the *characters* in each film identify. Some of these values do not match how the *actor* identifies. We apologize if any characters are misgendered in the data!

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-02-14')
tuesdata <- tidytuesdayR::tt_load(2023, week = 7)

age_gaps <- tuesdata$age_gaps

# Or read in the data manually

age_gaps <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-14/age_gaps.csv')
```

### Data Dictionary

# `age_gaps.csv`

|variable           |class     |description        |
|:------------------|:---------|:------------------|
|movie_name         |character |Name of the film   |
|release_year       |integer   |Release year       |
|director           |character |Director of the film|
|age_difference     |integer   |Age difference between the characters in whole years |
|couple_number      |integer   |An identifier for the couple in case multiple couples are listed for this film |
|actor_1_name       |character |The name of the older actor in this couple|
|actor_2_name       |character |The name of the younger actor in this couple|
|character_1_gender |character |The gender of the older character, as identified by the person who submitted the data for this couple|
|character_2_gender |character |The gender of the younger character, as identified by the person who submitted the data for this couple|
|actor_1_birthdate  |date      |The birthdate of the older member of the couple|
|actor_2_birthdate  |date      |The birthdate of the younger member of the couple|
|actor_1_age        |integer   |The age of the older actor when the film was released|
|actor_2_age        |integer   |The age of the younger actor when the film was released|


### Cleaning Script

```r
library(tidyverse)
library(here)
library(janitor)

age_gaps <- read_csv(
  "http://hollywoodagegap.com/movies.csv",
) |> 
  clean_names()

glimpse(age_gaps)

# Quickly check that the columns make sense.
length(vctrs::vec_cast(age_gaps$release_year, integer())) == nrow(age_gaps)
length(vctrs::vec_cast(age_gaps$age_difference, integer())) == nrow(age_gaps)
unique(age_gaps$actor_1_gender)
!any(is.na(as.Date(age_gaps$actor_1_birthdate)))
length(vctrs::vec_cast(age_gaps$actor_1_age, integer())) == nrow(age_gaps)
unique(age_gaps$actor_2_gender)
!any(is.na(as.Date(age_gaps$actor_2_birthdate)))
length(vctrs::vec_cast(age_gaps$actor_2_age, integer())) == nrow(age_gaps)

# Formally set the dates to dates.
age_gaps <- age_gaps |> 
  mutate(
    across(
      ends_with("birthdate"),
      as.Date
    )
  )

# Try to get a better understanding of the "gender" columns.
count(age_gaps, actor_1_gender)
count(age_gaps, actor_2_gender)

# The order of the characters doesn't seem to be consistent
age_gaps |> 
  summarize(
    p_1_older = mean(actor_1_age > actor_2_age),
    p_1_male = mean(actor_1_gender == "man"),
    p_1_female_2_male = mean(actor_1_gender == "woman" & actor_2_gender == "man"),
    p_1_first_alpha = mean(actor_1_name < actor_2_name)
  )

# For the most part, they put the man first if there's a man in the couple. It
# doesn't look like there's a strict rule, though. But beware: Some movies have
# more than 1 couple! Let's use all that to rebuild the data, always putting the
# older character first.
age_gaps <- age_gaps |> 
  mutate(
    couple_number = row_number(),
    .by = "movie_name"
  ) |> 
  pivot_longer(
    cols = starts_with(c("actor_1_", "actor_2_")),
    names_to = c(NA, NA, ".value"),
    names_sep = "_"
  ) |> 
  # Put the older actor first.
  arrange(desc(age_difference), movie_name, birthdate) |> 
  # While we have it pivoted, correct Elliot Page's name. I don't know if other
  # actors are similarly deadnamed, but at least we can fix this one. Note that
  # the *characters* played by Elliot in these particular films were women, so
  # I'll leave the gender as-is.
  mutate(
    name = case_match(
      name,
      "Ellen Page" ~ "Elliot Page",
      .default = name
    )
  ) |>
  mutate(
    position = row_number(),
    .by = c("movie_name", "couple_number")
  ) |> 
  pivot_wider(
    names_from = "position",
    names_glue = "actor_{position}_{.value}",
    values_from = c("name", "gender", "birthdate", "age")
  )

# The gender isn't really the actor so much as it is the character. Let's
# correct that.
age_gaps <- age_gaps |> 
  rename(
    "character_1_gender" = "actor_1_gender",
    "character_2_gender" = "actor_2_gender"
  )

glimpse(age_gaps)

# Save the data.
write_csv(
  age_gaps,
  here::here(
    "data", "2023", "2023-02-14",
    "age_gaps.csv"
  )
)
```
