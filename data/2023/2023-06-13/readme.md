### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics
for `#TidyTuesday`.

Twitter provides
[guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions)
for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an
[article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81)
on writing *good* alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> \### Chart type It's helpful for people with partial sight to know
> what chart type it is and gives context for understanding the rest of
> the visual. Example: Line graph \### Type of data What data is
> included in the chart? The x and y axis labels may help you figure
> this out. Example: number of bananas sold per day in the last year
> \### Reason for including the chart Think about why you're including
> this visual. What does it show that's meaningful. There should be a
> point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales \### Link to data or
> source Don't include this in your alt text, but it should be included
> somewhere in the surrounding text. People should be able to click on a
> link to view the source data or dig further into the visual. This
> provides transparency about your source and lets people explore the
> data. Example: Data from the USDA

Penn State has an
[article](https://accessibility.psu.edu/images/charts/) on writing alt
text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users.
> But since they are images, these media provide serious accessibility
> issues to colorblind users and users of screen readers. See the
> [examples on this page](https://accessibility.psu.edu/images/charts/)
> for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post
tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with
alt text programatically.

Need a **reminder**? There are
[extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related)
that force you to remember to add Alt Text to Tweets with media.

# SAFI survey data

The data this week comes from the [SAFI (Studying African Farmer-Led Irrigation) survey](https://datacarpentry.org/socialsci-workshop/data/), a subset of the data used in the [Data Carpentry Social Sciences workshop](https://datacarpentry.org/socialsci-workshop/). So, if you're looking how to learn how to work with this data, lessons are already available! Data is available through [Figshare](https://figshare.com/articles/dataset/SAFI_Survey_Results/6262019). 

CITATION: Woodhouse, Philip; Veldwisch, Gert Jan; Brockington, Daniel; Komakech, Hans C.; Manjichi, Angela; Venot, Jean-Philippe (2018): SAFI Survey Results. doi:10.6084/m9.figshare.6262019.v1

> SAFI (Studying African Farmer-Led Irrigation) is a currently running project which is looking at farming and irrigation methods. This is survey data relating to households and agriculture in Tanzania and Mozambique. The survey data was collected through interviews conducted between November 2016 and June 2017 using forms downloaded to Android Smartphones. The survey forms were created using the ODK (Open Data Kit) software via an Excel spreadsheet. The collected data is then sent back to a central server. The server can be used to download the collected data in both JSON and CSV formats. This is a teaching version of the collected data that we will be using. It is not the full dataset.

> The survey covered such things as; household features (e.g. construction materials used, number of household members), agricultural practices (e.g. water usage), assets (e.g. number and types of livestock) and details about the household members.

> The basic teaching dataset used in these lessons is a subset of the JSON dataset that has been converted into CSV format.



### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-06-13')
tuesdata <- tidytuesdayR::tt_load(2023, week = 24)

safi_data.csv <- tuesdata$`safi_data`

# Or read in the data manually

safi_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-13/safi_data.csv')
```

### Data Dictionary

# `safi_data.csv`

|variable             |class     |description          |
|:--------------------|:---------|:--------------------|
|key_ID               |integer   | Added to provide a unique Id for each observation. (The InstanceID field does this as well but it is not as convenient to use)  |
|village              |character | Village name             |
|interview_date       |character | Date of interview    |
|no_membrs            |integer   | Number of members in the household |
|years_liv            |integer   | Number of years living in this village or a neighboring village    |
|respondent_wall_type |character | Type of walls the house has |
|rooms                |integer   | Number of rooms in the main house used for sleeping          |
|memb_assoc           |character | Are you a member of an irrigation association? |
|affect_conflicts     |character | Have you been affected by conflicts with other irrigators in the area? |
|liv_count            |integer   | Livestock count          |
|items_owned          |character | Items owned by the household        |
|no_meals             |integer   | How many meals do people in your household normally eat in a day?            |
|months_lack_food     |character | 	Indicate which months, In the last 12 months have you faced a situation when you did not have enough food to feed the household?   |
|instanceID           |character | 	Unique identifier for the form data submission |


### Cleaning Script

Data was cleaned for the Data Carpentry Social Science lessons. Information available on their [SAFI Teaching Dataset page](https://datacarpentry.org/socialsci-workshop/data/). 
