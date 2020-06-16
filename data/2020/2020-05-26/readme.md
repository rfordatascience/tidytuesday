![](https://images.unsplash.com/photo-1551024709-8f23befc6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1425&q=80)
[Img credit: Kobby Mendez](https://unsplash.com/@kobbyfotos)

# Cocktails

The data this week comes from [Kaggle](https://www.kaggle.com/jenlooper/mr-boston-cocktail-dataset) and [Kaggle](https://www.kaggle.com/ai-first/cocktail-ingredients) courtesy of [Georgios Karamanis](https://github.com/rfordatascience/tidytuesday/issues/185).

The Mr Boston dataset was acquired from the [Mr. Boston Bartender's Guide](http://swizzle.ru/uploads/article_file/17/mr_boston.pdf), while the `cocktails.csv` dataset was web-scraped as part of a hackathon.

These datasets are relatively clean, and have lots of interesting data to count, summarize, or possibly classify with a model!

While I have tamed both datasets, the Mr. Boston dataset is IMO cleaner, the `cocktails.csv` dataset was web-scraped and has some classic "funkiness" that you get from web-scraping (empty rows, now lines `\n`, etc). I've left both datasets for your exploration, where the `cocktails.csv` is probably better used for data cleaning/validation and the Mr. Boston appears to be cleaner and close to analysis-ready. However, there are additional columns in the `cocktails.csv` dataset, so maybe try joining or further cleaning! The `cocktails.csv` dataset also has more non-alcoholic drinks if you'd prefer to skip the alcohol.

### Articles

* [Margarita Clustering](https://fivethirtyeight.com/videos/we-got-drunk-on-margaritas-for-science/)  -- this doesn't use our dataset, but provides a potential idea for how to approach this data  
* [Information is Beautiful Graphic](https://www.informationisbeautiful.net/visualizations/cocktails-interactive/)  
* [Recommender for Cocktail recipes](https://www.researchgate.net/publication/266142671_Recommendations_for_cocktail_recipes)  


### Warning/Notes

I've intentionally left the `measure` column as a string with a number + volume/unit so that you can try out potential strategies to cleaning it up.

Some potential tools:  
- `tidyr::separate()`: [Link](https://tidyr.tidyverse.org/reference/separate.html)  
- `stringr::str_split()`: [Link](https://stringr.tidyverse.org/reference/str_split.html)  

The `cocktails.csv` dataset was web-scraped and has some classic "funkiness" that you get from web-scraping (empty rows, new lines `\n` with blank, etc)

### Get the data here

```{r}
# Get the Data

cocktails <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/cocktails.csv')
boston_cocktails <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/boston_cocktails.csv')

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)

# Either ISO-8601 date or year/week works!

# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-05-26')
tuesdata <- tidytuesdayR::tt_load(2020, week = 22)


cocktails <- tuesdata$cocktails
```
### Data Dictionary

# `cocktails.csv`

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|row_id            |double    | row identifier|
|drink             |character | drink name |
|date_modified     |double    | date modified (web scraped) |
|id_drink          |double    | drink unique id |
|alcoholic         |character | alcoholic, non alcoholic, optional |
|category          |character | Category, eg cocktail, shot, etc|
|drink_thumb       |character | thumbnail of the drink |
|glass             |character | Recommended glass type |
|iba               |character | International Bartenders association category |
|video             |logical   | Video to how to make |
|ingredient_number |integer   | Ingredient number |
|ingredient        |character | Ingredient |
|measure           |character | Measurement/volume of ingredient |

# `boston_cocktails.csv`

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|name              |character | Name of cocktail |
|category          |character | Category of cocktail |
|row_id            |integer   | Drink identifier |
|ingredient_number |integer   | Ingredient number |
|ingredient        |character | Ingredient |
|measure           |character | Measurement/volume of ingredient |

### Cleaning Script

```{r}
library(tidyverse)

# source for boston drinks
"https://www.kaggle.com/jenlooper/mr-boston-cocktail-dataset"

# Source for drinks
"https://www.kaggle.com/ai-first/cocktail-ingredients"

# Read in the data --------------------------------------------------------

drinks <- read_csv("2020/2020-05-26/all_drinks.csv") %>% 
  janitor::clean_names() %>% 
  rename(row_id = x1)

boston_drks <- read_csv("2020/2020-05-26/mr-boston-flattened.csv")


# pivot_longer drinks -----------------------------------------------------

drk_ing <- drinks %>% 
  select(row_id:str_iba, contains("ingredient"), str_video) %>% 
  
  # pivot to take wide data to long
  pivot_longer(cols = contains("ingredient"), 
               names_to = "ingredient_number", 
               values_to = "ingredient") %>% 
  # remove text and extract only the digits
  mutate(ingredient_number = str_extract(ingredient_number, "[:digit:]+") %>% 
           as.integer()) %>% 
  # remove "str_" from any of the col names
  set_names(nm = str_remove(names(.), "str_")) 

drk_measure <- drinks %>% 
  # select only the join ids and cols w/ "measure"
  select(row_id, str_drink, id_drink, contains("measure")) %>% 
  # pivot to take wide data to long
  pivot_longer(cols = contains("measure"), 
               names_to = "measure_number", 
               values_to = "measure") %>% 
  # extract just digits
  mutate(measure_number = str_extract(measure_number, "[:digit:]+") %>% 
           as.integer()) %>% 
  # remove str_ from any col names
  set_names(nm = str_remove(names(.), "str_"))

# join the two long dfs back together
all_drks <- left_join(drk_ing, drk_measure, 
                      by = c("row_id", "drink", "id_drink", 
                             "ingredient_number" = "measure_number")) %>% 
  filter(!is.na(measure) & !is.na(ingredient))

# confirm if missing data
# confirm if missing data
anti_join(drk_ing, drk_measure, 
          by = c("row_id", "drink", "id_drink", 
                 "ingredient_number" = "measure_number"))

write_csv(all_drks, "2020/2020-05-26/cocktails.csv")

# pivot_longer boston drinks ----------------------------------------------

bs_drk_ing <- boston_drks %>% 
  mutate(row_id = row_number()) %>% 
  select(name, category, row_id, contains("ingredient")) %>% 
  pivot_longer(cols = contains("ingredient"), 
               names_to = "ingredient_number", 
               values_to = "ingredient") %>% 
  mutate(ingredient_number = str_extract(ingredient_number, "[:digit:]+") %>% 
           as.integer())


bs_drk_ms <- boston_drks %>% 
  mutate(row_id = row_number()) %>% 
  select(name, category, row_id, contains("measurement")) %>% 
  pivot_longer(cols = contains("measurement"), 
               names_to = "measure_number", 
               values_to = "measure") %>% 
  mutate(measure_number = str_extract(measure_number, "[:digit:]+") %>% 
           as.integer())

all_bs_drks <- left_join(bs_drk_ing, bs_drk_ms, 
                         by = c("name", "category", "row_id", 
                                "ingredient_number" = "measure_number")) %>% 
  filter(!is.na(ingredient) & !is.na(measure))

# confirm if missing data
anti_join(bs_drk_ing, bs_drk_ms, 
          by = c("name", "category", "row_id", 
                 "ingredient_number" = "measure_number"))

write_csv(all_bs_drks, "2020/2020-05-26/boston_cocktails.csv")

```
