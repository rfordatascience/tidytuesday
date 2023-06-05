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

![Paralympic logo which consists of 3 non-overlapping curved stripes colored red, blue, and green](https://www.paralympic.org/sites/default/files/styles/large_original/public/2019-10/IPC%20NEW%20EMBLEM.JPG?itok=_FSJbb6Q)

# Paralympics

The data this week comes from the [International Paralympic Committee](https://db.ipc-services.org/sdms/hira/web/index).

Data webscraped for the games of 1980 - 2016 for the athletes for all of their listed sports. There are additional summary-level datasets for medals by country/sport etc that are also available on the site.

Per [Wikipedia](https://en.wikipedia.org/wiki/Paralympic_Games) 

> The Paralympic Games or Paralympics are a periodic series of international multi-sport events involving athletes with a range of disabilities, including impaired muscle power (e.g. paraplegia and quadriplegia, muscular dystrophy, post-polio syndrome, spina bifida), impaired passive range of movement, limb deficiency (e.g. amputation or dysmelia), leg length difference, short stature, hypertonia, ataxia, athetosis, vision impairment and intellectual impairment. There are Winter and Summer Paralympic Games, which since the 1988 Summer Olympics in Seoul, South Korea, are held almost immediately following the respective Olympic Games.

Article - [1964 to 1988 — It was all about Zipora Rubin-Rosenbaum's dominance](https://www.paralympic.org/feature/1964-1988-it-was-all-about-zipora-rubin-rosenbaum-s-dominance)

Paralympic categories [article](https://www.paralympic.org/athletics/classification).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-08-03')
tuesdata <- tidytuesdayR::tt_load(2021, week = 32)

athletes <- tuesdata$athletes

# Or read in the data manually

athletes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-08-03/athletes.csv')

```
### Data Dictionary

# `athletes.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|gender   |character | Binary gender |
|event    |character | Event name |
|medal    |character | Medal type |
|athlete  |character | Athlete name (LAST NAME first name|
|abb      |character | Country abbreviation |
|country  |character | Country name |
|grp_id   |integer   | Group ID as a count within team sports |
|type     |character | Type of sport |
|year     |double    | year of games |
|guide    |character | Guide (for vision impaired athletes) |
|pilot    |character | Pilot (for vision impaired athletes) |

### Cleaning Script

```{r}
library(tidyverse)
library(rvest)

core_url <- "https://db.ipc-services.org/sdms/hira/web/competition/code/PG2016/sport/AR"

"body > div.container.bg-white.border.border-header.border-top-0.pb-3 > table > tbody > tr:nth-child(1) > td:nth-child(7) > div > a"

raw_html <- "https://db.ipc-services.org/sdms/hira/web/competition/code/PG2016" %>% 
  read_html()


# Archery -----------------------------------------------------------------


clean_arrow <- function(year){
  
  arrows <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/AR") %>% 
    read_html()
  
  raw_arrow <- arrows %>% 
    html_table() %>% 
    .[[2]] %>% 
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>% 
    rename(event = Event) %>% 
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    )
  
  ind_arrow <- raw_arrow %>% 
    separate(athlete, into = c("athlete", "abb"), sep = " \\(") %>% 
    separate(event, into = c("gender", "event"), sep = "'s | ", fill = "left", extra = "merge") %>% 
    mutate(abb = str_remove(abb, "\\)")) %>% 
    filter(str_detect(event, "Mixed|Team", negate = TRUE)) 
  
  team_arrow <- raw_arrow %>% 
    filter(str_detect(event, "Mixed|Team")) %>% 
    separate(athlete, into = c("country", "abb"), sep = " \\(") %>% 
    separate(abb, into = c("abb", "athlete"), sep = "\\)") %>% 
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>%
    separate_rows(athlete, sep = "(?<=[a-z])(?=[A-Z])") %>% 
    group_by(event, medal, abb) %>% 
    mutate(grp_id = row_number()) %>% 
    ungroup()
  
  bind_rows(ind_arrow, team_arrow) %>% 
    mutate(type = "Archery", year = year) 
}

clean_arrow(2008) %>% 
  print(n = 100)

year_vec <- seq(1980, 2016, by = 4)

try_arrow <- safely(clean_arrow)

all_arrow <- year_vec %>% 
  map(try_arrow) 

arrow_years <- all_arrow %>% 
  map_dfr("result")

# athletics ---------------------------------------------------------------

sport_vec <- raw_html %>% 
  html_nodes("td:nth-child(7) > div > a") %>% 
  html_attr("href") %>% 
  str_remove("/sdms/hira/web/competition/code/PG2016/sport/")


clean_ath <- function(year){
  
  ath <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/AT") %>% 
    read_html()
  
  raw_ath <- ath %>% 
    html_table() %>% 
    .[[2]] %>% 
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>% 
    rename(event = Event) %>% 
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>% 
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge")
  
  raw_ind <- raw_ath %>% 
    filter(str_detect(event, "4x", negate = TRUE)) %>% 
    separate(athlete, into = c("athlete", "abb"), sep = " \\(", fill = "left", extra = "merge") %>% 
    separate(abb, into = c("abb", "guide"), sep = "\\)") %>% 
    mutate(guide = str_remove(guide, "Guide: "),
           guide = if_else(guide == "", NA_character_, guide)) %>% 
    filter(!is.na(athlete)) 
  
  clean_ind <- raw_ind %>% 
    add_row(
      raw_ind %>% 
        filter(str_detect(guide, "\\(")) %>% 
        select(gender:medal, athlete = guide) %>% 
        separate(athlete, c("athlete", "abb"), sep = " \\(")
    ) %>% 
    filter(!is.na(athlete)) %>% 
    mutate(guide = if_else(str_detect(guide, "\\("), NA_character_, guide)) 
  
  
  clean_grp <- raw_ath %>% 
    filter(str_detect(event, "4x")) %>% 
    separate(athlete, into = c("country", "abb", "athlete"), sep = " \\(|\\)") %>% 
    separate_rows(athlete, sep = "(?<=[a-z])(?=[A-Z])") %>% 
    separate_rows(athlete, sep = "(?<=[A-Z]\\.)(?=[A-Z])") %>% 
    mutate(
      guide = if_else(
        str_detect(lead(athlete), "Guide"), 
        lead(athlete),
        NA_character_
      )
    ) %>% 
    filter(str_detect(athlete, "Guide", negate = TRUE)) %>%
    group_by(event, medal, country) %>% 
    mutate(grp_id = row_number()) %>% 
    ungroup()
  
  bind_rows(clean_ind, clean_grp) %>% 
    mutate(type = "Athletics", year = year)
  
}

test_df <- clean_ath(1980) 
test_df %>% 
  filter(str_detect(event, "4x60")) %>% 
  print(n = 100)

safe_ath <- safely(clean_ath)

ath_years <- year_vec %>% 
  map(safe_ath) %>% 
  map_dfr("result")

# Cycling -----------------------------------------------------------------

clean_cycle <- function(year){
  
  url_c <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/CY") %>% 
    read_html()
  
  raw_cycle <- url_c %>% 
    html_table() %>% 
    .[[2]] %>% 
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>% 
    rename(event = Event) %>% 
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>% 
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge")
  
  raw_ind_c <- raw_cycle %>% 
    filter(str_detect(event, "Team|Tandem", negate = TRUE)) %>% 
    separate(athlete, into = c("athlete", "abb"), sep = " \\(", fill = "left", extra = "merge") %>% 
    separate(abb, into = c("abb", "pilot"), sep = "Pilot: |\\(PT\\):") %>% 
    separate(athlete, sep = "(?<=[PT\\)])(?=[A-Z])", into = c("athlete", "pilot")) %>%
    separate(athlete, sep = "(?<=[a-z]+)(?=[A-Z])", into = c("athlete", "pilot")) %>%
    mutate(pilot = if_else(pilot == "", NA_character_, pilot)) %>% 
    filter(!is.na(athlete)) 
  
  clean_ind_c <- raw_ind_c %>% 
    add_row(
      raw_ind_c %>% 
        filter(str_detect(pilot, "\\(")) %>% 
        select(gender:medal, athlete = pilot) %>% 
        separate(athlete, c("athlete", "abb"), sep = " \\(")
    ) %>% 
    filter(!is.na(athlete)) %>% 
    mutate(pilot = if_else(str_detect(pilot, "\\("), NA_character_, pilot)) %>% 
    mutate(abb = str_remove(abb, "\\)"))
  
  
  clean_grp_c <- raw_cycle %>% 
    filter(str_detect(event, "Team")) %>% 
    separate(athlete, into = c("country", "abb", "athlete"), sep = " \\(|\\)") %>% 
    separate_rows(athlete, sep = "(?<=[a-z])(?=[A-Z])") %>% 
    mutate(
      guide = if_else(
        str_detect(lead(athlete), "Pilot|PT\\)"), 
        lead(athlete),
        NA_character_
      )
    ) %>% 
    filter(str_detect(athlete, "Pilot|PT\\)", negate = TRUE)) %>%
    group_by(event, medal, country) %>% 
    mutate(grp_id = row_number()) %>% 
    ungroup()
  
  bind_rows(clean_ind_c, clean_grp_c) %>% 
    mutate(year = year, type = "Cycling") %>% 
    rename(guide = pilot)
  
}

safe_cycle <- safely(clean_cycle)

cycle_years <- year_vec %>% 
  map(safe_cycle) %>% 
  map_dfr("result")


# Powerlifting ------------------------------------------------------------


clean_power <- function(year){
  
  raw_power <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/PO") %>% 
    read_html()
  
  clean_pwr <- raw_power %>% 
    html_table() %>% 
    .[[2]] %>% 
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>% 
    rename(event = Event) %>% 
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>% 
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>% 
    separate(athlete, into = c("athlete", "abb"), sep = " \\(", fill = "left", extra = "merge") %>% 
    separate_rows(abb, sep = " \\)") 
  
  clean_abb_power <- clean_pwr %>%
    mutate(abb = str_remove(abb, "\\)")) %>%
    bind_rows(clean_pwr %>%
                filter(str_detect(abb, "\\(")) %>%
                separate_rows(abb, sep = "\\(") %>%
                mutate(athlete = ifelse(str_length(abb) <= 4, lag(abb), athlete)) %>%
                mutate(
                  abb = str_remove(abb, "\\).*"),
                  athlete = str_remove(athlete, ">*\\)") %>% str_trim()
                )) %>%
    filter(str_detect(abb, "\\(", negate = TRUE), !is.na(athlete)) %>% 
    mutate(abb = str_remove(abb, "\\)"))
  
  
  clean_abb_power %>% 
    mutate(year = year, type = "Powerlifting")
}

clean_power(1984)

safe_power <- safely(clean_power)

power_years <- year_vec %>% 
  map(safe_power) %>% 
  map_dfr("result")


# Swimming ----------------------------------------------------------------

clean_swim <- function(year){
  
  raw_swim <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/SW") %>%
  read_html()

raw_ind_sw <- raw_swim %>%
  html_table() %>%
  .[[2]] %>%
  pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>%
  rename(event = Event) %>%
  mutate(
    medal = str_remove(medal, " Medallist\\(s\\)")
  ) %>%
  filter(str_detect(event, "4x", negate = TRUE)) %>%
  separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>% 
  separate_rows(athlete, sep = "(?<=[A-Z]\\))(?=[A-Z])") %>%
  separate(athlete, into = c("athlete", "abb"), sep = " \\(", fill = "left", extra = "merge")


clean_ind_sw <- raw_ind_sw %>%
  mutate(abb = str_remove(abb, "\\)")) %>%
  bind_rows(raw_ind_sw %>%
    filter(str_detect(abb, "\\(")) %>%
    separate_rows(abb, sep = "\\(") %>%
    mutate(athlete = ifelse(str_length(abb) <= 4, lag(abb), athlete)) %>%
    mutate(
      abb = str_remove(abb, "\\).*"),
      athlete = str_remove(athlete, ">*\\)") %>% str_trim()
    )) %>%
    filter(str_detect(abb, "\\(", negate = TRUE), !is.na(athlete))


clean_grp_sw <- raw_swim %>%
  html_table() %>%
  .[[2]] %>%
  pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>%
  rename(event = Event) %>%
  mutate(
    medal = str_remove(medal, " Medallist\\(s\\)")
  ) %>%
  filter(str_detect(event, "4x")) %>%
  separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>%
  separate(athlete, into = c("country", "abb", "athlete"), sep = " \\(|\\)") %>%
  separate_rows(athlete, sep = "(?<=[a-z])(?=[A-Z])") %>%
  group_by(event, medal, country) %>%
  mutate(grp_id = row_number()) %>%
  ungroup()

bind_rows(clean_ind_sw, clean_grp_sw) %>% 
  mutate(year = year, type = "Swimming") 

  }

safe_swim <- safely(clean_swim)

swim_years <- year_vec %>% 
  map(safe_swim) %>% 
  map_dfr("result")



# Table Tennis ------------------------------------------------------------

clean_tab_tennis <- function(year){
  
  raw_tab <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/TT") %>%
    read_html()
  
  clean_ind_tab <- raw_tab %>%
    html_table() %>%
    .[[2]] %>%
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>%
    rename(event = Event) %>%
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>%
    filter(str_detect(event, "Team", negate = TRUE)) %>%
    separate(
      event,
      into = c("gender", "event"),
      sep = " |'s ",
      fill = "left",
      extra = "merge"
    ) %>%
    separate_rows(athlete, sep = "(?<=[\\)])(?=[A-Z])") %>%
    separate(
      athlete,
      into = c("athlete", "abb"),
      sep = " \\(",
      fill = "left",
      extra = "merge"
    ) %>%
    mutate(abb = str_remove(abb, "\\)"))
  
  
  clean_grp_tab <- raw_tab %>%
    html_table() %>%
    .[[2]] %>%
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>%
    rename(event = Event) %>%
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>%
    filter(str_detect(event, "Team")) %>%
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>%
    separate(athlete, into = c("country", "abb", "athlete"), sep = " \\(|\\)") %>%
    separate_rows(athlete, sep = "(?<=[a-z])(?=[A-Z])") %>%
    separate_rows(athlete, sep = "(?<=[A-Z]\\.)(?=[A-Z])") %>% 
    group_by(event, medal, country) %>%
    mutate(grp_id = row_number()) %>%
    ungroup()
  
  bind_rows(clean_ind_tab, clean_grp_tab) %>% 
    mutate(year = year, type = "Table Tennis") 
  
}

safe_table <- safely(clean_tab_tennis)

table_years <- year_vec %>% 
  map(safe_table) %>% 
  map_dfr("result")

check_fun(table_years)

# Volleyball --------------------------------------------------------------



clean_volleyball <- function(year){
  
  raw_vb <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/VO") %>%
    read_html()
  
  clean_grp_vb <- raw_vb %>%
    html_table() %>%
    .[[2]] %>%
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>%
    rename(event = Event) %>%
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>%
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>%
    separate(athlete, into = c("country", "abb", "athlete"), sep = " \\(|\\)") %>%
    separate_rows(athlete, sep = "(?<=[a-z])(?=[A-Z])") %>%
    separate_rows(athlete, sep = "(?<=[A-Z]\\.)(?=[A-Z])") %>% 
    group_by(event, medal, country) %>%
    mutate(grp_id = row_number()) %>%
    ungroup()
  
  clean_grp_vb %>% 
    mutate(year = year, type = "Volleyball")
  
}

safe_vb <- safely(clean_volleyball)

vb_years <- year_vec %>% 
  map(safe_vb) %>% 
  map_dfr("result")

check_fun(vb_years)

# Basketball --------------------------------------------------------------

clean_basketball <- function(year){
  
  raw_bb <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/WB") %>%
    read_html()
  
  clean_grp_bb <- raw_bb %>%
    html_table() %>%
    .[[2]] %>%
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>%
    rename(event = Event) %>%
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>%
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>%
    separate(athlete, into = c("country", "abb", "athlete"), sep = " \\(|\\)") %>%
    separate_rows(athlete, sep = "(?<=[a-z])(?=[A-Z])") %>%
    group_by(event, medal, country) %>%
    mutate(grp_id = row_number()) %>%
    ungroup()
  
  clean_grp_bb %>% 
    mutate(year = year, type = "Basketball")
  
}

safe_bb <- safely(clean_basketball)

bb_years <- year_vec %>% 
  map(safe_bb) %>% 
  map_dfr("result")

check_fun(bb_years)

# Fencing -----------------------------------------------------------------

clean_fencing <- function(year){
  
  raw_f <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/WF") %>%
    read_html()
  
  clean_ind_f <- raw_f %>%
    html_table() %>%
    .[[2]] %>%
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>%
    rename(event = Event) %>%
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>%
    filter(str_detect(event, "Team", negate = TRUE)) %>%
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>%
    separate(athlete, into = c("athlete", "abb"), sep = " \\(", fill = "left", extra = "merge") %>% 
    mutate(abb = str_remove(abb, "\\)"))
  
  clean_grp_f <- raw_f %>%
    html_table() %>%
    .[[2]] %>%
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>%
    rename(event = Event) %>%
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>%
    filter(str_detect(event, "Team")) %>%
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>%
    separate(athlete, into = c("country", "abb", "athlete"), sep = " \\(|\\)") %>%
    separate_rows(athlete, sep = "(?<=[a-z])(?=[A-Z])") %>%
    separate_rows(athlete, sep = "(?<=[A-Z]\\.)(?=[A-Z])") %>% 
    group_by(event, medal, country) %>%
    mutate(grp_id = row_number()) %>%
    ungroup()
  
  bind_rows(clean_ind_f, clean_grp_f) %>% 
    mutate(year = year, type = "Fencing")
  
}
  
safe_fence <- safely(clean_fencing)

fence_years <- year_vec %>% 
  map(safe_fence) %>% 
  map_dfr("result")

check_fun(fence_years)


# Rugby -------------------------------------------------------------------

clean_rugby <- function(year){
  
  raw_rug <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/WR") %>%
    read_html()
  
  clean_grp_rug <- raw_rug %>%
    html_table() %>%
    .[[2]] %>%
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>%
    rename(event = Event) %>%
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)"),
      event = paste(event, "Wheelchair Rugby")
    ) %>%
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>%
    separate(athlete, into = c("country", "abb", "athlete"), sep = " \\(|\\)") %>%
    separate_rows(athlete, sep = "(?<=[a-z])(?=[A-Z])") %>%
    separate_rows(athlete, sep = "(?<=[A-Z]\\.)(?=[A-Z])") %>% 
    group_by(event, medal, country) %>%
    mutate(grp_id = row_number()) %>% 
    ungroup()
  
  clean_grp_rug %>% 
    mutate(year = year, type = "Rugby")
  
}

safe_rugby <- safely(clean_rugby)

rugby_years <- year_vec %>% 
  map(safe_rugby) %>% 
  map_dfr("result")

check_fun(rugby_years)


# Tennis ------------------------------------------------------------------

clean_tennis <- function(year){
  
  raw_ten <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/TT") %>%
    read_html()
  
  clean_ind_ten <- raw_ten %>%
    html_table() %>%
    .[[2]] %>%
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>%
    rename(event = Event) %>%
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>%
    filter(str_detect(event, "Double|Team", negate = TRUE)) %>%
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>%
    separate_rows(athlete, sep = "(?<=[\\)])(?=[A-Z])") %>%
    separate(athlete, into = c("athlete", "abb"), sep = " \\(", fill = "left", extra = "merge") %>% 
    mutate(abb = str_remove(abb, "\\)"))
  
  
  clean_grp_ten <- raw_ten %>%
    html_table() %>%
    .[[2]] %>%
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>%
    rename(event = Event) %>%
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>%
    filter(str_detect(event, "Double|Team")) %>%
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge") %>%
    separate(athlete, into = c("country", "abb", "athlete"), sep = " \\(|\\)") %>%
    separate_rows(athlete, sep = "(?<=[a-z])(?=[A-Z])") %>%
    group_by(event, medal, country) %>%
    mutate(grp_id = row_number()) %>%
    ungroup()
  
  bind_rows(clean_ind_ten, clean_grp_ten) %>% 
    mutate(year = year, type = "Wheelchair Tennis")
  
}

safe_tennis <- safely(clean_tennis)

tennis_years <- year_vec %>% 
  map(safe_tennis) %>% 
  map_dfr("result")

check_fun(tennis_years)

# Triathlon ---------------------------------------------------------------

clean_triathlon <- function(year){
  
  tri_url <- glue::glue("https://db.ipc-services.org/sdms/hira/web/competition/code/PG{year}/sport/TR") %>% 
    read_html()
  
  raw_tri <- tri_url %>% 
    html_table() %>% 
    .[[2]] %>% 
    pivot_longer(names_to = "medal", values_to = "athlete", cols = -Event) %>% 
    rename(event = Event) %>% 
    mutate(
      medal = str_remove(medal, " Medallist\\(s\\)")
    ) %>% 
    separate(event, into = c("gender", "event"), sep = " |'s ", fill = "left", extra = "merge")
  
  raw_ind_tri <- raw_tri %>% 
    filter(str_detect(event, "4x", negate = TRUE)) %>% 
    separate(athlete, into = c("athlete", "abb"), sep = " \\(", fill = "left", extra = "merge") %>% 
    separate(abb, into = c("abb", "guide"), sep = "\\)") %>% 
    mutate(guide = str_remove(guide, "Guide: "),
           guide = if_else(guide == "", NA_character_, guide)) %>% 
    filter(!is.na(athlete)) 
  
  clean_ind_tri <- raw_ind_tri %>% 
    add_row(
      raw_ind_tri %>% 
        filter(str_detect(guide, "\\(")) %>% 
        select(gender:medal, athlete = guide) %>% 
        separate(athlete, c("athlete", "abb"), sep = " \\(")
    ) %>% 
    filter(!is.na(athlete)) %>% 
    mutate(guide = if_else(str_detect(guide, "\\("), NA_character_, guide)) %>% 
    mutate(year = year, type = "Triathlon")
  
  
  clean_ind_tri
}

safe_tri <- safely(clean_triathlon)

tri_years <- year_vec %>% 
  map(safe_tri) %>% 
  map_dfr("result")

check_fun(tri_years)

all_sports <- bind_rows(
  list(arrow_years, ath_years, bb_years, cycle_years, fence_years, power_years,
       rugby_years, swim_years, table_years, tennis_years, tri_years, vb_years)
)

all_sports %>% 
  skimr::skim()

all_sports %>% 
  write_csv("2021/2021-08-03/athletes.csv")

check_fun(all_sports)

check_abb <- function(df_in) {
df_in %>% 
    filter(str_length(abb) > 3) %>% 
    select(athlete, abb, type, year)
  
}

all_sports %>% check_abb() %>% distinct(type, year)

```
