# Canadian Hockey Player Birth Months

If you're a Canadian hockey player, happy birth month!
That's more likely to be correct this time of year than in the Fall!

The dataset this week comes from [Statistics Canada](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1310041501&pickMembers%5B0%5D=3.1&cubeTimeFrame.startYear=1991&cubeTimeFrame.endYear=2022&referencePeriods=19910101%2C20220101), the [NHL team list endpoint](https://api.nhle.com/stats/rest/en/team), and the [NHL API](https://api-web.nhle.com/v1/).
The dataset was inspired by the blog [Are Birth Dates Still Destiny for Canadian NHL Players?](https://jlaw.netlify.app/2023/12/04/are-birth-dates-still-destiny-for-canadian-nhl-players/) by JLaw (via [https://universeodon.com/@jlaw/111522860812359901](Mastodon))!

> In the first chapter [Malcolm Gladwell’s Outliers](https://www.amazon.com/Outliers-Story-Success-Malcolm-Gladwell/dp/0316017930) he discusses how in Canadian Junior Hockey there is a higher likelihood for players to be born in the first quarter of the year.

> Because these kids are older within their year they make all the important teams at a young age which gets them better resources for skill development and so on.

> While it seems clear that more players are born in the first few months of the year, what isn’t explored is whether or not this would be expected. Maybe more people in Canada in general are born earlier in the year.

> I will explore whether Gladwell’s result is expected as well as whether this is still true in today’s NHL for Canadian-born players.

Can you reproduce JLaw's results? What else can you find in the NHL player data?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-01-09')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 2)

canada_births_1991_2022 <- tuesdata$canada_births_1991_2022
nhl_player_births <- tuesdata$nhl_player_births
nhl_rosters <- tuesdata$nhl_rosters
nhl_teams <- tuesdata$nhl_teams

# Option 2: Read directly from GitHub

canada_births_1991_2022 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-09/canada_births_1991_2022.csv')
nhl_player_births <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-09/nhl_player_births.csv')
nhl_rosters <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-09/nhl_rosters.csv')
nhl_teams <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-09/nhl_teams.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `canada_births_1991_2022.csv`

|variable |class  |description |
|:--------|:------|:-----------|
|year     |integer|birth year|
|month    |integer|birth month|
|births   |integer|number of live births in Canada in that year and month|

# `nhl_player_births.csv`

|variable             |class     |description          |
|:--------------------|:---------|:--------------------|
|player_id            |double    |unique id of this player (note: 2 players are listed twice with slightly different data) |
|first_name           |character |first name |
|last_name            |character |last name |
|birth_date           |date      |birth date |
|birth_city           |character |birth city |
|birth_country        |character |3-letter code for the birth country |
|birth_state_province |character |birth state or province, if applicable |
|birth_year           |integer   |birth year |
|birth_month          |integer   |birth month |

# `nhl_rosters.csv`

|variable              |class     |description           |
|:---------------------|:---------|:---------------------|
|team_code             |character |unique 3-letter code for this team |
|season                |integer   |season, as YYYYYYYY |
|position_type         |character |"defensemen", "forwards", or "goalies" |
|player_id             |double    |unique id of this player |
|headshot              |character |headshot url for this player-season |
|first_name            |character |first name            |
|last_name             |character |last name             |
|sweater_number        |double    |sweater number        |
|position_code         |character |position code (C = center, D = defense, G = goal, L = left wing, R = right wing) |
|shoots_catches        |character |hand preferred by this player for shooting and catching (L, R, or NA) |
|height_in_inches      |integer   |height in inches at the start of this season |
|weight_in_pounds      |integer   |weight in pounds at the start of this season |
|height_in_centimeters |integer   |height in centimeters at the start of this season |
|weight_in_kilograms   |integer   |weight in kilograms at the start of this season |
|birth_date            |date      |birth date            |
|birth_city            |character |birth city            |
|birth_country         |character |3-letter code for the birth country |
|birth_state_province  |character |birth state or province, if applicable |

# `nhl_teams.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|team_code |character |unique 3-letter code for this team |
|full_name |character |full name of this team |


### Cleaning Script

``` r
library(tidyverse)
library(here)
library(janitor)
library(fs)
library(httr2)
library(withr)

working_dir <- here::here("data", "2024", "2024-01-09")

teams <- httr2::request("https://api.nhle.com/stats/rest/en/team") |> 
  httr2::req_perform() |> 
  httr2::resp_body_json() |> 
  _$data |> 
  tibble::tibble(data = _) |> 
  tidyr::unnest_wider(data) |> 
  janitor::clean_names() |> 
  dplyr::select(team_code = tri_code, full_name)
  
rosters <- teams |> 
  dplyr::pull(team_code) |> 
  purrr::map(\(team_code) {
    seasons <- glue::glue("https://api-web.nhle.com/v1/roster-season/{team_code}") |> 
      httr2::request() |> 
      httr2::req_perform() |> 
      httr2::resp_body_json() |> 
      unlist()
    purrr::map(
      seasons,
      \(season) {
        season_roster <- glue::glue("https://api-web.nhle.com/v1/roster/{team_code}/{season}") |>
          httr2::request() |>
          httr2::req_perform() |>
          httr2::resp_body_json() |>
          tibble::enframe(name = "position_type") |> 
          tidyr::unnest_longer(value)
        if (nrow(season_roster)) {
          season_roster |> 
            tidyr::unnest_wider(value) |> 
            janitor::clean_names() |> 
            dplyr::rename(player_id = id) |> 
            tidyr::hoist("first_name", first_name = "default", .remove = FALSE) |> 
            tidyr::hoist("last_name", last_name = "default", .remove = FALSE) |> 
            tidyr::hoist("birth_city", birth_city = 1, .remove = FALSE) |> 
            tidyr::hoist("birth_state_province", birth_state_province = 1, .remove = FALSE) |>
            dplyr::mutate(
              team_code = team_code,
              season = season,
              .before = 1
            )
        } else {
          NULL
        }
      }
    ) |> 
      purrr::list_rbind()
  }) |> 
  purrr::list_rbind()

player_births <- rosters |> 
  dplyr::distinct(
    player_id,
    first_name,
    last_name,
    birth_date,
    birth_city,
    birth_country,
    birth_state_province
  ) |> 
  dplyr::mutate(
    birth_date = lubridate::ymd(birth_date),
    birth_year = lubridate::year(birth_date),
    birth_month = lubridate::month(birth_date)
  )

dl_path <- withr::local_tempfile(fileext = ".zip")

download.file(
  "https://www150.statcan.gc.ca/n1/tbl/csv/13100415-eng.zip",
  dl_path
)

canada_births <- readr::read_csv(dl_path) |> 
  janitor::clean_names() |> 
  dplyr::filter(
    !stringr::str_detect(month_of_birth, "Total"),
    characteristics == "Number of live births", 
    stringr::str_starts(geo, "Canada")
  ) |> 
  dplyr::mutate(
    year = as.integer(ref_date),
    month = stringr::str_extract(month_of_birth, "Month of birth, (\\w+)", 1) |> 
      factor(levels = month.name) |> 
      as.integer(),
    births = as.integer(value),
    .keep = "none"
  )

readr::write_csv(
  canada_births,
  fs::path(working_dir, "canada_births_1991_2022.csv")
)
readr::write_csv(
  player_births,
  fs::path(working_dir, "nhl_player_births.csv")
)
readr::write_csv(
  rosters,
  fs::path(working_dir, "nhl_rosters.csv")
)
readr::write_csv(
  teams,
  fs::path(working_dir, "nhl_teams.csv")
)
```
