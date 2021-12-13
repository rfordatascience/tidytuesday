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

# Spice Up Your Life!  <img src="https://raw.githubusercontent.com/jacquietran/spice_girls_data/main/mcdspwo_ec013-2000_cropped.jpg" align="right" height="200" alt ='Spice girls ensemble. It is the 5 spice girls against a blue circle background'/>

The data in this repo comes from [Spotify](https://www.spotify.com) and [Genius](https://www.genius.com). Thank you to the authors of the `spotifyr` and `geniusr` packages for making it easy to access data from these platforms!

There are 3 data sets about or related to the Spice Girls:

- `studio_album_tracks`: Audio features of each song from the three studio albums by the Spice Girls. From Spotify.
- `related artists`:  Artists deemed to be similar to the Spice Girls, with info about each artist including their musical genres and follower numbers. Includes a row with details for the Spice Girls, for comparison purposes. From Spotify.
- `lyrics`: Lyrics of each song from the three studio albums by the Spice Girls. From Genius.

Credit: [Jacquie Tran](https://www.twitter.com/jacquietran)

## Data dictionaries

A data dictionary for each data set is provided [here](https://github.com/jacquietran/spice_girls_data/blob/main/data_dictionaries.md).

## Example use

The R code below uses the `studio_album_tracks` data set to produce summary statistics for selected audio features.

```{r, message = FALSE}

# Load libraries
library(dplyr)

# Read data into R
studio_album_tracks <- readr::read_csv("https://github.com/jacquietran/spice_girls_data/raw/main/data/studio_album_tracks.csv")

# For each album, calculate mean values for danceability, energy, and valence
studio_album_tracks %>%
  group_by(album_name) %>%
  summarise(
    danceability_mean = mean(danceability),
    energy_mean = mean(energy),
    valence_mean = mean(valence)) %>%
  ungroup() %>%
  # Set factor levels of album_name
  mutate(
    album_name = factor(
      album_name, levels = c("Spice", "Spiceworld", "Forever"))) %>%
  arrange(album_name)

```


## Useful packages

- `spotifyr`: https://www.rcharlie.com/spotifyr/index.html
- `geniusr`: https://ewenme.github.io/geniusr/

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-12-14')
tuesdata <- tidytuesdayR::tt_load(2021, week = 51)

studio_album_tracks <- tuesdata$studio_album_tracks

# Or read in the data manually

studio_album_tracks <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-12-14/studio_album_tracks.csv')

```
### Data Dictionary

# `lyrics.csv`

|variable       |class     |description |
|:--------------|:---------|:-----------|
|artist_name    |character | Artist name |
|album_name     |character | Album name |
|track_number   |double    | Track number |
|song_id        |double    | Song ID |
|song_name      |character |Song Name    |
|line_number    |double    | Line Number  |
|section_name   |character | Section name  |
|line           |character | Line|
|section_artist |character |Section artist|

# `related_artists.csv`

|variable        |class     |description |
|:---------------|:---------|:-----------|
|artist_id       |character | Artist ID |
|artist_name     |character | Artist name  |
|genres          |character | Genres |
|popularity      |double    | Popularity    |
|followers_total |double    | Followers total |

# `studio_album_tracks.csv`

|variable           |class     |description |
|:------------------|:---------|:-----------|
|artist_name        |character |Artist name|
|artist_id          |character | Artist ID  |
|album_id           |character | Album ID   |
|album_release_date |double    | Release date  |
|album_release_year |double    | Year |
|danceability       |double    | Danceability        |
|energy             |double    | Energy |
|key                |double    | Key    |
|loudness           |double    | Loudness        |
|mode               |double    | Mode   |
|speechiness        |double    |Speechiness       |
|acousticness       |double    | Acousticness  |
|instrumentalness   |double    | Instrumentalness|
|liveness           |double    | Liveness |
|valence            |double    | Valence    |
|tempo              |double    | Tempo    |
|track_id           |character | Track ID      |
|time_signature     |double    | Time signature   |
|duration_ms        |double    | Duration in ms  |
|track_name         |character |track name|
|track_number       |double    | Track  number    |
|album_name         |character | Album name  |
|key_name           |character | Key name  |
|mode_name          |character | Mode name   |
|key_mode           |character | Key mode  |

### Cleaning Script

See: [Jacquie Tran's repo](https://github.com/jacquietran/spice_girls_data)