# Load Library
library(tidyverse)

# Read in raw data from Vera
df_raw <- read_csv("https://raw.githubusercontent.com/vera-institute/incarceration_trends/master/incarceration_trends.csv")

# Check out the data structure
df_raw %>% str()

# add a row id (for later joining)
df <- df_raw %>% 
  mutate(row_id = row_number())

# select only the gather columns and gather to tidy structure
# VERY important to have females listed above males or else case_when will label wrong

df_population <- df %>% 
  select(yfips:land_area, -total_pop, row_id) %>% 
  gather(pop_category, population, total_pop_15to64:white_pop_15to64) %>% 
  mutate(pop_category = case_when(str_detect(pop_category, "asian") ~ "Asian",
                                  str_detect(pop_category, "white") ~ "White",
                                  str_detect(pop_category, "black") ~ "Black",
                                  str_detect(pop_category, "female") ~ "Female",
                                  str_detect(pop_category, "male_pop") ~ "Male",
                                  str_detect(pop_category, "latino") ~ "Latino",
                                  str_detect(pop_category, "total") ~ "Total",
                                  str_detect(pop_category, "native") ~ "Native American",
                                  str_detect(pop_category, "other") ~ "Other",
                                  TRUE ~ NA_character_))

# select only the gather columns and gather to tidy structure
# VERY important to have females listed above males or else case_when will label wrong
df_prison_pop <- df %>% 
  select(yfips:county_name, urbanicity:land_area, total_prison_pop:white_prison_pop, row_id) %>% 
  gather(prison_pop_category, prison_population, total_prison_pop:white_prison_pop) %>% 
  mutate(prison_pop_category = case_when(str_detect(prison_pop_category, "asian") ~ "Asian",
                                  str_detect(prison_pop_category, "white") ~ "White",
                                  str_detect(prison_pop_category, "black") ~ "Black",
                                  str_detect(prison_pop_category, "female") ~ "Female",
                                  str_detect(prison_pop_category, "male_prison") ~ "Male",
                                  str_detect(prison_pop_category, "latino") ~ "Latino",
                                  str_detect(prison_pop_category, "total") ~ "Total",
                                  str_detect(prison_pop_category, "native") ~ "Native American",
                                  str_detect(prison_pop_category, "other") ~ "Other",
                                  TRUE ~ NA_character_))

# Left join the two dataframes together
# I used all the common columns including row_id

full_prison_pop_df <- left_join(df_population, df_prison_pop, 
          by = c("yfips", "fips", "year", "state", "county_name", 
                 "pop_category" = "prison_pop_category", "urbanicity", "region",
                 "division", "commuting_zone", "metro_area", "land_area", "row_id")) %>% 
  select(-c(yfips, fips, metro_area, land_area, row_id, commuting_zone)) 

# Summary data to get rate per 100000 by group

summ_prison <- full_prison_pop_df %>% 
  na.omit() %>% 
  group_by(year, urbanicity, pop_category) %>% 
  summarize(rate_per_100000 = sum(prison_population)/sum(population) * 100000) %>% 
  ungroup()

# Test plot looks good
ggplot(summ_prison, aes(x = year, y = rate_per_100000, color = urbanicity)) +
  geom_line() +
  facet_wrap(~pop_category)

# More gathers to get pre-trial data
df_pretrial <- df %>% 
  select(yfips:county_name, urbanicity:land_area, total_jail_pretrial:male_jail_pretrial) %>% 
  gather(pretrial_category, pretrial_population, total_jail_pretrial:male_jail_pretrial) %>% 
  mutate(pretrial_category = case_when(str_detect(pretrial_category, "asian") ~ "Asian",
                                  str_detect(pretrial_category, "white") ~ "White",
                                  str_detect(pretrial_category, "black") ~ "Black",
                                  str_detect(pretrial_category, "female") ~ "Female",
                                  str_detect(pretrial_category, "male_jail") ~ "Male",
                                  str_detect(pretrial_category, "latino") ~ "Latino",
                                  str_detect(pretrial_category, "total") ~ "Total",
                                  str_detect(pretrial_category, "native") ~ "Native American",
                                  str_detect(pretrial_category, "other") ~ "Other",
                                  TRUE ~ NA_character_))

# Pretrial dataset joined with population numbers
pretrial_pop_df <- left_join(df_population, df_pretrial, 
                         by = c("yfips", "fips", "year", "state", "county_name", 
                                "pop_category" = "pretrial_category", "urbanicity", "region",
                                "division", "commuting_zone", "metro_area", "land_area")) %>% 
  select(-c(yfips, fips, metro_area, land_area, row_id, commuting_zone))

# Summary data to get rate per 100000 by group
summ_pretrial <- pretrial_pop_df %>% 
  na.omit() %>% 
  group_by(year, urbanicity, pop_category) %>% 
  summarize(rate_per_100000 = sum(pretrial_population)/sum(population) * 100000) %>% 
  ungroup()

# plot matches Vera plot
ggplot(summ_pretrial, aes(x = year, y = rate_per_100000, color = urbanicity)) +
  geom_line() +
  facet_wrap(~pop_category) +
  labs(title = "Rate per 100,000 by county type and population group")

# Write files to .csv
write_csv(summ_prison, "prison_summary.csv")
write_csv(summ_pretrial, "pretrial_summary.csv")
write_csv(full_prison_pop_df, "prison_population.csv")
write_csv(pretrial_pop_df, "pretrial_population.csv")
