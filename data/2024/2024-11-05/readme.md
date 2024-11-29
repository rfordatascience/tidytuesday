# Democracy and Dictatorship

It's Election Day in the United States. If you are able to do so, vote!

To celebrate, we're looking at a dataset about Democracy and Dictatorship.

> This dataset updates [pacl](https://xmarquez.github.io/democracyData/reference/pacl.html) 
> with more countries and coverage from 1950 to 2020, as described in C. 
> Bjørnskov and M. Rode. "Regime types and regime change: A new dataset on 
< democracy, coups, and political institutions". In: *The Review of International Organizations*
> 15.2 (2020), pp. 531-551. [DOI: 10.1007/s11558-019-09345-1](https://link.springer.com/article/10.1007/s11558-019-09345-1).
> The full data and codebook can be downloaded [here](http://www.christianbjoernskov.com/bjoernskovrodedata/).

- How many countries switched from democracies to non-democracies? Did any of them keep their democratically elected leader after the switch?
- Which of those countries switched back to democracies? How long did it take?

Thank you to [Jon Harmon](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-11-05')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 45)

democracy_data <- tuesdata$democracy_data

# Option 2: Read directly from GitHub

democracy_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-11-05/democracy_data.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `democracy_data.csv`

|variable                    |class     |description                           |
|:---------------------------|:---------|:-------------------------------------|
|country_name                |character |Country name in the original PACL dataset. |
|country_code                |character |Three letter ISO country code. |
|year                        |integer   |Year. |
|regime_category_index       |integer   |Numeric regime category, following Cheibub, Ghandi and Vreeland (2010). |
|regime_category             |character |Regime category label, following Cheibub, Ghandi and Vreeland (2010). |
|is_monarchy                 |logical   |Is the country a hereditary monarchy? |
|is_commonwealth             |logical   |Is the country a member of the British Commonwealth? |
|monarch_name                |character |Name of the monarch. |
|monarch_accession_year      |integer   |Year of accession of the monarch. |
|monarch_birthyear           |integer   |Year of birth of the monarch. |
|is_female_monarch           |logical   |Is the monarch female. |
|is_democracy                |logical   |Is the country democratic or not? Following Cheibub, Ghandi and Vreeland (2010) Dichotomous indicator of democracy based on a minimalist definition. A country is defined as democratic, if elections were conducted, these were free and fair, and if there was a peaceful turnover of legislative and executive offices following those elections. |
|is_presidential             |logical   |Is the political system presidential? |
|president_name              |character |Name of the president. |
|president_accesion_year     |integer   |Accession year of the president. |
|president_birthyear         |integer   |Year of birth of the president. |
|is_interim_phase            |logical   |Is the president interim / preliminary? (more than 2 Presidents/year) |
|is_female_president         |logical   |Is the president female? |
|is_colony                   |logical   |Is the country a colony? |
|colony_of                   |character |If colony, which country is the colonial power? Country name of the colonial power. |
|colony_administrated_by     |character |If colony, which country is the colonial administrator? |
|is_communist                |logical   |Is the country's regime communist / socialist? |
|has_regime_change_lag       |logical   |Regime Change lag. If a coded event, such as a change in the Presidency, took place after 01.07 it is assigned to the following calendar year in the data. In this case, the lag variable will be TRUE. For all change events before that date, the lag variable is FALSE. |
|spatial_democracy           |double    |Average of geographical neighbors' Democracy score. |
|parliament_chambers         |integer   |Total number of chambers in parliament. |
|has_proportional_voting     |logical   |Is the electoral system characterized by including proportional representation? |
|election_system             |character |Electoral system. See [the package website](https://xmarquez.github.io/democracyData/reference/pacl_update.html) for a full list of options. |
|lower_house_members         |integer   |If bicameral parliament, total number of members in lower house. |
|upper_house_members         |integer   |If bicameral parliament, total number of members in upper house. |
|third_house_members         |integer   |If tricameral parliament, total number of members in third house. |
|has_new_constitution        |logical   |Whether a new constitution was implemented. |
|has_full_suffrage           |logical   |Whether electoral system attributes full suffrage. |
|suffrage_restriction        |character |If no full suffrage, kind of suffrage restriction. |
|electoral_category_index    |integer   |Alternative democracy indicator capturing degree of multi-party competition (index from 0 to 3). |
|electoral_category          |character |Alternative democracy indicator capturing degree of multi-party competition. |
|spatial_electoral           |double    |Average of geographical neighbors' electoral_category_index. |
|has_alternation             |logical   |Whether there's an alternation in power after election. Undocumented in original codebook. |
|is_multiparty               |logical   |Whether the elections are multiparty. Undocumented in original codebook. |
|has_free_and_fair_election  |logical   |Whether the elections are free and fair. Undocumented in original codebook. |
|parliamentary_election_year |integer   |Year of parliamentary election. Undocumented in original codebook. |
|election_month              |character |Month of parliamentary election. Undocumented in original codebook. |
|election_year               |integer   |Year of parliamentary election. Undocumented in original codebook. |
|has_postponed_election      |logical   |Whether the election was postponed. Undocumented in original codebook. |

### Cleaning Script

```r
# Data from the package {democracyData}
# install.packages("pak")
# pak::pak("xmarquez/democracyData")
library(democracyData)
library(tidyverse)

democracy_data <-
  democracyData::pacl_update |> 
  janitor::clean_names() |> 
  dplyr::select(
    "country_name" = "pacl_update_country",
    "country_code" = "pacl_update_country_isocode",
    "year",
    "regime_category_index" = "dd_regime",
    "regime_category" = "dd_category",
    "is_monarchy" = "monarchy",
    "is_commonwealth" = "commonwealth",
    "monarch_name",
    "monarch_accession_year" = "monarch_accession",
    "monarch_birthyear",
    "is_female_monarch" = "female_monarch",
    "is_democracy" = "democracy",
    "is_presidential" = "presidential",
    "president_name",
    "president_accesion_year" = "president_accesion",
    "president_birthyear",
    "is_interim_phase" = "interim_phase",
    "is_female_president" = "female_president",
    "is_colony" = "colony",
    "colony_of",
    "colony_administrated_by",
    "is_communist" = "communist",
    "has_regime_change_lag" = "regime_change_lag",
    "spatial_democracy",
    "parliament_chambers" = "no_of_chambers_in_parliament",
    "has_proportional_voting" = "proportional_voting",
    "election_system",
    "lower_house_members" = "no_of_members_in_lower_house",
    "upper_house_members" = "no_of_members_in_upper_house",
    "third_house_members" = "no_of_members_in_third_house",
    "has_new_constitution" = "new_constitution",
    "has_full_suffrage" = "fullsuffrage",
    "suffrage_restriction",
    "electoral_category_index" = "electoral",
    "spatial_electoral",
    "has_alternation" = "alternation",
    "is_multiparty" = "multiparty",
    "has_free_and_fair_election" = "free_and_fair_election",
    "parliamentary_election_year",
    "election_month" = "election_month_year",
    "has_postponed_election" = "postponed_election"
  ) |>
  dplyr::mutate(
    election_month = dplyr::na_if(.data$election_month, "?")
  ) |> 
  tidyr::separate_wider_regex(
    "election_month",
    patterns = c(
      election_month = "\\D+",
      election_year = "\\d{4}$"
    ),
    too_few = "align_start"
  ) |> 
  dplyr::mutate(
    electoral_category = dplyr::case_match(
      .data$electoral_category_index,
      0 ~ "no elections",
      1 ~ "single-party elections",
      2 ~ "non-democratic multi-party elections",
      3 ~ "democratic elections"
    ),
    .after = "electoral_category_index"
  ) |> 
  dplyr::mutate(
    election_month = stringr::str_squish(.data$election_month),
    dplyr::across(
      c(
        tidyselect::ends_with("_index"),
        tidyselect::contains("year"),
        tidyselect::ends_with("_members"),
        "parliament_chambers"
      ),
      as.integer
    ),
    dplyr::across(
      c(
        tidyselect::starts_with("is_"),
        tidyselect::starts_with("has_")
      ),
      as.logical
    )
  )
```
