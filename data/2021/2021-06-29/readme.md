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

![A fox walking past 10 Downing Street this week. The number of rescues involving the animals nearly doubled in 2020. Photograph: John Sibley/Reuters](https://i.guim.co.uk/img/media/6091b90d3e80a394d7202faa2c3a35caf2e98fb2/0_246_3500_2101/master/3500.jpg?width=620&quality=85&auto=format&fit=max&s=a2497e389b474b7bf65c98b0b87f91b8)

# Animal Rescues

The data this week comes from [London.gov](https://data.london.gov.uk/dataset/animal-rescue-incidents-attended-by-lfb) by way of Data is Plural and Georgios Karamanis.

> Fox in bedroom, dog trapped in wall. The London Fire Brigade responds to hundreds of requests to rescue animals each year. Its monthly-updated spreadsheet of such events goes back to 2009; it lists the location and type of property, the kind of animal and rescue, hours spent, a (very) brief description, and more. [h/t Soph Warnes]

> The London Fire Brigade attends a range of non-fire incidents (which we call 'special services'). These 'special services' include assistance to animals that may be trapped or in distress.
> 
> We routinely get asked for information about the number of such incident attended by the London Fire Brigade and this data is published on the London Datastore to assist those who require it.
> 
> The data is provided from January 2009 and isupdated monthly. A range of information is supplied for each incident including some location information (postcode, borough, ward), as well as the data/time of the incidents. We do not routinely record data about animal deaths or injuries.
> 
> Please note that any cost included is a notional cost calculated based on the length of time rounded up to the nearest hour spent by Pump, Aerial and FRU appliances at the incident and charged at the current Brigade hourly rate.

The Guardian also published [Animal rescues by London fire brigade rise 20% in pandemic year](https://www.theguardian.com/world/2021/jan/08/animal-rescues-london-fire-brigade-rise-2020-pandemic-year) a few months back.

> London firefighters encountered a surge in callouts to rescue animals in 2020, figures show.
> 
> The London fire brigade (LFB) was involved in 755 such incidents – more than two a day. The number of rescues rose by 20% compared with 2019 when there were 602, with the biggest rise coming in the number of non-domestic animals rescued, according to the data.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-06-29')
tuesdata <- tidytuesdayR::tt_load(2021, week = 27)

animal_rescues <- tuesdata$animal_rescues

# Or read in the data manually

animal_rescues <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-06-29/animal_rescues.csv')

```
### Data Dictionary

# `animal_rescues.csv`

|variable                      |class     |description |
|:-----------------------------|:---------|:-----------|
|incident_number               |double    | Unique incident ID |
|date_time_of_call             |character | Day and time of call (day/month/year hour:minute) |
|cal_year                      |double    | Calendar Year |
|fin_year                      |character | Fiscal year|
|type_of_incident              |character | Type of incident |
|pump_count                    |character | Pump count (number of trucks) |
|pump_hours_total              |character | Pump hours total |
|hourly_notional_cost          |double    | Hourly cost |
|incident_notional_cost        |character | Total cost of incident |
|final_description             |character | Final description |
|animal_group_parent           |character | Type of animal |
|originof_call                 |character | Where call originated |
|property_type                 |character | Property type |
|property_category             |character | Property category |
|special_service_type_category |character | Service type category  |
|special_service_type          |character | Service type |
|ward_code                     |character | Ward Code |
|ward                          |character | Ward name |
|borough_code                  |character | Borough code |
|borough                       |character | Borough name |
|stn_ground_name               |character | Station name |
|uprn                          |character | Unique property reference number |
|street                        |character | Street name |
|usrn                          |character | unique street reference number |
|postcode_district             |character | Postal code district |
|easting_m                     |character | Easting measure |
|northing_m                    |character |  Northing measure |
|easting_rounded               |double    | Easting rounded |
|northing_rounded              |double    | Northing rounded |
|latitude                      |character | Lat|
|longitude                     |character | Long |

### Cleaning Script

No cleaning this week, just `janitor::clean_names()`!
