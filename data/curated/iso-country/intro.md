We've referenced countries and country codes in many past datasets, but we've never looked closely at the ISO 3166 standard that defines these codes.

Wikipedia says:

> ISO 3166 is a standard published by the International Organization for 
> Standardization (ISO) that defines codes for the names of countries, dependent 
> territories, special areas of geographical interest, and their principal 
> subdivisions (e.g., provinces or states). The official name of the standard 
> is Codes for the representation of names of countries and their subdivisions.

The dataset this week comes from the {[ISOcodes](https://cran.r-project.org/package=ISOcodes)} R package. It consists of three tables:

- `countries`: Country codes from ISO 3166-1.
- `country_subdivisions`: Country subdivision code from ISO 3166-2.
- `former_countries`: Code for formerly used names of countries from ISO 3166-3.

Some questions to consider:

- When did ISO 3166-3 begin to log the date withdrawn as a full date, rather than just a year?
- Which countries have the most subdivisions identified by the International Organization for Standardization (ISO)? 
- Is there a pattern to which countries have sub-subdivisions (subdivisions with a `parent`) and which don't?

You can use this code to explore past datasets that have mentioned countries and/or country codes:

```r
# install.packages("pak")
# pak::pak("r4ds/ttmeta")
ttmeta::tt_datasets_metadata |> 
  dplyr::mutate(
    has_country = purrr::map_lgl(variable_details, function(var_details) {
      "country_code" %in% tolower(var_details$variable) ||
        any(stringr::str_detect(tolower(var_details$variable), "country"))
    })
  ) |> 
  dplyr::filter(has_country)
```
