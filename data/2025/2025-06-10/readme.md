# U.S. Judges and the historydata R package

This week we're exploring U. S. judge data from the {historydata} R package! 
This package is [looking for a new maintainer](https://github.com/ropensci/historydata/issues/23).
If you are interested in this dataset (and other datasets of historical information), please consider volunteering!
Check out the rOpenSci Blog [What Does It Mean to Maintain a Package?](https://ropensci.org/blog/2023/02/07/what-does-it-mean-to-maintain-a-package/) by Maëlle Salmon for more information.

Note: The package help for this dataset links to a particular PDF with some information about judgeships, but the actual source data can be found at [Biographical Directory of Article III Federal Judges: Export](https://www.fjc.gov/history/judges/biographical-directory-article-iii-federal-judges-export) on the [Federal Judicial Center](https://www.fjc.gov/) website.

> This dataset contains information about the appointments and careers of all federal judges in United States history since 1789. It includes judges who "judges presidentially appointed during good behavior who have served since 1789 on the U.S. District Courts, the U.S. Courts of Appeals, the Supreme Court of the United States, the former U.S. Circuit Courts, and the federal judiciary's courts of special jurisdiction." Some of the unnecessary information from the source has been excluded.

- How many judges have Pacific Islander as part of their designated race?
- Which Presidents appointed the most judges? The fewest?
- Which political parties have appointed the most judges to courts of customs or internation trade? Due to some coding issues in the current version of the {historydata} package, you may need to combine some terms to find all such appointments.

Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-06-10')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 23)

judges_appointments <- tuesdata$judges_appointments
judges_people <- tuesdata$judges_people

# Option 2: Read directly from GitHub

judges_appointments <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_appointments.csv')
judges_people <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_people.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-06-10')

# Option 2: Read directly from GitHub and assign to an object

judges_appointments = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_appointments.csv')
judges_people = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_people.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-06-10')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

judges_appointments = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_appointments.csv")
judges_people = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_people.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
judges_appointments = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_appointments.csv", DataFrame)
judges_people = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_people.csv", DataFrame)
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

### `judges_appointments.csv`

|variable                       |class     |description                           |
|:------------------------------|:---------|:-------------------------------------|
|judge_id                       |integer   |"Judge Identification Number."" This was used as a unique identifier for each judge, generated for purposes of the database, until July 2016. These numbers are no longer used and will not be generated for judges added to the database after July 2016, but will remain in the export as a courtesy to researchers who may have relied on them. This is one area that should be updated when the package gets a new maintainer. |
|court_name                     |character |The name of the court to which the judge was appointed. |
|court_type                     |character |The type of court to which the judge was appointed. "U. S. Court of Custo" and "U. S. Court of Inter" each have 1 entry due to coding issues. |
|president_name                 |character |The name of the President who appointed the judge. Some entries have "Assignment" or "Reassignment", indicating the judge was assigned or reassigned to this appointment via statute rather than by a President. |
|president_party                |character |The political party of the President who appointed the judge. Some entries have "Assignment" or "Reassignment", indicating the judge was assigned or reassigned to this appointment via statute rather than by a President. |
|nomination_date                |character |The date on which the judge was nominated, in "MM/DD/YYYY" format. |
|predecessor_last_name          |character |The last name of the judge's predecessor in this position. The word "new" is sometimes used to indicate that this is a new position (but also check "predecessor_first_name"). |
|predecessor_first_name         |character |The first name of the judge's predecessor in this position. The word "new" is sometimes used to indicate that this is a new position (but also check "predecessor_last_name"). |
|senate_confirmation_date       |character |The date on which the Senate confirmed this appointment, in "MM/DD/YYYY" format. Note that some judges were never confirmed (they were "recess appointments"), and some were put into the office by statute ("Assignment" or "Reassignment"). |
|commission_date                |character |The date on which the judgeship officially began, in "MM/DD/YYYY" format. NA for all recess appointments, as well as for four judgeships with missing information. |
|chief_judge_begin              |integer   |Year in which the judge began temporary service as Chief Judge. Only non-NA for 2 judges. |
|chief_judge_end                |integer   |Year in which the judge ended temporary service as Chief Judge. Only non-NA for 2 judges. |
|retirement_from_active_service |character |The date on which the judge retired from active service, in "MM/DD/YYYY" format. |
|termination_date               |character |The date on which the judge's service ended (when appropriate), in "MM/DD/YYYY" format. |
|termination_reason             |character |The reason that the judge's service ended (when appropriate). One of "Abolition of Court", "Appointment to Another Judicial Position", "Death", "Impeachment & Conviction", "Reassignment", "Recess Appointment-Not Confirmed", "Resignation", "Retirement" or NA. |

### `judges_people.csv`

|variable         |class     |description                           |
|:----------------|:---------|:-------------------------------------|
|judge_id         |integer   |"Judge Identification Number."" This was used as a unique identifier for each judge, generated for purposes of the database, until July 2016. These numbers are no longer used and will not be generated for judges added to the database after July 2016, but will remain in the export as a courtesy to researchers who may have relied on them. This is one area that should be updated when the package gets a new maintainer. |
|name_first       |character |The first name of the judge. |
|name_middle      |character |The middle name or initial of the judge, if available. |
|name_last        |character |The last name of the judge. |
|name_suffix      |character |One of "Jr.", "Sr.", "II", "III", or "IV", when appropriate. |
|birth_date       |integer   |The year in which the judge was born, if known. |
|birthplace_city  |character |The city in which the judge was born, if known. |
|birthplace_state |character |The state in which the judge was born, if known. |
|death_date       |integer   |The year in which the judge died, if known and applicable. |
|death_city       |character |The city in which the judge died, if known and applicable. |
|death_state      |character |The state in which the judge died, if known and applicable. |
|gender           |character |The gender of the judge, as reported by the judiciary. |
|race             |character |The race of the judge, as reported by the judiciary. |

## Cleaning Script

```r
# Clean data provided by the development version of the {historydata} R package.
# No cleaning was necessary.

# install.packages("pak")
# pak::pak("ropensci/historydata")
library(historydata)

judges_people <- historydata::judges_people
judges_appointments <- historydata::judges_appointments

```
