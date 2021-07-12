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

![Cast of Scooby Doo, aligned from left to right as Velma, Shaggy, Scooby, Fred, and Daphne set over a psychedlic rainbow background](https://nypost.com/wp-content/uploads/sites/2/2019/09/tv-scooby-doo-2b.jpg?quality=90&strip=all&w=618&h=410&crop=1)

# Scooby Doo Episodes

The data this week comes from [Kaggle](https://www.kaggle.com/williamschooleman/scoobydoo-complete) thanks to manual data aggregation by [plummye](https://www.kaggle.com/williamschooleman). Hat tip to [Sara Stoudt](https://github.com/rfordatascience/tidytuesday/issues/345) for recommending this dataset!

> Every Scooby-Doo episode and movie's various variables.
> 
> Took ~1 year to watch every Scooby-Doo iteration and track every variable. Many values are subjective by nature of watching but I tried my hardest to keep the data collection consistent.
> 
> If you plan to use this data for anything school/entertainment related you are free to (credit is always welcome). 

More info about Scooby Doo can be found on [ScoobyPedia](https://scoobydoo.fandom.com/wiki/Scoobypedia).

> Scoobypedia is an encyclopedia on the hit television series Scooby-Doo which has been airing for over 50 years!
> 
> The show follows the iconic mystery solving detectives, know as Mystery Inc., as they set out to solve crime and unmask criminals, bent on revenge or committing criminal acts for their own personal gain.
> 
> Titular character, Scooby, is followed by his best pal Shaggy as both vie for Scooby Snacks on their adventures! Velma brings her extra intellect and initiative to them, setting out plans to catch criminals. Fred is the team's leader while Daphne is bold and full of personality.
> 
> We are the go-to encyclopedia on all-things Scooby-Doo and are currently editing over 15,485 articles - we need your help! Create an account, Contribute to articles, and discuss the show on the number 1 Scooby-Doo

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-07-13')
tuesdata <- tidytuesdayR::tt_load(2021, week = 29)

scoobydoo <- tuesdata$scoobydoo

# Or read in the data manually

scoobydoo <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')

```
### Data Dictionary

# `scoobydoo.csv`

|variable                 |class     |description              |
|:------------------------|:---------|:------------------------|
|index                    |double    | Index ordering based on Scoobypedia |
|series_name              |character |Name of the series in which the episode takes place or in movies' cases the Scoobypedia's grouping classification |
|network                  |character |Network the TV series takes place in, if it is a movie will use similar grouping as series.name variable |
|season                   |character |Season of TV Series, if not TV Series will default to the format                   |
|title                    |character |Title of Episode/Movie                    |
|imdb                     |character | Score on IMDB (NULL if recently aired) |
|engagement               |character | Number of reviews on IMDB (NULL if very recently aired) |
|date_aired               |double    |Dated aired in US               |
|run_time                 |double    | Run time in min                 |
|format                   |character | Type of media                    |
|monster_name             |character |Name of monster              |
|monster_gender           |character |Binary monster gender            |
|monster_type             |character |Monster type              |
|monster_subtype          |character | Monster subtype           |
|monster_species          |character |monster_species          |
|monster_real             |character | Was monster real             |
|monster_amount           |double    | Monster amount            |
|caught_fred              |character | Caught by Fred              |
|caught_daphnie           |character |caught by Daphnie           |
|caught_velma             |character |caught by Velma             |
|caught_shaggy            |character |caught by Shaggy            |
|caught_scooby            |character |caught by Scooby            |
|captured_fred            |character |captured Fred            |
|captured_daphnie         |character |captured Daphnie         |
|captured_velma           |character |captured Velma           |
|captured_shaggy          |character |captured Shaggy          |
|captured_scooby          |character |captured Scooby          |
|unmask_fred              |character |unmask by fred              |
|unmask_daphnie           |character |unmask by Daphnie           |
|unmask_velma             |character |unmask by Velma             |
|unmask_shaggy            |character |unmask by Shaggy            |
|unmask_scooby            |character |unmask by Scooby            |
|snack_fred               |character |snack eaten by Fred               |
|snack_daphnie            |character |snack  eaten by Daphnie            |
|snack_velma              |character |snack  eaten by Velma              |
|snack_shaggy             |character |snack  eaten by Shaggy             |
|snack_scooby             |character |snack  eaten by Scooby             |
|unmask_other             |logical   |unmask by other             |
|caught_other             |logical   |caught by other             |
|caught_not               |logical   | Not caught               |
|trap_work_first          |character | Trap work first          |
|setting_terrain          |character | Setting type of terrain          |
|setting_country_state    |character |setting country state    |
|suspects_amount          |double    |suspects amount          |
|non_suspect              |character |non suspect              |
|arrested                 |character |arrested                 |
|culprit_name             |character |culprit name             |
|culprit_gender           |character |culprit binary gender           |
|culprit_amount           |double    |culprit amount           |
|motive                   |character |motive                   |
|if_it_wasnt_for          |character | Phrase at the end of show, ie "if it wasnt for ..."          |
|and_that                 |character |and that                 |
|door_gag                 |logical   |door gag                 |
|number_of_snacks         |character |number of snacks         |
|split_up                 |character |split up                 |
|another_mystery          |character |another mystery          |
|set_a_trap               |character |set a trap               |
|jeepers                  |character |Times "jeepers" said                  |
|jinkies                  |character | Times "jinkies" said                  |
|my_glasses               |character |Times "my glasses" said               |
|just_about_wrapped_up    |character | Times "just about wrapped up" said    |
|zoinks                   |character | Times "zoinks"said  |
|groovy                   |character |Times "groovy" said                   |
|scooby_doo_where_are_you |character |Times "scooby doo where are you" said |
|rooby_rooby_roo          |character | Times "rooby_rooby_roo" said          |
|batman                   |logical   |batman in episode                   |
|scooby_dum               |logical   | scooby_dum in episode               |
|scrappy_doo              |logical   |scrappy_doo in episode              |
|hex_girls                |logical   |hex_girls in episode                 |
|blue_falcon              |logical   |blue_falcon in episode              |
|fred_va                  |character |Fred voice actor                  |
|daphnie_va               |character |Daphnie voice actor               |
|velma_va                 |character |velma voice actor                 |
|shaggy_va                |character |shaggy  voice actor                |
|scooby_va                |character |scooby  voice actor                |

### Cleaning Script

