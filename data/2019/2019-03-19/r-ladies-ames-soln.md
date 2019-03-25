R-Ladies Ames Solution
================
Sam Tyner, Amanda Rae
3/19/2019

``` r
library(tidyverse)
combined_data <- read_csv("https://raw.githubusercontent.com/5harad/openpolicing/master/results/data_for_figures/combined_data.csv")
head(combined_data)
```

    ## # A tibble: 6 x 11
    ##   location state driver_race stops_per_year stop_rate search_rate
    ##   <chr>    <chr> <chr>                <dbl>     <dbl>       <dbl>
    ## 1 APACHE … AZ    Black                  266     0.995       0.077
    ## 2 APACHE … AZ    Hispanic              1008     0.262       0.053
    ## 3 APACHE … AZ    White                 6322     0.431       0.017
    ## 4 COCHISE… AZ    Black                 1169     0.23        0.047
    ## 5 COCHISE… AZ    Hispanic              9453     0.259       0.037
    ## 6 COCHISE… AZ    White                10826     0.145       0.024
    ## # … with 5 more variables: consent_search_rate <dbl>, arrest_rate <dbl>,
    ## #   citation_rate_speeding_stops <dbl>, hit_rate <dbl>,
    ## #   inferred_threshold <dbl>

Since we’re in Iowa, let’s isolate the Iowa data

``` r
iowa <- filter(combined_data, state == "IA")
iowa
```

    ## # A tibble: 0 x 11
    ## # … with 11 variables: location <chr>, state <chr>, driver_race <chr>,
    ## #   stops_per_year <dbl>, stop_rate <dbl>, search_rate <dbl>,
    ## #   consent_search_rate <dbl>, arrest_rate <dbl>,
    ## #   citation_rate_speeding_stops <dbl>, hit_rate <dbl>,
    ## #   inferred_threshold <dbl>

No Iowa. 😿.
