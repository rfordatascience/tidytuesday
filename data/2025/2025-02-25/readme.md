# Academic Literature on Racial and Ethnic Disparities in Reproductive Medicine in the US

This week we're exploring data on studies investigating racial and ethnic disparities in reproductive medicine as published in the eight highest impact peer-reviewed Ob/Gyn journals from January 1, 2010 through June 30, 2023. The data were collected as part of a review article [Racial and ethnic disparities in reproductive medicine in the United States: a narrative review of contemporary high-quality evidence](https://www.ajog.org/article/S0002-9378(24)00775-0/fulltext) published in the *American Journal of Obstetrics and Gynecology* in January 2025.  

> "There has been increasing debate around how or if race and ethnicity should be used in medical research—including the conceptualization of race as a biological entity, a social construct, or a proxy for racism. The objectives of this narrative review are to identify and synthesize reported racial and ethnic inequalities in obstetrics and gynecology (ob/gyn) and develop informed recommendations for racial and ethnic inequity research in ob/gyn."

A companion [interactive website](https://obgyn-shiny.shinyapps.io/obgyn-disp/) was published alongside the review article, and the data has also been used by college students to create [data art](https://katcorr.github.io/this-art-is-HARD/) to raise awareness about this research.   

The data provides an opportunity to critically examine how racial and ethnic disparities in reproductive medicine are framed, measured, and discussed in the academic literature. 

- Explore how race and ethnicity are categorized in these articles. Which categories are most prominent? Which are missing? How do sample sizes vary across groups?
- Has the sentiment of article titles, abstracts, keywords, and/or aims statements changed over time?  
- What type of health outcomes have been studied? What disparities have been identified? 


Thank you to [Kat Correia from Amherst College](https://github.com/katcorr) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-02-25')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 8)

article_dat <- tuesdata$article_dat
model_dat <- tuesdata$model_dat

# Option 2: Read directly from GitHub

article_dat <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-25/article_dat.csv')
model_dat <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-25/model_dat.csv')
```

```python
# Using Python
# Option 1: PyDyTuesday python library
## pip install PyDyTuesday

import PyDyTuesday

# Download files from the week, which you can then read in locally
PyDyTuesday.get_date('2025-02-25')

# Option 2: Read directly from GitHub and assign to an object

article_dat = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-25/article_dat.csv')
model_dat = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-25/model_dat.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)  

## PydyTuesday: A Posit collaboration with TidyTuesday  

- Exploring the TidyTuesday data in Python?  Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.

### Data Dictionary

# `article_dat.csv`

| variable           | class     | description                                                                                                                                                                                                                              |
|:-------------------|:----------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| pmid               | double    | The article's PubMed identification number                                                                                                                                                                                               |
| doi                | character | The article's Digital Object Identifier                                                                                                                                                                                                  |
| jabbrv             | character | Journal abbreviation                                                                                                                                                                                                                     |
| journal            | character | Journal full name                                                                                                                                                                                                                        |
| year               | double    | Year the article was published                                                                                                                                                                                                           |
| month              | character | Month the article was published                                                                                                                                                                                                          |
| day                | character | Day the article was published                                                                                                                                                                                                            |
| title              | character | Title of the article                                                                                                                                                                                                                     |
| abstract           | character | Abstract for the article                                                                                                                                                                                                                 |
| keywords           | character | Keywords for the article                                                                                                                                                                                                                 |
| study_aim          | character | Aim of the study                                                                                                                                                                                                                         |
| study_location     | character | Location of the study                                                                                                                                                                                                                    |
| study_year_start   | double    | The year the study started                                                                                                                                                                                                               |
| study_year_end     | double    | The year the study ended                                                                                                                                                                                                                 |
| study_type         | character | Type of study design: prospective cohort, retrospective cohort, case-control, cross-sectional, randomized controlled trial (RCT), registry                                                                                               |
| data_source        | character | Source of data                                                                                                                                                                                                                           |
| race1              | character | Race category that is used as the 'Referent' group in the study or, if no Referent group, that is presented first in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)   |
| race1_ss           | double    | Sample size for race1 group                                                                                                                                                                                                              |
| race2              | character | Race category that is presented second in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                              |
| race2_ss           | double    | Sample size for race2 group                                                                                                                                                                                                              |
| race3              | character | Race category that is presented third in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                               |
| race3_ss           | double    | Sample size for race3 group                                                                                                                                                                                                              |
| race4              | character | Race category that is presented fourth in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                              |
| race4_ss           | double    | Sample size for race4 group                                                                                                                                                                                                              |
| race5              | character | Race category that is presented fifth in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                               |
| race5_ss           | double    | Sample size for race5 group                                                                                                                                                                                                              |
| race6              | character | Race category that is presented sixth in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                               |
| race6_ss           | double    | Sample size for race6 group                                                                                                                                                                                                              |
| race7              | character | Race category that is presented seventh in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                             |
| race7_ss           | double    | Sample size for race7 group                                                                                                                                                                                                              |
| race8              | character | Race category that is presented eighth in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                              |
| race8_ss           | double    | Sample size for race8 group                                                                                                                                                                                                              |
| eth1               | character | Ethnic category that is used as the 'Referent' group in the study or, if no Referent group, that is presented first in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization) |
| eth1_ss            | double    | Sample size for the eth1 group                                                                                                                                                                                                           |
| eth2               | character | Ethnic category that is presented second in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                            |
| eth2_ss            | double    | Sample size for the eth2 group                                                                                                                                                                                                           |
| eth3               | character | Ethnic category that is presented third in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                             |
| eth3_ss            | double    | Sample size for the eth3 group                                                                                                                                                                                                           |
| eth4               | character | Ethnic category that is presented fourth in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                            |
| eth4_ss            | double    | Sample size for the eth4 group                                                                                                                                                                                                           |
| eth5               | character | Ethnic category that is presented fifth in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                             |
| eth5_ss            | double    | Sample size for the eth5 group                                                                                                                                                                                                           |
| eth6               | character | Ethnic category that is presented sixth in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                             |
| eth6_ss            | double    | Sample size for the eth6 group                                                                                                                                                                                                           |
| eth7               | logical   | Ethnic category that is presented seventh in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                           |
| eth7_ss            | logical   | Sample size for the eth7 group                                                                                                                                                                                                           |
| eth8               | logical   | Ethnic category that is presented eighth in the first table in the article, worded exactly as in the publication including letter case (e.g., capitalization)                                                                            |
| eth8_ss            | logical   | Sample size for the eth8 group                                                                                                                                                                                                           |
| access_to_care     | double    | Did the study address disparities in access to care?(1=yes, 0=no)                                                                                                                                                                        |
| treatment_received | double    | Did the study address disparities in treatment received? (1=yes, 0=no)                                                                                                                                                                   |
| health_outcome     | double    | Did the study address disparities in health outcomes? (1=yes, 0=no)                                                                                                                                                                      |
| cancer_ovarian     | double    | Did the study address ovarian cancer? (1=yes, 0=no)                                                                                                                                                                                      |
| cancer_uterine     | double    | Did the study address uterine cancer? (1=yes, 0=no)                                                                                                                                                                                      |
| cancer_cervical    | double    | Did the study address cervical cancer? (1=yes, 0=no)                                                                                                                                                                                     |
| cancer_vulvar      | double    | Did the study address vulvar cancer? (1=yes, 0=no)                                                                                                                                                                                       |
| other_gyn_onc      | double    | Did the study address other gynecological cancer? (1=yes, 0=no)                                                                                                                                                                          |
| endo               | double    | Did the study address endometriosis? (1=yes, 0=no)                                                                                                                                                                                       |
| fibroids           | double    | Did the study address fibroids? (1=yes, 0=no)                                                                                                                                                                                            |
| other_gyn_surg     | double    | Did the study address other gynecologic surgery? (1=yes, 0=no)                                                                                                                                                                           |
| fert               | double    | Did the study address fertility? (1=yes, 0=no)                                                                                                                                                                                           |
| matmorbmort        | double    | Did the study address maternal morbidity and mortality? (1=yes, 0=no)                                                                                                                                                                    |
| other_preg         | double    | Did the study address other pregnancy outcome? (1=yes, 0=no)                                                                                                                                                                             |
| phys_div           | double    | Did the study address physician diversity and/or training? (1=yes, 0=no)                                                                                                                                                                 |
| other              | double    | Did the study address other outcome? (1=yes, 0=no)                                                                                                                                                                                       |
| covid              | double    | Did the study address COVID-19 related concerns? (1=yes, 0=no)                                                                                                                                                                           |

