### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> ### Chart type
> It's helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you're including this visual. What does it show that's meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don't include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Great British Bakeoff

The data this week comes from the [`bakeoff` package](https://bakeoff.netlify.app/) from Alison Hill, Chester Ismay, and Richard Iannone.

Use the R package for all the data and raw datasets, and make use of the built-in palettes/scales!

```r
install.packages("bakeoff")
library(tidyverse)
library(bakeoff)

plot_off1 <- bakeoff::ratings %>% 
  mutate(ep_id = row_number()) %>%
  select(ep_id, viewers_7day, series, episode)

# create coordinates for labels
series_labels <- plot_off1 %>% 
  group_by(series) %>% 
  summarize(y_position = median(viewers_7day) + 1,
            x_position = mean(ep_id))
# make the plot
ggplot(plot_off1, aes(x = ep_id, y = viewers_7day, fill = factor(series))) +
  geom_col(alpha = .9) +
  ggtitle("Series 8 was a Big Setback in Viewers",
          subtitle= "7-Day Viewers across All Series/Episodes") +
  geom_text(data = series_labels, aes(label = series,
                                      x = x_position, 
                                      y = y_position)) +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) + 
  scale_fill_bakeoff(guide = "none")
```

For some introductory plots, also see [Data Visualization in the Tidyverse - The Great Tidy Plot Off](https://alison.netlify.app/uo-tidy-bakeoff/#1) by Alison Hill.

> The Great British Bake Off (often abbreviated to Bake Off or GBBO) is a British television baking competition, produced by Love Productions, in which a group of amateur bakers compete against each other in a series of rounds, attempting to impress two judges with their baking skills. One contestant is eliminated in each round, and the winner is selected from the contestants who reach the final. The first episode was aired on 17 August 2010, with its first four series broadcast on BBC Two, until its growing popularity led the BBC to move it to BBC One for the next three series. After its seventh series, Love Productions signed a three-year deal with Channel 4 to produce the series for the broadcaster. - [Wikipedia](https://en.wikipedia.org/wiki/The_Great_British_Bake_Off)


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-10-25')
tuesdata <- tidytuesdayR::tt_load(2022, week = 43)

bakers <- tuesdata$bakers

# Or read in the data manually

bakers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-10-25/bakers.csv')

```
### Data Dictionary


# challenges


|variable    |class     |description |
|:-----------|:---------|:-----------|
|series      |integer   | series    |
|episode     |integer   |episode    |
|baker       |character | baker    |
|result      |character |result    |
|signature   |character | signature    |
|technical   |integer   | technical    |
|showstopper |character | showstopper    |

# bakers


|variable                  |class     |description               |
|:-------------------------|:---------|:-------------------------|
|series                    |double    |series                    |
|baker                     |character |baker                     |
|star_baker                |integer   |star_baker                |
|technical_winner          |integer   |technical_winner          |
|technical_top3            |integer   |technical_top3            |
|technical_bottom          |integer   |technical_bottom          |
|technical_highest         |double    |technical_highest         |
|technical_lowest          |double    |technical_lowest          |
|technical_median          |double    |technical_median          |
|series_winner             |integer   |series_winner             |
|series_runner_up          |integer   |series_runner_up          |
|total_episodes_appeared   |double    |total_episodes_appeared   |
|first_date_appeared       |double    |first_date_appeared       |
|last_date_appeared        |double    |last_date_appeared        |
|first_date_us             |double    |first_date_us             |
|last_date_us              |double    |last_date_us              |
|percent_episodes_appeared |double    |percent_episodes_appeared |
|percent_technical_top3    |double    |percent_technical_top3    |
|baker_full                |character |baker_full                |
|age                       |double    |age                       |
|occupation                |character |occupation                |
|hometown                  |character |hometown                  |
|baker_last                |character |baker_last                |
|baker_first               |character |baker_first               |

# ratings


|variable             |class     |description          |
|:--------------------|:---------|:--------------------|
|series               |double    |series               |
|episode              |double    |episode              |
|uk_airdate           |double    |uk_airdate           |
|viewers_7day         |double    |viewers_7day         |
|viewers_28day        |double    |viewers_28day        |
|network_rank         |double    |network_rank         |
|channels_rank        |double    |channels_rank        |
|bbc_iplayer_requests |double    |bbc_iplayer_requests |
|episode_count        |double    |episode_count        |
|us_season            |double    |us_season            |
|us_airdate           |character |us_airdate           |

# episodes


|variable          |class     |description       |
|:-----------------|:---------|:-----------------|
|series            |double    |series            |
|episode           |double    |episode           |
|bakers_appeared   |integer   |bakers_appeared   |
|bakers_out        |integer   |bakers_out        |
|bakers_remaining  |integer   |bakers_remaining  |
|star_bakers       |integer   |star_bakers       |
|technical_winners |integer   |technical_winners |
|sb_name           |character |sb_name           |
|winner_name       |character |winner_name       |
|eliminated        |character |eliminated        |

### Cleaning Script

