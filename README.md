![](static/tt_logo.png)

## A weekly social data project in R

A weekly data project aimed at the R ecosystem. An emphasis will be placed on understanding how to summarize and arrange data to make meaningful charts with `ggplot2`, `tidyr`, `dplyr`, and other tools in the `tidyverse` ecosystem.

***

Join the R4DS online learning community in the weekly `#TidyTuesday` event! Every week we post a raw dataset, a chart or article related to that dataset, and ask you to explore the data. While the dataset will be “tamed”, it will not always be tidy! As such you might need to apply various `R for Data Science` techniques to wrangle the data into a true tidy format. The goal of `TidyTuesday` is to apply your R skills, get feedback, explore other’s work, and connect with the greater `#RStats` community! As such we encourage everyone of all skills to participate! 

We will have many sources of data and want to emphasize that **no causation** is implied. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our guidelines are to use the data provided to practice your data tidying and plotting techniques. Participants are invited to consider for themselves what nuancing factors might underlie these relationships. 

The intent of Tidy Tuesday is to provide a safe and supportive forum for individuals to practice their **wrangling** and **data visualization** skills independent of drawing conclusions. While we understand that the two are related, the focus of this practice is purely on building skills with real-world data.

All data will be posted on the data sets page on Monday. It will include the link to the original article (for context) and to the data set. 

We welcome all newcomers, enthusiasts, and experts to participate, but be mindful of a few things:

1. The data set comes from the source article or the source that the article credits. Be mindful that the data is what it is and Tidy Tuesday is designed to help you practice **data visualization** and **basic data wrangling** in R.  
2. Again, the data is what it is! You are welcome to explore beyond the provided dataset, but the data is provided as a "toy" dataset to practice techniques on.  
3. This is NOT about criticizing the original article or graph. Real people made the graphs, collected or acquired the data! Focus on the provided dataset, learning, and improving your techniques in R.  
4. This is NOT about criticizing or tearing down your fellow #RStats practitioners! Be supportive and kind to each other! Like other's posts and help promote the #RStats community!  
4. Use the hashtag #TidyTuesday on Twitter if you create your own version and would like to share it.
5. Include a picture of the visualisation when you post to Twitter.  
6. Include a copy of the code used to create your visualization when you post to Twitter. Comment your code wherever possible to help yourself and others understand your process!  
7. Focus on improving your craft, even if you end up with something simple!  
8. Give credit to the original data source whenever possible.  

***

