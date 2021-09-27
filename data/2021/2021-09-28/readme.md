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

![The logo for the National Bureau of Economic Research (NBER)](nber-logo.png)

# Economic Papers

The data this week comes from the National Bureau of Economic Research [NBER](https://www2.nber.org/RePEc/nbr/nberwo/) by way of the [`nberwp` package by Ben Davies](https://github.com/bldavies/nberwp).

> New research by NBER affiliates, circulated for discussion and comment. The NBER distributes more than 1,200 working papers each year. These papers have not been peer reviewed. Papers issued more than 18 months ago are open access. More recent papers are available without charge to affiliates of subscribing academic institutions, employees of NBER Corporate Associates, government employees in the US, journalists, and residents of low-income countries.

Ben also has a detailed [blogpost](https://bldavies.com/blog/female-representation-collaboration-nber/) looking over this data.

This is a good dataset to again better understand joining datasets in R. There are the combined datasets and the original tables.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-09-28')
tuesdata <- tidytuesdayR::tt_load(2021, week = 40)

papers <- tuesdata$papers

# Or read in the data manually

papers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-28/papers.csv')
authors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-28/authors.csv')
programs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-28/programs.csv')
paper_authors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-28/paper_authors.csv')
paper_programs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-28/paper_programs.csv')

```
### Data Dictionary

# `papers.csv`

|variable         |class     |description |
|:----------------|:---------|:-----------|
|paper            |character | Paper ID |
|catalogue_group  |character | Catalogue group, either Historical, Technical or General |
|year             |integer   | Year |
|month            |integer   | Month |
|title            |character | Title of the paper |
|author           |character | Author ID |
|name             |character | Author Name |
|user_nber        |character | Author nber ID |
|user_repec       |character | Author repec ID |
|program          |character | Program |
|program_desc     |character | Description of program |
|program_category |character | Program category |

### Cleaning Script

```{r}
library(nberwp)
library(tidyverse)

papers %>% 
  write_csv("2021/2021-09-28/papers.csv")

authors %>% 
  write_csv("2021/2021-09-28/authors.csv")

programs %>% 
  write_csv("2021/2021-09-28/programs.csv")

paper_authors %>% 
  write_csv('2021/2021-09-28/paper_authors.csv')

paper_programs %>% 
  write_csv("2021/2021-09-28/paper_programs.csv")

joined_df <- left_join(papers, paper_authors) %>% 
  left_join(authors) %>% 
  left_join(paper_programs) %>% 
  left_join(programs)%>% 
  mutate(
    catalogue_group = str_sub(paper, 1, 1),
    catalogue_group = case_when(
      catalogue_group == "h" ~ "Historical",
      catalogue_group == "t" ~ "Technical",
      catalogue_group == "w" ~ "General"
    ),
    .after = paper
  ) 

joined_df
```