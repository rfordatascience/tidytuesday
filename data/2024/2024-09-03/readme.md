# Stack Overflow Annual Developer Survey 2024

This week's dataset is derived from the 2024 Stack Overflow Annual Developer Survey. Conducted in May 2024, the survey gathered responses from over 65,000 developers across seven key sections:

1.  Basic information
2.  Education, work, and career
3.  Tech and tech culture
4.  Stack Overflow community
5.  Artificial Intelligence  (AI)
6.  Professional Developer Series - Not part of the main survey
7.  Thoughts on Survey

The dataset provided for this analysis focuses exclusively on the single-response questions from the main survey sections. Each categorical response in the survey has been integer-coded, with corresponding labels available in the crosswalk file.

What can you see about developer demographics? How do developers engage with Stack Overflow? What do they think about AI?

Thank you to [Havisha Khurana](https://github.com/havishak) for curating this week's dataset!

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-09-03')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 36)

qname_levels_single_response_crosswalk <- tuesdata$qname_levels_single_response_crosswalk
stackoverflow_survey_questions <- tuesdata$stackoverflow_survey_questions
stackoverflow_survey_single_response <- tuesdata$stackoverflow_survey_single_response

# Option 2: Read directly from GitHub

qname_levels_single_response_crosswalk <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-03/qname_levels_single_response_crosswalk.csv')
stackoverflow_survey_questions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-03/stackoverflow_survey_questions.csv')
stackoverflow_survey_single_response <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-03/stackoverflow_survey_single_response.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `qname_levels_single_response_crosswalk.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|qname    |character |Categorical Question/Column Name in main data       |
|level    |integer   |Integer index associated with each column response       |
|label   |character |Label associated with integer index      |

# `stackoverflow_survey_questions.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|qname    |character |Categorical Question/Column Name in main data |
|question |character |Text of the question as it was presented to the respondent |

# `stackoverflow_survey_single_response.csv`

| variable              | class     | description                                                                         |
|:--------------------------|:-----------------|:--------------------------|
| response_id           | double    | Respondent ID                                                                       |
| main_branch           | integer   | Professional coding level of the respondent |
| age                   | integer   | Age                                                                                 |
| remote_work           | integer   | Current work situation                                                              |
| ed_level              | integer   | Highest education level completed                                                   |
| years_code            | integer   | Years the respondent has coded in total; More than 50 years coded as 51                 |
| years_code_pro        | integer   | Years the respondent has coded professionally; More than 50 years coded as 51                 |
| dev_type              | integer   | Best current-job description                                                        |
| org_size              | integer   | People in the organization                                                          |
| purchase_influence    | integer   | Level of influence in purchasing new technology at their organization                |
| buildvs_buy           | integer   | How much customization was needed in most recent tool recommendation |
| country               | character | Country in which the respondent lives |
| currency              | character | Currency of the country                                                             |
| comp_total            | double    | Total compensation                                                                  |
| so_visit_freq         | integer   | Stack Overflow visiting frequency                                                   |
| so_account            | integer   | Stack Overflow account status                                                       |
| so_part_freq          | integer   | Stack Overflow participation frequency                                              |
| so_comm               | integer   | Whether the respondent considers themself a member of the Stack Overflow community?                  |
| ai_select             | integer   | Use AI in development process                                                       |
| ai_sent               | integer   | Stance on using AI tools as part of development workflow                            |
| ai_acc                | integer   | Trust in accuracy of AI as part of development workflow                             |
| ai_complex            | integer   | How well the respondent believes the AI tools they use in development workflows handle complex tasks |
| ai_threat             | integer   | Belief that AI is a threat to current job |
| survey_length         | integer   | Feeling about the length of the Stack Overflow Developer Survey this year |
| survey_ease           | integer   | Ease of completion of this survey |
| converted_comp_yearly | double    | Converted compensation                                                              |
| r_used                | integer   | Flag if respondent used R in the previous year                                      |
| r_want_to_use         | integer   | Flag if respondent want to use R in the next year                                   |

### Cleaning Script

```r
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
unzip_file <- unzip(temp, "survey_results_public.csv", exdir = tempdir())
stackoverflow_survey <- readr::read_csv(unzip_file)
unzip_file <- unzip(temp, "survey_results_schema.csv", exdir = tempdir())
stackoverflow_survey_questions <- readr::read_csv(unzip_file)
unlink(temp)
unlink(file.path(tempdir(), "survey_results_public.csv"))
unlink(file.path(tempdir(), "survey_results_schema.csv"))
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

stackoverflow_survey_questions <- stackoverflow_survey_questions %>%
    filter(qname %in% single_response) %>%
    select(qname, question) %>%
    mutate(qname = make_clean_names(qname))
```
