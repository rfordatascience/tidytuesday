# Pima Indian Diabetes Data: A Prospective Observational Cohort

This week we are exploring type 2 diabetes data from the Pima Indian community near Phoenix, Arizona. The study includes only women aged 21 and older, all of Pima heritage, with at least five years of follow-up. Each participant underwent regular oral glucose tolerance tests, and diabetes was diagnosed using WHO criteria.

> People with type 2 diabetes mellitus (DM) become less sensitive to insulin. After a glucose load, both blood glucose and insulin levels rise, but glucose does not fall as quickly as it should—leading to sustained elevations. The incidence of type 2 DM is rising in many Western cultures, as increasingly unhealthy and calorie-rich diets become common.

-   What is the distribution of the glucose-to-insulin ratio, and how does it differ by diabetes outcome?
-   Can we build a logistic regression model to predict `diabetes_5y` using glucose, BMI, and pedigree?
-   How does the number of pregnancies relate to diabetes risk in this cohort?
-   How does BMI vary across age groups, and is it associated with diabetes diagnosis?

Thank you to [Darakhshan Nehal](https://github.com/darakhshannehal) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-11-11')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 45)

diabetes <- tuesdata$diabetes

# Option 2: Read directly from GitHub

diabetes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-11/diabetes.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-11-11')

# Option 2: Read directly from GitHub and assign to an object

diabetes = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-11/diabetes.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-11-11')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

diabetes = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-11/diabetes.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
diabetes = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-11/diabetes.csv", DataFrame)
```


## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.


## Data Dictionary

### `diabetes.csv`

| variable | class | description |
|----|----|----|
| pregnancy_num | integer | number of pregnancies |
| glucose_mg-dl | integer | Plasma glucose concentration at 2 hours after administration of an oral glucose tolerance test |
| dbp_mm-hg | integer | Dose of Theophylline in milligrams per kilogram of body weight |
| triceps_mm | integer | triceps skin fold thickness in mm, a measure of subcutaneous fat |
| insulin_microui-ml | integer | serum insulin 2 hours after administration of an oral glucose tolerance test in microIU per milliliter (IU = international units) |
| bmi | double | body mass index, in kg of weight per meters squared of height, from 18.2 to 67.1 |
| pedigree | double | a diabetes pedigree score, which looks at the degree of relatedness of the patient with each additional relative with diabetes, weighted for the closeness of their genetic relation to the participant, from 0.78 to 2.42 |
| age | integer | Age in years, from 21 to 81 |
| diabetes_5y | character | Diagnosis of diabetes in the following 5 years, "pos" or "neg" |

## Cleaning Script

```r
## Diabetes data from medicaldata package by Peter Higgins

# Install medicaldata package
#remotes::install_github("higgi13425/medicaldata")
library(medicaldata)
library(tidyverse)

# Load diabetes data
diabetes = medicaldata::diabetes

# No data cleaning needed
# For more information and background on the data: https://pmc.ncbi.nlm.nih.gov/articles/PMC4418458/

```
