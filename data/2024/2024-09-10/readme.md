# Economic Diversity and Student Outcomes

College students are back on campus in the US, so we're exploring economic diversity and student outcomes! The dataset this week comes from [Opportunity Insights](https://opportunityinsights.org/data/) via an [article](https://www.nytimes.com/interactive/2017/01/18/upshot/some-colleges-have-more-students-from-the-top-1-percent-than-the-bottom-60.html) and associated [interactive visualization](https://www.nytimes.com/interactive/projects/college-mobility/university-of-texas-at-dallas) from the Upshot at the New York Times. Thank you to [Havisha Khurana](https://github.com/havishak) for suggesting this dataset!

> A new study, based on millions of anonymous tax records, shows that some colleges are even more economically segregated than previously understood, while others are associated with income mobility.

This dataset offers an opportunity to explore the [three rules that make a dataset "tidy"](https://r4ds.hadley.nz/data-tidy#sec-tidy-data):

1. Each variable is a column; each column is a variable.
2. Each observation is a row; each row is an observation.
3. Each value is a cell; each cell is a single value.

How might you pivot this data to make it longer? When might you want to do that? When might you pivot this data to make it wider?

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-09-10')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 37)

college_admissions <- tuesdata$college_admissions

# Option 2: Read directly from GitHub

college_admissions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-10/college_admissions.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `college_admissions.csv`

|variable                        |class     |description                           |
|:-------------------------------|:---------|:-------------------------------------|
|super_opeid                     |double    |Institution OPEID / Cluster ID when combining multiple OPEIDs. |
|name                            |character |Name of college (or college group). |
|par_income_bin                  |double    |Parent household income group based on percentile in the income distribution. |
|par_income_lab                  |character |Parent household income label. |
|attend                          |double    |Test-score-reweighted absolute attendance rate: Calculated as the fraction of students attending that college among all test-takers within a parent income bin in the Pipeline Analysis Sample. |
|stderr_attend                   |double    |Standard error on the attend variable. |
|attend_level                    |double    |The school average estimates reweighting on test score. Divide the test-score-reweighted absolute variables by this average to calculate the test-score-reweighted relative variables. |
|attend_sat                      |double    |Absolute attendance rate for specific test score band based on school tier/category. |
|stderr_attend_sat               |double    |Standard error on the attend_sat variable. |
|attend_level_sat                |double    |The school average estimates reweighting on test score. Divide the test-score-reweighted absolute variables by this average to calculate the test-score-reweighted relative variables. |
|rel_apply                       |double    |Test-score-reweighted relative application rate: Calculated using adjusted score-sending rates, the relative fraction of all standardized test takers who send test scores to a given college.  |
|stderr_rel_apply                |double    |Standard error on the rel_apply variable. |
|rel_attend                      |double    |Test-score-reweighted relative attendance rate: Calculated as the fraction of students attending that college among all test-takers within a parent income bin in the Pipeline Analysis Sample. Relative attendance rates are reported as a proportion of the mean attendance rate across all parent income bins for each college. |
|stderr_rel_attend               |double    |Standard error on the rel_attend variable. |
|rel_att_cond_app                |double    |Calculated as the ratio of rel_attend to rel_apply. |
|rel_apply_sat                   |double    |Relative application rate for specific test score band based on school tier/category. Selected test score band is the 50-point band that had the most attendees in each school tier/category. The selected range: Ivy Plus: SAT 1460-1510; Elite Public: SAT 1180-1230; Top Private: SAT 1410-1460; NESCAC: SAT 1370-1420; Tier 2 Private: SAT 1290-1340; Top 100 Private: SAT 1170-1220; Top 100 Public: SAT 1110-1160; Other Flagship: SAT 1070-1120 |
|stderr_rel_apply_sat            |double    |Standard error on the rel_apply_sat variable. |
|rel_attend_sat                  |double    |Relative attendance rate for specific test score band based on school tier/category. |
|stderr_rel_attend_sat           |double    |Standard error on the rel_attend_sat variable. |
|rel_att_cond_app_sat            |double    |Relative attendance rate, conditional on application, for specific test score band based on school tier/category |
|attend_instate                  |double    |Test-score-reweighted absolute attendance rate for in-state students. Only available for public schools. |
|stderr_attend_instate           |double    |Standard error on the attend_instate variable. |
|attend_level_instate            |double    |The school average estimates reweighting on test score. Divide the test-score-reweighted absolute variables by this average to calculate the test-score-reweighted relative variables. |
|attend_instate_sat              |double    |Absolute estimates on a specific test score for in-state students. Only available for public schools. |
|stderr_attend_instate_sat       |double    |Standard error on the attend_instate_sat variable. |
|attend_level_instate_sat        |double    |Absolute estimates on a specific test score for in-state students. Only available for public schools. |
|attend_oostate                  |double    |Test-score-reweighted absolute attendance rate for out-of-state students. Only available for public schools.  |
|stderr_attend_oostate           |double    |Standard error on the attend_oostate variable. |
|attend_level_oostate            |double    |The school average estimates reweighting on test score. Divide the test-score-reweighted absolute variables by this average to calculate the test-score-reweighted relative variables. |
|attend_oostate_sat              |double    |Absolute estimates on a specific test score for out-of-state students. Only available for public schools. |
|stderr_attend_oostate_sat       |double    |Standard error on the attend_oostate_sat variable. |
|attend_level_oostate_sat        |double    |Absolute estimates on a specific test score for out-of-state students. Only available for public schools. |
|rel_apply_instate               |double    |Test-score-reweighted relative application rate for in-state students. In-state status is measured using the students’ address when they take a standardized test. Only available for public schools. |
|stderr_rel_apply_instate        |double    |Standard error on the rel_apply_instate variable. |
|rel_attend_instate              |double    |Test-score-reweighted relative attendance rate for in-state students. Only available for public schools. |
|stderr_rel_attend_instate       |double    |Standard error on the rel_attend_instate variable. |
|rel_att_cond_app_instate        |double    |Test-score-reweighted relative attendance rate, conditional on application, for in-state students. Only available for public schools. |
|rel_apply_oostate               |double    |Test-score-reweighted relative application rate for out-of-state students. In-state status is measured using the students’ address when they take a standardized test. Only available for public schools. |
|stderr_rel_apply_oostate        |double    |Standard error on the rel_apply_oostate variable. |
|rel_attend_oostate              |double    |Test-score-reweighted relative attendance rate for out-of-state students. Only available for public schools.  |
|stderr_rel_attend_oostate       |double    |Standard error on the rel_attend_oostate variable. |
|rel_att_cond_app_oostate        |double    |Test-score-reweighted relative attendance rate, conditional on application, for out-of-state students. Only available for public schools. |
|rel_apply_instate_sat           |double    |Relative estimates on a specific test score for in-state students. Only available for public schools. |
|stderr_rel_apply_instate_sat    |double    |Standard error on the rel_apply_instate_sat variable. |
|rel_attend_instate_sat          |double    |Relative estimates on a specific test score for in-state students. Only available for public schools. |
|stderr_rel_attend_instate_sat   |double    |Standard error on the rel_attend_instate_sat variable. |
|rel_att_cond_app_instate_sat    |double    |Estimates on a specific test score for in-state students. Only available for public schools. |
|rel_apply_oostate_sat           |double    |Relative estimates on a specific test score for out-of-state students. Only available for public schools. |
|stderr_rel_apply_oostate_sat    |double    |Standard error on the rel_apply_oostate_sat variable. |
|rel_attend_oostate_sat          |double    |Relative estimates on a specific test score for out-of-state students. Only available for public schools. |
|stderr_rel_attend_oostate_sat   |double    |Standard error on the rel_attend_oostate_sat variable. |
|rel_att_cond_app_oostate_sat    |double    |Estimates on a specific test score for out-of-state students. Only available for public schools. |
|attend_unwgt                    |double    |Unweighted absolute attendance rate: Calculated as the fraction of students attending that college among all test-takers within a parent income bin in the Pipeline Analysis Sample. |
|stderr_attend_unwgt             |double    |Standard error on the attend_unwgt variable. |
|attend_unwgt_level              |double    |The unweighted school average estimates. Divide the unweighted absolute variables by this average to calculate the unweighted relative variables. |
|attend_unwgt_instate            |double    |Unweighted absolute estimates for instate students. Only available for public schools. |
|stderr_attend_unwgt_instate     |double    |Standard error on the attend_unwgt_instate variable. |
|attend_unwgt_oostate            |double    |Unweighted absolute estimates for out-of-state students. Only available for public schools. |
|stderr_attend_unwgt_oostate     |double    |Standard error on the attend_unwgt_oostate variable. |
|attend_unwgt_level_instate      |double    |The unweighted school average estimates. Divide the unweighted absolute variables by this average to calculate the unweighted relative variables. |
|attend_unwgt_level_oostate      |double    |The unweighted school average estimates. Divide the unweighted absolute variables by this average to calculate the unweighted relative variables. |
|rel_attend_unwgt                |double    |Unweighted relative attendance rate: Calculated as the fraction of students attending that college among all test-takers within a parent income bin in the Pipeline Analysis Sample. Relative attendance rates are reported as a proportion of the mean attendance rate across all parent income bins for each college.  |
|rel_apply_unwgt                 |double    |Unweighted relative application rate: Calculated using adjusted score-sending rates, the relative fraction of all standardized test takers who send test scores to a given college. |
|stderr_rel_attend_unwgt         |double    |Standard error on the rel_attend_unwgt variable. |
|stderr_rel_apply_unwgt          |double    |Standard error on the rel_apply_unwgt variable. |
|rel_att_cond_app_unwgt          |double    |Calculated as the ratio of rel_attend_unwgt to rel_apply_unwgt. |
|rel_attend_unwgt_instate        |double    |Unweighted relative estimates for instate students. Only available for public schools. |
|rel_attend_unwgt_oostate        |double    |Unweighted relative estimates for out-of-state students. Only available for public schools. |
|stderr_rel_attend_unwgt_instate |double    |Standard error on the rel_attend_unwgt_instate variable. |
|stderr_rel_attend_unwgt_oostate |double    |Standard error on the rel_attend_unwgt_oostate variable. |
|rel_apply_unwgt_instate         |double    |Unweighted relative estimates for instate students. Only available for public schools. |
|rel_apply_unwgt_oostate         |double    |Unweighted relative estimates for out-of-state students. Only available for public schools. |
|stderr_rel_apply_unwgt_instate  |double    |Standard error on the rel_apply_unwgt_instate variable. |
|stderr_rel_apply_unwgt_oostate  |double    |Standard error on the rel_apply_unwgt_oostate variable. |
|rel_att_cond_app_unwgt_instate  |double    |Unweighted estimates for instate students. Only available for public schools. |
|rel_att_cond_app_unwgt_oostate  |double    |Unweighted estimates for out-of-state students. Only available for public schools. |
|public                          |logical   |Indicator for public universities. |
|flagship                        |logical   |Indicator for public flagship universities (defined using the College Board Annual Survey of Colleges, 2016). |
|tier                            |character |Selectivity and type combination: Ivy-Plus (Ivy League colleges plus Stanford, Chicago, Duke, and MIT); Other elite college (Barron’s top selectivity category, other than the Ivy-plus, both public and private combined); Highly selective public college (Barron’s 2nd selectivity group); Highly selective private college (Barron’s 2nd selectivity group); Selective public college (Barron’s 3rd, 4th, and 5th selectivity groups); Selective private college (Barron’s 3rd, 4th, and 5th selectivity groups) See Chetty, Friedman, Saez, Turner, and Yagan (2020) for more information on how the tier is defined. |
|test_band_tier                  |character |School group for the test-score band statistics. |

### Cleaning Script

```r
# Mostly clean data provided by https://opportunityinsights.org.
library(tidyverse)

data_url <- "https://opportunityinsights.org/wp-content/uploads/2023/07/CollegeAdmissions_Data.csv"
college_admissions <- readr::read_csv(data_url) |> 
  # Drop redundant variables.
  dplyr::select(
    -"tier_name"
  ) |> 
  # Recode variables.
  dplyr::mutate(
    public = public == "Public",
    flagship = as.logical(flagship)
  )
```
