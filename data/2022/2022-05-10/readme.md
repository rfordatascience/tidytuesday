### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`.

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing *good* alt text for plots/graphs.

> Here’s a simple formula for writing alt text for data visualization:
>
> ### Chart type
>
> It’s helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual. Example: Line graph
>
> ### Type of data
>
> What data is included in the chart? The x and y axis labels may help you figure this out. Example: number of bananas sold per day in the last year
>
> ### Reason for including the chart
>
> Think about why you’re including this visual. What does it show that’s meaningful. There should be a point to every visual and you should tell people what to look for. Example: the winter months have more banana sales
>
> ### Link to data or source
>
> Don’t include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data. Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# NY Times bestsellers list

The data this week comes from [Post45 Data](https://data.post45.org/our-data/) by way of [Sara Stoudt](https://github.com/rfordatascience/tidytuesday/issues/434).

See their [Data Description](https://data.post45.org/wp-content/uploads/2022/01/NYT-Data-Description.pdf) for full details.

> Each peer-reviewed dataset has an accompanying curatorial statement, which provides an overview of the data that explains its contents, construction, and some possible uses.
> 
> Please cite data from the Post45 Data Collective and use the following six components in your citation: 
> 
> -   author name(s)  
> 
> -   date published in the Post45 repository 
> 
> -   title  
> 
> -   global persistent > identifier: [DOI](https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F> %2Fwww.doi.org%2F&data=04%7C01%7Ckayla.shipp.kamibayashi%40emory.edu%7C31069808f> 9074a2a59ad08d8ce96abd0%7Ce004fb9cb0a4424fbcd0322606d5df38%7C0%7C0%7C63748649381> 8763862%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h> aWwiLCJXVCI6Mn0%3D%7C1000&sdata=3EOVEbBZrdRlmq3n%2BFQkyf8cEK7jdW99oo8LFoSqXEo%3D> &reserved=0 "Original URL: http://www.doi.org/. Click or tap if you trust this > link.")   
> 
> -   Post45 Data Collective 
> 
> -   version number 
> 
> *Example replication data citation from The Program Era Project, Kelly, White, and Glass, 2021:*
> 
>  *Kelly, Nicholas; White, Nicole, Glass, Loren, 03/01/2021, “The Program Era > Project,” DOI: <https://doi.org/10.18737/CNJV1733p4520210415>, Post45 Data > Collective, V1.*

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-05-10')
tuesdata <- tidytuesdayR::tt_load(2022, week = 19)

nyt_titles <- tuesdata$nyt_titles

# Or read in the data manually

nyt_titles <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-10/nyt_titles.tsv')
nyt_full <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-10/nyt_full.tsv')

```

### Data Dictionary

# `nyt_titles.tsv`

This is a subset/summary of the larger dataset.

| variable    | class     | description                      |
|:------------|:----------|:---------------------------------|
| id          | double    | Book id                          |
| title       | character | Title of book                    |
| author      | character | Author                           |
| year        | double    | Year                             |
| total_weeks | double    | Total weeks on best sellers list |
| first_week  | double    | First week on list (date)        |
| debut_rank  | double    | Debut rank on the list           |
| best_rank   | double    | Best rank                        |

# `nyt_full.tsv`

| variable | class     | description    |
|:---------|:----------|:---------------|
| year     | double    | Year           |
| week     | double    | Week (as date) |
| rank     | double    | Rank (1 \> 18) |
| title_id | double    | Title ID       |
| title    | character | Title of book  |
| author   | character | Author         |

### Cleaning Script
