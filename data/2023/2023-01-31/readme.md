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

# Pet Cats UK

The data this week comes from the [Movebank for Animal Tracking Data](https://www.datarepository.movebank.org/handle/10255/move.882) via [Data is Plural](https://themarkup.org/data-is-plural/2023/01/25/from-jazz-solos-to-cats-on-the-move#:~:text=Giuseppe%20Sollazzo%5D-,Cats%20on%20the%20move,-.%20Between%202013). Thanks @jthomasmock for the suggestion!

> Between 2013 and 2017, Roland Kays et al. convinced hundreds of volunteers in the U.S., U.K., Australia, and New Zealand to strap GPS sensors on their pet cats. The aforelinked datasets include each cat’s characteristics (such as age, sex, neuter status, hunting habits) and time-stamped GPS pings.

> When using this dataset, please cite the original article.

> Kays R, Dunn RR, Parsons AW, Mcdonald B, Perkins T, Powers S, Shell L, McDonald JL, Cole H, Kikillus H, Woods L, Tindle H, Roetman P (2020) The small home ranges and large local ecological impacts of pet cats. Animal Conservation. [doi:10.1111/acv.12563](http://dx.doi.org/10.1111/acv.12563)

> Additionally, please cite the Movebank data package:

> McDonald JL, Cole H (2020) Data from: The small home ranges and large local ecological impacts of pet cats [United Kingdom]. Movebank Data Repository. [doi:10.5441/001/1.pf315732](http://dx.doi.org/10.5441/001/1.pf315732)

Additional datasets for the [US](https://www.datarepository.movebank.org/handle/10255/move.885), [Australia](https://www.datarepository.movebank.org/handle/10255/move.876), and [New Zealand](https://www.datarepository.movebank.org/handle/10255/move.879) are also available for download, but they were too large for us to include them directly.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-01-31')
tuesdata <- tidytuesdayR::tt_load(2023, week = 5)

cats_uk <- tuesdata$cats_uk
cats_uk_reference <- tuesdata$cats_uk_reference

# Or read in the data manually

cats_uk <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-31/cats_uk.csv')
cats_uk_reference <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-31/cats_uk_reference.csv')
```

### Data Dictionary

Full dictionaries are available on [Movebank](https://www.datarepository.movebank.org/handle/10255/move.882)

# `cats_uk.csv`

|variable                 |class     |description              |
|:------------------------|:---------|:------------------------|
|tag_id                   |character |A unique identifier for the tag, provided by the data owner. If the data owner does not provide a tag ID, an internal Movebank tag identifier may sometimes be shown.|
|event_id                 |double    |An identifier for the set of values associated with each event, i.e. sensor measurement. A unique event ID is assigned to every time-location or other time-measurement record in Movebank. If multiple measurements are included within a single row of a data file, they will share an event ID. If users import the same sensor measurement to Movebank multiple times, a separate event ID will be assigned to each.|
|visible                  |logical   |Determines whether an event is visible on the Movebank map. Values are calculated automatically, with TRUE indicating the event has not been flagged as an outlier by `algorithm_marked_outlier`, `import_marked_outlier` or `manually_marked_outlier`, or that the user has overridden the results of these outlier attributes using `manually_marked_valid` = TRUE. Allowed values are TRUE or FALSE.|
|timestamp                       |double    |The date and time corresponding to a sensor measurement or an estimate derived from sensor measurements.|
|location_long                   |double    |The geographic longitude of the location as estimated by the sensor. Positive values are east of the Greenwich Meridian, negative values are west of it.|
|location_lat                    |double    |The geographic longitude of the location as estimated by the sensor. Positive values are east of the Greenwich Meridian, negative values are west of it.|
|ground_speed                    |double    |The estimated ground speed provided by the sensor or calculated between consecutive locations. Units are reportedly m/s, which indicates that there is likely a problem with this data (either the units were reported erroneously or their is an issue with the sensor data).|
|height_above_ellipsoid          |double    |The estimated height above the ellipsoid, typically estimated by the tag. Units: meters|
|algorithm_marked_outlier        |logical   |Identifies events marked as outliers using a user-selected filter algorithm in Movebank. Outliers have the value TRUE.|
|manually_marked_outlier         |logical   |Identifies events flagged manually as outliers, typically using the Event Editor in Movebank, and may also include outliers identified using other methods. Outliers have the value TRUE.|
|study_name                      |character |The name of the study in Movebank.|

# `cats_uk_reference.csv`

|variable                      |class     |description                   |
|:-----------------------------|:---------|:-----------------------------|
|tag_id                        |character |A unique identifier for the tag, provided by the data owner. If the data owner does not provide a tag ID, an internal Movebank tag identifier may sometimes be shown. |
|animal_id                     |character |An individual identifier for the animal, provided by the data owner. If the data owner does not provide an Animal ID, an internal Movebank animal identifier is sometimes shown. |
|animal_taxon                  |character |The scientific name of the species on which the tag was deployed, as defined by the Integrated Taxonomic Information System (ITIS, www.itis.gov). If the species name can not be provided, this should be the lowest level taxonomic rank that can be determined and that is used in the ITIS taxonomy. |
|deploy_on_date                |double    |The timestamp when the tag deployment started. |
|deploy_off_date               |double    |The timestamp when the tag deployment ended. |
|hunt                          |logical   |Whether the animal was allowed to hunt. |
|prey_p_month                  |double    |Approximate number of prey caught by the animal per month. |
|animal_reproductive_condition |character |The reproductive condition of the animal at the beginning of the deployment. |
|animal_sex                    |character |The sex of the animal, as "m" or "f".|
|hrs_indoors                   |double    |The average number of hours which the animal was indoors per day. |
|n_cats                        |double    |The number of cats in the house.|
|food_dry                      |logical   |Whether the cat was fed dry food.|
|food_wet                      |logical   |Whether the cat was fed wet food.|
|food_other                    |logical   |Whether the cat was fed other food.|
|study_site                    |character |A location such as the deployment site or colony, or a location-related group such as the herd or pack name.|
|age_years                     |double    |The age of the animal at the beginning of the deployment, in years. "0" indicates that the animal was < 1 year old.|


### Cleaning Script

```r
library(tidyverse)
library(here)
library(janitor)

cats_uk <- read_csv("https://www.datarepository.movebank.org/bitstream/handle/10255/move.883/Pet%20Cats%20United%20Kingdom.csv?sequence=3") |> 
  clean_names() |> 
  # Standardize things and reorder columns.
  select(
    tag_id = tag_local_identifier,
    event_id:location_lat,
    ground_speed,
    height_above_ellipsoid,
    algorithm_marked_outlier,
    manually_marked_outlier,
    study_name
  ) |> 
  # Explicitly encode FALSE in the outlier columns.
  tidyr::replace_na(
    list(
      algorithm_marked_outlier = FALSE,
      manually_marked_outlier = FALSE
    )
  )

cats_uk_reference <- read_csv("https://www.datarepository.movebank.org/bitstream/handle/10255/move.884/Pet%20Cats%20United%20Kingdom-reference-data.csv?sequence=1") |>
  clean_names() |> 
  mutate(
    # animal_life_stage is ALMOST just age in years.
    age_years = case_when(
      str_detect(animal_life_stage, fixed("<")) ~ 0L,
      str_detect(animal_life_stage, "year") ~ str_extract(
        animal_life_stage, "\\d+"
      ) |> 
        as.integer(),
      TRUE ~ NA_integer_
    )
  ) |> 
  # There are only a handful of unique values for the comments, extract those.
  separate_wider_delim(
    animal_comments,
    "; ",
    names = c("hunt", "prey_p_month")
  ) |> 
  mutate(
    hunt = case_when(
      str_detect(hunt, "Yes") ~ TRUE,
      str_detect(hunt, "No") ~ FALSE,
      TRUE ~ NA
    ),
    prey_p_month = as.numeric(
      str_remove(prey_p_month, "prey_p_month: ")
    )
  ) |> 
  # manipulation_comments similarly has a pattern.
  separate_wider_delim(
    manipulation_comments,
    "; ",
    names = c("hrs_indoors", "n_cats", "food")
  ) |> 
  mutate(
    hrs_indoors = as.numeric(
      str_remove(hrs_indoors, "hrs_indoors: ")
    ),
    n_cats = as.integer(
      str_remove(n_cats, "n_cats: ")
    )
  ) |> 
  separate_wider_delim(
    food,
    ",",
    names = c("food_dry", "food_wet", "food_other")
  ) |> 
  mutate(
    food_dry = case_when(
      str_detect(food_dry, "Yes") ~ TRUE,
      str_detect(food_dry, "No") ~ FALSE,
      TRUE ~ NA
    ),
    food_wet = case_when(
      str_detect(food_wet, "Yes") ~ TRUE,
      str_detect(food_wet, "No") ~ FALSE,
      TRUE ~ NA
    ),
    food_other = case_when(
      str_detect(food_other, "Yes") ~ TRUE,
      str_detect(food_other, "No") ~ FALSE,
      TRUE ~ NA
    )
  ) |>
  # Drop uninteresting fields.
  select(
    -animal_life_stage,
    -attachment_type,
    -data_processing_software,
    -deployment_end_type,
    -duty_cycle,
    -deployment_id,
    -manipulation_type,
    -tag_manufacturer_name,
    -tag_mass,
    -tag_model,
    -tag_readout_method
  )

glimpse(cats_uk)
glimpse(cats_uk_reference)

cats_uk |> write_csv(
  here(
    "data",
    "2023",
    "2023-01-31",
    "cats_uk.csv"
  )
)

cats_uk_reference |> write_csv(
  here(
    "data",
    "2023",
    "2023-01-31",
    "cats_uk_reference.csv"
  )
)
```
