# Tennis Grand Slams

A few exciting Tennis-related datasets this week, all of which come courtesy of Wikipedia! "All records are based on data from the Association of Tennis Professionals (ATP), the International Tennis Federation (ITF), and the official websites of the four Grand Slam tournaments." - Wikipedia

"The Open Era is the current era of professional tennis. It began in 1968 when the Grand Slam tournaments allowed professional players to compete with amateurs, ending the division that had persisted since the dawn of the sport in the 19th century." - Wikipedia

"The Grand Slam tournaments, also called majors, are the four most important annual tennis events. They offer the most ranking points, prize money, public and media attention, the greatest strength and size of field, and greater number of "best of" sets for men. The Grand Slam itinerary consists of the Australian Open in mid January, the French Open around late May through early June, Wimbledon in June-July, and the US Open in August-September. Each tournament is played over a two-week period. The Australian and United States tournaments are played on hard courts, the French on clay, and Wimbledon on grass." - Wikipedia

The court surface could be an interesting additional piece of data that I have left out, you could add it in with some clever `case_when()` calls.

I have tamed the datasets pretty thoroughly but there are several ways you could combine, summarize, or otherwise plot the data for this week. I have a spoiler/hint at the bottom if you get stuck with combining! I also left my relatively rough cleaning and data collection .rmd in, and have uploaded it.

### DISCLAIMER

The Grand Slam tournaments happen in a rough 2-week timeframe as mentioned above, however I was unable to find a nice dataset that covered the specific day of both the men's and women's finals. As such I have used a static date that estimates the date of the championship match, and likely has an error of a few days for each tournament. However, this is still useful for determining the *approximate* age of the player at each tournament.

## *Data Sources:*
[Women's Timeline](https://en.wikipedia.org/wiki/Tennis_performance_timeline_comparison_(women))  
[Men's Timeline](https://en.wikipedia.org/wiki/Tennis_performance_timeline_comparison_(men))  
[Date of Birth/First Title](https://en.wikipedia.org/wiki/List_of_Grand_Slam_singles_champions_in_Open_Era_with_age_of_first_title)  
[Women's Singles Champs](https://en.wikipedia.org/wiki/List_of_Grand_Slam_women%27s_singles_champions)  
[Men's Singles Champs](https://en.wikipedia.org/wiki/List_of_Grand_Slam_men%27s_singles_champions)  

## Article

The [Financial Times Article](https://ig.ft.com/sites/visual-history-of-womens-tennis/) has lots of great inspiration plots, but uses different datasets. Specifically the author used match wins vs tournament wins and tennis rankings over time rather than tournament placing. The author [John Burn-Murdoch](https://twitter.com/jburnmurdoch/status/777828932959756289) is a great follow for DataViz and visual storytelling resources, including R and D3.

Additionally a [gist](https://gist.github.com/johnburnmurdoch/bd20db77b2582031604ccd1bdc4be582) and [Tweet](https://twitter.com/jburnmurdoch/status/1101955617533685760) from John Burn-Murdoch goes through the process of collecting some men's tennis data, and then how he iterated across several plots. It's worth taking a look at for either code-inspiration for this week or as a general example of plot iteration for publication.

# Get the Data!

```
player_dob <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-09/player_dob.csv")

grand_slams <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-09/grand_slams.csv")

grand_slam_timeline <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-09/grand_slam_timeline.csv")
```

# Data Dictionaries

* `grand_slam_timeline`  

|variable   |class     |description |
|:----------|:---------|:-----------|
|player     |character | Player Name         |
|year       |integer   | Tournament Year           |
|tournament |character | Tournament name           |
|outcome    |character | Outcome - where player was eliminated, was absent, or won - there are some NAs |
|gender     |character | Male/Female for this dataset  |

* `grand_slams`  

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|year              |integer   | Tournament Year         |
|grand_slam        |character | Tournament name           |
|name              |character | Player Name           |
|rolling_win_count |integer   | Rolling win = cumulative sum of wins across time/player           |
|tournament_date   |date    | **Approximate** Tournament Date (ymd)           |
|gender            |character | Male/Female for this dataset         |

* `player_dob`    

|variable            |class     |description |
|:-------------------|:---------|:-----------|
|name                |character | Player name         |
|grand_slam          |character | Tournament for first major title win     |
|date_of_birth       | date    | date of birth (ymd)          |
|date_of_first_title | date    | date of first major title win (ymd)        |
|age                 | double    | Age in days          |

### Spoiler

To get the tournament performance at age rather than simply across time we need to `join` the Date of Birth dataset with the grandslam dataset.

```{r}
age_slams_comb <- left_join(grand_slams, player_dob, by = c("name")) %>% 
  mutate(age = tournament_date - date_of_birth) %>% # needs to be datetime
  group_by(name, age, gender) %>% 
  summarize(counts = n()) %>% 
  group_by(name) %>% 
  mutate(total_wins = cumsum(counts)) %>% 
  arrange(desc(total_wins))

# test plot
age_slams_comb %>% 
  ggplot(aes(x = age, y = total_wins, group = name)) +
  geom_point() +
  geom_step() +
  facet_wrap(~gender)
```
