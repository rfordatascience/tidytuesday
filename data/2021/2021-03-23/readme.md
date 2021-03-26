![Logo for the United Nations](https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/UN_emblem_blue.svg/1205px-UN_emblem_blue.png)

# UN Votes

The data this week comes from [Harvard's Dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=hdl:1902.1/12379) by way of [Mine Çetinkaya-Rundel, David Robinson, and Nicholas Goguen-Compagnoni](https://github.com/dgrtwo/unvotes/blob/7eb7034314ff79c49c9e0785fcd9d216fa04cf14/DESCRIPTION#L6).

Original Data citation:  
> Citation: Erik Voeten "Data and Analyses of Voting in the UN General Assembly" Routledge Handbook of International Organization, edited by Bob Reinalda (published May 27, 2013). Available at SSRN: http://ssrn.com/abstract=2111149

The `{unvotes}` R package is on [CRAN](https://cran.r-project.org/web/packages/unvotes/unvotes.pdf)! [Github link](https://github.com/dgrtwo/unvotes)

This is a wrapper around the datasets, although I've included them as CSVs in the TidyTuesday repo.

Get package from CRAN:  

`install.packages("unvotes")`

[Mine Çetinkaya-Rundel wrote about the process of updating the package](http://www.citizen-statistician.org/2021/03/open-source-contribution-as-a-student-project/) on the Citizen Statistician blog.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-03-23')
tuesdata <- tidytuesdayR::tt_load(2021, week = 13)

unvotes <- tuesdata$unvotes

# Or read in the data manually

unvotes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/unvotes.csv')
roll_calls <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/roll_calls.csv')
issues <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/issues.csv')

```
### Data Dictionary

# `unvotes.csv`

|variable     |class     |description |
|:------------|:---------|:-----------|
|rcid         |double    | The roll call id; used to join with un_votes and un_roll_call_issues |
|country      |character | Country name, by official English short name |
|country_code |character | 2-character ISO country code |
|vote         |integer   | Vote result as a factor of yes/abstain/no |

# `roll_calls.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|rcid          |integer   |.           |
|session       |double    | Session number. The UN holds one session per year; these started in 1946|
|importantvote |integer   | Whether the vote was classified as important by the U.S. State Department report "Voting Practices in the United Nations". These classifications began with session 39|
|date          |double    | Date of the vote, as a Date vector|
|unres         |character | Resolution code |
|amend         |integer   | Whether the vote was on an amendment; coded only until 1985 |
|para          |integer   | Whether the vote was only on a paragraph and not a resolution; coded only until 1985|
|short         |character |  Short description |
|descr         |character | Longer description|

# `issues.csv`

|variable   |class     |description |
|:----------|:---------|:-----------|
|rcid       |integer   | The roll call id; used to join with unvotes and un_roll_calls |
|short_name |character | Two-letter issue codes |
|issue      |integer   | Descriptive issue name |

### Cleaning Script

The data cleaning can be found in the [data-raw](https://github.com/dgrtwo/unvotes/blob/master/data-raw/un-data.R) folder of the package.

```
library(dplyr)
library(readxl)
library(countrycode)
library(tidyr)
library(forcats)

vlevels <- c("yes", "abstain", "no")

load("data-raw/UNVotes2021.RData")

un_votes <- completeVotes %>%
  filter(vote <= 3) %>%
  mutate(
    country = countrycode(ccode, "cown", "country.name"),
    country_code = countrycode(ccode, "cown", "iso2c"),
    # Match based on old version of data from unvotes package
    country_code = case_when(
      country == "Czechoslovakia" ~ "CS",
      country == "Yugoslavia" ~ "YU",
      country == "German Democratic Republic" ~ "DD",
      country == "Yemen People's Republic" ~ "YD",
      TRUE ~ country_code
    ),
    country = if_else(!is.na(Countryname) & Countryname == "German Federal Republic", "Federal Republic of Germany", country)
  ) %>%
  select(rcid, country, country_code, vote) %>%
  mutate(vote = as.character(vote)) %>%
  mutate(vote = fct_recode(vote, yes = "1", abstain = "2", no = "3"))

descriptions <- completeVotes %>%
  select(session, rcid, abstain, yes, no, importantvote, date, unres, amend, para, short, descr, me, nu, di, hr, co, ec) %>%
  distinct(rcid, .keep_all = TRUE)

un_roll_calls <- descriptions %>%
  select(rcid, session, importantvote:descr) %>%
  mutate(rcid = as.integer(rcid),
         date = as.Date(date)) %>%
  arrange(rcid)

un_roll_call_issues <- descriptions %>%
  select(rcid, me:ec) %>%
  gather(short_name, value, me:ec) %>%
  mutate(rcid = as.integer(rcid),
         value = as.numeric(value)) %>%
  filter(value == 1) %>%
  select(-value) %>%
  mutate(issue = fct_recode(short_name,
                            "Palestinian conflict" = "me",
                            "Nuclear weapons and nuclear material" = "nu",
                            "Colonialism" = "co",
                            "Human rights" = "hr",
                            "Economic development" = "ec",
                            "Arms control and disarmament" = "di"))
```

See [Mine Çetinkaya-Rundel who wrote about the process of updating the package](http://www.citizen-statistician.org/2021/03/open-source-contribution-as-a-student-project/) on the Citizen Statistician blog.
