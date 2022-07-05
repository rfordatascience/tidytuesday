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

# SF Rents

The data this week comes from [Kate Pennington](https://www.katepennington.org/data), [data.sfgov.org](https://data.sfgov.org/Housing-and-Buildings/Building-Permits/i98e-djp9/data), [Vital Signs](https://www.vitalsigns.mtc.ca.gov/housing-production).

If using Dr. Pennington's data, please cite:

> Pennington, Kate (2018).  Bay Area Craigslist Rental Housing Posts, 2000-2018. Retrieved from https://github.com/katepennington/historic_bay_area_craigslist_housing_posts/blob/master/clean_2000_2018.csv.zip.

Her methodology can be found at [her website](https://www.katepennington.org/clmethod).

> What impact does new housing have on rents, displacement, and gentrification in the surrounding neighborhood? Read our interview with economist Kate Pennington about her article, “Does Building New Housing Cause Displacement?:The Supply and Demand Effects of Construction in San Francisco.” - [Kate Pennington on Gentrification and Displacement in San Francisco](https://matrix.berkeley.edu/research-article/kate-pennington-on-gentrification-and-displacement-in-san-francisco/)

All building permits can be found at the [Socrata API endpoint](https://dev.socrata.com/foundry/data.sfgov.org/i98e-djp9).

[Does Building New Housing Cause Displacement?: The Supply and Demand Effects of Construction in San Francisco, Kate Pennington](https://deliverypdf.ssrn.com/delivery.php?ID=633098025092007018100111000090099113028078052014017010096086115031084093005071006121006013001017037121004120115095110019127088030002028047082021105096077030116126112035012004119111070017001125071120113001081103019023004097110009123126028091014027071110&EXT=pdf&INDEX=TRUE)


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-07-05')
tuesdata <- tidytuesdayR::tt_load(2022, week = 27)

rent <- tuesdata$rent

# Or read in the data manually

rent <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-07-05/rent.csv')
permits <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-07-05/sf_permits.csv')
new_construction <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-07-05/new_construction.csv')


```
### Data Dictionary

# `rent.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|post_id     |character | Unique ID     |
|date        |double    | date    |
|year        |double    |year    |
|nhood       |character |neighborhood    |
|city        |character |city    |
|county      |character |county    |
|price       |double    | price in USD    |
|beds        |double    | n of beds    |
|baths       |double    | n of baths    |
|sqft        |double    | square feet of rental    |
|room_in_apt |double    | room in apartment    |
|address     |character | address    |
|lat         |double    | latitude    |
|lon         |double    | longitude    |
|title       |character | title of listing    |
|descr       |character | description    |
|details     |character | additional details    |

# `sf_permits.csv`

|variable                               |class     |description |
|:--------------------------------------|:---------|:-----------|
|permit_number                          |character |permit_number                             |
|permit_type                            |double    |permit_type                               |
|permit_type_definition                 |character |permit_type_definition                    |
|permit_creation_date                   |double    |permit_creation_date                      |
|block                                  |character |block                                     |
|lot                                    |character |lot                                       |
|street_number                          |double    |street_number                             |
|street_number_suffix                   |character |street_number_suffix                      |
|street_name                            |character |street_name                               |
|street_suffix                          |character |street_suffix                             |
|unit                                   |double    |unit                                      |
|unit_suffix                            |character |unit_suffix                               |
|description                            |character |description                               |
|status                                 |character |status                                    |
|status_date                            |double    |status_date                               |
|filed_date                             |double    |filed_date                                |
|issued_date                            |double    |issued_date                               |
|completed_date                         |double    |completed_date                            |
|first_construction_document_date       |double    |first_construction_document_date          |
|structural_notification                |character |structural_notification                   |
|number_of_existing_stories             |double    |number_of_existing_stories                |
|number_of_proposed_stories             |double    |number_of_proposed_stories                |
|voluntary_soft_story_retrofit          |character |voluntary_soft_story_retrofit             |
|fire_only_permit                       |character |fire_only_permit                          |
|permit_expiration_date                 |double    |permit_expiration_date                    |
|estimated_cost                         |double    |estimated_cost                            |
|revised_cost                           |double    |revised_cost                              |
|existing_use                           |character |existing_use                              |
|existing_units                         |double    |existing_units                            |
|proposed_use                           |character |proposed_use                              |
|proposed_units                         |double    |proposed_units                            |
|plansets                               |double    |plansets                                  |
|tidf_compliance                        |logical   |tidf_compliance                           |
|existing_construction_type             |double    |existing_construction_type                |
|existing_construction_type_description |character |existing_construction_type_description    |
|proposed_construction_type             |double    |proposed_construction_type                |
|proposed_construction_type_description |character |proposed_construction_type_description    |
|site_permit                            |character |site_permit                               |
|supervisor_district                    |double    |supervisor_district                       |
|neighborhoods_analysis_boundaries      |character |neighborhoods_analysis_boundaries         |
|zipcode                                |double    |zipcode                                   |
|location                               |character |location                                  |
|record_id                              |double    |record_id                                 |
|date                                   |double    |date                                      |

# `new_construction.csv`

|variable             |class     |description |
|:--------------------|:---------|:-----------|
|cartodb_id           |integer   | ID    |
|the_geom             |logical   | type of geom    |
|the_geom_webmercator |logical   |variable    |
|county               |character | Country    |
|year                 |integer   | Year    |
|totalproduction      |integer   | Total production of housing    |
|sfproduction         |integer   | Single family production    |
|mfproduction         |integer   | multi family production    |
|mhproduction         |integer   | mobile home production    |
|source               |character | source    |

### Cleaning Script

```r
library(tidyverse)
library(httr)

raw_df <- read_csv("2022/2022-07-05/clean_2000_2018.csv.zip")


# https://www.vitalsigns.mtc.ca.gov/housing-production
url <- "https://mtc.carto.com/api/v2/sql?q=SELECT%20*%20FROM%20nyee_uw6v%20ORDER%20BY%20county%2C%20year"

raw_json <- url |>
  httr::GET() |>
  content()

new_construction <- tibble(data = raw_json$rows) |>
  unnest_wider(data)

new_construction |>
  write_csv("2022/2022-07-05/new_construction.csv")

permit_url <- "https://data.sfgov.org/resource/i98e-djp9.json?permit_number=201602179765"

permit_url <- "https://data.sfgov.org/resource/i98e-djp9.json?$where=filed_date > '2000-01-01T12:00:00'"

download.file("https://data.sfgov.org/resource/i98e-djp9.csv?$where=filed_date%20%3E%20%272000-01-01T12:00:00%27&$limit=800000", "2022/2022-07-05/permits.csv")

permits_raw <- read_csv("2022/2022-07-05/permits.csv")

permit_build <- permits_raw |>
  filter(permit_type %in% c(1, 2, 3, 6)) |>
  mutate(date = lubridate::date(permit_creation_date)) |>
  filter(date <= as.Date("2018-12-31"))

permit_build |>
  write_csv("2022/2022-07-05/sf-permits.csv")
```