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

# Publications List

The data this week comes from [Project Oasis](https://www.projectnewsoasis.com/publications) by way of [Data is Plural](https://www.data-is-plural.com/archive/2022-03-30-edition/).

Read the full [report](https://www.projectnewsoasis.com/sites/default/files/2022-02/project-oasis-report-2021-1.pdf)

> You can browse a comprehensive list of digitally focused, local news organizations below. Filter your view with the options to the right to narrow the scope of organizations that appear. Clicking on an organization will take you to its profile page, which includes more details about the publisher. All information in the database was self-reported by the organizations or is publicly available.

> Project Oasis is a collaboration between UNC Hussman School of Journalism and Media, LION Publishers, Douglas K. Smith and the Google News Initiative to map the progress and choices of locally focused digital news publishers, and share the most relevant insights with you. See below for FAQs about the project and the criteria used in the research.

More articles by [NiemanLab](https://www.niemanlab.org/2020/03/the-google-backed-project-oasis-hopes-to-crack-the-code-of-successful-local-digital-news-organizations/)

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-04-05')
tuesdata <- tidytuesdayR::tt_load(2022, week = 14)

news_orgs <- tuesdata$news_orgs

# Or read in the data manually

news_orgs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-04-05/news_orgs.csv')

```
### Data Dictionary

# `news_orgs.csv`

|variable                                      |class     |description |
|:---------------------------------------------|:---------|:-----------|
|publication_name                              |character | Name|
|parent_publication                            |character | Parent publication       |
|url                                           |character | Website |
|owner                                         |character | Owner name    |
|is_owner_founder                              |character | Is the owner the founder? |
|city                                          |character | City|
|state                                         |character | State       |
|country                                       |character | Country      |
|primary_language                              |character | Language    |
|primary_language_other                        |logical   | Other lang   |
|tax_status_founded                            |character | Tax status when founded |
|tax_status_current                            |character | Tax status current |
|year_founded                                  |double    | Year founded |
|total_employees                               |character | Total N of employees|
|budget_percent_editorial                      |character | Budget % editorial |
|budget_percent_revenue_generation             |character | Budget % revenue generation |
|budget_percent_product_technology             |character | Budget percent product tech |
|budget_percent_administration                 |character | Budget percent admin |
|products                                      |character | Products |
|products_other                                |character | Products other   |
|distribution                                  |character | Distribution method|
|distribution_method_other                     |character | Distribution method other  |
|geographic_area                               |character | Geographic area |
|core_editorial_strategy_characteristics       |character | Core editorial strategy |
|core_editorial_strategy_characteristics_other |character | Core editorial strategy other  |
|coverage_topics                               |character | Coverage topics |
|coverage_topics_other                         |logical   | Coverage topics other |
|underrepresented_communities                  |character | Underrepresented community types|
|underrepresented_communities_not_listed       |character | Other community |
|revenue_streams                               |character | Revenue stream|
|revenue_stream_other                          |logical   | Revenue stream other |
|revenue_stream_additional_info                |logical   | Revenue stream additional |
|revenue_stream_largest                        |character | Largest revenue stream |
|revenue_streams_largest_other                 |character | Largest revenue stream other |
|paywall_or_gateway                            |character | Paywall or gateway? |
|paywall_or_gateway_other                      |logical   | Paywall or gateway other|
|advertising_products                          |character | Advertising products |
|advertising_product_other                     |logical   | ADvertising products other |
|real_world_impacts                            |character | Real world impacts|
|summary                                       |character | Summary|

### Cleaning Script

