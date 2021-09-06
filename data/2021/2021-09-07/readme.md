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

![The start of the 2018 Austrian Grand Prix - the image is of two long lines of F1 cars racing around the corner of the Austrian Grand Prix track.](https://upload.wikimedia.org/wikipedia/commons/e/e9/2018_Austrian_Grand_Prix_turn_1_%2843147259711%29.jpg)

# Formula 1 Races

The data this week comes from the [Ergast API](https://ergast.com/mrd/db/#csv), which has a CC-BY license.  H/t to [Sara Stoudt](https://github.com/rfordatascience/tidytuesday/issues/372) for sharing the link to the data by way of [Data is Plural](https://www.data-is-plural.com/archive/2021-08-25-edition/)!

[FiveThirtyEight](https://fivethirtyeight.com/features/formula-one-racing/) published a nice article on "Who’s The Best Formula One Driver Of All Time?". While the ELO data is not present in this dataset, you could calculate your own rating or using the [`{elo}`](https://github.com/eheinzen/elo) package to create ELO scores.

Per [Wikipedia, Formula 1](https://en.wikipedia.org/wiki/Formula_One): 

> Formula One (also known as Formula 1 or F1) is the highest class of international auto racing for single-seater formula racing cars sanctioned by the Fédération Internationale de l'Automobile (FIA). The World Drivers' Championship, which became the FIA Formula One World Championship in 1981, has been one of the premier forms of racing around the world since its inaugural season in 1950. The word formula in the name refers to the set of rules to which all participants' cars must conform. A Formula One season consists of a series of races, known as Grands Prix, which take place worldwide on both purpose-built circuits and closed public roads.
>
> The results of each race are evaluated using a points system to determine two annual World Championships: one for drivers, the other for constructors. Each driver must hold a valid Super Licence, the highest class of racing licence issued by the FIA. The races must run on tracks graded "1" (formerly "A"), the highest grade-rating issued by the FIA. Most events occur in rural locations on purpose-built tracks, but several events take place on city streets.

Each team can be called a "constructor" and they have two drivers. For example, Lewis Hamilton is the primary (driver) for the Mercedes team (constructor).


### License
> Complete images of the Ergast database are published shortly after each race under the [Attribution-NonCommercial-ShareAlike 3.0 Unported Licence](http://creativecommons.org/licenses/by-nc-sa/3.0/).

### Data

There is an option for raw CSVs (which is what is included in this repo), a SQL database, or querying the raw API. This is a _great_ dataset to practice with using the `httr` package to query an API, SQL against the database or `dbplyr` against the database! You can also work with the raw CSVs and practice your `dplyr::left_join()` and friends. Read more about `dplyr` joins in the [`dplyr` "joins" documentation](https://dplyr.tidyverse.org/reference/join.html).

If you wish to query the raw API, you can check the docs for example, to get a table of all drivers who have ever finished `#1` in the championship: [http://ergast.com/mrd/methods/status/](http://ergast.com/mrd/methods/status/). There is also an option to download the SQL database itself.

```
download.file(
  "http://ergast.com/downloads/f1db_ansi.sql.gz", 
  destfile = "f1db-mysql.zip"
)
```

Working with this data will require you to do several left joins, for example to get the standings for each race/driver. Each of the tables listed in the data dictionary have their keys for joining. If you don't want to dig too deep into the data, then I would recommend starting here. This is a good dataset of results by race, driver, season!

```
driver_results_df <- driver_standings %>% 
  left_join(races, by = "raceId") %>% 
  rename(driver_url = url) %>% 
  left_join(drivers, by = "driverId")
  
glimpse(driver_results_df)

#> Rows: 33,206
#> Columns: 22
#> $ driverStandingsId <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, #> 14, 1…
#> $ raceId            <dbl> 18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, #> 19, …
#> $ driverId          <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, #> 8, …
#> $ points            <dbl> 10, 8, 6, 5, 4, 3, 2, 1, 14, 11, 6, 6, 10, 3, #> 2,…
#> $ position          <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 1, 3, 6, 7, 4, 9, 10, #> 2,…
#> $ positionText      <chr> "1", "2", "3", "4", "5", "6", "7", "8", "1", #> "3"…
#> $ wins              <dbl> 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, #> 1, …
#> $ year              <dbl> 2008, 2008, 2008, 2008, 2008, 2008, 2008, #> 2008, …
#> $ round             <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, #> 2, …
#> $ circuitId         <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, #> 2, …
#> $ name              <chr> "Australian Grand Prix", "Australian Grand #> Prix"…
#> $ date              <date> 2008-03-16, 2008-03-16, 2008-03-16, #> 2008-03-16,…
#> $ time              <chr> "04:30:00", "04:30:00", "04:30:00", #> "04:30:00", …
#> $ driver_url        <chr> #> "http://en.wikipedia.org/wiki/2008_Australian_Gr…
#> $ driverRef         <chr> "hamilton", "heidfeld", "rosberg", "alonso", #> "ko…
#> $ number            <chr> "44", "\\N", "6", "14", "\\N", "\\N", "\\N", #> "7"…
#> $ code              <chr> "HAM", "HEI", "ROS", "ALO", "KOV", "NAK", #> "BOU",…
#> $ forename          <chr> "Lewis", "Nick", "Nico", "Fernando", #> "Heikki", "…
#> $ surname           <chr> "Hamilton", "Heidfeld", "Rosberg", "Alonso", #> "Ko…
#> $ dob               <date> 1985-01-07, 1977-05-10, 1985-06-27, #> 1981-07-29,…
#> $ nationality       <chr> "British", "German", "German", "Spanish", #> "Finni…
#> $ url               <chr> #> "http://en.wikipedia.org/wiki/Lewis_Hamilton", "…
```

To query the raw API, you can use `httr`, just make sure to end the call/url in `.json` to return JSON data.

```
library(tidyverse)
library(jsonlite)
library(httr)

standing <- 1
raw_json <- httr::GET(url = glue::glue(
  "http://ergast.com/api/f1/driverStandings/{standing}/drivers.json")) %>% 
  content(type = "text", encoding = "UTF-8") %>% 
  jsonlite::parse_json(simplifyVector = FALSE) 
  
raw_json %>% 
  View()
  
winner_table <- raw_json$MRData$DriverTable$Drivers %>%
  tibble(data = .) %>%
  unnest_wider(data)
  
winner_table %>% glimpse()
#> Rows: 30
#> Columns: 8
#> $ driverId        <chr> "alonso", "mario_andretti", "ascari", "j…
#> $ permanentNumber <chr> "14", NA, NA, NA, "22", NA, NA, NA, NA, …
#> $ code            <chr> "ALO", NA, NA, NA, "BUT", NA, NA, NA, NA…
#> $ url             <chr> "http://en.wikipedia.org/wiki/Fernando_A…
#> $ givenName       <chr> "Fernando", "Mario", "Alberto", "Jack", …
#> $ familyName      <chr> "Alonso", "Andretti", "Ascari", "Brabham…
#> $ dateOfBirth     <chr> "1981-07-29", "1940-02-28", "1918-07-13"…
#> $ nationality     <chr> "Spanish", "American", "Italian", "Austr…
```

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-09-07')
tuesdata <- tidytuesdayR::tt_load(2021, week = 37)

results <- tuesdata$results

# Or read in the data manually

circuits <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/circuits.csv')
constructor_results <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/constructor_results.csv')
constructor_standings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/constructor_standings.csv')
constructors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/constructors.csv')
driver_standings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/driver_standings.csv')
drivers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/drivers.csv')
lap_times <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/lap_times.csv')
pit_stops <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/pit_stops.csv')
qualifying <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/qualifying.csv')
races <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/races.csv')
results <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/results.csv')
seasons <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/seasons.csv')
status <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/status.csv')

```
### Data Dictionary

+----------------------+       
| List of Tables       |       
+----------------------+       
| circuits             |       
| constructorResults   |       
| constructorStandings |       
| constructors         |       
| driverStandings      |       
| drivers              |       
| lapTimes             |       
| pitStops             |       
| qualifying           |       
| races                |       
| results              |       
| seasons              |       
| status               |       
+----------------------+       

+------------------------------------------------------------------+
| General Notes                                                    |
+------------------------------------------------------------------|
| Dates, times and durations are in ISO 8601 format                |
| Dates and times are UTC                                          |
| Strings use UTF-8 encoding                                       |
| Primary keys are for internal use only                           |
| Fields ending with "Ref" are unique identifiers for external use |
| A grid position of '0' is used for starting from the pitlane     |
| Labels used in the positionText fields:                          |
|   "D" - disqualified                                             |
|   "E" - excluded                                                 |
|   "F" - failed to qualify                                        |
|   "N" - not classified                                           |
|   "R" - retired                                                  |
|   "W" - withdrew                                                 |
+------------------------------------------------------------------+

### `circuits.csv`

+------------+--------------+------+-----+---------+----------------+---------------------------+
| Field      | Type         | Null | Key | Default | Extra          | Description               |
+------------+--------------+------+-----+---------+----------------+---------------------------+
| circuitId  | int(11)      | NO   | PRI | NULL    | auto_increment | Primary key               |
| circuitRef | varchar(255) | NO   |     |         |                | Unique circuit identifier |
| name       | varchar(255) | NO   |     |         |                | Circuit name              |
| location   | varchar(255) | YES  |     | NULL    |                | Location name             |
| country    | varchar(255) | YES  |     | NULL    |                | Country name              |
| lat        | float        | YES  |     | NULL    |                | Latitude                  |
| lng        | float        | YES  |     | NULL    |                | Longitude                 |
| alt        | int(11)      | YES  |     | NULL    |                | Altitude (metres)         |
| url        | varchar(255) | NO   | UNI |         |                | Circuit Wikipedia page    |
+------------+--------------+------+-----+---------+----------------+---------------------------+

### constructor_results table
+----------------------+--------------+------+-----+---------+----------------+----------------------------------------+
| Field                | Type         | Null | Key | Default | Extra          | Description                            |
+----------------------+--------------+------+-----+---------+----------------+----------------------------------------+
| constructorResultsId | int(11)      | NO   | PRI | NULL    | auto_increment | Primary key                            |
| raceId               | int(11)      | NO   |     | 0       |                | Foreign key link to races table        |
| constructorId        | int(11)      | NO   |     | 0       |                | Foreign key link to constructors table |
| points               | float        | YES  |     | NULL    |                | Constructor points for race            |
| status               | varchar(255) | YES  |     | NULL    |                | "D" for disqualified (or null)         |
+----------------------+--------------+------+-----+---------+----------------+----------------------------------------+

### constructor_standings table
+------------------------+--------------+------+-----+---------+----------------+------------------------------------------+
| Field                  | Type         | Null | Key | Default | Extra          | Description                              |
+------------------------+--------------+------+-----+---------+----------------+------------------------------------------+
| constructorStandingsId | int(11)      | NO   | PRI | NULL    | auto_increment | Primary key                              |
| raceId                 | int(11)      | NO   |     | 0       |                | Foreign key link to races table          |
| constructorId          | int(11)      | NO   |     | 0       |                | Foreign key link to constructors table   |
| points                 | float        | NO   |     | 0       |                | Constructor points for season            |
| position               | int(11)      | YES  |     | NULL    |                | Constructor standings position (integer) |
| positionText           | varchar(255) | YES  |     | NULL    |                | Constructor standings position (string)  |
| wins                   | int(11)      | NO   |     | 0       |                | Season win count                         |
+------------------------+--------------+------+-----+---------+----------------+------------------------------------------+

### constructors table
+----------------+--------------+------+-----+---------+----------------+-------------------------------+
| Field          | Type         | Null | Key | Default | Extra          | Description                   |
+----------------+--------------+------+-----+---------+----------------+-------------------------------+
| constructorId  | int(11)      | NO   | PRI | NULL    | auto_increment | Primary key                   |
| constructorRef | varchar(255) | NO   |     |         |                | Unique constructor identifier |
| name           | varchar(255) | NO   | UNI |         |                | Constructor name              |
| nationality    | varchar(255) | YES  |     | NULL    |                | Constructor nationality       |
| url            | varchar(255) | NO   |     |         |                | Constructor Wikipedia page    |
+----------------+--------------+------+-----+---------+----------------+-------------------------------+

### driver_standings table
+-------------------+--------------+------+-----+---------+----------------+-------------------------------------+
| Field             | Type         | Null | Key | Default | Extra          | Description                         |
+-------------------+--------------+------+-----+---------+----------------+-------------------------------------+
| driverStandingsId | int(11)      | NO   | PRI | NULL    | auto_increment | Primary key                         |
| raceId            | int(11)      | NO   |     | 0       |                | Foreign key link to races table     |
| driverId          | int(11)      | NO   |     | 0       |                | Foreign key link to drivers table   |
| points            | float        | NO   |     | 0       |                | Driver points for season            |
| position          | int(11)      | YES  |     | NULL    |                | Driver standings position (integer) |
| positionText      | varchar(255) | YES  |     | NULL    |                | Driver standings position (string)  |
| wins              | int(11)      | NO   |     | 0       |                | Season win count                    |
+-------------------+--------------+------+-----+---------+----------------+-------------------------------------+

### drivers table
+-------------+--------------+------+-----+---------+----------------+--------------------------+
| Field       | Type         | Null | Key | Default | Extra          | Description              |
+-------------+--------------+------+-----+---------+----------------+--------------------------+
| driverId    | int(11)      | NO   | PRI | NULL    | auto_increment | Primary key              |
| driverRef   | varchar(255) | NO   |     |         |                | Unique driver identifier |
| number      | int(11)      | YES  |     | NULL    |                | Permanent driver number  |
| code        | varchar(3)   | YES  |     | NULL    |                | Driver code e.g. "ALO"   |     
| forename    | varchar(255) | NO   |     |         |                | Driver forename          |
| surname     | varchar(255) | NO   |     |         |                | Driver surname           |
| dob         | date         | YES  |     | NULL    |                | Driver date of birth     |
| nationality | varchar(255) | YES  |     | NULL    |                | Driver nationality       |
| url         | varchar(255) | NO   | UNI |         |                | Driver Wikipedia page    |
+-------------+--------------+------+-----+---------+----------------+--------------------------+

### lap_times table
+--------------+--------------+------+-----+---------+-------+-----------------------------------+
| Field        | Type         | Null | Key | Default | Extra | Description                       |
+--------------+--------------+------+-----+---------+-------+-----------------------------------+
| raceId       | int(11)      | NO   | PRI | NULL    |       | Foreign key link to races table   |
| driverId     | int(11)      | NO   | PRI | NULL    |       | Foreign key link to drivers table |
| lap          | int(11)      | NO   | PRI | NULL    |       | Lap number                        |
| position     | int(11)      | YES  |     | NULL    |       | Driver race position              |
| time         | varchar(255) | YES  |     | NULL    |       | Lap time e.g. "1:43.762"          |
| milliseconds | int(11)      | YES  |     | NULL    |       | Lap time in milliseconds          |
+--------------+--------------+------+-----+---------+-------+-----------------------------------+

### pit_stops table
+--------------+--------------+------+-----+---------+-------+-----------------------------------+
| Field        | Type         | Null | Key | Default | Extra | Description                       |
+--------------+--------------+------+-----+---------+-------+-----------------------------------+
| raceId       | int(11)      | NO   | PRI | NULL    |       | Foreign key link to races table   |
| driverId     | int(11)      | NO   | PRI | NULL    |       | Foreign key link to drivers table |
| stop         | int(11)      | NO   | PRI | NULL    |       | Stop number                       |
| lap          | int(11)      | NO   |     | NULL    |       | Lap number                        |
| time         | time         | NO   |     | NULL    |       | Time of stop e.g. "13:52:25"      |
| duration     | varchar(255) | YES  |     | NULL    |       | Duration of stop e.g. "21.783"    |
| milliseconds | int(11)      | YES  |     | NULL    |       | Duration of stop in milliseconds  |
+--------------+--------------+------+-----+---------+-------+-----------------------------------+

### qualifying table
+---------------+--------------+------+-----+---------+----------------+----------------------------------------+
| Field         | Type         | Null | Key | Default | Extra          | Description                            |
+---------------+--------------+------+-----+---------+----------------+----------------------------------------+
| qualifyId     | int(11)      | NO   | PRI | NULL    | auto_increment | Primary key                            |
| raceId        | int(11)      | NO   |     | 0       |                | Foreign key link to races table        |
| driverId      | int(11)      | NO   |     | 0       |                | Foreign key link to drivers table      |
| constructorId | int(11)      | NO   |     | 0       |                | Foreign key link to constructors table |
| number        | int(11)      | NO   |     | 0       |                | Driver number                          |
| position      | int(11)      | YES  |     | NULL    |                | Qualifying position                    |
| q1            | varchar(255) | YES  |     | NULL    |                | Q1 lap time e.g. "1:21.374"            |
| q2            | varchar(255) | YES  |     | NULL    |                | Q2 lap time                            |
| q3            | varchar(255) | YES  |     | NULL    |                | Q3 lap time                            |
+---------------+--------------+------+-----+---------+----------------+----------------------------------------+

### races table
+-----------+--------------+------+-----+------------+----------------+------------------------------------+
| Field     | Type         | Null | Key | Default    | Extra          | Description                        |
+-----------+--------------+------+-----+------------+----------------+------------------------------------+
| raceId    | int(11)      | NO   | PRI | NULL       | auto_increment | Primary key                        |
| year      | int(11)      | NO   |     | 0          |                | Foreign key link to seasons table  |
| round     | int(11)      | NO   |     | 0          |                | Round number                       |
| circuitId | int(11)      | NO   |     | 0          |                | Foreign key link to circuits table |
| name      | varchar(255) | NO   |     |            |                | Race name                          | 
| date      | date         | NO   |     | 0000-00-00 |                | Race date e.g. "1950-05-13"        |
| time      | time         | YES  |     | NULL       |                | Race start time e.g."13:00:00"     |
| url       | varchar(255) | YES  | UNI | NULL       |                | Race Wikipedia page                |
+-----------+--------------+------+-----+------------+----------------+------------------------------------+

### results table
+-----------------+--------------+------+-----+---------+----------------+---------------------------------------------+
| Field           | Type         | Null | Key | Default | Extra          | Description                                 |
+-----------------+--------------+------+-----+---------+----------------+---------------------------------------------+
| resultId        | int(11)      | NO   | PRI | NULL    | auto_increment | Primary key                                 |
| raceId          | int(11)      | NO   |     | 0       |                | Foreign key link to races table             |
| driverId        | int(11)      | NO   |     | 0       |                | Foreign key link to drivers table           |
| constructorId   | int(11)      | NO   |     | 0       |                | Foreign key link to constructors table      |
| number          | int(11)      | YES  |     | NULL    |                | Driver number                               |
| grid            | int(11)      | NO   |     | 0       |                | Starting grid position                      |
| position        | int(11)      | YES  |     | NULL    |                | Official classification, if applicable      |
| positionText    | varchar(255) | NO   |     |         |                | Driver position string e.g. "1" or "R"      |
| positionOrder   | int(11)      | NO   |     | 0       |                | Driver position for ordering purposes       |
| points          | float        | NO   |     | 0       |                | Driver points for race                      |
| laps            | int(11)      | NO   |     | 0       |                | Number of completed laps                    |
| time            | varchar(255) | YES  |     | NULL    |                | Finishing time or gap                       |
| milliseconds    | int(11)      | YES  |     | NULL    |                | Finishing time in milliseconds              |   
| fastestLap      | int(11)      | YES  |     | NULL    |                | Lap number of fastest lap                   |
| rank            | int(11)      | YES  |     | 0       |                | Fastest lap rank, compared to other drivers |
| fastestLapTime  | varchar(255) | YES  |     | NULL    |                | Fastest lap time e.g. "1:27.453"            |
| fastestLapSpeed | varchar(255) | YES  |     | NULL    |                | Fastest lap speed (km/h) e.g. "213.874"     |
| statusId        | int(11)      | NO   |     | 0       |                | Foreign key link to status table            |
+-----------------+--------------+------+-----+---------+----------------+---------------------------------------------+

### seasons table
+-------+--------------+------+-----+---------+-------+-----------------------+
| Field | Type         | Null | Key | Default | Extra | Description           |
+-------+--------------+------+-----+---------+-------+-----------------------+
| year  | int(11)      | NO   | PRI | 0       |       | Primary key e.g. 1950 |
| url   | varchar(255) | NO   | UNI |         |       | Season Wikipedia page |
+-------+--------------+------+-----+---------+-------+-----------------------+

### status table
+----------+--------------+------+-----+---------+----------------+---------------------------------+
| Field    | Type         | Null | Key | Default | Extra          | Description                     |
+----------+--------------+------+-----+---------+----------------+---------------------------------+
| statusId | int(11)      | NO   | PRI | NULL    | auto_increment | Primary key                     |
| status   | varchar(255) | NO   |     |         |                | Finishing status e.g. "Retired" |
+----------+--------------+------+-----+---------+----------------+---------------------------------+

### Cleaning Script

Not a real cleaning script, just me exploring the data structures.

```{r}
library(tidyverse)
library(fs)
library(httr)

# if you want SQL with tables
# download.file(
#   "http://ergast.com/downloads/f1db_ansi.sql.gz", 
#   destfile = "2021/2021-09-07/f1db-mysql.zip"
#   )

download.file(
  "http://ergast.com/downloads/f1db_csv.zip", 
  destfile = "2021/2021-09-07/f1db.zip"
)

unzip("2021/2021-09-07/f1db.zip", exdir = "2021/2021-09-07/")

raw_data <- map(
  fs::dir_ls("2021/2021-09-07/", glob = "*.csv"),
  read_csv
  ) %>% 
  set_names(nm = str_remove(names(.), "2021/2021-09-07/"))

raw_data %>% 
  str(max.level = 1)

# Example of JSON/HTTR
raw_json <- httr::GET(url = glue::glue(
  "http://ergast.com/api/f1/driverStandings/{standing}/drivers.json")) %>% 
  content(type = "text", encoding = "UTF-8")

raw_json%>% 
  View()

raw_json$MRData$DriverTable$Drivers %>%
  tibble(data = .) %>%
  unnest_wider(data)

driver_standings %>% 
  left_join(raw_data$races.csv, by = "raceId") %>% 
  rename(driver_url = url) %>% 
  left_join(raw_data$drivers.csv, by = "driverId")

file_names <- fs::dir_ls("2021/2021-09-07/", glob = "*.csv") %>% 
  str_remove("2021/2021-09-07/") %>% 
  str_remove(".csv")
  
file_names

```