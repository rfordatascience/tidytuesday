![](static/tt_logo.png)

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

***

# DataSets
## [2018](data/2018) | [2019](data/2019) | [2020](data/2020)  

| Week | Date | Data | Source | Article
| :---: | :---: | :--- | :--- | :---|
| 1 | `2019-12-31` | Bring your own data from 2019! | | |
| 2 | `2020-01-07` | [Australian Fires](data/2020/2020-01-07/readme.md) | [Bureau of Meteorology](http://www.bom.gov.au/climate/data/stations/)| [NY Times](https://www.nytimes.com/interactive/2020/01/02/climate/australia-fires-map.html) & [BBC](https://www.bbc.com/news/world-australia-50951043) |
| 3 | `2020-01-14` | [Passwords](data/2020/2020-01-14/readme.md) | [Knowledge is Beautiful](https://docs.google.com/spreadsheets/d/1cz7TDhm0ebVpySqbTvrHrD3WpxeyE4hLZtifWSnoNTQ/edit#gid=21) | [Information is Beautiful](https://informationisbeautiful.net/visualizations/top-500-passwords-visualized/) |
| 4 | `2020-01-21` | [Song Genres](data/2020/2020-01-21/readme.md) | [`spotifyr` ](https://www.rcharlie.com/spotifyr/) | [Kaylin Pavlik](https://www.kaylinpavlik.com/classifying-songs-genres/) |
| 5 | `2020-01-28` | [San Francisco Trees](data/2020/2020-01-28/readme.md) | [data.sfgov.org](https://data.sfgov.org/City-Infrastructure/Street-Tree-List/tkzw-k3nq) | [SF Weekly](https://www.sfweekly.com/news/feature/trees-of-life/) |
| 6 | `2020-02-04` | [NFL Attendance](data/2020/2020-02-04/readme.md) | [Pro Football Reference](https://www.pro-football-reference.com/years/2002/index.htm) | [Casino.org](https://www.casino.org/record-and-attendance/) |
| 7 | `2020-02-11` | [Hotel Bookings](data/2020/2020-02-11/readme.md) | [Antonio, Almeida, and Nunes, 2019](https://www.sciencedirect.com/science/article/pii/S2352340918315191#bib5) | [`tidyverts`](https://tsibble.tidyverts.org/) |
| 8 | `2020-02-18` | [Food's Carbon Footprint](data/2020/2020-02-18/readme.md) | [nu3](https://www.nu3.de/blogs/nutrition/food-carbon-footprint-index-2018) | [`r-tastic` by Kasia Kulma](https://r-tastic.co.uk/post/from-messy-to-tidy/) |
| 9 | `2020-02-25` | [Measles Vaccination](data/2020/2020-02-25/readme.md) | [The Wallstreet Journal](https://github.com/WSJ/measles-data) | [The Wall Street Journal](https://www.wsj.com/graphics/school-measles-rate-map/) |
| 10 | `2020-03-03` | [NHL Goals](data/2020/2020-03-03/readme.md) | [HockeyReference.com](https://www.hockey-reference.com/leaders/goals_career.html) | [Washington Post](https://www.washingtonpost.com/graphics/2020/sports/capitals/ovechkin-700-goals/?utm_campaign=wp_graphics&utm_medium=social&utm_source=twitter)|
| 11 | `2020-03-10` | [College Tuition, Diversity, and Pay](data/2020/2020-03-10/readme.md) | [TuitionTracker.org](https://www.tuitiontracker.org/) | [TuitionTracker.org](https://www.tuitiontracker.org/school.html?unitid=228778) |
| 12 | `2020-03-17` | [The Office](data/2020/2020-03-17/readme.md) | [`schrute`](https://bradlindblad.github.io/schrute/index.html) | [The Pudding](https://pudding.cool/2017/08/the-office/) |
| 13 | `2020-03-24` | [Traumatic Brain Injury](data/2020/2020-03-24/readme.md) | [CDC](https://www.cdc.gov/mmwr/volumes/68/wr/mm6810a1.htm) | [CDC Traumatic Brain Injury Report](https://www.cdc.gov/mmwr/volumes/68/wr/mm6810a1.htm) |
| 14 | `2020-03-31` | [Beer Production](data/2020/2020-03-31/readme.md) | [TTB](https://www.ttb.gov/beer/statistics) | [Brewers Association](https://www.brewersassociation.org/insights/cans-bottles-craft-beer-packaging-trends/) |
| 15 | `2020-04-07` | [Tour de France](data/2020/2020-04-07/readme.md) | [`tdf` package](https://github.com/alastairrushworth/tdf) | [Alastair Rushworth's blog](https://alastairrushworth.github.io/Visualising-Tour-de-France-data-in-R/) |
| 16 | `2020-04-14` | [Best Rap Artists](data/2020/2020-04-14/readme.md) | [BBC Music](http://www.bbc.com/culture/story/20191007-the-greatest-hip-hop-songs-of-all-time-who-voted) | [Simon Jockers at Datawrapper](https://blog.datawrapper.de/best-hip-hop-songs-of-all-time-visualized/) |
| 17 | `2020-04-21` | [GDPR Violation](data/2020/2020-04-21/readme.md) | [Privacy Affairs](https://www.privacyaffairs.com/gdpr-fines/) | [Roel Hogervorst](https://blog.rmhogervorst.nl/blog/2020/04/08/scraping-gdpr-fines/) |
| 18 | `2020-04-28` | [Broadway Musicals](data/2020/2020-04-28/readme.md) | [Playbill](https://www.playbill.com/grosses) | [Alex Cookson](https://www.alexcookson.com/post/most-successful-broadway-show-of-all-time/) |
| 19 | `2020-05-05` | [Animal Crossing](data/2020/2020-05-05/readme.md) | [Villager DB](https://github.com/jefflomacy/villagerdb) | [Polygon](https://www.polygon.com/2020/4/2/21201065/animal-crossing-new-horizons-calm-mindfulness-coronavirus-quarantine) |
| 20 | `2020-05-12` | [Volcano Eruptions](data/2020/2020-05-12/readme.md) | [Smithsonian](https://volcano.si.edu/) | [Axios](https://www.axios.com/chart-every-volcano-that-erupted-since-krakatoa-467da621-41ba-4efc-99c6-34ff3cb27709.html) & [Wikipedia](https://en.wikipedia.org/wiki/Volcano)|
| 21 | `2020-05-19` | [Beach Volleyball](data/2020/2020-05-19/readme.md) | [BigTimeStats](https://bigtimestats.blog/data/) | [FiveThirtyEight](https://fivethirtyeight.com/features/serving-is-a-disadvantage-in-some-olympic-sports/) & [Wikipedia](https://en.wikipedia.org/wiki/Beach_volleyball#Skills)|
| 22 | `2020-05-26` | [Cocktails](data/2020/2020-05-26/readme.md) | [Kaggle](https://www.kaggle.com/ai-first/cocktail-ingredients) & [Kaggle](https://www.kaggle.com/jenlooper/mr-boston-cocktail-dataset) | [FiveThirtyEight](https://fivethirtyeight.com/videos/we-got-drunk-on-margaritas-for-science/) |
| 23 | `2020-06-02` | [Marble Races](data/2020/2020-06-02/readme.md) | [Jelle's Marble Runs](https://www.youtube.com/channel/UCYJdpnjuSWVOLgGT9fIzL0g)| [Randy Olson](http://www.randalolson.com/2020/05/24/a-data-driven-look-at-marble-racing/) |
| 24 | `2020-06-09` | [African-American Achievements](data/2020/2020-06-09/readme.md) | [Wikipedia](https://en.wikipedia.org/wiki/List_of_African-American_inventors_and_scientists) & [Wikipedia](https://en.wikipedia.org/wiki/List_of_African-American_firsts) | [David Blackwell](https://www.stltoday.com/news/local/obituaries/david-blackwell-fought-racism-became-world-famous-statistician/article_8ea41058-5f35-5afa-9c3a-007200c5c179.html) & [Petition for David Blackwell](https://www.change.org/p/american-statistical-association-rename-the-fisher-lecture-after-david-blackwell?recruiter=1107887809) |
| 25 | `2020-06-16` | [African-American History](data/2020/2020-06-16/readme.md) | [Black Past](https://www.blackpast.org/donate/) & [Census](https://www.census.gov/content/dam/Census/library/working-papers/2002/demo/POP-twps0056.pdf) & [Slave Voyages](https://slavevoyages.org/) | [The Guardian](https://www.theguardian.com/news/2019/aug/15/400-years-since-slavery-timeline) |
| 26 | `2020-06-23` | [Caribou Locations](data/2020/2020-06-23/readme.md) | [Movebank](https://www.movebank.org/cms/movebank-content/about-movebank) | [B.C. Ministry of Environment](https://www2.gov.bc.ca/assets/gov/environment/plants-animals-and-ecosystems/wildlife-wildlife-habitat/caribou/science_update_final_from_web_jan_2014.pdf)  |
| 27 | `2020-06-30` | [Claremont Run of X-Men](data/2020/2020-06-30/readme.md) | [Claremont Run](http://www.claremontrun.com/) | [Wikipedia - Uncanny X-Men](https://en.wikipedia.org/wiki/Uncanny_X-Men)  |
| 28 | `2020-07-07` | [Coffee Ratings](data/2020/2020-07-07/readme.md) | [James LeDoux](https://github.com/jldbc/coffee-quality-database) & [Coffee Quality Database](https://github.com/jldbc/coffee-quality-database)  | [Yorgos Askalidis - TWD](https://towardsdatascience.com/the-data-speak-ethiopia-has-the-best-coffee-91f88ed37e84)  |
| 29 | `2020-07-14` | [Astronaut Database](data/2020/2020-07-14/readme.md) | [Corlett, Stavnichuk & Komarova article](https://www.sciencedirect.com/science/article/abs/pii/S2214552420300444) | [Corlett, Stavnichuk & Komarova article](https://www.sciencedirect.com/science/article/abs/pii/S2214552420300444) |
| 30 | `2020-07-21` | [Australian Animal Outcomes](data/2020/2020-07-21/readme.md) | [RSPCA](https://www.rspca.org.au/what-we-do/our-role-caring-animals/annual-statistics) | [RSPCA Report](https://www.rspca.org.au/sites/default/files/RSPCA%20Report%20on%20animal%20outcomes%202018-2019.pdf) |
| 31 | `2020-07-28` | [Palmer Penguins](data/2020/2020-07-28/readme.md) | [Gorman, Williams and Fraser, 2014](https://doi.org/10.1371/journal.pone.0090081) | [Palmer Penguins](https://allisonhorst.github.io/palmerpenguins/) |
| 32 | `2020-08-04` | [European Energy](data/2020/2020-08-04/readme.md) | [Eurostat Energy](https://ec.europa.eu/eurostat/statistics-explained/index.php/Electricity_generation_statistics_%E2%80%93_first_results) | [Washington Post Energy](https://www.washingtonpost.com/climate-environment/2020/07/30/biden-calls-100-percent-clean-electricity-by-2035-heres-how-far-we-have-go/?arc404=true&utm_medium=social&utm_source=twitter&utm_campaign=wp_graphics) |
| 33 | `2020-08-11` | [Avatar: The Last Airbender](data/2020/2020-08-11/readme.md) | [`appa`](https://github.com/averyrobbins1/appa) | [Exploring Avatar: The Last Airbender transcript data](https://www.avery-robbins.com/2020/07/11/avatar-eda/) |
| 34 | `2020-08-18` | [Extinct Plants](data/2020/2020-08-18/readme.md) | [IUCN Red List](https://www.iucnredlist.org/) | [Florent Lavergne infographic](https://www.behance.net/gallery/98304453/Infographic-Plants-in-Danger) |
| 35 | `2020-08-25` | [Chopped](data/2020/2020-08-25/readme.md) | [Kaggle](https://www.kaggle.com/jeffreybraun/chopped-10-years-of-episode-data) & [IMDB](https://www.imdb.com/title/tt1353281/episodes?ref_=tt_eps_sn_mr) | [Vice](https://www.vice.com/en_us/article/wj8q39/how-chopped-became-tvs-greatest-cooking-show) |
| 36 | `2020-09-01` | [Global Crop Yields](data/2020/2020-09-01/readme.md) | [Our World in Data](https://ourworldindata.org/crop-yields) | [Our World in Data](https://ourworldindata.org/crop-yields) |
| 37 | `2020-09-08` | [Friends](data/2020/2020-09-08/readme.md) | [`friends` R package](https://github.com/EmilHvitfeldt/friends) | [ceros interactive article](https://www.ceros.com/originals/friends-scripts-25th-anniversary-catchphrase-scenes-quotes/) |
| 38 | `2020-09-15` | [Gov Spending on Kids](data/2020/2020-09-15/readme.md) | [Urban Institute](https://datacatalog.urban.org/dataset/state-state-spending-kids-dataset) | [Joshua Rosenberg](https://twitter.com/jrosenberg6432)'s [`tidykids`](https://jrosen48.github.io/tidykids/index.html) package |
| 39 | `2020-09-22` | [Himalayan Climbers](data/2020/2020-09-22/readme.md) | [The Himalayan Database](https://www.himalayandatabase.com/) | [Alex Cookson blog post](https://www.alexcookson.com/post/analyzing-himalayan-peaks-first-ascents/) |
| 40 | `2020-09-29` | [Beyonce & Taylor Swift Lyrics](data/2020/2020-09-29/readme.md) | [Rosie Baillie](https://twitter.com/Rosie_Baillie_) and [Dr. Sara Stoudt](https://twitter.com/sastoudt) | [Taylor Swift lyrics](https://rpubs.com/RosieB/taylorswiftlyricanalysis) |
| 41 | `2020-10-06` | [NCAA Women's Basketball](data/2020/2020-10-06/readme.md) | [FiveThirtyEight](https://fivethirtyeight.com/features/louisiana-tech-was-the-uconn-of-the-80s/) | [FiveThirtyEight](https://fivethirtyeight.com/features/louisiana-tech-was-the-uconn-of-the-80s/) |
| 42 | `2020-10-13` | [`datasauRus` dozen](data/2020/2020-10-13/readme.md) | [Alberto Cairo blogpost](http://www.thefunctionalart.com/2016/08/download-datasaurus-never-trust-summary.html) | [`datasauRus` R package - Steph Locke +  Lucy D'Agostino McGowan](https://cran.r-project.org/web/packages/datasauRus/vignettes/Datasaurus.html) |
| 43 | `2020-10-20` | [Great American Beer Festival Data](data/2020/2020-10-20/readme.md) | [Great American Beer Festival](https://www.greatamericanbeerfestival.com/the-competition/winners/) | [2019 GABF Medal Winner Analysis](https://www.brewersassociation.org/insights/gabf-medal-winners-analyzed-2019-edition/) |
| 44 | `2020-10-27` | [Canadian Wind Turbines](data/2020/2020-10-27/readme.md) | [open.canada.ca](https://open.canada.ca/data/en/dataset/79fdad93-9025-49ad-ba16-c26d718cc070) | [Canada's National Observer](https://www.nationalobserver.com/2020/10/23/news/wind-turbine-database-canada) |
| 45 | `2020-11-03` | [IKEA Furniture](data/2020/2020-11-03/readme.md) | [Kaggle](https://www.kaggle.com/ahmedkallam/ikea-sa-furniture-web-scraping) | [FiveThirtyEight](https://fivethirtyeight.com/features/the-weird-economics-of-ikea/) |
| 46 | `2020-11-10` | [Historical Phones](data/2020/2020-11-10/readme.md) | [Mobile vs Landline subscriptions](https://ourworldindata.org/technology-adoption#technology-leapfrogging) | [Pew Research Smartphone Adoption](https://www.pewresearch.org/global/2019/02/05/smartphone-ownership-is-growing-rapidly-around-the-world-but-not-always-equally/) |
| 47 | `2020-11-17` | [Black in Data](data/2020/2020-11-17/readme.md) | [Black in Data Week](https://blkindata.github.io/bidweek2020/) | [BlackInData `#DataViz`](https://blkindata.github.io/project/blackindataviz/) |
| 48 | `2020-11-24` | [Washington Trails](data/2020/2020-11-24/readme.md) | [WTA](https://www.wta.org/go-outside/hikes?b_start:int=1) | [TidyX](https://github.com/thebioengineer/TidyX) |
| 49 | `2020-12-01` | [Toronto Shelters](data/2020/2020-12-01/readme.md) | [`opendatatoronto`](https://github.com/sharlagelfand/opendatatoronto) | [rabble.ca](https://rabble.ca/blogs/bloggers/cathy-crowes-blog/2019/03/twitter-truth-torontos-homeless-emergency) |


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