## Submitting Datasets
Want to submit an interesting dataset? Please open an [Issue](https://github.com/rfordatascience/tidytuesday/issues) and post a link to the article (or blogpost, etc) using the data, then we can discuss adding it to a future TidyTuesday Event!

## Submitting Code Chunks
Want to submit a useful code-chunk? Please submit as a [Pull Request](https://github.com/rfordatascience/tidytuesday/tree/master/community_resources/code_chunks) and follow the [guide](https://github.com/rfordatascience/tidytuesday/blob/master/community_resources/code_chunks/readme.md).

***

# DataSets
## [2018](data/2018)

## [2019](data/2019)
| Week | Date | Data | Source | Article
| :---: | :---: | :--- | :--- | :---|
| 1 | `2019-01-01` | [#Rstats & #TidyTuesday Tweets](data/2019/2019-01-01) | [`rtweet`](https://rtweet.info/) | [stackoverflow.blog](https://stackoverflow.blog/2017/10/10/impressive-growth-r/) |
| 2 | `2019-01-08` | [TV's Golden Age](data/2019/2019-01-08) | [IMDb](https://www.imdb.com/) | [The Economist](https://www.economist.com/graphic-detail/2018/11/24/tvs-golden-age-is-real) |
| 3 | `2019-01-15` | [Space Launches](data/2019/2019-01-15) | [JSR Launch Vehicle Database](http://www.planet4589.org/space/lvdb/index.html) | [The Economist](https://economist.com/graphic-detail/2018/10/18/the-space-race-is-dominated-by-new-contenders) |
| 4 | `2019-01-22` | [Incarceration Trends](data/2019/2019-01-22) | [Vera Institute](https://github.com/vera-institute/incarceration_trends) | [Vera Institute](https://github.com/vera-institute/incarceration_trends) |
| 5 | `2019-01-29` | [Dairy production & Consumption](data/2019/2019-01-29) | [USDA](https://www.ers.usda.gov/data-products/dairy-data/) | [NPR](https://www.npr.org/2019/01/09/683339929/nobody-is-moving-our-cheese-american-surplus-reaches-record-high) |
| 6 | `2019-02-05` | [House Price Index & Mortgage Rates](data/2019/2019-02-05) | [FreddieMac](http://www.freddiemac.com/research/indices/house-price-index.html) & [FreddieMac](http://www.freddiemac.com/pmms/) | [Fortune](http://fortune.com/2014/06/24/american-housing-the-good-the-bad-and-the-ugly-in-6-charts/) |
| 7 | `2019-02-12` | [Federal R&D Spending](data/2019/2019-02-12) | [AAAS](https://www.aaas.org/programs/r-d-budget-and-policy/historical-rd-data) | [New York Times](https://dotearth.blogs.nytimes.com/2014/11/02/panels-latest-warming-warning-misses-global-slumber-party-on-energy-research/) |
| 8 | `2019-02-19` | [US PhD's Awarded](data/2019/2019-02-19) | [NSF](https://ncses.nsf.gov/pubs/nsf19301/data) | [`#epibookclub`](https://twitter.com/EpiEllie/status/1096876638632140805) |
| 9 | `2019-02-26` | [French Train Delays](data/2019/2019-02-26) | [SNCF](https://ressources.data.sncf.com/explore/dataset/regularite-mensuelle-tgv-aqst/information/?sort=nombre_de_trains_annules&q=gare&dataChart=eyJxdWVyaWVzIjpbeyJjaGFydHMiOlt7InR5cGUiOiJzcGxpbmUiLCJmdW5jIjoiQVZHIiwieUF4aXMiOiJleHRlcm5lcyIsInNjaWVudGlmaWNEaXNwbGF5Ijp0cnVlLCJjb2xvciI6IiNhNmQ4NTQifV0sInhBeGlzIjoicGVyaW9kZSIsIm1heHBvaW50cyI6IiIsInRpbWVzY2FsZSI6Im1vbnRoIiwic29ydCI6IiIsImNvbmZpZyI6eyJkYXRhc2V0IjoicmVndWxhcml0ZS1tZW5zdWVsbGUtdGd2LWFxc3QiLCJvcHRpb25zIjp7InNvcnQiOiJub21icmVfZGVfdHJhaW5zX2FubnVsZXMifX19XSwidGltZXNjYWxlIjoiIiwiZGlzcGxheUxlZ2VuZCI6dHJ1ZSwiYWxpZ25Nb250aCI6dHJ1ZX0%3D) | [RTL - Today](https://today.rtl.lu/news/luxembourg/1306023.html) |
| 10 | `2019-03-05` | [Women in the Workplace](data/2019/2019-03-05) | [Census Bureau](https://www.census.gov/data/tables/time-series/demo/industry-occupation/median-earnings.html) & [Bureau of Labor](https://www.bls.gov/opub/ted/2012/ted_20121123.htm) | [Census Bureau](https://www.census.gov/library/stories/2018/05/gender-pay-gap-in-finance-sales.html) |
| 11 | `2019-03-12` | [Board Games](data/2019/2019-03-12) | [Board Game Geeks](https://boardgamegeek.com/) | [fivethirtyeight](https://fivethirtyeight.com/features/designing-the-best-board-game-on-the-planet/) |
| 12 | `2019-03-19` | [Stanford Open Policing Project](data/2019/2019-03-19) | [Stanford Open Policing Project](https://openpolicing.stanford.edu/data/) <br> [SOPP - arXiv:1706.05678](https://github.com/5harad/openpolicing) | [SOPP - arXiv:1706.05678](https://arxiv.org/abs/1706.05678) |
| 13 | `2019-03-26` | [Seattle Pet Names](data/2019/2019-03-26) | [seattle.gov](https://data.seattle.gov/Community/Seattle-Pet-Licenses/jguv-t9rb) | [Curbed Seattle](https://seattle.curbed.com/2019/1/2/18165658/seattle-popular-pet-names-2018) |
| 14 | `2019-04-02` | [Seattle Bike Traffic](data/2019/2019-04-02) | [seattle.gov](http://www.seattle.gov/transportation/projects-and-programs/programs/bike-program/bike-counters) | [Seattle Times](https://www.seattletimes.com/seattle-news/transportation/what-we-can-learn-from-seattles-bike-counter-data/) |
| 15 | `2019-04-09` | [Tennis Grand Slam Champions](data/2019/2019-04-09) | [Wikipedia](https://en.wikipedia.org/wiki/List_of_Grand_Slam_women%27s_singles_champions) | [Financial Times](https://ig.ft.com/sites/visual-history-of-womens-tennis/) |
| 16 | `2019-04-16` | [The Economist Data Viz Mistakes](data/2019/2019-04-16) | [The Economist](https://medium.economist.com/mistakes-weve-drawn-a-few-8cdd8a42d368) | [The Economist](https://medium.economist.com/mistakes-weve-drawn-a-few-8cdd8a42d368) |
| 17 | `2019-04-23` | [Anime Data](data/2019/2019-04-23) | [MyAnimeList](https://www.kaggle.com/aludosan/myanimelist-anime-dataset-as-20190204) | [MyAnimeList](https://myanimelist.net/topanime.php?type=bypopularity) |
| 18 | `2019-04-30` | [Chicago Bird Collisions](data/2019/2019-04-30) | [Winger et al, 2019](https://datadryad.org/resource/doi:10.5061/dryad.8rr0498) | [Winger et al, 2019](https://royalsocietypublishing.org/doi/10.1098/rspb.2019.0364#d3e550) |
| 19 | `2019-05-07` | [Global Student to Teacher Ratios](data/2019/2019-05-07) | [UNESCO](http://data.uis.unesco.org/index.aspx?queryid=180) | [Center for Public Education](http://www.centerforpubliceducation.org/research/class-size-and-student-achievement) |
| 20 | `2019-05-14` | [Nobel Prize Winners](data/2019/2019-05-14) | [Kaggle](https://www.kaggle.com/nobelfoundation/nobel-laureates) | [The Economist](https://www.economist.com/graphic-detail/2016/10/03/greying-of-the-nobel-laureates) |
| 21 | `2019-05-21` | [Global Plastic Waste](data/2019/2019-05-21) | [Our World In Data](https://ourworldindata.org/plastic-pollution) | [Our World in Data](https://ourworldindata.org/plastic-pollution) |
| 22 | `2019-05-28` | [Wine Ratings](data/2019/2019-05-28) | [Kaggle](https://www.kaggle.com/zynicide/wine-reviews) | [Vivino](https://www.vivino.com/wine-news/how-much-does-a-good-bottle-of-wine-cost) |
| 23 | `2019-06-04` | [Ramen Ratings](data/2019/2019-06-04) | [TheRamenRater.com](https://www.theramenrater.com/resources-2/the-list/) | [Food Republic](https://www.foodrepublic.com/2014/12/02/theres-a-website-that-has-rated-1518-bowls-of-instant-ramen/) |

***  

# Useful links

| Link | Description |
| --- | --- |
| [:link:](https://www.rfordatasci.com) | The R4DS Online Learning Community Website|
| [:link:](http://r4ds.had.co.nz/) | The R for Data Science textbook |
| [:link:](https://carbon.now.sh/) | Carbon for sharing beautiful code pics |
| [:link:](https://github.com/MilesMcBain/gistfo) | Post gist to Carbon from RStudio |
| [:link:](https://github.com/yonicd/carbonate) | Post to Carbon from RStudio |
| [:link:](https://github.com/join) | Join GitHub! |
| [:link:](https://guides.github.com/activities/hello-world/) | Basics of GitHub |
| [:link:](https://happygitwithr.com/) | Learn how to use GitHub with R |
| [:link:](http://ggplot2.tidyverse.org/reference/ggsave.html) | Save high-rez `ggplot2` images |

# Useful data sources

| Link | Description |
| --- | --- |
| [:link:](https://docs.google.com/spreadsheets/d/1wZhPLMCHKJvwOkP4juclhjFgqIY8fQFMemwKL2c64vk/edit#gid=0) | Data is Plural collection |
| [:link:](https://github.com/BuzzFeedNews/everything/blob/master/README.md) | BuzzFeedNews GitHub |
| [:link:](https://github.com/theeconomist/) | The Economist GitHub |
| [:link:](https://cran.r-project.org/web/packages/fivethirtyeight/fivethirtyeight.pdf) | The `fivethirtyeight` data package 
| [:link:](https://github.com/TheUpshot) | The Upshot by NY Times |
| [:link:](https://github.com/baltimore-sun-data) | The Baltimore Sun Data Desk |
| [:link:](https://github.com/datadesk) | The LA Times Sun Data Desk |
| [:link:](https://github.com/OpenNewsLabs/news-graphics-team) | Open News Labs |
| [:link:](https://t.co/BMvJO2dT1o) | BBC Data Journalism team |

***

# Data Viz/Science Books

Only books available freely online are sourced here. Feel free to add to the list

| Link | Description |
| --- | --- |
| [:link:](https://serialmentor.com/dataviz/) | Fundamentals of Data Viz by Claus Wilke |
| [:link:](https://bookdown.org/rdpeng/artofdatascience/) | The Art of Data Science by Roger D. Peng & Elizabeth Matsui |
| [:link:](https://www.tidytextmining.com/) | Tidy Text Mining by Julia Silge & David Robinson |
| [:link:](https://geocompr.robinlovelace.net/) | Geocomputation with R by Robin Lovelace, Jakub Nowosad, Jannes Muenchow |
| [:link:](https://socviz.co/index.html#preface) | Data Visualization by Kieran Healy |
| [:link:](http://www.cookbook-r.com/Graphs/) | `ggplot2` cookbook by Winston Chang |
 [:link:](https://medium.com/bbc-visual-and-data-journalism/how-the-bbc-visual-and-data-journalism-team-works-with-graphics-in-r-ed0b35693535) | BBC Data Journalism team |


