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

# Horror Movies

> Purpose is to explore a dataset about horror movies dating back to the 1950s. Data set was extracted from **[The Movie Datbase](https://www.themoviedb.org)** via the tmdb API using R <code>httr</code>. There are ~35K movie records in this dataset.

Note - to use the images, append the poster path to the following url: https://www.themoviedb.org/t/p/w1280

Read more about Tanya's workshop on her GitHub: [Horror Movies](https://github.com/tashapiro/horror-movies)


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-11-01')
tuesdata <- tidytuesdayR::tt_load(2022, week = 44)

horror_movies <- tuesdata$horror_movies

# Or read in the data manually

horror_movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-11-01/horror_movies.csv')

```
### Data Dictionary

# `horror_movies.csv`

| **Variable**          | **Type** | **Definition**             | **Example**                     |
|:---------------|:--------------:|:------------------|:---------------------|
| **id**                |   int    | unique movie id            | 4488                            |
| **original_title**    |   char   | original movie title       | Friday the 13th                 |
| **title**             |   char   | movie title                | Friday the 13th                 |
| **original_language** |   char   | movie language             | en                              |
| **overview**          |   char   | movie overview/desc        | Camp counselors are stalked...  |
| **tagline**           |   char   | tagline                    | They were warned...             |
| **release_date**      |   date   | release date               | 1980-05-09                      |
| **poster_path**       |   char   | image url                  | /HzrPn1gEHWixfMOvOehOTlHROo.jpg |
| **popularity**        |   num    | popularity                 | 58.957                          |
| **vote_count**        |   int    | total votes                | 2289                            |
| **vote_average**      |   num    | average rating             | 6.4                             |
| **budget**            |   int    | movie budget               | 550000                          |
| **revenue**           |   int    | movie revenue              | 59754601                        |
| **runtime**           |   int    | movie runtime (min)        | 95                              |
| **status**            |   char   | movie status               | Released                        |
| **genre_names**       |   char   | list of genre tags         | Horror, Thriller                |
| **collection_id**     |   num    | collection id (nullable)   | 9735                            |
| **collection_name**   |   char   | collection name (nullable) | Friday the 13th Collection      |

### Cleaning Script


[Tanya Shapiro - Horror Movies workshop](https://github.com/tashapiro/horror-movies/tree/main/code)
