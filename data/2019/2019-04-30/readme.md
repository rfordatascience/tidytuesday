# Chicago Bird Collisions

[Winger et al, 2019](https://royalsocietypublishing.org/doi/10.1098/rspb.2019.0364#d3e550) examined nocturnal flight-calling behavior and vulnerability to artificial light in migratory birds. 

> "Understanding interactions between biota and the built environment is increasingly important as human modification of the landscape expands in extent and intensity. For migratory birds, collisions with lighted structures are a major cause of mortality, but the mechanisms behind these collisions are poorly understood. Using 40 years of collision records of passerine birds, we investigated the importance of species' behavioural ecologies in predicting rates of building collisions during nocturnal migration through Chicago, IL and Cleveland, OH, USA. "

> "One of the few means to examine species-specific dynamics of social biology during nocturnal bird migration is through the study of short vocalizations made in flight by migrating birds. Many species of birds, especially passerines (order Passeriformes), produce such vocal signals during their nocturnal migrations. These calls (hereafter, ‘flight calls’) are hypothesized to function as important social cues for migrating birds that may aid in orientation, navigation and other decision-making behaviours.not all nocturnally migratory species make flight calls, raising the possibility that different lineages of migratory birds vary in the degree to which social cues and collective decisions are important for accomplishing migration. "

I have only uploaded the raw and tamed Chicago dataset as it is the most complete, but you can access the full raw data [here](https://datadryad.org/resource/doi:10.5061/dryad.8rr0498). 

Each row in the `bird_collisions.csv` dataset accounts for a single observation of a bird collision. You can aggregate by species/genus, time, or other factors.

h/t to [Data is Plural 2019/04/10](https://docs.google.com/spreadsheets/d/1wZhPLMCHKJvwOkP4juclhjFgqIY8fQFMemwKL2c64vk/edit#gid=0)

### Important Notes but Spoilers

An important point but somewhat spoiler from the authors
> From 2000 to 2018, D.E.W. and M.H. recorded data on the status of night-time lighting at McCormick Place during pre-dawn walks to collect collisions by recording the proportion of the 17 window bays that were illuminated... We used this index to test whether building lighting influenced the number of collisions and whether the influence of light levels on collisions counts varied across the sets of species with different flight-calling behaviour or habitat preferences.

There is a factor data column (`bird_collisions$locality`) that indicates if the data was collected at McCormick Place (MP) or elsewhere in Chicago (CHI). If you `dplyr::filter` to only use `MP` you can `dplyr::left_join` the light data and the bird collision data to look at the effects of light on bird collisions from 2000 on.

# Get the data!

```
bird_collisions <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-30/bird_collisions.csv")
mp_light <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-30/mp_light.csv")
```

## Citations

When using this data, please cite the original publication:

> Winger BM, Weeks BC, Farnsworth A, Jones AW, Hennen M, Willard DE (2019) Nocturnal flight-calling behaviour predicts vulnerability to artificial light in migratory birds. Proceedings of the Royal Society B 286(1900): 20190364. https://doi.org/10.1098/rspb.2019.0364

If using the data alone, please cite the [Dryad data package](https://cran.r-project.org/web/packages/rdryad/rdryad.pdf):

> Winger BM, Weeks BC, Farnsworth A, Jones AW, Hennen M, Willard DE (2019) Data from: Nocturnal flight-calling behaviour predicts vulnerability to artificial light in migratory birds. Dryad Digital Repository. https://doi.org/10.5061/dryad.8rr0498



# Data Dictionary

### `bird_collisions.csv`
|variable    |class     |description |
|:-----------|:---------|:-----------|
|genus       | factor | Bird Genus          |
|species     | factor | Bird species           |
|date        | date    | Date of collision death (ymd)           |
|locality    | factor | MP or CHI - recording at either McCormick Place or greater Chicago area           |
|family      | factor | Bird Family          |
|flight_call | factor | Does the bird use a flight call - yes or no           |
|habitat     | factor | Open, Forest, Edge - their habitat affinity          |
|stratum     | factor  | Typical occupied stratum - ground/low or canopy/upper           |

### `mp_light.csv`
|variable    |class  |description |
|:-----------|:------|:-----------|
|date        | date | Date of light recording  (ymd)        |
|light_score | integer | Number of windows lit at the McCormick Place, Chicago - higher = more light          |

# Cleaning script

```
library(tidyverse)
library(here)


# Read in the raw data

raw_birds <- read_csv(here("2019", "2019-04-30", "Chicago_collision_data.csv")) %>% 
  janitor::clean_names()

raw_light <- read_csv(here("2019", "2019-04-30", "Light_levels_dryad.csv")) %>% 
  janitor::clean_names()

raw_call <- read_csv(here("2019", "2019-04-30", "bird_call.csv")) %>% 
  set_names(nm = "col_to_split")

# add column names for call_data
clean_col <- c("genus", "species", "Family", "Collisions", "Flight Call", "Habitat", "Stratum")

# separate space delim columns
clean_call <- raw_call %>% 
  separate(col_to_split, into = clean_col, sep = " ") %>% 
  janitor::clean_names() %>% 
  select(family, genus, species, everything())

# join bird metadata to impact data
clean_birds <- raw_birds %>% 
  left_join(clean_call, by = c("genus", "species")) %>% 
  mutate(flight_call = case_when(genus == "Ammodramus" & species == "nelsoni" ~ "Yes",
                                 genus == "Ammodramus" & species == "leconteii" ~ "Yes",
                                 TRUE ~ flight_call)) %>% 
  filter(!is.na(flight_call),
         !is.na(collisions)) %>% 
  select(-collisions)

# confirm match - matches the summary-level data
raw_birds %>% 
  unite("g_s", c("genus","species")) %>% 
  group_by(g_s) %>% 
  count(sort = TRUE)

clean_birds %>% write_csv(here("2019", "2019-04-30", "bird_collisions.csv"))
raw_light %>% write_csv(here("2019", "2019-04-30", "mp_light.csv"))

```
