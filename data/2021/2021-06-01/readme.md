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

---

![Logo for the survivoR R package, which is a black hexagon, a golden lit torch, and the word "survivoR" in white.](http://gradientdescending.com/wp-content/uploads/2020/11/hex-torch.png)

# Survivor TV Show data!

The data this week comes from the [`survivorR` R package](https://github.com/doehm/survivoR) by way of Daniel Oehm.

> 596 episodes. 40 seasons. 1 package!
> 
> `survivoR` is a collection of data sets detailing events across all 40 seasons of the US Survivor, including castaway information, vote history, immunity and reward challenge winners and jury votes.

Full details about the package and additional datasets available in the package are available on [GitHub](https://github.com/doehm/survivoR). The package is on CRAN as `survivoR` and can be installed for ALL the datasets, themes, etc via `install.packages("survivoR")`.

Some example code is available at [Daniel's Website](http://gradientdescending.com/survivor-data-from-the-tv-series-in-r/).

Additional context/details about the Survivor TV show can be found on [Wikipedia](https://en.wikipedia.org/wiki/Survivor_(American_TV_series)).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-06-01')
tuesdata <- tidytuesdayR::tt_load(2021, week = 23)

summary <- tuesdata$summary

# Or read in the data manually

summary <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-06-01/summary.csv')

```
### Data Dictionary

# `summary.csv`

|variable        |class     |description |
|:---------------|:---------|:-----------|
|season_name     |character | Name of season |
|season          |integer   | Season number |
|location        |character | Season geo location |
|country         |character | Season country |
|tribe_setup     |character | Tribe Setup |
|full_name       |character | Full name of player |
|winner          |character | Season winner |
|runner_ups      |character | Runner ups |
|final_vote      |character | Final vote for winner |
|timeslot        |character | Time slot on TV |
|premiered       |double    | Premiered date |
|ended           |double    | Ended date |
|filming_started |double    | Filming started date |
|filming_ended   |double    | Filming ended date |
|viewers_premier |double    | Viewers (millions) at premier |
|viewers_finale  |double    | Viewers at finale |
|viewers_reunion |double    | Viewers for reunion |
|viewers_mean    |double    | Viewers average |
|rank            |double    | Viewer ranking |

# `challenges.csv`

|variable       |class     |description |
|:--------------|:---------|:-----------|
|season_name     |character | Name of season |
|season          |integer   | Season number |
|episode        |double    | Episode number |
|title          |character | Episode title |
|day            |double    | Day of season |
|challenge_type |character | Challenge type |
|winners        |character | Winners names |
|winning_tribe  |character | Winning tribe |

# `castaways.csv`

|variable             |class     |description |
|:--------------------|:---------|:-----------|
|season_name     |character | Name of season |
|season          |integer   | Season number |
|full_name            |character | Full name of participant |
|castaway             |character | Castaway's first name |
|age                  |double    | Age |
|city                 |character | Origin city |
|state                |character | Origin state |
|personality_type     |character | personality type |
|day                  |double    | Day of season |
|order                |integer   | Order |
|result               |character | Result |
|jury_status          |character | Jury status |
|original_tribe       |character | Original tribe |
|swapped_tribe        |character | Swapped tribe |
|swapped_tribe2       |character |Swapped tribe 2 |
|merged_tribe         |character | Merged tribe |
|total_votes_received |double    | Total votes received |
|immunity_idols_won   |double    | Immunity idols won |

# `viewers.csv`

|variable               |class     |description |
|:----------------------|:---------|:-----------|
|season_name     |character | Name of season |
|season          |integer   | Season number |
|episode_number_overall |double    | Episode number overall |
|episode                |double    | Episode number |
|title                  |character | Episode title |
|episode_date           |double    | Date |
|viewers                |double    | Viewers in millions |
|rating_18_49           |double    | Rating by viwers aged 18-49  |
|share_18_49            |double    | Share of viewers aged 18-49 |

# `jury_votes.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|season_name     |character | Name of season |
|season          |integer   | Season number |
|castaway    |character | Castaway |
|finalist    |character | Finalist |
|vote        |double    | Vote |

### Cleaning Script

No cleaning script, just the CRAN package `survivoR`!