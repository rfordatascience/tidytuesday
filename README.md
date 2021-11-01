![Logo for the TidyTuesday project, represented by the word TidyTuesday over a messy splash of black paint](static/tt_logo.png)

## A weekly social data project in R

A weekly data project aimed at the R ecosystem. As this project was borne out of the `R4DS Online Learning Community` and the `R for Data Science` textbook, an emphasis was placed on understanding how to summarize and arrange data to make meaningful charts with `ggplot2`, `tidyr`, `dplyr`, and other tools in the `tidyverse` ecosystem. However, any code-based methodology is welcome - just please remember to share the code used to generate the results.

***

Join the `R4DS Online Learning Community` in the weekly `#TidyTuesday` event! Every week we post a raw dataset, a chart or article related to that dataset, and ask you to explore the data. While the dataset will be “tamed”, it will not always be tidy! As such you might need to apply various `R for Data Science` techniques to wrangle the data into a true tidy format. The goal of `TidyTuesday` is to apply your R skills, get feedback, explore other’s work, and connect with the greater `#RStats` community! As such we encourage everyone of all skills to participate! 

We will have many sources of data and want to emphasize that **no causation** is implied. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our guidelines are to use the data provided to practice your data tidying and plotting techniques. Participants are invited to consider for themselves what nuancing factors might underlie these relationships. 

The intent of Tidy Tuesday is to provide a safe and supportive forum for individuals to practice their **wrangling** and **data visualization** skills independent of drawing conclusions. While we understand that the two are related, the focus of this practice is purely on building skills with real-world data.

All data will be posted on the data sets page on Monday. It will include the link to the original article (for context) and to the data set. 

We welcome all newcomers, enthusiasts, and experts to participate, but be mindful of a few things:

1. The data set comes from the source article or the source that the article credits. Be mindful that the data is what it is and Tidy Tuesday is designed to help you practice **data visualization** and **basic data wrangling** in R.  
2. Again, the data is what it is! You are welcome to explore beyond the provided dataset, but the data is provided as a "toy" dataset to practice techniques on.  
3. This is NOT about criticizing the original article or graph. Real people made the graphs, collected or acquired the data! Focus on the provided dataset, learning, and improving your techniques in R.  
4. This is NOT about criticizing or tearing down your fellow `#RStats` practitioners or their code! Be supportive and kind to each other! Like other's posts and help promote the `#RStats` community!  
4. Use the hashtag #TidyTuesday on Twitter if you create your own version and would like to share it.
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
c. Let us know you're found something interesting and are working on it by filing an [Issue](https://github.com/rfordatascience/tidytuesday/issues) on our GitHub  
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

  Thomas Mock (2021). Tidy Tuesday: A weekly data project aimed at the R ecosystem.
  https://github.com/rfordatascience/tidytuesday.

A BibTeX entry for LaTeX users is

```
  @misc{tidytuesday, 
    title = {Tidy Tuesday: A weekly data project aimed at the R ecosystem}, 
    author = {Mock, Thomas}, 
    url = {https://github.com/rfordatascience/tidytuesday}, 
    
    year = {2021} 
  }
```

