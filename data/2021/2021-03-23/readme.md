![](https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/UN_emblem_blue.svg/1205px-UN_emblem_blue.png)

# UN Votes

The data this week comes from [Harvard's Dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=hdl:1902.1/12379) by way of [Mine Çetinkaya-Rundel, David Robinson, and Nicholas Goguen-Compagnoni](https://github.com/dgrtwo/unvotes/blob/7eb7034314ff79c49c9e0785fcd9d216fa04cf14/DESCRIPTION#L6).

Original Data citation:  
> Citation: Erik Voeten "Data and Analyses of Voting in the UN General Assembly" Routledge Handbook of International Organization, edited by Bob Reinalda (published May 27, 2013). Available at SSRN: http://ssrn.com/abstract=2111149

The `{unvotes}` R package is now on [CRAN](https://cran.r-project.org/web/packages/unvotes/unvotes.pdf)! [Github link](https://github.com/dgrtwo/unvotes)

This is a wrapper around the datasets, although I've included them as CSVs in the TidyTuesday repo.

Get package from CRAN:  

`install.packages("unvotes")`

[Mine Çetinkaya-Rundel wrote about the process](http://www.citizen-statistician.org/2021/03/open-source-contribution-as-a-student-project/) on the Citizen Statistician blog.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-03-23')
tuesdata <- tidytuesdayR::tt_load(2021, week = 13)

unvotes <- tuesdata$unvotes

# Or read in the data manually

unvotes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/unvotes.csv')
roll_calls <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/roll_calls.csv')
issues <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-23/issues.csv')

```
### Data Dictionary

# `unvotes.csv`

|variable     |class     |description |
|:------------|:---------|:-----------|
|rcid         |double    | The roll call id; used to join with un_votes and un_roll_call_issues |
|country      |character | Country name, by official English short name |
|country_code |character | 2-character ISO country code |
|vote         |integer   | Vote result as a factor of yes/abstain/no |

# `roll_calls.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|rcid          |integer   |.           |
|session       |double    | Session number. The UN holds one session per year; these started in 1946|
|importantvote |integer   | Whether the vote was classified as important by the U.S. State Department report
"Voting Practices in the United Nations". These classifications began with session 39|
|date          |double    | Date of the vote, as a Date vector|
|unres         |character | Resolution code |
|amend         |integer   | Whether the vote was on an amendment; coded only until 1985 |
|para          |integer   | Whether the vote was only on a paragraph and not a resolution; coded only until 1985|
|short         |character |  Short description |
|descr         |character | Longer description|

# `issues.csv`

|variable   |class     |description |
|:----------|:---------|:-----------|
|rcid       |integer   | The roll call id; used to join with un_votes and un_roll_calls |
|short_name |character | Two-letter issue codes |
|issue      |integer   | Descriptive issue name |

### Cleaning Script

No cleaning, but see [Mine Çetinkaya-Rundel who wrote about the process](http://www.citizen-statistician.org/2021/03/open-source-contribution-as-a-student-project/) on the Citizen Statistician blog.