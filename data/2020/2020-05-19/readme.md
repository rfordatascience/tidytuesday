![Beach Volleyball](https://cdn.pixabay.com/photo/2016/08/24/14/17/beach-volleyball-1617093_960_720.jpg)

# Beach Volleyball

The data this week comes from [Adam Vagnar](https://github.com/rfordatascience/tidytuesday/issues/62) who also [blogged](https://bigtimestats.blog/2019/09/15/avp-stat-trends/) about this dataset. There's a LOT of data here - match-level results, player details, and match-level statistics for some matches. For all this dataset all the matches are played 2 vs 2, so there are columns for 2 winners (1 team) and 2 losers (1 team). The data is relatively ready for analysis and clean, although there are some duplicated columns and the data is wide due to the 2-players per team.

Check out the data dictionary, or [Wikipedia](https://en.wikipedia.org/wiki/Beach_volleyball#Skills) for some longer-form details around what the various match statistics mean. 

Most of the data is from the international [FIVB tournaments](https://en.wikipedia.org/wiki/FIVB_Beach_Volleyball_World_Championships) but about 1/3 is from the US-centric [AVP](https://en.wikipedia.org/wiki/Association_of_Volleyball_Professionals).

> The FIVB Beach Volleyball World Tour (known between 2003 and 2012 as the FIVB Beach Volleyball Swatch World Tour for sponsorship reasons) is the worldwide professional beach volleyball tour for both men and women organized by the Fédération Internationale de Volleyball (FIVB). The World Tour was introduced for men in 1989 while the women first competed in 1992.
> 
> Winning the World Tour is considered to be one of the highest honours in international beach volleyball, being surpassed only by the World Championships, and the Beach Volleyball tournament at the Summer Olympic Games.

[FiveThirtyEight](https://fivethirtyeight.com/features/serving-is-a-disadvantage-in-some-olympic-sports/) examined the disadvantage of serving in beach volleyball, although they used Olympic-level data. Again, Adam Vagnar also covered this data on his [blog](https://bigtimestats.blog/2019/09/15/avp-stat-trends/).

### Get the data here

```{r}
# Get the Data

vb_matches <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-19/vb_matches.csv', guess_max = 76000)

# Or read in with tidytuesdayR package (https://github.com/dslc-io/tidytuesdayR)

# Either ISO-8601 date or year/week works!

# Install via pak::pak("dslc-io/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-05-19')
tuesdata <- tidytuesdayR::tt_load(2020, week = 21)


vb_matches <- tuesdata$vb_matches
```
### Data Dictionary

# `vb_matches.csv`

|variable              |class     |description |
|:---------------------|:---------|:-----------|
|circuit               |character | Either AVP (USA) or FIVB (International) |
|tournament            |character | Tournament City or Name|
|country               |character | Country where tournament played |
|year                  |double    | Year of tournament |
|date                  |double    | Date of match |
|gender                |character | Gender of team |
|match_num             |double    | Match Number |
|w_player1             |character | Winner player 1 Name|
|w_p1_birthdate        |double    | Winner player 1 birth date|
|w_p1_age              |double    |Winner player 1 age|
|w_p1_hgt              |double    |Winner player 1 height in inches |
|w_p1_country          |character |Winner player country |
|w_player2             |character |Winner player 2 name |
|w_p2_birthdate        |double    |Winner player 2 birthdate |
|w_p2_age              |double    |Winner player 2 age|
|w_p2_hgt              |double    |Winner player 2 height in inches |
|w_p2_country          |character |Winner player 2 country |
|w_rank                |character |Winner team rank|
|l_player1             |character | Losing player 1 name|
|l_p1_birthdate        |double    | Losing player 1 birthdate|
|l_p1_age              |double    | Losing player 1 age|
|l_p1_hgt              |double    | Losing player 1 height in inches |
|l_p1_country          |character | Losing player 1 country|
|l_player2             |character | Losing player 2 name |
|l_p2_birthdate        |double    | Losing player 2 birthdate |
|l_p2_age              |double    | Losing player 2 age|
|l_p2_hgt              |double    | Losing player 2 height in inches |
|l_p2_country          |character | Losing player 2 country|
|l_rank                |character | Losing team rank|
|score                 |character | Match score separated by a dash and matches separated by a comma, eg 21 points to 12 points is 21-12|
|duration              |double    | Duration of match in minutes |
|bracket               |character | Tournament bracket |
|round                 |character | Tournament round |
|w_p1_tot_attacks      |double    |Winner player 1 number of attacks (attacking swings over the net) |
|w_p1_tot_kills        |double    |Winner player 1 number of kills (point ending attacks) |
|w_p1_tot_errors       |double    |Winner player 1 mistakes |
|w_p1_tot_hitpct       |double    |Winner player 1 hitting percentage - calculated as (kills-errors)/attacks - this is the player's effectiveness at scoring |
|w_p1_tot_aces         |double    |Winner player 1 total aces - point ending serves |
|w_p1_tot_serve_errors |double    |Winner player 1 total serving errors - mistakes made on serve |
|w_p1_tot_blocks       |double    |Winner player 1 total blocks - point ending blocks |
|w_p1_tot_digs         |double    |Winner player 1 total digs - successful defense of an attack |
|w_p2_tot_attacks      |double    |Winner player 2 number of attacks (attacking swings over the net) 
|w_p2_tot_kills        |double    |Winner player 2 number of kills (point ending attacks) |
|w_p2_tot_errors       |double    |Winner player 2 mistakes |
|w_p2_tot_hitpct       |double    |Winner player 2 hitting percentage - calculated as (kills-errors)/
|w_p2_tot_aces         |double    |Winner player 2 total aces - point ending serves |
|w_p2_tot_serve_errors |double    |Winner player 2 total serving errors - mistakes made on serve |
|w_p2_tot_blocks       |double    |Winner player 2 total blocks - point ending blocks |
|w_p2_tot_digs         |double    |Winner player 2 total digs - successful defense of an attack |
|l_p1_tot_attacks      |double    | Losing player 1 number of attacks (attacking swings over the net) 
|l_p1_tot_kills        |double    | Losing player 1 number of kills (point ending attacks) |
|l_p1_tot_errors       |double    | Losing player 1 mistakes |
|l_p1_tot_hitpct       |double    | Losing player 1 hitting percentage - calculated as (kills-errors)/
|l_p1_tot_aces         |double    | Losing player 1 total aces - point ending serves |
|l_p1_tot_serve_errors |double    | Losing player 1 total serving errors - mistakes made on serve |
|l_p1_tot_blocks       |double    | Losing player 1 total blocks - point ending blocks |
|l_p1_tot_digs         |double    | Losing player 1 total digs - successful defense of an attack |
|l_p2_tot_attacks      |double    |Losing player 2 number of attacks (attacking swings over the net) 
|l_p2_tot_kills        |double    |Losing player 2 number of kills (point ending attacks) |
|l_p2_tot_errors       |double    |Losing player 2 mistakes |
|l_p2_tot_hitpct       |double    |Losing player 2 hitting percentage - calculated as (kills-errors)/
|l_p2_tot_aces         |double    |Losing player 2 total aces - point ending serves |
|l_p2_tot_serve_errors |double    |Losing player 2 total serving errors - mistakes made on serve |
|l_p2_tot_blocks       |double    |Losing player 2 total blocks - point ending blocks |
|l_p2_tot_digs         |double    |Losing player 2 total digs - successful defense of an attack |

### `skimr`

```{r}
── Data Summary ────────────────────────
                           Values  
Name                       vb_matches
Number of rows             76756   
Number of columns          65      
_______________________            
Column type frequency:             
  character                17      
  Date                     5       
  difftime                 1       
  numeric                  42      
________________________           
Group variables            None    

── Variable type: character ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   skim_variable n_missing complete_rate   min   max empty n_unique whitespace
 1 circuit               0         1         3     4     0        2          0
 2 tournament            0         1         3    22     0      177          0
 3 country               0         1         4    22     0       51          0
 4 gender                0         1         1     1     0        2          0
 5 w_player1             0         1         6    29     0     3388          0
 6 w_p1_country         12         1.00      4    20     0       85          0
 7 w_player2             0         1         5    30     0     3431          0
 8 w_p2_country          5         1.00      4    20     0       87          0
 9 w_rank              148         0.998     1     7     0      812          0
10 l_player1             0         1         5    29     0     5713          0
11 l_p1_country         18         1.00      4    20     0      109          0
12 l_player2             0         1         5    30     0     5689          0
13 l_p2_country         10         1.00      4    20     0      111          0
14 l_rank             1240         0.984     1     7     0      837          0
15 score                22         1.00      4    25     0     6624          0
16 bracket               0         1         6    21     0       36          0
17 round              4939         0.936     7     8     0       10          0

── Variable type: Date ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable  n_missing complete_rate min        max        median     n_unique
1 date                   0         1     2000-09-16 2019-08-29 2009-08-25      658
2 w_p1_birthdate       383         0.995 1953-06-13 2004-07-15 1981-10-30     2805
3 w_p2_birthdate       408         0.995 1952-10-11 2004-06-08 1981-10-15     2847
4 l_p1_birthdate      1059         0.986 1953-06-13 2004-12-01 1982-03-28     4236
5 l_p2_birthdate       959         0.988 1949-12-04 2004-08-12 1982-03-20     4282

── Variable type: difftime ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable n_missing complete_rate min      max       median n_unique
1 duration           2249         0.971 120 secs 8040 secs 42'00"      108

── Variable type: numeric ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   skim_variable         n_missing complete_rate     mean     sd  hist 
 1 year                          0         1     2010.     5.48   ▃▇▆▅▇
 2 match_num                     0         1       31.8   23.5    ▇▅▂▁▁
 3 w_p1_age                    383         0.995   28.7    5.05   ▂▇▃▁▁
 4 w_p1_hgt                   3966         0.948   73.7    3.64   ▁▅▇▃▁
 5 w_p2_age                    408         0.995   28.8    4.85   ▁▇▆▁▁
 6 w_p2_hgt                   4016         0.948   73.7    3.69   ▁▃▇▆▁
 7 l_p1_age                   1059         0.986   28.3    5.26   ▂▇▂▁▁
 8 l_p1_hgt                   6988         0.909   73.4    3.62   ▁▃▇▅▁
 9 l_p2_age                    959         0.988   28.4    5.12   ▂▇▁▁▁
10 l_p2_hgt                   6983         0.909   73.5    3.65   ▁▃▇▅▁
11 w_p1_tot_attacks          62178         0.190   25.9   10.0    ▇▅▁▁▁
12 w_p1_tot_kills            62178         0.190   14.7    5.34   ▂▇▅▁▁
13 w_p1_tot_errors           62413         0.187    2.90   2.27   ▇▁▁▁▁
14 w_p1_tot_hitpct           62185         0.190    0.480  0.230  ▇▁▁▁▁
15 w_p1_tot_aces             60560         0.211    1.32   1.45   ▇▂▁▁▁
16 w_p1_tot_serve_errors     62417         0.187    2.03   1.65   ▇▃▁▁▁
17 w_p1_tot_blocks           60560         0.211    1.70   2.15   ▇▂▁▁▁
18 w_p1_tot_digs             62178         0.190    8.35   5.48   ▇▅▁▁▁
19 w_p2_tot_attacks          62174         0.190   26.1   10.1    ▇▇▁▁▁
20 w_p2_tot_kills            62174         0.190   14.8    5.33   ▂▇▅▁▁
21 w_p2_tot_errors           62413         0.187    2.92   2.29   ▇▁▁▁▁
22 w_p2_tot_hitpct           62181         0.190    0.477  0.164  ▁▇▁▁▁
23 w_p2_tot_aces             60556         0.211    1.19   1.36   ▇▁▁▁▁
24 w_p2_tot_serve_errors     62413         0.187    1.93   1.62   ▇▃▁▁▁
25 w_p2_tot_blocks           60556         0.211    1.69   2.19   ▇▂▁▁▁
26 w_p2_tot_digs             62174         0.190    8.54   5.56   ▇▃▁▁▁
27 l_p1_tot_attacks          62179         0.190   27.1   11.1    ▇▁▁▁▁
28 l_p1_tot_kills            62179         0.190   12.8    5.76   ▃▇▃▁▁
29 l_p1_tot_errors           62413         0.187    4.38   2.76   ▇▂▁▁▁
30 l_p1_tot_hitpct           62189         0.190    0.313  0.176  ▃▇▁▁▁
31 l_p1_tot_aces             60561         0.211    0.776  1.04   ▇▂▁▁▁
32 l_p1_tot_serve_errors     62418         0.187    2.10   1.66   ▇▃▁▁▁
33 l_p1_tot_blocks           60561         0.211    0.997  1.53   ▇▁▁▁▁
34 l_p1_tot_digs             62179         0.190    7.19   5.17   ▇▂▁▁▁
35 l_p2_tot_attacks          62178         0.190   26.7   10.8    ▃▇▁▁▁
36 l_p2_tot_kills            62178         0.190   12.6    5.66   ▃▇▃▁▁
37 l_p2_tot_errors           62413         0.187    4.32   2.71   ▇▃▁▁▁
38 l_p2_tot_hitpct           62189         0.190    0.313  0.176  ▂▇▁▁▁
39 l_p2_tot_aces             60560         0.211    0.775  1.06   ▇▁▁▁▁
40 l_p2_tot_serve_errors     62417         0.187    2.05   1.66   ▇▂▁▁▁
41 l_p2_tot_blocks           60560         0.211    1.06   1.56   ▇▁▁▁▁
42 l_p2_tot_digs             62178         0.190    7.14   5.18   ▇▃▁▁▁
```
### Cleaning Script

Data is already pretty clean! You may want to pivot the data by team or optionally separate out the winning/losing scores by match.

```{r}
library(tidyverse)

col_types_vb <- cols(
  circuit = col_character(),
  tournament = col_character(),
  country = col_character(),
  year = col_double(),
  date = col_date(format = ""),
  gender = col_character(),
  match_num = col_double(),
  w_player1 = col_character(),
  w_p1_birthdate = col_date(format = ""),
  w_p1_age = col_double(),
  w_p1_hgt = col_double(),
  w_p1_country = col_character(),
  w_player2 = col_character(),
  w_p2_birthdate = col_date(format = ""),
  w_p2_age = col_double(),
  w_p2_hgt = col_double(),
  w_p2_country = col_character(),
  w_rank = col_character(),
  l_player1 = col_character(),
  l_p1_birthdate = col_date(format = ""),
  l_p1_age = col_double(),
  l_p1_hgt = col_double(),
  l_p1_country = col_character(),
  l_player2 = col_character(),
  l_p2_birthdate = col_date(format = ""),
  l_p2_age = col_double(),
  l_p2_hgt = col_double(),
  l_p2_country = col_character(),
  l_rank = col_character(),
  score = col_character(),
  duration = col_time(format = ""),
  bracket = col_character(),
  round = col_character(),
  w_p1_tot_attacks = col_double(),
  w_p1_tot_kills = col_double(),
  w_p1_tot_errors = col_double(),
  w_p1_tot_hitpct = col_double(),
  w_p1_tot_aces = col_double(),
  w_p1_tot_serve_errors = col_double(),
  w_p1_tot_blocks = col_double(),
  w_p1_tot_digs = col_double(),
  w_p2_tot_attacks = col_double(),
  w_p2_tot_kills = col_double(),
  w_p2_tot_errors = col_double(),
  w_p2_tot_hitpct = col_double(),
  w_p2_tot_aces = col_double(),
  w_p2_tot_serve_errors = col_double(),
  w_p2_tot_blocks = col_double(),
  w_p2_tot_digs = col_double(),
  l_p1_tot_attacks = col_double(),
  l_p1_tot_kills = col_double(),
  l_p1_tot_errors = col_double(),
  l_p1_tot_hitpct = col_double(),
  l_p1_tot_aces = col_double(),
  l_p1_tot_serve_errors = col_double(),
  l_p1_tot_blocks = col_double(),
  l_p1_tot_digs = col_double(),
  l_p2_tot_attacks = col_double(),
  l_p2_tot_kills = col_double(),
  l_p2_tot_errors = col_double(),
  l_p2_tot_hitpct = col_double(),
  l_p2_tot_aces = col_double(),
  l_p2_tot_serve_errors = col_double(),
  l_p2_tot_blocks = col_double(),
  l_p2_tot_digs = col_double()
)

raw_df <- c("https://raw.githubusercontent.com/BigTimeStats/beach-volleyball/master/data/match_archive_2000_to_2017_v2.csv",
            "https://raw.githubusercontent.com/BigTimeStats/beach-volleyball/master/data/match_update_20170729_to_20170912.csv",
            "https://raw.githubusercontent.com/BigTimeStats/beach-volleyball/master/data/match_update_20170913_to_20180314.csv",
            "https://raw.githubusercontent.com/BigTimeStats/beach-volleyball/master/data/match_update_20180315_to_20180821.csv",
            "https://raw.githubusercontent.com/BigTimeStats/beach-volleyball/master/data/match_update_20180822_to_20190409.csv",
            "https://raw.githubusercontent.com/BigTimeStats/beach-volleyball/master/data/match_update_20190410_to_20190818.csv",
            "https://raw.githubusercontent.com/BigTimeStats/beach-volleyball/master/data/match_update_20190818_to_20190902.csv") %>% 
  map_dfr(read_csv, col_types = col_types_vb)
  
raw_df %>% 
  skimr::skim()
  
# Georgios Karamanis noticed that the birthdates are 
# incorrect for anyone born before 1970 (off by 100 years)
clean_df <- mutate_at(
  raw_df,
  vars(contains("birthdate")),
  list(~ if_else(. >= as.Date("2020-01-01"),
    . - lubridate::years(100),
    .
  ))
)

write_csv(clean_df, "2020/2020-05-19/vb_matches.csv")

```
