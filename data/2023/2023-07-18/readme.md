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

# GPT detectors 

The data this week comes from Simon Couch's [detectors R package](https://github.com/simonpcouch/detectors/). containing predictions from various GPT detectors. 

The data is based on the pre-print:

GPT Detectors Are Biased Against Non-Native English Writers. Weixin Liang, Mert Yuksekgonul, Yining Mao, Eric Wu, James Zou. arXiv: [2304.02819](https://arxiv.org/abs/2304.02819)

> The study authors carried out a series of experiments passing a number of essays to different GPT detection models. Juxtaposing detector predictions for papers written by native and non-native English writers, the authors argue that GPT detectors disproportionately classify real writing from non-native English writers as AI-generated.



### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-07-18')
tuesdata <- tidytuesdayR::tt_load(2023, week = 29)

detectors <- tuesdata$detectors

# Or read in the data manually

detectors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-07-18/detectors.csv')

```

### Data Dictionary

# `detectors.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|kind        |character |Whether the essay was written by a "Human" or "AI".      |
|.pred_AI    |double    |The class probability from the GPT detector that the inputted text was written by AI. |
|.pred_class |character |The uncalibrated class prediction, encoded as `if_else(.pred_AI > .5, "AI", "Human")` |
|detector    |character |The name of the detector used to generate the predictions. |
|native      |character |For essays written by humans, whether the essay was written by a native English writer or not. These categorizations are coarse; values of `"Yes"` may actually be written by people who do not write with English natively. `NA` indicates that the text was not written by a human.   |
|name        |character |A label for the experiment that the predictions were generated from. |
|model       |character |For essays that were written by AI, the name of the model that generated the essay.  |
|document_id |double    |A unique identifier for the supplied essay. Some essays were supplied to multiple detectors. Note that some essays are AI-revised derivatives of others. |
|prompt      |character |For essays that were written by AI, a descriptor for the form of "prompt engineering" passed to the model. |

### Cleaning Script

csv file was generated from the detectors tibble in the 'detectors' R package. 
