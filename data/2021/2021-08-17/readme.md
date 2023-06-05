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

![Image of three characters from Star Trek huddled around the onboard computer, reading through some of the on screen prompts.](https://nerdist.com/wp-content/uploads/2020/06/data-computer.jpg)

# Star Trek commands

The data this week comes from [SpeechInteraction.org](http://www.speechinteraction.org/TNG/). H/t to [Sara Stoudt](https://github.com/rfordatascience/tidytuesday/issues/346) for sharing this dataset.

> ### Tea, Earl Grey, Hot: Designing Speech Interactions from the Imagined Ideal of Star Trek

> Speech is now common in daily interactions with our devices, thanks to voice user interfaces (VUIs) like Alexa. Despite their seeming ubiquity, designs often do not match users' expectations. Science fiction, which is known to influence design of new technologies, has included VUIs for decades. Star Trek: The Next Generation is a prime example of how people envisioned ideal VUIs. Understanding how current VUIs live up to Star Trek's utopian technologies reveals mismatches between current designs and user expectations, as informed by popular fiction. Combining conversational analysis and VUI user analysis, we study voice interactions with the Enterprise's computer and compare them to current interactions. Independent of futuristic computing power, we find key design-based differences: Star Trek interactions are brief and functional, not conversational, they are highly multimodal and context-driven, and there is often no spoken computer response. From this, we suggest paths to better align VUIs with user expectations.

Example commands are available on [YouTube](https://www.youtube.com/watch?v=qotCgA26Fp8).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-08-17')
tuesdata <- tidytuesdayR::tt_load(2021, week = 34)

computer <- tuesdata$computer

# Or read in the data manually

computer <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-08-17/computer.csv')

```
### Data Dictionary

See full details at [SpeechInteraction.org](http://www.speechinteraction.org/TNG/TeaEarlGreyHotDatasetCodeBook.pdf)

# `computer.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|name        |character | ID name |
|char        |character | The name of the speaking character |
|line        |character | The complete line of dialog (may contain more speech than the speech interaction). Parentheticals are directions and not spoken. |
|direction   |character | Stage directions as written in the episode script |
|type        |character | The type of interaction, see detailed definitions below |
|pri_type    |character | The primary interaction type as defined by the below ranking |
|domain      |character | The domain of interaction, see detailed definitions below |
|sub_domain  |character | The sub-domain of interaction, generally a specific setting, see below |
|nv_resp     |logical   | On a person's line when the computer completes the query but without speaking a response. |
|interaction |character | The actual speech interaction. May be shorter or longer than the line of dialog |
|char_type   |character | Either Person or Computer |
|is_fed      |logical   | Indicates whether an interaction is with the standard Enterprise system (true) or another (false), which is akin to having a few interactions with a Google Home in an Alexa dataset.|
|error       |logical   | The interaction resulted in an error |
|value_id    |character | Value ID |

### Cleaning Script

```
library(tidyverse)
library(jsonlite)

url <- "http://www.speechinteraction.org/TNG/teaearlgreyhotdataset.json"

raw_json <- parse_json(url(url))

raw_json %>% 
  listviewer::jsonedit()

clean_df <- raw_json %>% 
  enframe() %>% 
  unnest_longer(value) %>% 
  unnest_wider(value) %>% 
  unnest_longer(type) %>% 
  unnest_longer(domain) %>% 
  unnest_longer(`sub-domain`) %>% 
  janitor::clean_names()

clean_df %>% write_csv("2021/2021-08-17/computer.csv")
```
