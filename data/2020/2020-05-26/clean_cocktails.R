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
