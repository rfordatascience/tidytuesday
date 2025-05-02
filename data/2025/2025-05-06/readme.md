# National Science Foundation Grant Terminations under the Trump Administration

This week we're exploring a dataset of grants for scientific research and education projects
from the U.S. National Science Foundation (NSF) that have been terminated by
the Trump administration in 2025. In an unprecedented and possibly illegal action, the NSF has terminated
over 1,000 such grants starting on April 18, 2025, and terminations continue. These
data were collected by [Grant Watch](https://grant-watch.us) by crowdsourcing
from researchers and program administrators, as the administration has not released
information on these terminations.

From a [New York Times article on the terminations](https://www.nytimes.com/2025/04/22/science/trump-national-science-foundation-grants.html):

> In general, the agency provides scientists with the opportunity to dispute its
> decisions about funding. But researchers were informed that the decision to
> cancel their grants was final and not subject to appeal.
>
>Scientists expressed fear about the growing disruptions to research and the
> harm it may do to both academia and the public at large.
>
>"It’s shocking to see the government do this,"" said Jon Freeman, a psychologist
>at Columbia University whose grant on studying facial perception was terminated.
>"It cedes American leadership in science and technology to China and to other
>countries. I think it is going to take at least 10 years for American
>scientific and biomedical research to recover from this."

More information, as well as similar data on grant terminations from the National
Institutes of Health (NIH), can be found at <https://grant-watch.us>.

Some questions you might explore are:

- How many grants, and how much money, were terminated by state or congressional
  district? What institutions? How can you present these on a map?
- Grants from what directorates, divisions, or programs made up most of the 
  projects terminated?
- What topics or terms are most common in project titles or abstracts?

More elaborate analysis could use [data on total awards](https://www.nsf.gov/about/about-nsf-by-the-numbers)
to look at the fraction of awards terminated, or [data on educational institutions](https://nces.ed.gov/ipeds/use-the-data)
to look at what kinds of institutions are most affected.

Check out the cleaning script below for instructions on fetching the latest version of the data!

Thank you to [Noam Ross and Scott Delaney, Grant Watch](https://github.com/noamross) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-05-06')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 18)

nsf_terminations <- tuesdata$nsf_terminations

# Option 2: Read directly from GitHub

nsf_terminations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-06/nsf_terminations.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-05-06')

# Option 2: Read directly from GitHub and assign to an object

nsf_terminations = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-06/nsf_terminations.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-05-06')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

nsf_terminations = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-06/nsf_terminations.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
nsf_terminations = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-06/nsf_terminations.csv", DataFrame)
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

### `nsf_terminations.csv`

|variable                |class     |description                           |
|:-----------------------|:---------|:-------------------------------------|
|grant_number            |character |The numeric ID of the grant. |
|project_title           |character |The title of the project the grant funds. |
|termination_letter_date |date      |The date a termination letter was received by the organization. |
|org_name                |character |The name of the organization or institution funded to do the project. |
|org_city                |character |The name of the organization's city. |
|org_state               |character |The organization's two-letter state abbreviation. |
|org_district            |character |The congressional district (state and number) where the organization is located. |
|usaspending_obligated   |double    |The amount of money, via USAspending.gov, that NSF had committed to funding. |
|award_type              |character |The type of grant. |
|directorate_abbrev      |character |The three-letter abbreviation of the NSF directorate name. |
|directorate             |character |The NSF directorate (the highest level of organization), which administered the grant. |
|division                |character |The NSF division (housed within directorate) which administered the grant. |
|nsf_program_name        |character |The name of the funding program under which the grant was made. |
|nsf_url                 |character |The URL pointing to the award information in the public NSF award database. |
|usaspending_url         |character |The URL pointing to budget and spending information at the public USAspending.gov website. |
|nsf_startdate           |date      |The start date of the project. |
|nsf_expected_end_date   |date      |The date the project was expected to end. |
|org_zip                 |character |The 5- or 9-digit ZIP code of the organization receiving the grant. |
|org_uei                 |character |The unique entitity identifier (UEI) of the organization recieving the grant, used across U.S. government databases. |
|abstract                |character |The text of the project abstract, describing the work to be done. |
|in_cruz_list            |logical   |Whether the project was in a [list of NSF projects named by U.S. Senator Ted Cruz](https://democrats-science.house.gov/imo/media/doc/democratic_staff_report-defending_hidden_figures.pdf) that he claimed "promoted Diversity, Equity, and Inclusion (DEI) or advanced neo-Marxist class warfare propaganda." |

## Cleaning Script

```r
# Fetch data from the CSV download link at https://grant-watch.us/nsf-data.html
raw_nsf_terminations <- readr::read_csv("https://drive.usercontent.google.com/download?id=1TFoyowiiMFZm73iU4YORniydEeHhrsVz&export=download")

# Clean the data
nsf_terminations <- raw_nsf_terminations |> 
  janitor::clean_names() |> 
  mutate(usaspending_obligated = stringi::stri_replace_first_fixed(usaspending_obligated, "$", "") |> 
           readr::parse_number()) |> 
  mutate(in_cruz_list = !is.na(in_cruz_list)) |> 
  mutate(grant_number = as.character(grant_number)) 
```