Note: If you would like to cite the [tidytuesdayR](https://thebioengineer.github.io/tidytuesdayR/) package, you should use `citation("tidytuesdayR")` instead.

***

### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.
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

***

# DataSets
## [2018](data/2018) | [2019](data/2019) | [2020](data/2020)  | [2021](data/2021)

| Week | Date | Data | Source | Article
| :---: | :---: | :--- | :--- | :---|
| 1 | `2020-12-29` | Bring your own data from 2020! | | |
| 2 | `2021-01-05` | [Transit Cost Project](data/2021/2021-01-05/readme.md) | [TransitCosts.com](https://transitcosts.com/) | [Transit Costs Case Study](https://transitcosts.com/city/boston-case-the-story-of-the-green-line-extension/) |
| 3 | `2021-01-12` | [Art Collections](data/2021/2021-01-12/readme.md) | [Tate Collection](http://bit.ly/3sev5lM) | [AR of Artworks](https://josephlewis.github.io/aspect.html) |
| 4 | `2021-01-19` | [Kenya Census](data/2021/2021-01-19/readme.md) | [`rKenyaCensus`](https://github.com/Shelmith-Kariuki/rKenyaCensus) | [Introducing `rKenyaCensus`](https://shelkariuki.netlify.app/post/rkenyacensus/) |
| 5 | `2021-01-26` | [Plastic Pollution](data/2021/2021-01-26/readme.md) | [Break Free from Plastic](https://www.breakfreefromplastic.org) | [Sarah Sauve](https://github.com/sarahsauve/TidyTuesdays/blob/master/BFFPDashboard/BlogPost.md) |
| 6 | `2021-02-02` | [HBCU Enrollment](data/2021/2021-02-02/readme.md) | [Data.World](https://data.world/nces/hbcu-fall-enrollment-1976-2015) & [Data.World](https://data.world/nces/high-school-completion-and-bachelors-degree-attainment) | [HBCU Donations Article](https://theundefeated.com/features/how-hbcus-are-using-more-than-250-million-in-donations/) |
| 7 | `2021-02-09` | [Wealth and Income](data/2021/2021-02-09/readme.md) | [Urban Institute](https://apps.urban.org/features/wealth-inequality-charts/) & [US Census](https://www.census.gov/data/tables/time-series/demo/income-poverty/historical-income-households.html) | [Urban Institute](https://apps.urban.org/features/wealth-inequality-charts/) |
| 8 | `2021-02-16` | [W.E.B. Du Bois Challenge](data/2021/2021-02-16/readme.md) | [Du Bois Data Challenge](https://github.com/ajstarks/dubois-data-portraits/tree/master/challenge) | [Anthony Starks - Recreating Du Bois's data portraits](https://medium.com/nightingale/recreating-w-e-b-du-boiss-data-portraits-87dd36096f34) |
| 9 | `2021-02-23` | [Employment and Earnings](data/2021/2021-02-23/readme.md) | [BLS](https://www.bls.gov/cps/tables.htm#charemp_m) | [BLS Article](https://www.bls.gov/careeroutlook/2018/article/blacks-in-the-labor-force.htm) |
| 10 | `2021-03-02` | [SuperBowl Ads](data/2021/2021-03-02/readme.md) | [FiveThirtyEight](https://github.com/fivethirtyeight/superbowl-ads) | [FiveThirtyEight](https://projects.fivethirtyeight.com/super-bowl-ads/) |
| 11 | `2021-03-09` | [Bechdel Test](data/2021/2021-03-09/readme.md) | [FiveThirtyEight](https://github.com/fivethirtyeight/data/tree/master/bechdel) | [FiveThirtyEight](https://fivethirtyeight.com/features/the-dollar-and-cents-case-against-hollywoods-exclusion-of-women/) |
| 12 | `2021-03-16` | [Video Games + Sliced](data/2021/2021-03-16/readme.md) | [Steam](https://www.kaggle.com/michau96/popularity-of-games-on-steam) | [SteamCharts](https://steamcharts.com/) |
| 13 | `2021-03-23` | [UN Votes](data/2021/2021-03-23/readme.md) | [Harvard Dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=hdl:1902.1/12379) | [Citizen Statistician](http://www.citizen-statistician.org/2021/03/open-source-contribution-as-a-student-project/) |
| 14 | `2021-03-30` | [Makeup Shades](data/2021/2021-03-30/readme.md) | [The Pudding data](https://github.com/the-pudding/data/tree/master/foundation-names) | [The Pudding](https://pudding.cool/2021/03/foundation-names/) |
| 15 | `2021-04-06` | [Global deforestation](data/2021/2021-04-06/readme.md) | [Our World in Data](https://ourworldindata.org/forests-and-deforestation) | [Our World in Data](https://ourworldindata.org/forests-and-deforestation) |
| 16 | `2021-04-13` | [US Post Offices](data/2021/2021-04-13/readme.md) | [Cameron Blevins and Richard W. Helbock](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/NUKCNA) | [US Post Offices](https://cblevins.github.io/us-post-offices/) |
| 17 | `2021-04-20` | [Netflix Titles](data/2021/2021-04-20/readme.md) | [Kaggle](https://www.kaggle.com/shivamb/netflix-shows) | [Flixable](https://flixable.com/netflix-museum/) |
| 18 | `2021-04-27` | [CEO Departures](data/2021/2021-04-27/readme.md) | [Gentry et al.](https://onlinelibrary.wiley.com/doi/abs/10.1002/smj.3278) | [investors.com](https://www.investors.com/news/ceo-turnover-bailing-out-droves/) |
| 19 | `2021-05-04` | [Water Access Points](data/2021/2021-05-04/readme.md) | [WPDX](https://www.waterpointdata.org/) | [WPDX](https://www.waterpointdata.org/) |
| 20 | `2021-05-11` | [US Broadband](data/2021/2021-05-11/readme.md) | [Microsoft GitHub](https://github.com/microsoft/USBroadbandUsagePercentages) | [The Verge](https://www.theverge.com/22418074/broadband-gap-america-map-county-microsoft-data) |
| 21 | `2021-05-18` | [Ask a Manager Salary Survey](data/2021/2021-05-18/readme.md) | [Ask a Manager](https://docs.google.com/spreadsheets/d/1IPS5dBSGtwYVbjsfbaMCYIWnOuRmJcbequohNxCyGVw/edit?resourcekey#gid=1625408792) | [Ask a Manager](https://www.askamanager.org/2021/05/some-findings-from-24000-peoples-salaries.html) |
| 22 | `2021-05-25` | [Mario Kart World Records](data/2021/2021-05-25/readme.md) | [Mario Kart World Records](https://mkwrs.com/) | [Mario Kart Record-breaking](https://www.thegamer.com/mario-kart-64-speedrunner-is-the-first-to-hit-a-190000-trick-breaks-two-world-records-at-once/) |
| 23 | `2021-06-01` | [Survivor TV Show](data/2021/2021-06-01/readme.md) | [`survivoR` Package](https://github.com/doehm/survivoR) | [Daniel's Oehm's Website](http://gradientdescending.com/survivor-data-from-the-tv-series-in-r/) |
| 24 | `2021-06-08` | [Great Lakes Fish](data/2021/2021-06-08/readme.md) | [Great Lakes Database](http://www.glfc.org/great-lakes-databases.php) | [Detroit Free Press](https://www.freep.com/story/news/local/michigan/2017/10/23/king-chinook-salmon-great-lakes-fish/780231001/) |
| 25 | `2021-06-15` | [WEB Du Bois and Juneteenth](data/2021/2021-06-15/readme.md) | [`#DuBoisChallenge` tweets](https://public.tableau.com/app/profile/sekou.tyler/viz/DuBoisChalllenge2021TwitterMetrics/DuBoisChallenge2021TwitterActivity) | [The Intercept](https://theintercept.com/2020/06/19/how-to-mark-juneteenth-in-the-year-2020/) |
| 26 | `2021-06-22` | [Public Park Access](data/2021/2021-06-22/readme.md) | [TPL](https://www.tpl.org/parks-and-an-equitable-recovery-parkscore-report) | [CityLab](https://www.bloomberg.com/news/articles/2021-05-27/the-cities-where-people-of-color-can-walk-to-a-park) |
| 27 | `2021-06-29` | [Animal Rescues](data/2021/2021-06-29/readme.md) | [London.gov](https://data.london.gov.uk/dataset/animal-rescue-incidents-attended-by-lfb) | [The Guardian](https://www.theguardian.com/world/2021/jan/08/animal-rescues-london-fire-brigade-rise-2020-pandemic-year) |
| 28 | `2021-07-06` | [International Independence Days](data/2021/2021-07-06/readme.md) | [Wikipedia](https://en.wikipedia.org/wiki/List_of_national_independence_days) | [WorldAtlas.com](https://www.worldatlas.com/articles/list-of-independence-days-by-country.html) |
| 29 | `2021-07-13` | [Scooby Doo](data/2021/2021-07-13/readme.md) | [Kaggle](https://www.kaggle.com/williamschooleman/scoobydoo-complete) | [ScoobyPedia](https://scoobydoo.fandom.com/wiki/Scoobypedia) |
| 30 | `2021-07-20` | [US Droughts](data/2021/2021-07-20/readme.md) | [Drought Monitor](https://droughtmonitor.unl.edu/DmData/DataDownload.aspx) | [NYTimes](https://www.nytimes.com/interactive/2021/06/11/climate/california-western-drought-map.html) & [CNN](https://www.cnn.com/2021/06/17/weather/west-california-drought-maps/index.html) |
| 31 | `2021-07-27` | [Olympic Medals](data/2021/2021-07-27/readme.md) | [Kaggle](https://www.kaggle.com/heesoo37/120-years-of-olympic-history-athletes-and-results) | [Financial Times](https://ig.ft.com/tokyo-olympics-alternative-medal-table/) & [FiveThirtyEight](https://projects.fivethirtyeight.com/olympics-medal-count/)  |
| 32 | `2021-08-03` | [Paralympic Medals](data/2021/2021-08-03/readme.md) | [IPC](https://db.ipc-services.org/sdms/hira) | [IPC](https://www.paralympic.org/feature/1964-1988-it-was-all-about-zipora-rubin-rosenbaum-s-dominance) |
| 33 | `2021-08-10` | [BEA Infrastructure Investment](data/2021/2021-08-10/readme.md) | [BEA](https://www.bea.gov/system/files/2021-01/infrastructure-data-may-2020.xlsx) | [BEA](https://www.bea.gov/system/files/papers/BEA-WP2020-12.pdf) |
| 34 | `2021-08-17` | [Star Trek Voice Commands](data/2021/2021-08-17/readme.md) | [SpeechInteraction.org](http://www.speechinteraction.org/TNG/) | [SpeechInteraction.org](http://www.speechinteraction.org/TNG/) |
| 35 | `2021-08-24` | [Lemurs](data/2021/2021-08-24/readme.md) | [Kaggle](https://www.kaggle.com/jessemostipak/duke-lemur-center-data) | [Zehr et al, 2014 - Nature](https://www.nature.com/articles/sdata201419) |
| 36 | `2021-08-31` | [Bird Baths](data/2021/2021-08-31/readme.md) | [Cleary et al, 2016](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0150899#abstract0) | [The Conversation](https://theconversation.com/bath-bullies-bacteria-and-battlegrounds-the-secret-world-of-bird-baths-65629) & [Cleary et al, 2016](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0150899#abstract0) |
| 37 | `2021-09-07` | [Formula 1 Races](data/2021/2021-09-07/readme.md) | [ergast.com/mrd/db](https://ergast.com/mrd/db/) | [FiveThirtyEight](https://fivethirtyeight.com/features/formula-one-racing/) |
| 38 | `2021-09-14` | [Billboard Top 100](data/2021/2021-09-14/readme.md) | [Data.World](https://data.world/kcmillersean/billboard-hot-100-1958-2017#) | [ThePudding](https://pudding.cool/projects/music-history/) |
| 39 | `2021-09-21` | [Emmy Awards](data/2021/2021-09-21/readme.md) | [Emmys](https://www.emmys.com/awards/nominations/award-search) | [Susie Lu](https://bit.ly/3hQNZM8) |
| 40 | `2021-09-28` | [NBER Papers](data/2021/2021-09-28/readme.md) | [NBER](https://www.nber.org/) | [`nberwp` R package](https://github.com/bldavies/nberwp) |
| 41 | `2021-10-05` | [Registered Nurses](data/2021/2021-10-05/readme.md) | [Data.World](https://data.world/zendoll27/registered-nursing-labor-stats-1998-2020) | [BLS](https://www.bls.gov/oes/2017/may/oes291141.htm) |
| 42 | `2021-10-12` | [Global Seafood](data/2021/2021-10-12/readme.md) | [OurWorldinData.org](https://ourworldindata.org/seafood-production) | [OurWorldinData.org](https://ourworldindata.org/seafood-production) |
| 43 | `2021-10-19` | [Big Pumpkins](data/2021/2021-10-19/readme.md) | [BigPumpkins.com](http://www.bigpumpkins.com/ViewArticle.asp?id=132) | [Great Pumpkin Commonwealth](https://gpc1.org/history-of-pumpkin-growing/) |
| 44 | `2021-10-26` | [Ultra Trail Running](data/2021/2021-10-26/readme.md) | [BjnNowak-Github Repo](https://github.com/BjnNowak/UltraTrailRunning) | [RunRepeat.com](https://runrepeat.com/state-of-ultra-running) |
| 45 | `2021-11-02` | [Making maps with R](data/2021/2021-11-02/readme.md) | [Geocomputation with R](https://geocompr.robinlovelace.net/adv-map.html) | [Geocomputation with R](https://geocompr.robinlovelace.net/adv-map.html) |

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
