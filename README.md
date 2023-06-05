![Logo for the TidyTuesday project, represented by the word TidyTuesday over a messy splash of black paint](static/tt_logo.png)

## A weekly social data project in R

A weekly data project aimed at the R ecosystem. As this project was borne out of the `R4DS Online Learning Community` and the `R for Data Science` textbook, an emphasis was placed on understanding how to summarize and arrange data to make meaningful charts with `ggplot2`, `tidyr`, `dplyr`, and other tools in the `tidyverse` ecosystem. However, any code-based methodology is welcome - just please remember to share the code used to generate the results.

***

Join the `R4DS Online Learning Community` in the weekly `#TidyTuesday` event! Every week we post a raw dataset, a chart or article related to that dataset, and ask you to explore the data. While the dataset will be "tamed", it will not always be tidy! As such you might need to apply various `R for Data Science` techniques to wrangle the data into a true tidy format. The goal of `TidyTuesday` is to apply your R skills, get feedback, explore other's work, and connect with the greater `#RStats` community! As such we encourage everyone of all skills to participate! 

We will have many sources of data and want to emphasize that **no causation** is implied. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our guidelines are to use the data provided to practice your data tidying and plotting techniques. Participants are invited to consider for themselves what nuancing factors might underlie these relationships. 

The intent of Tidy Tuesday is to provide a safe and supportive forum for individuals to practice their **wrangling** and **data visualization** skills independent of drawing conclusions. While we understand that the two are related, the focus of this practice is purely on building skills with real-world data.

All data will be posted on the data sets page on Monday. It will include the link to the original article (for context) and to the data set. 

We welcome all newcomers, enthusiasts, and experts to participate, but be mindful of a few things:

1. The data set comes from the source article or the source that the article credits. Be mindful that the data is what it is and Tidy Tuesday is designed to help you practice **data visualization** and **basic data wrangling** in R.  
2. Again, the data is what it is! You are welcome to explore beyond the provided dataset, but the data is provided as a "toy" dataset to practice techniques on.  
3. This is NOT about criticizing the original article or graph. Real people made the graphs, collected or acquired the data! Focus on the provided dataset, learning, and improving your techniques in R.  
4. This is NOT about criticizing or tearing down your fellow `#RStats` practitioners or their code! Be supportive and kind to each other! Like other's posts and help promote the `#RStats` community!  
4. Use the hashtags #TidyTuesday and #RStats on Twitter if you create your own version and would like to share it.
5. Include a picture of the visualisation when you post to Twitter.  
6. Include a copy of the code used to create your visualization when you post to Twitter. Comment your code wherever possible to help yourself and others understand your process!  
7. Focus on improving your craft, even if you end up with something simple!  
8. Give credit to the original data source whenever possible.  

***

## Submitting Datasets

