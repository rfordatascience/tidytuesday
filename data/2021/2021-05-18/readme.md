![Logo for the Ask a Manager blog which is a white red-haired woman next to the words "Ask a Manager, and if you don't I'll tell you anyway"](https://www.askamanager.org/wp-content/uploads/2019/09/cropped-aam-resize-1-550px_width.png)

Please note that the image above belongs to the Ask a Manager blog/Alison Green.

# Ask a Manager Survey

The data this week comes from the [Ask a Manager Survey](https://docs.google.com/spreadsheets/d/1IPS5dBSGtwYVbjsfbaMCYIWnOuRmJcbequohNxCyGVw/edit?resourcekey#gid=1625408792). H/t to [Kaija Gahm](https://github.com/rfordatascience/tidytuesday/issues/340) for sharing it as an issue!

> The salary survey a few weeks ago got a huge response — 24,000+ people shared their salaries and other info, which is a lot of raw data to sift through. Reader Elisabeth Engl kindly took the raw data and analyzed some of the trends in it and here's what she found. (She asked me to note that she did this as a fun project to share some insights from the survey, rather than as a paid engagement.)

> This data does not reflect the general population; it reflects Ask a Manager readers who self-selected to respond, which is a very different group (as you can see just from the demographic breakdown below, which is very white and very female).

Elisabeth Engl prepped some plots for the [Ask a Manager blog](https://www.askamanager.org/2021/05/some-findings-from-24000-peoples-salaries.html) using this data.

The survey itself is available [here](https://www.askamanager.org/2021/04/how-much-money-do-you-make-4.html).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-05-18')
tuesdata <- tidytuesdayR::tt_load(2021, week = 21)

survey <- tuesdata$survey

# Or read in the data manually

survey <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-05-18/survey.csv')

```
### Data Dictionary

# `survey.csv`

|variable                                 |class     |description |
|:----------------------------------------|:---------|:-----------|
|timestamp                                |character | Timestamp when survey submitted |
|how_old_are_you                          |character | How old are you (bracket range) |
|industry                                 |character | Industry |
|job_title                                |character | Job title |
|additional_context_on_job_title          |character | Additional context on job, free text |
|annual_salary                            |double    | Annual salary in local currency |
|other_monetary_comp                      |character | Additional other monetary comp |
|currency                                 |character | Local currency |
|currency_other                           |character | Currency for other compensation |
|additional_context_on_income             |character | Additional context on income (free text) |
|country                                  |character | Country currently working in |
|state                                    |character | State |
|city                                     |character | City |
|overall_years_of_professional_experience |character | Overall years of professional experience (bracketed) |
|years_of_experience_in_field             |character | Years of experience in field (bracketed) |
|highest_level_of_education_completed     |character | Highest level of education completed |
|gender                                   |character | Gender |
|race                                     |character | Race |

### Cleaning Script

