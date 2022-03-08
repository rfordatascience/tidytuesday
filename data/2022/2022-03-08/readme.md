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

# EU Student mobility

The data this week comes from [Data.Europa](https://data.europa.eu/data/datasets?locale=en&catalog=eac&query=erasmus&page=1&sort=issued%2Bdesc,%20relevance%2Bdesc,%20title.en%2Basc) hattip to [Data is Plural](https://www.data-is-plural.com/archive/2022-02-09-edition/).

Wimdu wrote a short [blog post](https://www.wimdu.co.uk/blog/discover-popular-erasmus-destinations) on the most popular ERASMUS destinations.

The ERASMUS program: EU programme for education, training, youth and sport

> Erasmus students are those that take advantage of the Erasmus exchange program, a well supported and organised scheme that has been in operation since the late 1980's. It allows for students to study at universities in the EU member states for set periods of time.
> Erasmus students study a wide variety of subjects but most use the program for advancing their language skills with a view to working in the international sphere, and it is advised that anyone interested seeks information on the Erasmus scheme online.
>
> The European Credit Transfer System means that academic credits you earn in your course while abroad will count towards your qualification.

> Similar mobility periods are aggregated where possible (same sending/receiving organisation, same status regrading fewer oppts, gender, age, …) in order to reduce file size. Mobility periods started in 2020 and 2021  will be published once they are finalised. 



### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-03-08')
tuesdata <- tidytuesdayR::tt_load(2022, week = 10)

erasmus <- tuesdata$erasmus

# Or read in the data manually

erasmus <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-08/erasmus.csv')

```
### Data Dictionary

# `erasmus.csv`

|variable                            |class     |description |
|:-----------------------------------|:---------|:-----------|
|project_reference                   |character |Project reference is an aggregation of several information (YYYY-X-AAAA-KKKKK-NNNNN) where YYYY represent year, X represents the round within the call year, AAAA represents the National Agency managing the project, KKKKK is the key action code and NNNNNN is an auto generated number |
|academic_year                       |character | Only relevant for higher education (KA103, KA107) - Year-Month (YYYY-MM) |
|mobility_start_month                |character | Year-Month (YYYY-MM) |
|mobility_end_month                  |character | Year-Month (YYYY-MM) |
|mobility_duration                   |double    | Exact duration of the mobility in calendar days (date2-date1) |
|activity_mob                        |character |.           |
|field_of_education                  |character | Participant field of education |
|participant_nationality             |character | Code (DE, FR, BE, …..) |
|education_level                     |character | Included where relevant |
|participant_gender                  |character | Male/Female/Undefined |
|participant_profile                 |character | Staff or learner, training can be retrieved from activity field |
|special_needs                       |character | Yes/no|
|fewer_opportunities                 |character | Yes/no |
|group_leader                        |character | Yes/no |
|participant_age                     |double    |Age at start of mobility in years |
|sending_country_code                |character | Code (DE, FR, BE, …..) |
|sending_city                        |character |City of sending organisation|
|sending_organization                |character | Name of organisation |
|sending_organisation_erasmus_code   |character | Organisation Erasmus code |
|receiving_country_code              |character | Code (DE, FR, BE, …..) |
|receiving_city                      |character | City of receiving organisationn |
|receiving_organization              |character | Name of organisation |
|receiving_organisation_erasmus_code |character | Organisation Erasmus code |
|participants                        |double    | Total number of participants |

### Cleaning Script