`TidyTuesday` is built around open datasets that are found in the "wild" or submitted as [Issues](https://github.com/rfordatascience/tidytuesday/issues) on our GitHub.

If you find a dataset that you think would be interesting, you can approach it through two ways:

## Two Ways to Contribute

1. **Submit the dataset as an [Issue](https://github.com/rfordatascience/tidytuesday/issues)**  
a. Find an interesting dataset  
b. Find a report, blog post, article etc relevant to the data   
c. Submit the dataset as an [Issue](https://github.com/rfordatascience/tidytuesday/issues) along with a link to the article  

2. **Create an entire TidyTuesday challenge!**  
a. Find an interesting dataset  
b. Find a report, blog post, article etc relevant to the data (or create one yourself!)  
c. Let us know you've found something interesting and are working on it by filing an [Issue](https://github.com/rfordatascience/tidytuesday/issues) on our GitHub  
d. Provide a link or the raw data and a cleaning script for the data  
e. Write a basic `readme.md` file using the minimal template below and make sure to give yourself credit! 

#### `readme.md` template

```
# INPUT THE SUBJECT TITLE OF THE DATASET

The data this week comes from [SOURCE_OF_DATA](URL_TO_DATA). 

This [ARTICLE_SOURCE](LINK_TO_ARTICLE) talks about SUBJECT TITLE in greater detail.

Credit: [YOUR NAME](Twitter handle or other social media profile)
```

## Submitting Code Chunks
Want to submit a useful code-chunk? Please submit as a [Pull Request](https://github.com/rfordatascience/tidytuesday/tree/master/community_resources/code_chunks) and follow the [guide](https://github.com/rfordatascience/tidytuesday/blob/master/community_resources/code_chunks/readme.md).

## Citing TidyTuesday

To cite the TidyTuesday repo/project in publications use:

  Thomas Mock (2022). Tidy Tuesday: A weekly data project aimed at the R ecosystem.
  https://github.com/rfordatascience/tidytuesday.

A BibTeX entry for LaTeX users is

```
  @misc{tidytuesday, 
    title = {Tidy Tuesday: A weekly data project aimed at the R ecosystem}, 
    author = {Mock, Thomas}, 
    url = {https://github.com/rfordatascience/tidytuesday}, 
    
    year = {2022} 
  }
```

Note: If you would like to cite the [tidytuesdayR](https://thebioengineer.github.io/tidytuesdayR/) package, you should use `citation("tidytuesdayR")` instead.

***

### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.
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

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programmatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

***

# DataSets
## [2018](data/2018) | [2019](data/2019) | [2020](data/2020)  | [2021](data/2021) | [2022](data/2022) | [2023](data/2023)

| Week | Date | Data | Source | Article
| :---: | :---: | :--- | :--- | :---|
| 1 | `2023-01-03` | Bring your own data to start 2023! | | |
| 2 | `2023-01-10` | [Bird FeederWatch data](data/2023/2023-01-10/readme.md) | [FeederWatch](https://feederwatch.org/explore/raw-dataset-requests/) | [Over 30 Years of Standardized Bird Counts at Supplementary Feeding Stations in North America: A Citizen Science Data Report for Project FeederWatch](https://www.frontiersin.org/articles/10.3389/fevo.2021.619682/full) |
| 3 | `2023-01-17` | [Art history data](data/2023/2023-01-17/readme.md) | [arthistory data package](https://saralemus7.github.io/arthistory/) | [Quantifying Art Historical Narratives](https://github.com/hollandstam1/thesis/blob/main/_book/Quantifying-Art-Historical-Narratives.pdf) |
| 4 | `2023-01-24` | [Alone data](data/2023/2023-01-24/readme.md) | [Alone data package](https://github.com/doehm/alone) | [Alone R package: Datasets from the survival TV series](https://gradientdescending.com/alone-r-package-datasets-from-the-survival-tv-series/) |
| 5 | `2023-01-31` | [Pet Cats UK](data/2023/2023-01-31/readme.md) | [Movebank for Animal Tracking Data](https://www.datarepository.movebank.org/handle/10255/move.882) | [Cats on the Move](https://themarkup.org/data-is-plural/2023/01/25/from-jazz-solos-to-cats-on-the-move#:~:text=Giuseppe%20Sollazzo%5D-,Cats%20on%20the%20move,-.%20Between%202013) |
| 6 | `2023-02-07` | [Big Tech Stock Prices](data/2023/2023-02-07/readme.md) | [Big Tech Stock Prices on Kaggle](https://www.kaggle.com/datasets/evangower/big-tech-stock-prices) | [5 Charts on Big Tech Stocks' Collapse](https://www.morningstar.com/articles/1129535/5-charts-on-big-tech-stocks-collapse) |
| 7 | `2023-02-14` | [Hollywood Age Gaps](data/2023/2023-02-14/readme.md) | [Hollywood Age Gap](https://hollywoodagegap.com/movies.csv) | [Hollywood Age Gap](https://hollywoodagegap.com/) |
| 8 | `2023-02-21` | [Bob Ross Paintings](data/2023/2023-02-21/readme.md) | [Bob Ross Paintings data](https://github.com/jwilber/Bob_Ross_Paintings/blob/master/data/bob_ross_paintings.csv) | [Bob Ross Colors data package](https://github.com/frankiethull/BobRossColors) |
| 9 | `2023-02-28` | [African Language Sentiment](data/2023/2023-02-28/readme.md) | [AfriSenti: Sentiment Analysis dataset for 14 African languages](https://github.com/afrisenti-semeval/afrisent-semeval-2023) | [AfriSenti: A Twitter Sentiment Analysis Benchmark for African Languages](https://arxiv.org/pdf/2302.08956.pdf) |
| 10 | `2023-03-07` | [Numbats in Australia](data/2023/2023-03-07/readme.md) | [Atlas of Living Australia](https://www.ala.org.au) | [Numbat page at the Atlas of Living Australia](https://bie.ala.org.au/species/https://biodiversity.org.au/afd/taxa/6c72d199-f0f1-44d3-8197-224a2f7cff5f) |
| 11 | `2023-03-14` | [European Drug Development](data/2023/2023-03-14/readme.md) | [European Medicines Agency](https://www.ema.europa.eu/en/medicines/download-medicine-data) | [Dissecting 28 years of European pharmaceutical development](https://towardsdatascience.com/dissecting-28-years-of-european-pharmaceutical-development-3affd8f87dc0) |
| 12 | `2023-03-21` | [Programming Languages](data/2023/2023-03-21/readme.md) | [Programming Language DataBase](https://pldb.com/index.html) | [Does every programming language have line comments?](https://pldb.com/posts/does-every-programming-language-support-line-comments.html) |
| 13 | `2023-03-28` | [Time Zones](data/2023/2023-03-28/readme.md) | [IANA tz database](https://data.iana.org/time-zones/tz-link.html) | ["What Is Daylight Saving Time"](https://www.timeanddate.com/time/dst/) |
| 14 | `2023-04-04` | [Premier League Match Data](data/2023/2023-04-04/readme.md) | [Premier League Match Data 2021-2022](https://www.kaggle.com/datasets/evangower/premier-league-match-data) | [Who wins the EPL if games end at half time?](https://www.kaggle.com/code/evangower/who-wins-the-epl-if-games-end-at-half-time/) |
| 15 | `2023-04-11` | [US Egg Production Data](data/2023/2023-04-11/readme.md) | [US Egg Production Data 2007-2021](https://osf.io/z2gxn/) | [The Humane League Labs US Egg Production Dataset](https://thehumaneleague.org/article/E008R01-us-egg-production-data) |
| 16 | `2023-04-18` | [Neolithic Founder Crops](data/2023/2023-04-18/readme.md) | [The "Neolithic Founder Crops"" in Southwest Asia: Research Compendium](https://github.com/joeroe/SWAsiaNeolithicFounderCrops/) | [Revisiting the concept of the 'Neolithic Founder Crops' in southwest Asia](https://link.springer.com/article/10.1007/s00334-023-00917-1) |
| 17 | `2023-04-25` | [London Marathon](data/2023/2023-04-25/readme.md) | [London Marathon R package](https://github.com/nrennie/LondonMarathon) | [Scraping London Marathon data with {rvest}](https://nrennie.rbind.io/blog/web-scraping-rvest-london-marathon/) |
| 18 | `2023-05-02` | [The Portal Project](data/2023/2023-05-02/readme.md) | [Portal Project Data](https://github.com/weecology/portaldata) | [Portal Project](https://portal.weecology.org/) |
| 19 | `2023-05-09` | [Childcare Costs](data/2023/2023-05-09/readme.md) | [National Database of Childcare Prices](https://www.dol.gov/agencies/wb/topics/featured-childcare) | [National Database of Childcare Prices](https://www.dol.gov/agencies/wb/topics/featured-childcare) |
| 20 | `2023-05-16` | [Tornados](data/2023/2023-05-16/readme.md) | [NOAA's National Weather Service Storm Prediction Center Severe Weather Maps, Graphics, and Data Page](https://www.spc.noaa.gov/wcm/#data) | [Diving into US Tornado Data](https://www.kaggle.com/code/evangower/diving-into-us-tornado-data) |
| 21 | `2023-05-23` | [Central Park Squirrels](data/2023/2023-05-23/readme.md) | [2018 Central Park Squirrel Census]([https://www.spc.noaa.gov/wcm/#data](https://data.cityofnewyork.us/Environment/2018-Central-Park-Squirrel-Census-Squirrel-Data/vfnx-vebw)) | [The Squirrel Census](https://www.thesquirrelcensus.com/) |
| 22 | `2023-05-30` | [Verified Oldest People](data/2023/2023-05-30/readme.md) | [frankiethull: Centenarians](https://github.com/frankiethull/centenarians) | [Wikipedia: List of the verified oldest people](https://en.wikipedia.org/wiki/List_of_the_verified_oldest_people) |
| 23 | `2023-06-06` | [Energy](data/2023/2023-06-06/readme.md) | [Energy Data Explorer](https://ourworldindata.org/explorers/energy) | [Our World in Data Energy Complete Dataset](https://github.com/owid/energy-data) |

***  

# Useful links

| Link | Description |
| --- | --- |
| [Link](https://www.rfordatasci.com) | The R4DS Online Learning Community Website|
| [Link](http://r4ds.had.co.nz/) | The R for Data Science textbook |
| [Link](https://carbon.now.sh/) | Carbon for sharing beautiful code pics |
| [Link](https://github.com/MilesMcBain/gistfo) | Post gist to Carbon from RStudio |
| [Link](https://github.com/yonicd/carbonate) | Post to Carbon from RStudio |
| [Link](https://github.com/join) | Join GitHub! |
| [Link](https://guides.github.com/activities/hello-world/) | Basics of GitHub |
| [Link](https://happygitwithr.com/) | Learn how to use GitHub with R |
| [Link](http://ggplot2.tidyverse.org/reference/ggsave.html) | Save high-rez `ggplot2` images |

# Useful data sources

| Link | Description |
| --- | --- |
| [Link](https://docs.google.com/spreadsheets/d/1wZhPLMCHKJvwOkP4juclhjFgqIY8fQFMemwKL2c64vk/edit#gid=0) | Data is Plural collection |
| [Link](https://github.com/BuzzFeedNews/everything/blob/master/README.md) | BuzzFeedNews GitHub |
| [Link](https://github.com/theeconomist/) | The Economist GitHub |
| [Link](https://cran.r-project.org/web/packages/fivethirtyeight/fivethirtyeight.pdf) | The `fivethirtyeight` data package 
| [Link](https://github.com/TheUpshot) | The Upshot by NY Times |
| [Link](https://github.com/baltimore-sun-data) | The Baltimore Sun Data Desk |
| [Link](https://github.com/datadesk) | The LA Times Data Desk |
| [Link](https://github.com/OpenNewsLabs/news-graphics-team) | Open News Labs |
| [Link](https://t.co/BMvJO2dT1o) | BBC Data Journalism team |

***

# Data Viz/Science Books

Only books available freely online are sourced here. Feel free to add to the list

| Link | Description |
| --- | --- |
| [Link](https://serialmentor.com/dataviz/) | Fundamentals of Data Viz by Claus Wilke |
| [Link](https://bookdown.org/rdpeng/artofdatascience/) | The Art of Data Science by Roger D. Peng & Elizabeth Matsui |
| [Link](https://www.tidytextmining.com/) | Tidy Text Mining by Julia Silge & David Robinson |
| [Link](https://geocompr.robinlovelace.net/) | Geocomputation with R by Robin Lovelace, Jakub Nowosad, Jannes Muenchow |
| [Link](https://socviz.co/index.html#preface) | Data Visualization by Kieran Healy |
| [Link](http://www.cookbook-r.com/Graphs/) | `ggplot2` cookbook by Winston Chang |
 [Link](https://medium.com/bbc-visual-and-data-journalism/how-the-bbc-visual-and-data-journalism-team-works-with-graphics-in-r-ed0b35693535) | BBC Data Journalism team |
