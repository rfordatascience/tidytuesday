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

# Dog breeds

The data this week comes from the American Kennel Club courtesy of [KKakey](https://github.com/kkakey/dog_traits_AKC/blob/main/README.md) - thanks!

- `breed_traits` - trait information on each dog breed and scores for each trait (wide format)
- `trait_description` - long descriptions of each trait and values corresponding to `Trait_Score`
- `breed_rank_all` - popularity of dog breeds by AKC registration statistics from 2013-2020

[USA Today Article](https://www.usatoday.com/picture-gallery/life/2021/06/28/the-50-most-popular-dog-breeds-in-america/45134329/) and [Vox](https://www.vox.com/2016/8/31/12715176/most-popular-dog-breeds) with more graphics.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-02-01')
tuesdata <- tidytuesdayR::tt_load(2022, week = 5)

breed_traits <- tuesdata$breed_traits

# Or read in the data manually

breed_traits <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_traits.csv')
trait_description <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/trait_description.csv')
breed_rank_all <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-01/breed_rank.csv')

```
<img src="https://media-cldnry.s-nbcnews.com/image/upload/newscms/2020_28/1587661/dogs-age-years-kb-inline-200707.jpg" alt="image of five puppies sitting and looking at camera with a white background" width="300" >


## Data Dictionary

### `breed_traits.csv`

|variable        |class     |description |
|:---------------|:---------|:-----------|
|Breed    |character | Dog Breed |
|Affectionate With Family            |character | Placement on scale of 1-5 for the breed's tendancy to be "Affectionate With Family" (Trait_Score) |
|Good With Young Children            |character | Placement on scale of 1-5 for the breed's tendancy to be "Good With Young Children" (Trait_Score) |
|Good With Other Dogs          |character | Placement on scale of 1-5 for the breed's tendancy to be "Good With Other Dogs" (Trait_Score) |
|Shedding Level          |character | Placement on scale of 1-5 for the breed's "Shedding Level" (Trait_Score) |
|Coat Grooming Frequency         |character | Placement on scale of 1-5 for the breed's "Coat Grooming Frequency" (Trait_Score) |
|Drooling Level         |character | Placement on scale of 1-5 for the breed's "Drooling Level" (Trait_Score) |
|Coat Type         |character | Description of the breed's coat type (Trait_Score) |
|Coat Length         |character | Description of the breed's coat length (Trait_Score) |
|Openness To Strangers            |character | Placement on scale of 1-5 for the breed's tendancy to be open to strangers (Trait_Score) |
|Playfulness Level           |character | Placement on scale of 1-5 for the breed's tendancy to be playful (Trait_Score) |
|Watchdog/Protective Nature         |character | Placement on scale of 1-5 for the breed's "Watchdog/Protective Nature" (Trait_Score) |
|Adaptability Level         |character | Placement on scale of 1-5 for the breed's tendancy to be adaptable (Trait_Score) |
|Trainability Level        |character | Placement on scale of 1-5 for the breed's tendancy to be adaptable (Trait_Score) |
|Energy Level         |character | Placement on scale of 1-5 for the breed's "Energy Level" (Trait_Score) |
|Barking Level         |character | Placement on scale of 1-5 for the breed's "Barking Level" (Trait_Score) |
|Mental Stimulation Needs         |character | Placement on scale of 1-5 for the breed's "Mental Stimulation Needs" (Trait_Score) |

### `trait_description.csv`

|variable        |class     |description |
|:---------------|:---------|:-----------|
|Trait    |character | Dog Breed |
|Trait_1            |character | Value corresponding to `Trait` when `Trait_Score` = 1 |
|Trait_5            |character    | Value corresponding to `Trait` when `Trait_Score` = 5 |
|Description            |character | Long description of trait |

### `breed_rank_all.csv`

|variable        |class     |description |
|:---------------|:---------|:-----------|
|Breed    |character | Dog Breed |
|2013 Rank            |character | Popularity of breed based on AKC registration statistics in 2013 |
|2014 Rank            |character | Popularity of breed based on AKC registration statistics in 2014 |
|2015 Rank            |character | Popularity of breed based on AKC registration statistics in 2015 |
|2016 Rank            |character | Popularity of breed based on AKC registration statistics in 2016 |
|2017 Rank            |character | Popularity of breed based on AKC registration statistics in 2017 |
|2018 Rank            |character | Popularity of breed based on AKC registration statistics in 2018 |
|2019 Rank            |character | Popularity of breed based on AKC registration statistics in 2020 |
|2020 Rank            |character | Popularity of breed based on AKC registration statistics in 2019 |
|links            |character    | Link to the dog breed's AKC webpage |
|Image            |character    | Link to image of dog breed |

********************************************************

Scripts to retrieve the data: 
- [webscraping_script-1.Rmd](https://github.com/kkakey/dog_traits_AKC/blob/main/webscraping_script-1.Rmd)
- [webscraping_script-2.Rmd](https://github.com/kkakey/dog_traits_AKC/blob/main/webscraping_script-2.Rmd)

Last retrieved on Dec. 23, 2021