# `model_dat.csv`

| variable         | class     | description                                                                                                                                                                             |
|:-----------------|:----------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| doi              | character | The article's Digital Object Identifier                                                                                                                                                 |
| model_number     | double    | Number identifying the model                                                                                                                                                            |
| stratified       | character | Was the analysis stratified? (1=yes, 0=no)                                                                                                                                              |
| stratgrp         | character | If the analysis was stratified, specifies the stratification group                                                                                                                      |
| subanalysis      | character | Was the analysis a subanalysis? (1=yes, 0=no)                                                                                                                                           |
| subgrp           | character | If the analysis was a subanalysis, specifies the subanalysis group                                                                                                                      |
| outcome          | character | Outcome measure for the model as reported in the article                                                                                                                                |
| measure          | character | Estimated measure from the model: incidence, prevalence, odds ratio (OR), risk ratio (RR), hazards ratio (HR), absolute difference, percent, other                                      |
| measure_comments | character | If 'other' measure was selected, specifies the estimated measure from the model                                                                                                         |
| covariates       | character | List of covariates included in the model; if the model is unadjusted, then 'None' is recorded                                                                                           |
| comparison       | double    | Number identifying the comparison made within a given model number                                                                                                                      |
| ref              | character | Reference group, recorded exactly as in the publication including letter case (e.g., capitalization) and without abbreviations; if reference group is not applicable, 'N/A' is recorded |
| compare          | character | Comparison group, recorded exactly as in the publication including letter case (e.g., capitalization) and without abbreviations                                                         |
| point            | double    | Point estimate for measure                                                                                                                                                              |
| lower            | double    | Lower bound of 95% confidence interval for measure; if a 95% confidence interval was not provided, -99 is recorded                                                                      |
| upper            | double    | Upper bound of 95% confidence interval for measure; if a 95% confidence interval was not provided, -99 is recorded                                                                      |

### Cleaning Script

```r
# Clean data provided by Kat Correia. Student interns extracted this information
# from reproductive medicine journals using duplicate data entry. 
# After duplicate data entry discrepancies were resolved, their 
# individual files were combined, and posted for public access 
# as Google sheets, e.g.,:
# https://docs.google.com/spreadsheets/d/1UuWGQxRU0wxVuOZGYnvkwKn-GdmLIj8kzmUm4KLRHQY/edit?gid=1719021104#gid=1719021104
# No additional cleaning was necessary.

article_dat <- readr::read_csv("https://kcorreia.people.amherst.edu/repro_med_disparities-article-level-data.csv")

model_dat <- readr::read_csv("https://kcorreia.people.amherst.edu/repro_med_disparities-model-level-data.csv")


```
