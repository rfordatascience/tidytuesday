# Nobel Laureate Publications

"The Nobel Prize is a set of annual international awards bestowed in several categories by Swedish and Norwegian institutions in recognition of academic, cultural, or scientific advances." - [Wikipedia](https://en.wikipedia.org/wiki/Nobel_Prize).

This week's h/t goes to Georgios Karamanis for sharing the Nobel data links on GitHub! The data covers metadata for all of the Nobel prize winners. An additional dataset looks at all the publications from each winner. [From the data aggregators](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/6NJ5RN) for the publications dataset, "We constructed the publication records for almost all Nobel laureates in physics, chemistry, and physiology or medicine from 1900 to 2016 (545 out of 590, 92.4%). We first collected information manually from Nobel Prize official websites, their university websites, and Wikipedia. We then match it algorithmically with big data, tracing publication records from the MAG database."

The raw data for all the papers come from the Harvard `dataverse` as seen [here](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/6NJ5RN) and the information about the winners themselves comes from Kaggle as seen [here](https://www.kaggle.com/nobelfoundation/nobel-laureates#archive.csv). 

If you want to dive deeper on some network analysis - Wagner et al, 2015 examined [*Do Nobel Laureates Create Prize-Winning Networks?*](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4521825/) and shared some [data](https://figshare.com/articles/Nobel_Prize_winners_in_Medicine_or_Physiology/1454521).

There is also a nice run through with `tidyverse` codepic on Kaggle [here](https://www.kaggle.com/devisangeetha/nobel-prize-winners-story).

# Get the data!

```
nobel_winners <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-14/nobel_winners.csv")
nobel_winner_all_pubs <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-14/nobel_winner_all_pubs.csv")
```

# Data Dictionary


### `nobel_winners.csv`

|variable             |class     |description |
|:---|:---|:-----------|
|prize_year           |double    | Year that Nobel Prize was awarded|
|category             |character | Field of study/category|
|prize                |character | Prize Name |
|motivation           |character | Motivation of the award |
|prize_share          |character | Share eg 1 of 1, 1 of 2, 1 of 4, etc |
|laureate_id          |double    | ID assigned to each winner |
|laureate_type        |character | Individual or organization  |
|full_name            |character | name of the winner|
|birth_date           |double    | birth date of winner |
|birth_city           |character | birth city/state of winner |
|birth_country        |character | birth country of winner |
|gender               |character | binary gender of the winner |
|organization_name    |character | organization name |
|organization_city    |character | organization city |
|organization_country |character | organization country |
|death_date           |double    | death date of the winner (if dead) |
|death_city           |character | death city (if dead) |
|death_country        |character | death country (if dead) |

### `nobel_winner_all_pubs.csv`

|variable               |class     |description |
|:----------------------|:---------|:-----------|
|laureate_id            |double    | Assigned Laureate ID (doesn't match other dataset) |
|laureate_name          |character | Abbreviated name |
|prize_year             |double    | Prize year |
|title                  |character | Title of paper |
|pub_year               |double    | Publication year |
|paper_id               |double    | Paper ID|
|doi                    |character | DOI of paper|
|journal                |character | Journal paper published in |
|affiliation            |character | Affiliation of the author |
|is_prize_winning_paper |character | Is associated as the Nobel winning paper (yes or no)|
|category               |character | Category/field of study |

# Cleaning script

```
library(tidyverse)
library(here)
library(janitor)

# read in the specific category/field datasets and the overall winners

nobel_winners <- read_csv(here("2019", "2019-05-14", "archive.csv")) %>% 
  janitor::clean_names() %>% 
  rename("prize_year" = year,
         "gender" = sex)

chem_pubs <- read_csv(here("2019", "2019-05-14", "Chemistry publication record.csv")) %>% 
  janitor::clean_names() %>% 
  mutate(category = "chemistry")

med_pubs <- read_csv(here("2019", "2019-05-14", "Medicine publication record.csv")) %>% 
  janitor::clean_names() %>% 
  mutate(category = "medicine")

physics_pubs <- read_csv(here("2019", "2019-05-14", "Physics publication record.csv")) %>% 
  janitor::clean_names() %>% 
  mutate(category = "physics")

all_pubs <- bind_rows(chem_pubs, med_pubs, physics_pubs)

all_pubs %>% 
  write_csv(here("2019", "2019-05-14", "nobel_winner_all_pubs.csv"))

nobel_winners %>% 
  write_csv(here("2019", "2019-05-14", "nobel_winners.csv"))

```
