![Animal crossing villagers on a bridge with Tom Nook](https://www.slantmagazine.com/wp-content/uploads/2020/04/animalcrossingnewhorizons.jpg)

# Animal Crossing - New Horizons

The data this week comes from the [VillagerDB](https://github.com/jefflomacy/villagerdb) and [Metacritic](https://www.metacritic.com/game/switch/animal-crossing-new-horizons/critic-reviews). VillagerDB brings info about villagers, items, crafting, accessories, including links to their images. Metacritic brings user and critic reviews of the game (scores and raw text).

Per [Wikipedia](https://en.wikipedia.org/wiki/Animal_Crossing:_New_Horizons): 

> Animal Crossing: New Horizons is a 2020 life simulation video game developed and published by Nintendo for the Nintendo Switch. It is the fifth main series title in the Animal Crossing series. New Horizons was released in all regions on March 20, 2020.

> New Horizons sees the player assuming the role of a customizable character who moves to a deserted island after purchasing a package from Tom Nook, a tanuki character who has appeared in every entry in the Animal Crossing series. Taking place in real-time, the player can explore the island in a nonlinear fashion, gathering and crafting items, catching insects and fish, and developing the island into a community of anthropomorphic animals.

Animal Crossing as explained by a [Polygon](https://www.polygon.com/2020/4/2/21201065/animal-crossing-new-horizons-calm-mindfulness-coronavirus-quarantine) opinion piece.

> With just a few design twists, the work behind collecting hundreds or even thousands of items over weeks anpd months becomes an exercise of mindfulness, predictability, and agency that many players find soothing instead of annoying.

> Games that feature gentle progression give us a sense of progress and achievability, teaching us that putting in a little work consistently while taking things one step at a time can give us some fantastic results. It’s a good life lesson, as well as a way to calm yourself and others, and it’s all achieved through game design.

Potential Analyses:
* Reviews: Sentiment analysis, text analysis, scores, date effect
* Villagers/Items: Gender, species, sayings, personality, price, recipe, what about a [star sign](https://nookipedia.com/wiki/Star_sign) based off the birthday column?

Some potential context for `user_reviews.tsv` from [538](https://fivethirtyeight.com/features/ghostbusters-is-a-perfect-example-of-how-internet-ratings-are-broken/) and a point of potential strife via [Animal Crossing World](https://animalcrossingworld.com/2019/06/you-can-only-have-one-animal-crossing-new-horizons-island-per-nintendo-switch-system/), and lastly a [spoiler article](https://towardsdatascience.com/sentiment-analysis-of-animal-crossing-reviews-7ae98bc91dd3) analyzing the reviews in R by Boon Tan. 

PS there is an easter egg somewhere in the readme - something to do with... turnips.

### Get the data here

```{r}
# Get the Data

critic <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/critic.tsv')
user_reviews <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/user_reviews.tsv')
items <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/items.csv')
villagers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/villagers.csv')

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO USE tidytuesdayR version ? from GitHub

# Either ISO-8601 date or year/week works!

# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-05-05')
tuesdata <- tidytuesdayR::tt_load(2020, week = 19)


critic <- tuesdata$critic
```
### Data Dictionary


# `critic.tsv`

[Source](https://www.metacritic.com/game/switch/animal-crossing-new-horizons/critic-reviews)

|variable    |class     |description |
|:-----------|:---------|:-----------|
|grade       |integer   | 0-100 score given by the critic (missing for some) where higher score = better. |
|publication |character | The source of the review |
|text        |character | Raw text describing the review. |
|date        |double    | Date review published |

# `user_reviews.tsv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|grade     |integer   | Raw score (0-10) where higher score = better.|
|user_name |character | User name of reviewer |
|text      |character | Raw text of the review |
|date      |double    | Date review published. |

# `villagers.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|row_n       |integer   | row_n is a numerical ID |
|id          |character | id is a short text identifier |
|name        |character | name of the villager |
|gender      |character | gender of the villager |
|species     |character | species of the villager |
|birthday    |character | birthday of the villager (month-day) |
|personality |character | Personality|
|song        |character | Song associated with the villager |
|phrase      |character | Catchphraase of the villager |
|full_id     |character | Full text id of villager |
|url         |character | Link to image of the villager |

# `items.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|num_id        |integer   | Numerical id - note that some items have multiple rows as they have multiple recipe items |
|id            |character | Character id|
|name          |character | Name of the item|
|category      |character | Category of item (eg furniture, clothing, etc|
|orderable     |logical   | Orderable from catalogue|
|sell_value    |integer   | sell value|
|sell_currency |character | sell currency |
|buy_value     |integer   | buy value|
|buy_currency  |character | buy currency|
|sources       |character | way to acquire or person/place to acquire from|
|customizable  |character | Is it customizable? |
|recipe        |integer   | Recipe number |
|recipe_id     |character | Recipe ID|
|games_id      |character | game id|
|id_full       |character | Full character id|
|image_url     |character | Link to image of item |

### Cleaning Script

```{r}
library(rvest)
library(tidyverse)
library(jsonlite)
library(listviewer)

url <- "https://github.com/jefflomacy/villagerdb/tree/master/data/items"

all_villagers <- list.files("villagerdb-master/data/villagers")

village_read <- function(file_name){
  fromJSON(here::here("villagerdb-master/data/villagers", file_name))
}

item_read <- function(file_name){
  fromJSON(here::here("villagerdb-master/data/items", file_name))
}


json_list <- all_villagers %>% 
  map(village_read)

listviewer::jsonedit(json_com)

clean_villagers <- json_list %>% 
  enframe() %>% 
  rename(row_n = name) %>% 
  unnest_wider(value) %>% 
  unnest_longer(games) %>% 
  unnest_wider(games) %>% 
  unnest_wider(coffee) %>% 
  select(-...1) %>% 
  rename(coffee_beans = beans, coffee_milk = milk, coffee_sugar = sugar) %>% janitor::clean_names() %>% 
  filter(games_id == "nh") %>% 
  select(row_n, id, name, gender:personality, song, phrase)

final_villagers <- left_join(clean_villagers, villager_db_villagers_images %>% 
  mutate(full_id = id, 
         id = str_remove(id, "villager-")) %>% 
  select(full_id, id, name, url),
  by = c("name", "id"))

final_villagers %>% 
  write_csv("2020/2020-05-05/villagers.csv")

# Read and clean item JSON ------------------------------------------------



all_items <- list.files("villagerdb-master/data/items")

items_list <- all_items %>% 
  map(item_read)

jsonedit(items_list)

items_nh <- items_list %>% 
  enframe() %>% 
  rename(row_n = name) %>% 
  unnest_wider(value) 

items_price <- items_nh %>% 
  unnest_longer(games) %>% 
  unnest_wider(games) %>% 
  unnest_wider(sellPrice) %>% 
  rename(sell_value = value, sell_currency = currency) %>% 
  select(-...1) %>% 
  unnest_wider(buyPrices) %>% 
  select(-...1)

items_long <- items_price %>% 
  unnest_longer(recipe) %>% 
  mutate(customizable = unlist(customizable)) %>% 
  unnest_longer(sources) %>% 
  unnest_longer(interiorThemes)

buy_long <- items_long %>% 
  unnest_wider(currency) %>% 
  rename(buy_price_1 = ...1,
         buy_price_2 = ...2)

buy_df_wide <- buy_long %>% 
  unnest_wider(value) %>% 
  rename(buy_currency_1 = ...1,
         buy_currency_2 = ...2)

currency_2 <- buy_df_wide %>% 
  filter(!is.na(buy_currency_2)) %>% 
  select(-buy_price_1, -buy_currency_1) %>% 
  rename(buy_value = buy_price_2, buy_currency = buy_currency_2)

item_df_final <- buy_df_wide %>% 
  select(-buy_currency_2, -buy_price_2) %>%
  rename(buy_value = buy_price_1, buy_currency = buy_currency_1) %>% 
  bind_rows(currency_2) %>% 
  arrange(row_n, id) %>% 
  rename(buy_cur = buy_currency, buy_val = buy_value) %>% 
  rename(buy_value = buy_cur, buy_currency = buy_val) %>% 
  unnest_longer(rvs) %>% 
  filter(games_id == "nh")

item_df_final

joined_img_df <- item_df_final %>% 
  left_join(all_items, by = c("id", "name")) %>% 
  select(num_id = row_n, id:orderable, sell_value, sell_currency, buy_value, buy_currency, sources, customizable, recipe:id_full, image_url = url, -xSize, -ySize)

joined_img_df %>% 
  write_csv("2020/2020-05-05/items.csv")
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

### BONUS SUPER SECRET DATASET

Keep going if you wanna learn about the turnip market.

![](https://pbs.twimg.com/media/EXL57OpXQAI97rt?format=jpg&name=360x360)

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

![tornps - image of Tom Nook imitating the stonks meme](https://images2.minutemediacdn.com/image/upload/c_fill,w_720,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/dataimagepngbase64iVBORw0KGgoAAAANSUhEUgAABAAAAAMA-28c059a4188930f6801c9b8a335805dc.jpg)


# WARNING

Please note that this may be bordering on making the game a type of "work" - so feel free to skip if you don't want to think about the game THIS hard.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

### SERIOUSLY ENJOY THE GAME HOWEVER YOU WANT

If you want to continue please see the below for context and some scraping code for an example plot in R.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

### Ok here is the easter egg

This is an example dataset from [GameWith](https://gamewith.net/animal-crossing-new-horizons/article/show/17008) of example turnip price graphs and additional info from [Polygon](https://www.polygon.com/animal-crossing-new-horizons-switch-acnh-guide/2020/3/20/21181835/selling-turnips-stalk-market). Lastly - [The Verge](https://www.theverge.com/2020/4/14/21213923/animal-crossing-new-horizons-turnip-prices-sell-exchange-profit) also dives into Turnip price watch groups - links to [The Stalk Market](https://twitter.com/KnightCarmine/status/1244392945056276482/photo/1).

There appear to be 3-4 types of turnip price trends.
* Random: Price fluctuates without clear pattern
* Spike: Price declines for a few days and then jumps up 3x before quickly declining
* Crash: Price increases early and then crashes
* Decline: Price constantly decreases across week

```{r}
# Turnip price graphs examples

raw_turnip <- read_html(turnip)

cooked_turnips <- raw_turnip %>% 
  html_nodes("div.acnh_kabu > table") %>% 
  html_table() %>% 
  bind_rows() %>% 
  as_tibble() %>% 
  rename("time" = ...1) %>% 
  slice(3:10) %>% 
  group_by(time) %>% 
  mutate(week = row_number()) %>% 
  ungroup() %>% 
  pivot_longer(cols = Mon:Sat, names_to = "day", values_to = "turnip_price")


turnip_levels <- cooked_turnips %>% 
  distinct(day) %>% 
  pull()

cooked_turnips %>% 
  mutate(day_time = paste(day, time, sep = "-"),
         day_time = factor(day_time, 
                           levels = c("Mon-AM", "Mon-PM", "Tue-AM","Tue-PM", 
                                      "Wed-AM", "Wed-PM", "Thu-AM", "Thu-PM", 
                                      "Fri-AM", "Fri-PM", "Sat-AM" , "Sat-PM")),
         week = factor(week, labels = c("Random", "Spike", "Crash", "Declining"))
  ) %>% 
  ggplot(aes(x = day_time, y = turnip_price, color = week, group = week)) +
  geom_line()
  
```
