# useR! 2025 program

This week we're exploring the program for the [useR! 2025](https://user2025.r-project.org/) conference.
useR! 2025 will be hosted at Duke University in Durham, NC, USA from August 8-10, 2025.
The conference will feature keynote presentations from leading R developers and data scientists, technical talks and tutorials, interactive tutorials and training sessions, poster presentations, networking opportunities, and both in-person and virtual attendance options (with the virtual conference taking place on August 1, 2025).
The event hashtag is #useR2025, so when sharing your TidyTuesday creations this week, please add this hashtag as well!

From the useR! website:

> useR! conferences are annual nonprofit gatherings organized by R community volunteers and supported by the R Foundation. These conferences have been the premier global venue for the R community since 2004, bringing together R developers, users, and enthusiasts from around the world.

The virtual conference program can be found at <https://user2025.r-project.org/program/virtual> and the in-person program at <https://user2025.r-project.org/program/in-person>.
Use this week's data to

- Discover emerging themes at useR! 2025
- Create an interactive conference program app
- Build a data visualization that inspires folks to participate in useR! 2025

or do whatever you think would be helpful to you or the R community to get the most out of useR! 2025, whether participating in person or virtually.


Thank you to [Mine Çetinkaya-Rundel, Duke University + Posit PBC](https://github.com/mine-cetinkaya-rundel) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-04-29')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 17)

user2025 <- tuesdata$user2025

# Option 2: Read directly from GitHub

user2025 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-29/user2025.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-04-29')

# Option 2: Read directly from GitHub and assign to an object

user2025 = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-29/user2025.csv')
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

### `user2025.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
|id              |double    |Submission ID from Indico, the conference management tool. |
|session         |character |Name of session. |
|date            |date      |Date of session. |
|time            |character |Time of session. |
|room            |character |Room where session will take place. |
|title           |character |Title of talk, poster, or tutorial. |
|content         |character |Abstract of talk, poster, or tutorial. |
|video_recording |character |Whether there will be a video recording available after the conference. |
|keywords        |character |Keywords of talk, poster, or tutorial. |
|speakers        |character |Name(s) of speaker(s) and their affiliations. |
|co_authors      |character |Name(s) of co-author(s) and their affiliations. |

## Cleaning Script

```r
# Clean data provided by useR! 2025 program committee. No cleaning was necessary.
user2025 <- readr::read_csv("program.csv")

```
