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

# Bob Ross Paintings

The data this week comes from Jared Wilber's data on [Bob Ross Paintings](https://github.com/jwilber/Bob_Ross_Paintings/blob/master/data/bob_ross_paintings.csv) via @frankiethull [Bob Ross Colors data package](https://github.com/frankiethull/BobRossColors).

> This is data from the [paintings of Bob Ross](https://www.twoinchbrush.com/all-paintings) featured in the TV Show 'The Joy of Painting'.

@frankiethull created an R data package [{BobRossColors}](https://github.com/frankiethull/BobRossColors) with information on the palettes that leveraged imgpalr to mine divergent and qualitative colors from each painting image. In addition, unique Bob Ross named colors are in the package as well.

In the github repository of the dataset, there are also [pngs of the paintings](https://github.com/jwilber/Bob_Ross_Paintings/tree/master/data/paintings) themselves!

You might also want to check out our [previous Bob Ross dataset from 2019-08-06](https://tidytues.day/2019/2019-08-06) to see if there are correlations between named objects and named colors!



### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-02-21')
tuesdata <- tidytuesdayR::tt_load(2023, week = 8)

bob_ross <- tuesdata$bob_ross

# Or read in the data manually

bob_ross <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-21/bob_ross.csv')
```

### Data Dictionary

# `bob_ross.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
|painting_index   |double    |	Painting number as enumerated in collection.   |
|img_src          |character |	Url path to image.      |
|painting_title   |character |	Title of the painting.  |
|season           |double    |  Season of 'The Joy of Painting' in which the painting was featured.           |
|episode          |double    |  Episode of 'The Joy of Painting' in which the painting was featured.	        |
|num_colors       |double    |  Number of unique colors used in the painting.       |
|youtube_src      |character |	Youtube video of episode featuring the painting.      |
|colors           |character |	List of colors used in the painting.          |
|color_hex        |character |	List of colors (hexadecimal code) used in the painting.     |
|Black_Gesso      |logical |Black_Gesso used |
|Bright_Red       |logical |Bright_Red used |
|Burnt_Umber      |logical |Burnt_Umber used |
|Cadmium_Yellow   |logical |Cadmium_Yellow used |
|Dark_Sienna      |logical |Dark_Sienna used |
|Indian_Red       |logical |Indian_Red used |
|Indian_Yellow    |logical |Indian_Yellow used |
|Liquid_Black     |logical |Liquid_Black used |
|Liquid_Clear     |logical |Liquid_Clear used |
|Midnight_Black   |logical |Midnight_Black used |
|Phthalo_Blue     |logical |Phthalo_Blue used |
|Phthalo_Green    |logical |Phthalo_Green used |
|Prussian_Blue    |logical |Prussian_Blue used |
|Sap_Green        |logical |Sap_Green used |
|Titanium_White   |logical |Titanium_White used |
|Van_Dyke_Brown   |logical |Van_Dyke_Brown used |
|Yellow_Ochre     |logical |Yellow_Ochre used |
|Alizarin_Crimson |logical |Alizarin_Crimson used |

### Cleaning Script

```r
library(tidyverse)

# Read in the data
bob_ross <- read_csv(
  "https://raw.githubusercontent.com/jwilber/Bob_Ross_Paintings/master/data/bob_ross_paintings.csv",
) 

glimpse(bob_ross)

# The first column doesn't contain data that we need, so we can remove it

bob_ross <- select(bob_ross, -1)

# Several columns refer to presence/absence of named colors.

bob_ross <- bob_ross |> 
  mutate(
    across(Black_Gesso:Alizarin_Crimson, as.logical)
  )

# Save the data.
write_csv(
  bob_ross,
  here::here(
    "data", "2023", "2023-02-21",
    "bob_ross.csv"
  )
)
```