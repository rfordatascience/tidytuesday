![](https://cdn.shopify.com/s/files/1/0506/0633/collections/image2_2_1300x.jpg?v=1551118659)

# Marble Racing

The data this week comes from [Jelle's Marble Runs](https://www.youtube.com/channel/UCYJdpnjuSWVOLgGT9fIzL0g) courtesy of [Randy Olson](http://www.randalolson.com/2020/05/24/a-data-driven-look-at-marble-racing/).

Randy's [blogpost](http://www.randalolson.com/2020/05/24/a-data-driven-look-at-marble-racing/) covers some additional analysis.

> Jelle's Marble Runs started as a quirky YouTube channel back in 2006 and has refined the art of marble racing to the point that many — including [sponsor John Oliver from Last Week Tonight](https://youtu.be/z4gBMw64aqk?t=1067) — consider marble racing a legitimate contender for the national sports spotlight. Given that Jelle's Marble Runs just completed their popular Marbula One competition last month, I was curious to look at the race results to see if these races were anything more than chaos.
> 
> Do some marbles race better than others? Who would I put my money on in season 2 of Marbula One? ... If any of these questions interest you, read on and I'll answer some of them.
> 
> The first step to answering these questions was to get some data. Thankfully, all of the Marbula One videos are organized in a YouTube playlist available here. From every race, my marble racing analytics team recorded each marble racer's qualifier performance, total race time, average lap time, final rank, and some other statistics. That dataset is available for download on my website here.

Some additional context from the fandom Wiki [for Jelle's Marble Runs](https://jellesmarbleruns.fandom.com/wiki/Marble_League_Wiki) and a link to [Season 1](https://jellesmarbleruns.fandom.com/wiki/Marbula_One_Season_1) courtesy of [Georgios Karamanis](https://twitter.com/geokaramanis/status/1267539394665332736).

- Spotlight from John Oliver [on Last Week Tonight](https://youtu.be/z4gBMw64aqk?t=1067)  
- courtesy of [Dennis Hammerschmidt](https://twitter.com/d_hammers/status/1267542002826194944)  

### Get the data here

```{r}
# Get the Data

marbles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-02/marbles.csv')

# Or read in with tidytuesdayR package (https://github.com/dslc-io/tidytuesdayR)

# Either ISO-8601 date or year/week works!

# Install via pak::pak("dslc-io/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-06-02')
tuesdata <- tidytuesdayR::tt_load(2020, week = 23)


marbles <- tuesdata$marbles
```
### Data Dictionary

# `marbles.csv`

|variable       |class     |description |
|:--------------|:---------|:-----------|
|date           |character | date of race |
|race           |character | race id |
|site           |character | site of race |
|source         |character | youtube url |
|marble_name    |character | name of marble |
|team_name      |character | team name|
|time_s         |double    | Time in seconds|
|pole           |character |pole position|
|points         |double    | Points gained |
|track_length_m |double    |track length in meters |
|number_laps    |double    |number of laps |
|avg_time_lap   |double    | average lap time |
|host           |character | Host of race |
|notes          |character | Notes (very few, but some notes about potential errors) |

### `skimr`

```
── Data Summary ────────────────────────
                           Values 
Name                       marbles
Number of rows             256    
Number of columns          14     
_______________________           
Column type frequency:            
  character                9      
  numeric                  5      
________________________          
Group variables                   

── Variable type: character ────────────────────────────────────────────────────────
  skim_variable n_missing complete_rate   min   max empty n_unique whitespace
1 date                  0        1          8     9     0       16          0
2 race                  0        1          4     4     0       16          0
3 site                  0        1          7    15     0        8          0
4 source                0        1         34    34     0       16          0
5 marble_name           0        1          4     9     0       32          0
6 team_name             0        1          6    16     0       16          0
7 pole                128        0.5        2     3     0       16          0
8 host                  0        1          2     3     0        2          0
9 notes               249        0.0273    37   100     0        7          0

── Variable type: numeric ──────────────────────────────────────────────────────────
  skim_variable  n_missing complete_rate   mean      sd hist 
1 time_s                 3         0.988 191.   169.    ▇▁▁▇▁
2 points               128         0.5     6.45   7.74  ▇▂▂▁▁
3 track_length_m         0         1      13.2    0.952 ▅▅▂▁▇
4 number_laps            0         1       6.25   5.53  ▇▁▃▂▂
5 avg_time_lap           3         0.988  29.7    5.55  ▃▆▇▇▂


```

### Cleaning Script

```{r}
library(tidyverse)
library(skimr)
library(janitor)


marbles <- read_csv("2020/2020-06-02/Jelles-Marble-Racing-Marbula-One.csv") %>% 
 janitor::clean_names() %>% 
  select(-x14) %>% 
  rename(notes = x15)

skimr::skim(marbles)

marbles %>% 
  write_csv("2020/2020-06-02/marbles.csv")
```
