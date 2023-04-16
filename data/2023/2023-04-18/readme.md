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

# Neolithic Founder Crops

The data this week comes from [The "Neolithic Founder Crops"" in Southwest Asia: Research Compendium](https://github.com/joeroe/SWAsiaNeolithicFounderCrops/). ["Revisiting the concept of the 'Neolithic Founder Crops' in southwest Asia"](https://link.springer.com/article/10.1007/s00334-023-00917-1) is an open-access research paper that uses the data. Thank you for sharing your research, [@joeroe](https://github.com/joeroe)!

According to the [social media thread about this dataset](https://fosstodon.org/@joeroe@archaeo.social/110186477750041419):

> Eight 'founder crops' — emmer wheat, einkorn wheat, barley, lentil, pea, chickpea, bitter vetch, and flax — have long been thought to have been the bedrock of #Neolithic economies. 
> ...
> We found that Neolithic economies were much more diverse than previously thought, incorporating dozens of species of cereals, legumes, small-seeded grasses, brassicas, pseudocereals, sedges, flowering plants, trees, and shrubs. Free-threshing wheat, grass pea, faba bean, and ‘new’ glume wheat were especially widely cultivated.

Read the thread for context about this data!

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-04-18')
tuesdata <- tidytuesdayR::tt_load(2023, week = 16)

founder_crops <- tuesdata$founder_crops

# Or read in the data manually

founder_crops <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-18/founder_crops.csv')
```

### Data Dictionary

# `founder_crops.csv`

|variable          |class     |description       |
|:-----------------|:---------|:-----------------|
|source            |character |the source database|
|source_id         |character |id of this record in the source database|
|source_site_name  |character |name of the site in the source database|
|site_name         |character |standardized site name|
|latitude          |double    |latitude          |
|longitude         |double    |longitude         |
|phase             |character |phase             |
|phase_description |character |phase_description |
|phase_code        |character |phase_code        |
|age_start         |double    |oldest date for the record, in years before 1950 CE (years BP)|
|age_end           |double    |most recent date for the record, in years before 1950 CE (years BP)|
|taxon_source      |character |taxonomy as stated in the course database|
|n                 |double    |number of individuals in the sample|
|prop              |double    |proportion of this sample that contains this crop|
|reference         |character |papers describing this data|
|taxon_detail      |character |canonical name for this taxonomic group|
|taxon             |character |taxonomic details for this sample; this and the previous column may have been swapped in the source|
|genus             |character |genus             |
|family            |character |family            |
|category          |character |broad category for this sample|
|founder_crop      |character |traditional founder crop to which this sample belongs|
|edibility         |character |parts of the plant that are edible, if any|
|grass_type        |character |for grasses, the category for this sample|
|legume_type       |character |for legumes, the category for this sample|

### Cleaning Script

```r
# All packages used in this script:
library(tidyverse)
library(here)

url <- "https://raw.githubusercontent.com/joeroe/SWAsiaNeolithicFounderCrops/main/analysis/data/derived_data/swasia_neolithic_flora.tsv"
founder_crops <- readr::read_tsv(url) |> 
  # de-duplicate the reference column
  dplyr::mutate(
    reference = purrr::map_chr(
      reference,
      \(ref) {
        if (is.na(ref)) {
          return(NA)
        }
        ref |> 
          stringr::str_split_1(";") |> 
          unique() |> 
          paste(collapse = ";")
      }
    )
  )

readr::write_csv(
  founder_crops,
  here::here(
    "data",
    "2023",
    "2023-04-18",
    "founder_crops.csv"
  )
)
```
