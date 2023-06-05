### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> ### Chart type
> It's helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you're including this visual. What does it show that's meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don't include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

![Company D, 8th Illinois Volunteer Regiment. Image collected by W.E.B .Du Bois and Thomas J Calloway, January 1, 1899. Photo: Universal History Archive/Universal Images Group via Getty Images](https://theintercept.imgix.net/wp-uploads/sites/1/2020/06/webdubois-theintercept-embed.jpg?auto=compress%2Cformat&q=90&w=1024&h=633)

# Du Bois and Juneteenth Revisited

The data this week comes from [Anthony Starks](https://twitter.com/ajstarks), [Allen Hillery](https://twitter.com/AlDatavizguy/status/1358454676497313792?s=20) [Sekou Tyler](https://twitter.com/sqlsekou/status/1360281040657522689?s=20). The tweets aggregated show the [`#DuBoisChallenge`](https://github.com/ajstarks/dubois-data-portraits/blob/master/challenge/README.md) tweets from 2021. The data used for the challenge is also accessible from [TidyTuesday week 8 of 2021](https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-02-16/readme.md).

Sekou has also visualized the Twitter activity in a [dashboard](https://public.tableau.com/app/profile/sekou.tyler/viz/DuBoisChalllenge2021TwitterMetrics/DuBoisChallenge2021TwitterActivity).

Please also revisit the [2020 data](https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-06-16/readme.md) for data for and recognition of Juneteenth. While Juneteenth recognizes the political act of the freeing of the last American slaves in Texas, W.E.B Du Bois argued a more poignant detail:
> in a series of landmark works, is that some 500,000 Black Americans freed themselves from slavery by walking off their plantation, with many of them joining up with the Union Army. Then, with the help of some Union Army officers, they organized themselves into soldiers, officers, farmers, spies, cooks, and nurses who enabled the Union to win the war, while their absence on plantations crippled the South's economy. This is the true Juneteenth: a freedom won by the freed.

- [WEB Du Bois](https://en.wikipedia.org/wiki/W._E._B._Du_Bois)  

- [The Intercept - Juneteenth](https://theintercept.com/2020/06/19/how-to-mark-juneteenth-in-the-year-2020/)  

Juneteenth details from the Intercept.

> The holiday marks, generally, the end of slavery in the United States, and more specifically the order of Gen. Gordon Granger that declared the freedom of enslaved people in Texas, a state that was a stubborn holdout after Gen. Robert E. Lee had surrendered his army. The order was read on June 19, 1865, and lore has it that upon learning of emancipation, those it applied to stopped working instantly and launched into celebration. 
> 
> That wasn't the only work stoppage that Juneteenth celebrates. Some of the discourse surrounding Juneteenth is palatable to corporate America because it can reinforce some of the comforting ideas about the Civil War: that Abraham Lincoln and the generals of the Union Army, in their benevolence, freed the slaves. The reality, argued W.E.B Du Bois in a series of landmark works, is that some 500,000 Black Americans freed themselves from slavery by walking off their plantation, with many of them joining up with the Union Army. Then, with the help of some Union Army officers, they organized themselves into soldiers, officers, farmers, spies, cooks, and nurses who enabled the Union to win the war, while their absence on plantations crippled the South's economy. This is the true Juneteenth: a freedom won by the freed.

- [PBS on Juneteenth](https://www.pbs.org/wnet/african-americans-many-rivers-to-cross/history/what-is-juneteenth/)

### Get the data here

Please note that data can also be used from 2021 week 8 and 2020 week 24/25.

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-06-15')
tuesdata <- tidytuesdayR::tt_load(2021, week = 25)

tweets <- tuesdata$tweets

# Or read in the data manually

tweets <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-06-15/tweets.csv')
```
### Data Dictionary

# `tweets.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|datetime      |double    | Date and time of tweet |
|content       |character | Text for tweet |
|retweet_count |double    | Retweet count for tweet |
|like_count    |double    | Like count for tweet |
|quote_count   |double    | Quote tweet count for tweet |
|text          |character | Where tweet was posted from |
|username      |character | Username of Tweeter |
|location      |character | Location tweeted from |
|followers     |double    | Followers of the tweeter |
|url           |character | Canonical url of tweet |
|verified      |logical   | Is user verified? |
|lat           |double    | Latitude of user |
|long          |double    | Longitude of user |

### Cleaning Script

No cleaning script this week!
