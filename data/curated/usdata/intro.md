This week we're exploring the [CIA World Factbook](https://www.cia.gov/the-world-factbook/)! 
The dataset comes from the [{usdatasets}](https://cran.r-project.org/package=usdatasets) R package via [this post on LinkedIn](https://www.linkedin.com/posts/andrescaceresrossi_rstats-rstudio-opensource-activity-7249513444830318592-r395).

> The *World Factbook* provides basic intelligence on the history, people, government, 
> economy, energy, geography, environment, communications, transportation, military, 
> terrorism, and transnational issues for 265 world entities.

Which countries have the highest number of internet users per square kilometer?
Which countries have the highest percentage of internet users?

You might want to join this dataset with past TidyTueday datasets that featured country information!

```r
# pak::pak("r4ds/ttmeta")
library(tidyverse)
library(ttmeta)

country_datasets <- ttmeta::tt_datasets_metadata |> 
  dplyr::mutate(
    has_country = purrr::map_lgl(
      .data$variable_details,
      \(var_dets) {
        !is.null(var_dets) && 
          any(stringr::str_detect(tolower(var_dets$variable), "country"))
      }
    )
  ) |> 
  dplyr::filter(has_country)
```
