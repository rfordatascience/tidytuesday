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

# Elevators

The data this week comes from the [Elevators data package](https://emilhvitfeldt.github.io/elevators/).

> This data package contains a data set of the registered elevator devices in New York City provided by the Department of Buildings in response to a September 2015 FOIL request.
>
> The package is available for use and the raw data files are available in the github repository: https://github.com/EmilHvitfeldt/elevators/tree/main/data-raw
> 
> License: The above data is free to use under the terms of the MIT license. 
> 
> Please use the following citation if you do download the data: Hvitfeldt E (2022). elevators: Data Package Containing Information About Elevators in NYC. https://github.com/EmilHvitfeldt/elevators, https://emilhvitfeldt.github.io/elevators/.

Some initial examples: https://emilhvitfeldt.github.io/elevators/

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-12-06')
tuesdata <- tidytuesdayR::tt_load(2022, week = 49)

elevators <- tuesdata$elevators

# Or read in the data manually

elevators <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-12-06/elevators.csv')

```
### Data Dictionary

# `elevators.csv`


|variable                     |class     |description                  |
|:----------------------------|:---------|:----------------------------|
|DV_DEVICE_NUMBER             |character |Unique identifier for the elevator |
|Device Status                |character |Device status                |
|DV_DEVICE_STATUS_DESCRIPTION |character |Devlice status description |
|BIN                          |double    |Building Identification Number |
|TAX_BLOCK                    |double    |ID for tax block. Smaller than borough |
|TAX_LOT                      |double    |ID for tax lot. Smaller than tax block |
|HOUSE_NUMBER                 |character |House number, very poorly parsed, use with caution |
|STREET_NAME                  |character |Street name, very poorly parsed, use with caution                  |
|ZIP_CODE                     |double    |Zip code, formatted to 5 digits. 0 and 99999 are marked as NA |
|Borough                      |character |Borough                      |
|Device Type                  |character |Type of device. Most common type is "Passenger Elevator" |
|DV_LASTPER_INSP_DATE         |double    |Date, refers to the last periodic inspection by the Department of Buildings. These dates will no longer be accurate, as they were collected by November 2015 |
|DV_LASTPER_INSP_DISP         |character |Display, last periodic inspection |
|DV_APPROVAL_DATE             |character |Date of approval for elevator|
|DV_MANUFACTURER              |character |Name of manufacturer, poorly cleaned. Most assigned NA |
|DV_TRAVEL_DISTANCE           |character |Distance traveled, not cleaned. Mixed formats |
|DV_SPEED_FPM                 |character |Speed in feet/minute         |
|DV_CAPACITY_LBS              |double    |Capacity in lbs              |
|DV_CAR_BUFFER_TYPE           |character |Buffer type. A buffer is a device designed to stop a descending car or counterweight beyond its normal limit and to soften the force with which the elevator runs into the pit during an emergency. Takes values "Oil", "Spring", and NA |
|DV_GOVERNOR_TYPE             |character |Governor type, An overspeed governor is an elevator device which acts as a stopping mechanism in case the elevator runs beyond its rated speed |
|DV_MACHINE_TYPE              |character |Machine type, labels unknown.|
|DV_SAFETY_TYPE               |character |Safety type, labels unknown.|
|DV_MODE_OPERATION            |character |Operation mode, labels unknown |
|DV_STATUS_DATE               |double    |Status date               |
|DV_FLOOR_FROM                |character |Lowest floor, not cleaned. Mixed formats |
|DV_FLOOR_TO                  |character |Highest floor, not cleaned. Mixed formats |
|...27                        |logical   |...27                        |
|LATITUDE                     |double    |Latitude of elevator         |
|LONGITUDE                    |double    |Longitude of elevator        |    

### Cleaning Script

Clean data - no script
