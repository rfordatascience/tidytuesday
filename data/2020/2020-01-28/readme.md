![Southern Magnolia tree in urban San Francisco](https://www.fuf.net/wp-content/uploads/2012/10/A.Mag-grand-treeAdam.jpg)

# San Francisco Trees

The data this week comes from San Francisco's [open data portal](https://data.sfgov.org/City-Infrastructure/Street-Tree-List/tkzw-k3nq).

There are dozens of tree species, and many other intresting features to explore in this dataset! I did drop a few columns that were either > 75% missing or redundant, feel free to check out the source for the fully original dataset.

Also - make sure to follow [@tidypod](https://twitter.com/tidypod) - they'll have some interesting `#TidyTuesday` updates to come this week!

Some interesting articles:
- [Trees of Life in SF](https://www.sfweekly.com/news/feature/trees-of-life/)
- [Landmark trees](http://www.sftrees.com/new-page-1)
- [Non-native trees](https://medium.com/@tharkibo/none-of-these-trees-belong-in-san-francisco-and-neither-do-you-and-thats-ok-377ce44d7198)
- [Friends of the urban forest](https://www.fuf.net/resources-reference/urban-tree-species-directory/)
- [SF Tree Guide](https://sfenvironment.org/sites/default/files/fliers/files/sf_tree_guide.pdf)

### Get the data here

```{r}
# Get the Data

sf_trees <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-28/sf_trees.csv')

# Or read in with tidytuesdayR package (https://github.com/dslc-io/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO UPDATE tidytuesdayR from GitHub

# Either ISO-8601 date or year/week works!

# Install via pak::pak("dslc-io/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-01-28') 
tuesdata <- tidytuesdayR::tt_load(2020, week = 5)


sf_trees <- tuesdata$sf_trees
```
### Data Dictionary

# `sf_trees.csv`

A full data dictionary is available at: [the source](https://data.sfgov.org/City-Infrastructure/Street-Tree-List/tkzw-k3nq) but it's fairly sparse.

|variable     |class     |description |
|:------------|:---------|:-----------|
|tree_id      |double    | Unique ID |
|legal_status |character | LegalLegal staus: Permitted or DPW maintained |
|species      |character | Tree species includes common name after the :: separator |
|address      |character | Street Address |
|site_order   |double    | Order of tree at address where multiple trees are at same address. Trees are ordered in ascending
address order |
|site_info    |character | Site Info - Where the tree resides |
|caretaker    |character | Agency or person that is primary caregiver to tree -- Owner of Tree |
|date         |double    | Date Planted (NA if before 1955)|
|dbh          |double    | [Diameter at breast height](https://en.wikipedia.org/wiki/Diameter_at_breast_height) |
|plot_size    |character | Dimension of plot - typically in feet |
|latitude     |double    | Latitude |
|longitude    |double    | Longitude |

### Cleaning Script

```{r}

library(tidyverse)
library(here)
library(tidytuesdaymeta)
library(pryr)
library(visdat)
library(skimr)
library(lubridate)
library(leaflet)

create_tidytuesday_folder()

raw_df <- read_csv(here::here("2020", "2020-01-28", "Street_Tree_Map.csv"),
                   col_types = 
                   cols(
                     TreeID = col_double(),
                     qLegalStatus = col_character(),
                     qSpecies = col_character(),
                     qAddress = col_character(),
                     SiteOrder = col_double(),
                     qSiteInfo = col_character(),
                     PlantType = col_character(),
                     qCaretaker = col_character(),
                     qCareAssistant = col_character(),
                     PlantDate = col_character(),
                     DBH = col_double(),
                     PlotSize = col_character(),
                     PermitNotes = col_character(),
                     XCoord = col_double(),
                     YCoord = col_double(),
                     Latitude = col_double(),
                     Longitude = col_double(),
                     Location = col_character()
                   )) %>% 
  janitor::clean_names()

small_df <- raw_df %>% 
  select(-x_coord,-y_coord,-q_care_assistant, -permit_notes) %>% 
  filter(plant_type != "Landscaping") %>% 
  select(-plant_type) %>% 
  separate(plant_date, into = c("date", "time"), sep = " ") %>% 
  mutate(date = parse_date(date, "%m/%d/%Y")) %>% 
  select(-time, -location) %>% 
  arrange(date) %>% 
  rename(legal_status = q_legal_status,
         species = q_species,
         address = q_address,
         site_info = q_site_info,
         caretaker = q_caretaker)

small_df %>% skimr::skim()

small_df %>% 
  write_csv(here::here("2020", "2020-01-28", "sf_trees.csv"))
```
