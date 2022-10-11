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

# Ravelry Yarn

The data this week comes from [ravelry.com](https://www.ravelry.com/yarns/) by way of [Alice Walsh](https://github.com/awalsh17).

Also see the [{ravelRy}](https://www.kaylinpavlik.com/introducing-new-r-package-ravelry/) R package by Kaylin Pavlik.

> Ravelry describes itself as a social networking and organizational tool for knitters, crocheters, designers, spinners, weavers and dyers.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-10-11')
tuesdata <- tidytuesdayR::tt_load(2022, week = 41)

yarn <- tuesdata$yarn

# Or read in the data manually

yarn <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-10-11/yarn.csv')

```
### Data Dictionary

# `yarn.csv`

|variable                  |class     |description |
|:-------------------------|:---------|:-----------|
|discontinued              |logical   | discontinued true/false    |
|gauge_divisor             |double    | gauge divisor - The number of inches that equal min_gauge to max_gauge stitches    |
|grams                     |double    | Unit weight in grams    |
|id                        |double    | id     |
|machine_washable          |logical   | machine washable true/false    |
|max_gauge                 |double    | max gauge - The max number of stitches that equal gauge_divisor    |
|min_gauge                 |double    | min gauge - The min number of stitches that equal gauge_divisor   |
|name                      |character | name    |
|permalink                 |character | permalink    |
|rating_average            |double    | rating average - The average rating out of 5    |
|rating_count              |double    | rating count    |
|rating_total              |double    | rating total    |
|texture                   |character | texture  - Texture free text  |
|thread_size               |character | thread size    |
|wpi                       |double    | wraps per inch    |
|yardage                   |double    | yardage     |
|yarn_company_name         |character | Yarn company name    |
|yarn_weight_crochet_gauge |logical   | Yarn weight crochet gauge - Crochet gauge for the yarn weight category   |
|yarn_weight_id            |double    | Yarn weight ID - Identifier for the yarn weight category     |
|yarn_weight_knit_gauge    |character | Yarn weight knit gauge -     Knit guage for the yarn weight category    |
|yarn_weight_name          |character | Yarn weight  name -     Name for the yarn weight category    |
|yarn_weight_ply           |double    | Yarn weight ply -     Ply for the yarn weight category    |
|yarn_weight_wpi           |character | Yarn weight wraps per inch -     Wraps per inch for the yarn weight category    |
|texture_clean             |character | Texture clean -     Texture with some light text cleaning    |

### Cleaning Script

Clean script source: <https://github.com/awalsh17/ravelry_yarns>

```r
# Call to ravelry API

library(dplyr)
library(httr)
library(jsonlite)

# get the information on 100,000 yarns -------
# iterate over all pages (1000 results per) 100,000 total, api user/pass was saved to env

pages <- c(1:100)

resp <- purrr::map(pages, ~httr::GET(
  url = paste0("https://api.ravelry.com/yarns/search.json?sort=best&page_size=1000&page=", .x),
  authenticate(Sys.getenv("RAVELRY_API_USER"), Sys.getenv("RAVELRY_API_PASS"))))

# first item is the yarn data

yarn_all <- purrr::map_dfr(resp, ~fromJSON(content(.x, as = "text"))[[1]])

# second is the paginator - 100 pages

# write out raw

saveRDS(yarn_all, "data/yarn_raw.Rds")

# unnest the data frame, remove first_photo and personal_attributes

yarn_all <- tidyr::unnest(yarn_all, yarn_weight, names_sep = "_") %>%
  select(-first_photo, -personal_attributes)

# yarn_weight_min_gauge and yarn_weight_max_gauge are always missing

yarn_all <- select(yarn_all, -yarn_weight_max_gauge, -yarn_weight_min_gauge)

# clean the texture variable

yarn_all$texture_clean <- stringr::str_trim(yarn_all$texture)
yarn_all$texture_clean <- stringr::str_to_lower(yarn_all$texture_clean)

# write out the final csv

write.csv(yarn_all, "data/yarn.csv", row.names = FALSE)




# Query for more yarn information -----

# need to split request up into chunks of 100

chunks <- dplyr::ntile(1:100000, 1000)
yarn_ids <- purrr::map(
  1:1000,
  ~paste(unique(yarn_all$id)[chunks == .x], collapse = "+"))

resp <- purrr::map(
  yarn_ids,
  ~httr::GET(url = paste0("https://api.ravelry.com/yarns.json?ids=", .x),
             authenticate(Sys.getenv("RAVELRY_API_USER"), Sys.getenv("RAVELRY_API_PASS"))))

yarn_json <- purrr::map(
  resp,
  ~parse_json(content(.x, as = "text"), simplifyVector = TRUE)$yarns)
yarn_json <- unlist(yarn_json, recursive = FALSE)

# yarn_fibers with have more than one row per yarn

yarn_fibers <- purrr::map_dfr(yarn_json, ~.x[["yarn_fibers"]], .id = "yarn_id") %>%
  tidyr::unnest(fiber_type, names_sep = "_") %>%
  select(-fiber_category, -id) %>%
  rename(id = yarn_id) # make primary key id for yarn

# yarn_attributes have more than one row per yarn (care, color, dye)

yarn_attributes <- purrr::map_dfr(yarn_json, ~.x[["yarn_attributes"]], .id = "yarn_id") %>%
  tidyr::unnest(yarn_attribute_group, names_sep = "_") %>%
  select(-id, -yarn_attribute_group_id) %>%
  rename(id = yarn_id) # make primary key id for yarn

# this has all the possible values for the yarn_attribute_group

yarn_attribute_groups <- httr::GET(
  url = "https://api.ravelry.com/yarn_attributes/groups.json",
  authenticate(Sys.getenv("RAVELRY_API_USER"), Sys.getenv("RAVELRY_API_PASS")))

yarn_attribute_groups <- fromJSON(content(yarn_attribute_groups, as = "text"))[[1]] %>%
  tidyr::unnest(yarn_attributes, names_sep = "_") %>%
  select(-children) # for construction attributes, just remove for here

# write out yarn_fibers and yarn_attributes

write.csv(yarn_fibers, "data/yarn_fibers.csv", row.names = FALSE)
write.csv(yarn_attribute_groups, "data/yarn_attribute_groups.csv", row.names = FALSE)
write.csv(yarn_attributes, "data/yarn_attributes.csv", row.names = FALSE)
```
