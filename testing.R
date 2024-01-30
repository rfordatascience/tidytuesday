library(tidyverse)
library(lubridate)


source("utils.R")

dfs <- get_current_tt_data()

df <- read_csv(dfs[1])

df <- df %>%
  select(id,region,country,is_groundhog,type,active,predictions_count) %>%
  filter(active == TRUE)

df2 <- read_csv(dfs[2])
df2 %>%
  select(-details)

gh <- inner_join(df,df2, by = "id")
