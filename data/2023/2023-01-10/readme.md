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

# Project FeederWatch

The data this week comes from the [Project FeederWatch](https://feederwatch.org/explore/raw-dataset-requests/).

> FeederWatch is a November-April survey of birds that visit backyards, nature centers, community areas, and other locales in North America. Citizen scientists could birds in areas with plantings, habitat, water, or food that attracts birds. The schedule is completely flexible. People count birds as long as they like on days of their choosing, then enter their counts online. This allows anyone to track what is happening to birds around your home and to contribute to a continental data-set of bird distribution and abundance.

> FeederWatch data show which bird species visit feeders at thousands of locations across the continent every winter. The data also indicate how many individuals of each species are seen. This information can be used to measure changes in the winter ranges and abundances of bird species over time.

A subset of the 2021 data is included for this TidyTuesday, but data available through 1988 is available for download on [FeederWatch Raw Dataset Downloads page](https://feederwatch.org/explore/raw-dataset-requests/)

> Project FeederWatch is operated by the Cornell Lab of Ornithology and Birds Canada. Since 2016, Project FeederWatch has been sponsored by Wild Bird Unlimited. 

> Acknowledging FeederWatch.

> The Cornell Lab of Ornithology and Birds Canada are committed to making data gathered through our citizen science programs freely accessible to students, journalists, and the general public."  

> "This unique dataset is completely dependent on the efforts of our network of volunteer participants. We ask that all data analysts give credit to the thousands of participants who have made FeederWatch possible, as well as to Birds Canada and the Cornell Lab of Ornithology for developing and managing the program."

[Examples of analyses](https://feederwatch.org/explore/raw-dataset-requests/) are included with the raw data and there is a section to [Explore](https://feederwatch.org/explore/) the data.

More details on analyzing this dataset:  
[Over 30 Years of Standardized Bird Counts at Supplementary Feeding Stations in North America: A Citizen Science Data Report for Project FeederWatch](https://www.frontiersin.org/articles/10.3389/fevo.2021.619682/full) by David N. Bonter and Emma I. Greig

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-01-10')
tuesdata <- tidytuesdayR::tt_load(2023, week = 02)

feederwatch <- tuesdata$feederwatch

# Or read in the data manually

feederwatch <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-10/PFW_2021_public.csv')
site_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-10/PFW_count_site_data_public_2021.csv')

```
### Data Dictionary

> The [Project FeederWatch Data Dictionary](https://drive.google.com/file/d/1kHmx2XhA2MJtEyTNMpwqTQEnoa9M7Il2/view?usp=sharing) explains all fields and codes used in the database and is essential for understanding the dataset.

# `PFW_2021_public.csv`


|variable           |class     |description        |
|:------------------|:---------|:------------------|
|loc_id             |character |Unique identifier for each survey site |
|latitude           |double    |Latitude in decimal degrees for each survey site |
|longitude          |double    |Longitude in decimal degrees for each survey site |
|subnational1_code  |character |Country abbreviation and State or Province abbreviation of each survey site. Note that the files may contain some "XX" locations. These are sites that were incorrectly placed by the user (e.g., site plotted in the ocean.) |
|entry_technique    |character |Variable indicating method of site localization |
|sub_id             |character |Unique identifier for each checklist |
|obs_id             |character |Unique identifier for each observation of a species |
|Month              |double    |Month of 1st day of two-day observation period |
|Day                |double    |Day of 1st day of two-day observation period |
|Year               |double    |Year of 1st day of two-day observation period |
|PROJ_PERIOD_ID     |character |Calendar year of end of FeederWatch season |
|species_code       |character |Bird species observed, stored as 6-letter species codes |
|how_many           |double    |Maximum number of individuals seen at one time during observation period |
|valid              |double    |Validity of each observation based on flagging system |
|reviewed           |double    |Review state of each observation based on flagging system |
|day1_am            |double    |Variable indicating if observer watched during morning of count Day 1 |
|day1_pm            |double    |Variable indicating if observer watched during afternoon of count Day 1 |
|day2_am            |double    |Variable indicating if observer watched during morning of count Day 2 |
|day2_pm            |double    |Variable indicating if observer watched during afternoon of count Day 2 |
|effort_hrs_atleast |double    |Participant estimate of survey time  for each checklist |
|snow_dep_atleast   |double    |Participant estimate of minimum snow depth during a checklist |
|Data_Entry_Method  |character |Data entry method for each checklist (e.g., web, mobile app or paper form) |

# `PFW_count_site_data_public_2021.csv`

|variable                     |class     |description                  |
|:----------------------------|:---------|:----------------------------|
|loc_id                       |character |loc_id                       |
|proj_period_id               |character |proj_period_id               |
|yard_type_pavement           |double    |yard_type_pavement           |
|yard_type_garden             |double    |yard_type_garden             |
|yard_type_landsca            |double    |yard_type_landsca            |
|yard_type_woods              |double    |yard_type_woods              |
|yard_type_desert             |double    |yard_type_desert             |
|hab_dcid_woods               |double    |habitat type decidious woods               |
|hab_evgr_woods               |double    |habitat type evergreen woods               |
|hab_mixed_woods              |double    |habitat type mixed woods              |
|hab_orchard                  |double    |habitat type orchard                  |
|hab_park                     |double    |habitat type park                     |
|hab_water_fresh              |double    |habitat type fresh water              |
|hab_water_salt               |double    |habitat type salt water               |
|hab_residential              |double    |habitat type residential              |
|hab_industrial               |double    |habitat type industrial               |
|hab_agricultural             |double    |habitat type agricultural             |
|hab_desert_scrub             |double    |habitat type desert_scrub             |
|hab_young_woods              |double    |habitat type young_woods              |
|hab_swamp                    |double    |habitat type swamp                    |
|hab_marsh                    |double    |habitat type marsh                    |
|evgr_trees_atleast           |double    |minimum number of trees or shrubs in the count area - evergreen trees           |
|evgr_shrbs_atleast           |double    |minimum number of trees or shrubs in the count area - evergreen shrubs          |
|dcid_trees_atleast           |double    |minimum number of trees or shrubs in the count area - deciduous trees           |
|dcid_shrbs_atleast           |double    |minimum number of trees or shrubs in the count area - deciduous srubs        |
|fru_trees_atleast            |double    |minimum number of trees or shrubs in the count area - fruit trees            |
|cacti_atleast                |double    |minimum number of trees or shrubs in the count area - cacti               |
|brsh_piles_atleast           |double    |minimum number of brush piles located within the count area           |
|water_srcs_atleast           |double    |minimum number of water sources located within the count area         |
|bird_baths_atleast           |double    |minimum number of bird baths located within the count area      |
|nearby_feeders               |double    |presence or absense of feeders              |
|squirrels                    |double    |do squirrels take food from feeders at least 3 times per week?                   |
|cats                         |double    |are cats active within 30 m of the feeders for at least 30 minutes 3 days per week?                        |
|dogs                         |double    |are dogs active within 30 m of the feeders for at least 30 minutes 3 days per week?                          |
|humans                       |double    |are humans active within 30 m of the feeders for at least 30 minutes 3 days per week?                        |
|housing_density              |double    |participant estimated housing density of neighborhood          |
|fed_yr_round                 |double    |fed_yr_round                 |
|fed_in_jan                   |double    |fed_in_jan                   |
|fed_in_feb                   |double    |fed_in_feb                   |
|fed_in_mar                   |double    |fed_in_mar                   |
|fed_in_apr                   |double    |fed_in_apr                   |
|fed_in_may                   |double    |fed_in_may                   |
|fed_in_jun                   |double    |fed_in_jun                   |
|fed_in_jul                   |double    |fed_in_jul                   |
|fed_in_aug                   |double    |fed_in_aug                   |
|fed_in_sep                   |double    |fed_in_sep                   |
|fed_in_oct                   |double    |fed_in_oct                   |
|fed_in_nov                   |double    |fed_in_nov                   |
|fed_in_dec                   |double    |fed_in_dec                   |
|numfeeders_suet              |double    |numfeeders suet              |
|numfeeders_ground            |double    |numfeeders ground            |
|numfeeders_hanging           |double    |numfeeders hanging           |
|numfeeders_platfrm           |double    |numfeeders platfrm           |
|numfeeders_humming           |double    |numfeeders hummingbird           |
|numfeeders_water             |double    |numfeeders water dispensers             |
|numfeeders_thistle           |double    |numfeeders thistle           |
|numfeeders_fruit             |double    |numfeeders fruit             |
|numfeeders_hopper            |double    |numfeeders hopper            |
|numfeeders_tube              |double    |numfeeders tube              |
|numfeeders_other             |double    |numfeeders other             |
|population_atleast           |double    |participant estimated population of city or town         |
|count_area_size_sq_m_atleast |double    |participant estimated area of survey site |

### Cleaning Script

```r
# Download the raw data.

PFW_2021_public <- readr::read_csv("https://clo-pfw-prod.s3.us-west-2.amazonaws.com/data/PFW_2021_public.csv")
dplyr::glimpse(PFW_2021_public)

# There are almost three million rows! The file is too big for github, let's
# subsample.

set.seed(424242)
PFW_2021_public_subset <- dplyr::slice_sample(PFW_2021_public, n = 1e5)

readr::write_csv(PFW_2021_public_subset, here::here("data", "2023", "2023-01-10", "PFW_2021_public.csv"))
```
