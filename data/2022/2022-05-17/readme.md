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

# Eurovision

The data this week comes from [Eurovision](https://eurovision.tv/). Hattip to [Tanya Shapiro](https://github.com/tashapiro/eurovision-contest/blob/main/code/eurovision_scraping.R#L97-L98) and [Bob Rudis](https://twitter.com/hrbrmstr/status/1526299494811422721?s=20&t=1ShDVK93h06QEmNZvGmK0Q) for sharing some methods to cleaning/scraping this data.

The country to country voting data comes from [Data.World](https://data.world/datagraver/eurovision-song-contest-scores-1975-2019)

Credit to [Tanya Shapiro](https://github.com/tashapiro/eurovision-contest) for the below readme content. 

> # Eurovision Contest &nbsp; :microphone:
The following project uses data from the [Eurovision Song Contest site](https://eurovision.tv/). Data was scraped using R and packages such as **rvest** and **jsonlite**. The resulting dataset represents information for all contestants for each year and by round (e.g. semi-final, final). It is important to note that changes in scoring system have occured through different points in time, e.g. semi-final rounds were not introduced until 2005.

> ## About

> Excerpt taken from [Wikipedia](https://en.wikipedia.org/wiki/Eurovision_Song_Contest):

>The Eurovision Song Contest (French: Concours Eurovision de la chanson), sometimes abbreviated to ESC and often known simply as Eurovision, is an international songwriting competition organised annually by the European Broadcasting Union (EBU), featuring participants representing primarily European countries. Each participating country submits an original song to be performed on live television and radio, transmitted to national broadcasters via the EBU's Eurovision and Euroradio networks, with competing countries then casting votes for the other countries' songs to determine a winner.

>Based on the Sanremo Music Festival held in Italy since 1951, Eurovision has been held annually since 1956 (apart from 2020), making it the longest-running annual international televised music competition and one of the world's longest-running television programmes. Active members of the EBU, as well as invited associate members, are eligible to compete, and as of 2022, 52 countries have participated at least once. Each participating broadcaster sends one original song of three minutes duration or less to be performed live by a singer or group of up to six people aged 16 or older. Each country awards two sets of 1–8, 10 and 12 points to their favourite songs, based on the views of an assembled group of music professionals and the country's viewing public, with the song receiving the most points declared the winner. Other performances feature alongside the competition, including a specially-commissioned opening and interval act and guest performances by musicians and other personalities, with past acts including Cirque du Soleil, Madonna and the first performance of Riverdance. Originally consisting of a single evening event, the contest has expanded as new countries joined (including countries outside of Europe, such as Australia), leading to the introduction of relegation procedures in the 1990s, and eventually the creation of semi-finals in the 2000s. As of 2022, Germany has competed more times than any other country, having participated in all but one edition, while Ireland holds the record for the most victories, with seven wins in total.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-05-17')
tuesdata <- tidytuesdayR::tt_load(2022, week = 20)

eurovision <- tuesdata$eurovision

# Or read in the data manually

eurovision <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-17/eurovision.csv')

```
### Data Dictionary

# `eurovision.csv`

|variable       |class     | Description                                          |
|:--------------|:---------| :--------- |
|event          |character | Event Name, e.g. Helsinki 2007                       |
|host_city      |character | Host city name, e.g. Helsinki                        |
|year           |integer   | Event year, e.g. 2007                                |
|host_country   |character | Host city country, e.g. Finland                      |
|event_url      |character | Link to event                                        |
|section        |character | Final, semi-final, first semi final, second-semi-final |
|artist         |character | Name of performer/participant                        |
|song           |character | Song title name                                      |
|artist_url     |character | Link to participant bio                              |
|image_url      |character | Link to participant image |
|artist_country |character | Participant country, e.g. Austria                    |
|country_emoji  |character | Emoji code for Country |
|running_order  |integer   | Running order for the teams |
|total_points   |integer   | Points                                               |
|rank           |integer   | Numeric rank, e.g. 2                                 |
|rank_ordinal   |character | Ordinal rank, e.g. 2nd                               |
|qualified      |logical   | Is the team qualified |
|winner         |logical   | Was this team the grand champion |

### `eurovision-votes.csv`

|variable           |class     |description |
|:------------------|:---------|:-----------|
|year               |double    | Year |
|semi_final         |character | Semi-final or final           |
|edition            |character | Which edition |
|jury_or_televoting |character | Jury or televoting |
|from_country       |character | Country that voted |
|to_country         |character | Country receiving votes |
|points             |double    | Points |
|duplicate          |character | Duplicate    |

### Cleaning Script

``` r
library(rvest)
library(tidyverse)
library(countrycode)
library(stringi)
library(V8)

# credit to Tanya Shapiro that was adapted for the URLs for each year
# Web Scraping Events by Year ----
url_events <- "https://eurovision.tv/events"

events <- url_events %>%
  read_html() %>%
  html_elements("div.relative") %>%
  html_elements("h4") %>%
  html_text() %>%
  str_squish()

event_links <- url_events %>%
  read_html() %>%
  html_elements("div.w-full") %>%
  html_elements("a.absolute") %>%
  html_attr("href")

countries <- url_events %>%
  read_html() %>%
  html_elements("div.relative") %>%
  html_elements("span.px-4") %>%
  html_text() %>%
  str_squish()

countries <- countries[-3]

by_year <- tibble(
  event = events,
  host_city = events,
  host_country = countries,
  url = event_links
) %>%
  separate(host_city, c("host_city", "year"), sep = " (?=[0-9])") %>%
  mutate(year = as.integer(year))

by_year



# Get Eurovision ----------------------------------------------------------
# credit to bob rudis for initial script that was adapted
get_euro <- function(url, section) {
  cli::cli_alert_info("{url} at {section}\n")

  ctx <- v8()

  pg <- read_html(paste0(url, "/", section))

  html_nodes(pg, xpath = ".//table[contains(@x-data, 'JSON')]") |>
    html_attr("x-data") |>
    stri_replace_first_regex("^table\\(", "var tbl = ") |>
    stri_replace_last_regex("\\)$", "") |>
    ctx$eval()

  ctx$get("tbl") |>
    tibble::as_tibble()
}

get_euro("https://eurovision.tv/event/rotterdam-2021", "second-semi-final")
# https://eurovision.tv/event/rotterdam-2021/participants
# https://eurovision.tv/event/rotterdam-2021/first-semi-final
# https://eurovision.tv/event/rotterdam-2021/second-semi-final
# https://eurovision.tv/event/rotterdam-2021/grand-final


all_scores <- by_year |>
  mutate(section = case_when(
    year >= 2008 ~ list(c("first-semi-final", "second-semi-final", "grand-final")),
    between(year, 2004, 2007) ~ list(c("semi-final", "grand-final")),
    TRUE ~ list("final")
  )) |>
  unnest_longer(section) |>
  mutate(data = map2(url, section, ~ get_euro(.x, .y)))

all_scores_old <- all_scores

all_scores <- all_scores |>
  bind_rows(score_below_2000)

all_part <- all_scores |>
  rename(event_url = url) |>
  unchop(data) |>
  unnest_wider(data) |>
  unpack(participant) |>
  unpack(country)

clean_part <- all_part |>
  rename(
    artist = name,
    song = performance, artist_url = url, 
    artist_country = nickname, country_emoji = emoji
  )


clean_part |>
  count(year) |>
  arrange(desc(year)) |>
  ggplot(aes(x = year, y = n, group = 1)) +
  geom_line()

clean_part |>
  write_csv("2022/2022-05-17/eurovision.csv")
```
