![Hero image of the main characters](https://observer.case.edu/wp-content/uploads/2020/02/Avatar-Nickelodeon-900x450.png)

# Avatar: The last airbender

The data this week comes from the [`appa` R package](https://github.com/averyrobbins1/appa) created by [Avery Robbins](https://twitter.com/robbins_ave). H/t to [Kelsey Gonzalez](https://twitter.com/KelseyEGonzalez) for recommending this data package.

The original data came from the [Avatar Wiki](https://avatar.fandom.com/wiki/Avatar_Wiki), and the example code used to scrape this dataset is also covered on [Avery's blog](https://www.avery-robbins.com/2020/07/15/avatar-web-scraping/) along with a quick exploration of the available data in a separate [blog post](https://www.avery-robbins.com/2020/07/11/avatar-eda/).

There is also a "Avatar" themed palette from the [`tvthemes` R package](https://github.com/Ryo-N7/tvthemes) courtesy of [Ryo Nakagawara](https://twitter.com/R_by_Ryo/status/1292826454640611338?s=20)

For people who have not seen the show or read this series of books, [Wikipedia](https://en.wikipedia.org/wiki/Avatar:_The_Last_Airbender) covers the high level details.

> Avatar: The Last Airbender is set in a world where human civilization consists of four nations, named after the four classical elements: the Water Tribes, the Earth Kingdom, the Fire Nation, and the Air Nomads. In each nation, certain people, known as "benders" (waterbenders, earthbenders, firebenders and airbenders), have the ability to telekinetically manipulate and control the element corresponding to their nation, using gestures based on Chinese martial arts. The Avatar is the only person with the ability to bend all four elements.
> 
> The series is centered around the journey of 12-year-old Aang, the current Avatar and last survivor of his nation, the Air Nomads, along with his friends Sokka, Katara, and later Toph Beifong, as they strive to end the Fire Nation's war against the other nations of the world. It also follows the story of Zuko—the exiled prince of the Fire Nation, seeking to restore his lost honor by capturing Aang, accompanied by his wise uncle Iroh—and later, that of his ambitious sister Azula.
> 
> Avatar: The Last Airbender was commercially successful and was acclaimed by audiences and critics, who praised its art direction, soundtrack, cultural references, humor, characters, and themes. These include concepts rarely touched on in youth entertainment, such as war, genocide, imperialism, colonialism, totalitarianism, and free choice.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-08-11')
tuesdata <- tidytuesdayR::tt_load(2020, week = 33)

avatar <- tuesdata$avatar

# Or read in the data manually

avatar <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-08-11/avatar.csv')
scene_description <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-08-11/scene_description.csv')

```
### Data Dictionary

# `avatar.csv`

This is the core dataset (scene description text moved to alternative dataset as it was a list column).

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|id                |integer   | Unique Row identifier |
|book              |character   | Book name|
|book_num          |integer   |Book number|
|chapter           |character   | Chapter name |
|chapter_num       |integer   | Chapter Name|
|character         |character | Character speaking|
|full_text         |character | Full text (scene description, character text) |
|character_words   |character | Text coming from characters |
|writer            |character | Writer of book |
|director          |character | Director of episode |
|imdb_rating       |double    | IMDB rating for episode |

# `scene_description.csv`

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|id                |integer   | Unique row identifier |
|scene_description |character | Scene description text |

### Cleaning Script

```{r}
library(tidyverse)
library(appa)

avatar <- appa::appa

scene_description <- avatar %>% 
  select(id, scene_description) %>% 
  unnest_longer(scene_description) %>% 
  filter(!is.na(scene_description))

scene_description %>% 
  write_csv(here::here("2020", "2020-08-11", "scene_description.csv"))

avatar %>% 
  select(-scene_description) %>% 
  write_csv(here::here("2020", "2020-08-11", "avatar.csv"))

```