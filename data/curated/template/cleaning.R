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

stackoverflow_survey_single_response <- stackoverflow_survey %>%
    
    # Adding a flag if the respondent used R in past year or wants to use R in next year
    mutate(
        RUsed = as.integer(ifelse(is.na(LanguageHaveWorkedWith), NA,
                                  grepl("R", LanguageHaveWorkedWith))),
        RWantToUse = as.integer(ifelse(is.na(LanguageHaveWorkedWith), NA,
                                       grepl("R", LanguageWantToWorkWith)))
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
        across(where(is.character),as.factor))

## Step 4: Create a data-dictionary file which saves each factor level for character variables, so they can be saved as integer in the main dataset.

# Select only factor columns
factor_var <- stackoverflow_survey_single_response %>%
    select(where(is.factor)) 

# Record how many levels associated which each column
column_n_levels <- map_int(colnames(factor_var), 
                           ~length(levels(factor_var[,.x])))

# Create a tibble with variable name and level
qname_levels_single_response_crosswalk <- tibble(
    qname = rep(colnames(factor_var), column_n_levels) 
) %>%
    group_by(qname) %>%
    mutate(level = row_number()) %>%
    ungroup() %>%
    mutate(
        labels = unlist(map(colnames(factor_var), ~levels(factor_var[,.x]))) 
    )

# Change factor variables to integer in main survey response

stackoverflow_survey_single_response <- stackoverflow_survey_single_response %>%
    mutate(across(where(is.factor), as.numeric))

### Ready to export - stackoverflow_survey_single_response and qname_levels_single_response_crosswalk files
