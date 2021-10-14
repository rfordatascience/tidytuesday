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

![A photo of several fishermen standing over about a dozen large green buckets of fish. The fish are light grey and white, very long and each is about 12 inches long. They are on a beach, with the ocean in the background.](https://images.unsplash.com/photo-1507991426709-5bbee2c6a189?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1548&q=80)

# Global Fishing

The data this week comes from [OurWorldinData.org](https://ourworldindata.org/seafood-production). More details can be found on their site.

* Increasing pressures on fish populations mean one-third of global fish stocks are overexploited – this has increased from 10% in the 1970s.  
* The world now produces more than 155 million tonnes of seafood each year.  
* There are large differences in per capita fish consumption across the world.  
* The world now produces more seafood from aquaculture (fish farming) than from wild catch. This has played a key role in alleviating pressure on wild fish populations.  

### Get the data here
	
```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-10-12')
tuesdata <- tidytuesdayR::tt_load(2021, week = 42)

consumption <- tuesdata$`fish-and-seafood-consumption-per-capita`

# Or read in the data manually

farmed <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-12/aquaculture-farmed-fish-production.csv')
captured_vs_farmed <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-12/capture-fisheries-vs-aquaculture.csv')
captured <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-12/capture-fishery-production.csv')
consumption <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-12/fish-and-seafood-consumption-per-capita.csv')
stock <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-12/fish-stocks-within-sustainable-levels.csv')
fishery <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-12/global-fishery-catch-by-sector.csv')
production <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-12/seafood-and-fish-production-thousand-tonnes.csv')

```
### Data Dictionary

# `seafood_consumption.csv`

# `aquaculture-farmed-fish-production.csv`

|variable                             |class     |description |
|:------------------------------------|:---------|:-----------|
|Entity                               |character | Country/entity |
|Code                                 |character | Country code (see `countrycode` R package) |
|Year                                 |double    |.           |
|Aquaculture production (metric tons) |double    |.           |

# `capture-fisheries-vs-aquaculture.csv`

|variable                                   |class     |description |
|:------------------------------------------|:---------|:-----------|
|Entity                               |character | Country/entity |
|Code                                 |character | Country code (see `countrycode` R package) |
|Year                                       |double    | Year|
|Aquaculture production (metric tons)       |double    | Production of aquaculture animals|
|Capture fisheries production (metric tons) |double    | Captured aquaculture |

# `capture-fishery-production.csv`

|variable                                   |class     |description |
|:------------------------------------------|:---------|:-----------|
|Entity                               |character | Country/entity |
|Code                                 |character | Country code (see `countrycode` R package) |
|Year                                       |double    | Year |
|Capture fisheries production (metric tons) |double    | Captured fisheres production |

# `fish-and-seafood-consumption-per-capita.csv`

|variable                                                       |class     |description |
|:--------------------------------------------------------------|:---------|:-----------|
|Entity                               |character | Country/entity |
|Code                                 |character | Country code (see `countrycode` R package) |
|Year                                                           |double    | Year |
|Fish, Seafood- Food supply quantity (kg/capita/yr) (FAO, 2020) |double    | Food supply in fish in kg/capita/year |

# `fish-stocks-within-sustainable-levels.csv`

|variable                                                                |class     |description |
|:-----------------------------------------------------------------------|:---------|:-----------|
|Entity                               |character | Country/entity |
|Code                                 |character | Country code (see `countrycode` R package) |
|Year                                                                    |double    | Year |
|Share of fish stocks within biologically sustainable levels (FAO, 2020) |double    | Share of sustainable fish stock |
|Share of fish stocks that are overexploited                             |double    | Share of fish stock that are overexploited |


# `global-fishery-catch-by-sector.csv`

|variable                            |class     |description |
|:-----------------------------------|:---------|:-----------|
|Entity                               |character | Country/entity |
|Code                                 |character | Country code (see `countrycode` R package) |
|Year                                |double    | Year |
|Artisanal (small-scale commercial)  |double    | Catch by small-scale commercial |
|Discards                            |double    | Discarded quantities |
|Industrial (large-scale commercial) |double    | Large scale commercial |
|Recreational                        |double    | Recreational fishing |
|Subsistence                         |double    | Food caught to feed self/family |

# `seafood-and-fish-production-thousand-tonnes.csv`

|variable                                      |class     |description |
|:----------------------------------------------|:---------|:-----------|
|Entity                               |character | Country/entity |
|Code                                 |character | Country code (see `countrycode` R package) |
|Year                                          |double    |.           |
|Pelagic Fish - 2763 - Production - 5510 - tonnes       |double    | Pelagic Fish |
|Crustaceans - 2765 - Production - 5510 - tonnes        |double    | Crustaceans |
|Cephalopods - 2766 - Production - 5510 - tonnes        |double    | Cephalopods |
|Demersal Fish - 2762 - Production - 5510 - tonnes      |double    | Demersal |
|Freshwater Fish - 2761 - Production - 5510 - tonnes    |double    | Freshwater |
|Molluscs, Other - 2767 - Production - 5510 - tonnes    |double    | Molluscs |
|Marine Fish, Other - 2764 - Production - 5510 - tonnes |double    | Marine |

### Cleaning Script

