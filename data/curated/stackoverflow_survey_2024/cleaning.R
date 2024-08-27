## Load libraries

library(janitor)
library(dplyr)
library(purrr)
library(tidyr)

## Data available in a zip file on https://survey.stackoverflow.co/
## Downloading the zip file and storing in a temp location
## Then extracting the results

temp <- tempfile()
download.file("https://cdn.sanity.io/files/jo7n4k8s/production/262f04c41d99fea692e0125c342e446782233fe4.zip/stack-overflow-developer-survey-2024.zip",temp, mode = "wb")
unzip_file <- unzip(temp, "survey_results_public.csv")
stackoverflow_survey <- readr::read_csv(unzip_file)
unlink(temp)
rm(temp, unzip_file)

## Survey Description

# The Stackoverflow annual survey has 7 sections:

# 1. Basic information
# 2. Education, work, and career
# 3. Tech and tech culture
# 4. Stack community
# 5. AI
# 6. Professional Developer Series - not part of the main survey and was shown to only professional developers
# 7. Thoughts on Survey

# Within each section, there are single-response and multiple-response questions. The original file is >150 MB
# To subset the the data file so it is < 20MB, I am taking the following steps:  
# Only keeping single-response questions.
# Saving response labels in a crosswalk file, and encoding each column value as an integer.
# Adding a binary variable if the responded is an R user

## Step 1: Remove professional developer series questions and Check question used to gauge attention

stackoverflow_survey <- stackoverflow_survey %>%
    select(-c(Check, TBranch:JobSatPoints_11, JobSat))

## Step 2: Separate single-response questions

# Select cols with multi-response questions
# Flagging if they have semi-colon in the response (;)

multi_response <- colnames(stackoverflow_survey)[grepl(";",stackoverflow_survey[1:1000,])]
#57 columns are multi-response

# The remaining are single response
single_response <- setdiff(colnames(stackoverflow_survey),
                           multi_response)

## Step 3: Create a data.frame for single-response questions

## Create a flag if someone used R in the past year or wnat to use it in the next year

r_used <- stackoverflow_survey %>%
  select(ResponseId, LanguageHaveWorkedWith) %>%
  separate_rows(LanguageHaveWorkedWith, sep = ";") %>%
  filter(LanguageHaveWorkedWith == "R") %>%
  pull(ResponseId)

r_want_to_use <- stackoverflow_survey %>%
  select(ResponseId, LanguageWantToWorkWith) %>%
  separate_rows(LanguageWantToWorkWith, sep = ";") %>%
  filter(LanguageWantToWorkWith == "R") %>%
  pull(ResponseId)

stackoverflow_survey_single_response <- stackoverflow_survey %>%
    
    # add flags
    mutate(
      RUsed = case_when(
        is.na(LanguageHaveWorkedWith) ~ NA_integer_,
        ResponseId %in% r_used ~ 1L,
        TRUE ~ 0L
      ),
      RWantToUse = case_when(
        is.na(LanguageWantToWorkWith) ~ NA_integer_,
        ResponseId %in% r_want_to_use ~ 1L,
        TRUE ~ 0L
      )
    ) %>%
    select(ResponseId, all_of(single_response), RUsed, RWantToUse) %>%
    clean_names() %>%
    # remove if all columns are NA
    filter(!if_all(-response_id, is.na)) %>%
    
    # Changing years coding and years coding professionally to integer
    mutate(
        across(c(years_code, years_code_pro), ~case_when(
            .x == "Less than 1 year" ~ "0",
            .x == "More than 50 years" ~ "51",
            TRUE ~ .x
        )),
        across(c(years_code, years_code_pro), as.integer),
        
        # Changings character variables to factor
        across(where(is.character), 
               ~case_when(
                   .x == "Other (please specify):" ~ "Other",
                   TRUE ~ .x
               )),
        across(where(is.character),as.factor),
        # Changing country and currency back to character
        across(c(country, currency), as.character)
        )

## Step 4: Create a data-dictionary file which saves each factor level for character variables, so they can be saved as integer in the main dataset.

# Select only factor columns
factor_var <- stackoverflow_survey_single_response %>%
    select(where(is.factor)) 

# Record how many levels associated which each column
column_n_levels <- map_int(colnames(factor_var), 
                           ~length(levels(factor_var[,.x] %>% pull)))

# Create a tibble with variable name and level
qname_levels_single_response_crosswalk <- tibble(
    qname = rep(colnames(factor_var), column_n_levels) 
) %>%
    group_by(qname) %>%
    mutate(level = row_number()) %>%
    ungroup() %>%
    mutate(
        label = unlist(map(colnames(factor_var), ~levels(factor_var[,.x] %>% pull))) 
    )

# Change factor variables to integer in main survey response

stackoverflow_survey_single_response <- stackoverflow_survey_single_response %>%
    mutate(across(where(is.factor), as.integer))

### Ready to export - stackoverflow_survey_single_response and qname_levels_single_response_crosswalk files

## To use the dataset, re-label data, using the code:

# survey_relabel <- stackoverflow_survey_single_response
# relabel_columns <- unique(qname_levels_single_response_crosswalk$qname)
# 
# for (col_name in relabel_columns) {
#   survey_relabel[[col_name]] <- stackoverflow_survey_single_response %>%
#     select(all_of(col_name)) %>%
#     rename("level" = col_name) %>%
#     left_join(qname_levels_single_response_crosswalk %>% filter(qname == col_name), 
#               by = c("level")) %>%
#     pull(labels)
# }

