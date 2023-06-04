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

# Verified Oldest People

The data this week comes from the [Wikipedia List of the verified oldest people](https://en.wikipedia.org/wiki/List_of_the_verified_oldest_people) via [frankiethull on GitHub](https://github.com/frankiethull/centenarians). Thank you for the submission, Frank!

> These are lists of the 100 known verified oldest people sorted in descending order by age in years and days. The oldest person ever whose age has been independently verified is Jeanne Calment (1875–1997) of France, who lived to the age of 122 years and 164 days. The oldest verified man ever is Jiroemon Kimura (1897–2013) of Japan, who lived to the age of 116 years and 54 days. The oldest known living person is Maria Branyas of Spain, aged 116 years, 85 days. The oldest known living man is Juan Vicente Pérez of Venezuela, aged 114 years, 1 day. The 100 oldest women have, on average, lived several years longer than the 100 oldest men.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-05-30')
tuesdata <- tidytuesdayR::tt_load(2023, week = 22)

centenarians <- tuesdata$centenarians

# Or read in the data manually

centenarians <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-30/centenarians.csv')

```

### Data Dictionary

# `centenarians.csv`

|variable                    |class     |description                 |
|:---------------------------|:---------|:---------------------------|
|rank                        |integer   |This person's overall rank by age.|
|name                        |character |The full name of this person.|
|birth_date                  |date      |This person's birth date.|
|death_date                  |date      |This person's death date (or NA if still alive).|
|age                         |double   |The person's age, either on the day of their death or on the day when the dataset was extracted on 2023-05-25.|
|place_of_death_or_residence |character |Where the person lives now or where they were when they died.|
|gender                      |character |Most likely actually the sex assigned to the person at birth (the source article does not specify).|
|still_alive                 |character |Either "alive" if the person was still alive at the time when the article as referenced, or "deceased" if the person was no longer alive.|

### Cleaning Script

No data cleaning. See the [source GitHub repo](https://github.com/frankiethull/centenarians) for details.
