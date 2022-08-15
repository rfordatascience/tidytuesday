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

# Open Psychometrics

The dataset this week comes from **[Open-Source Psychometrics Project](https://openpsychometrics.org/)** courtesy of [Tanya Shapiro](https://twitter.com/tanya_shapiro/status/1558936093390774272?s=20&t=tI4nccuwEG4SjWd3H1Suew).

## About

Project collecting and analyzing data from the **[Open-Source Psychometrics Project](https://openpsychometrics.org/)**. The datasets include information about characters from different universes and their respective personality traits. 

About the Open-Source Psychometrics Project (excerpt from website):

> This website provides a collection of interactive personality tests with detailed results that can be taken for personal entertainment or to learn more about personality assessment. These tests range from very serious and widely used scientific instruments popular psychology to self produced quizzes. A special focus is given to the strengths, weaknesses and validity of the various systems.

## Data

I randomly selected **100** different univereses (e.g. Game of Thrones, Bob's Burgers, Westworld, etc) and collected information about their respective characters. Dataset includes information on **890** characters total. Information for the entire project can also be downloaded directly from [opensychometrics.org](https://openpsychometrics.org/tests/characters/data/). Note, the full zip files are codified - i.e. characteters and questions are expressed as varchar IDs and require lookups.

There are a total of 400 different personality questions (that's a lot of traits!). One recommendation from the project suggests this data can be used for cool projects like dimension reduction - i.e. which traits are similar and convey the same info? 

Information about [Scoring](https://openpsychometrics.org/tests/characters/development/) from their site:

>The idea of this test is to match takers to a fictional character based on similarity of personality.

>A fictional character does not have a real personality, but people might perceive it to have one. It is unknown if this perception of personality actually has the same structure as human individual differences.

>This test assumes that a character's assumed personality is reflected in the average ratings of individuals. To collect this data a survey was developed. In it, the volunteer respondent rates 30 characters on 1 trait each, randomly drawn from a bank of 30 traits. With enough data, all the individual surveys can be combined into a comprehensive database of assumed personality.

## Related Data Visuals

There are tons of ways to explore this data. Recently,  Tanya used it to compare characters from **[Westworld](https://github.com/tashapiro/tanya-data-viz/tree/main/westworld)**.

![plot](https://github.com/tashapiro/tanya-data-viz/blob/main/westworld/plots/westworld-radar-plot.png)

Also see their article: <https://openpsychometrics.org/tests/characters/documentation/>


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-08-16')
tuesdata <- tidytuesdayR::tt_load(2022, week = 33)

characters <- tuesdata$characters

# Or read in the data manually

characters <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-08-16/characters.csv')

```
## Dictionary

### Characters

High level information about characters. Includes a **notability** score and links to related pages.

| **variable** | **type** | **description**                     |
|:-------------|:---------|:------------------------------------|
| id           | varchar  | Character ID                        |
| name         | varchar  | Character Name                      |
| uni_id       | varchar  | Universe ID, e.g. GOT               |
| uni_name     | varchar  | Universe Name, e.g. Game of Thrones |
| notability   | num      | Notability Score                    |
| link         | varchar  | Link to Character Page              |
| image_link   | varchar  | Link to Character Image             |

### Psychology Stats

Personality/Psychometric Stats per character.

| **variable**   | **type** | **description**                        |
|:---------------|:---------|:---------------------------------------|
| char_id        | varchar  | Character ID                           |
| char_name      | varchar  | Character Name                         |
| uni_id         | varchar  | Universe ID, e.g. GOT                  |
| uni_name       | varchar  | Universe Name, e.g. Game of Thrones    |
| question       | varchar  | Personality Question - e.g. messy/neat |
| personality    | varchar  | Character Personality, e.g. neat       |
| avg_rating     | num      | Score out of 100                       |
| rank           | int      | Rank                                   |
| rating_sd      | num      | Rating Standard Deviation              |
| number_ratings | int      | Number of Ratings (Responses)          |

### Myers-Briggs

Users who took the personal personality assessment tests were subsequently asked to self-identify their **Myers-Briggs** types. Dataset contains results.

| **variable**   | **type** | **description**                     |
|:---------------|:---------|:------------------------------------|
| char_id        | varchar  | Character ID                        |
| char_name      | varchar  | Character Name                      |
| uni_id         | varchar  | Universe ID, e.g. GOT               |
| uni_name       | varchar  | Universe Name, e.g. Game of Thrones |
| myers_briggs   | varchar  | Myers Briggs Type, e.g. ENFP        |
| avg_match_perc | num      | Percentage match                    |
| number_users   | int      | number of user respondents          |


### Cleaning Script

