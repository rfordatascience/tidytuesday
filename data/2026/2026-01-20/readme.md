# Astronomy Picture of the Day (APOD) Archive

This week we're exploring the Astronomy Picture of the Day (APOD) archive.
APOD is a popular NASA website featuring daily astronomy related images with a scientific explanation.  
Each day a different image or photograph of our universe is featured, along with a brief explanation. 
This APOD archive contains image information from the 2007 - 2025, pulled together into the {astropic} R package.

- What types of objects are most common in the archive?
- Are any images posted more than once?

Thank you to [Erin Grand](https://github.com/eringrand) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-01-20')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 3)

apod <- tuesdata$apod

# Option 2: Read directly from GitHub

apod <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-20/apod.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-01-20')

# Option 2: Read directly from GitHub and assign to an object

apod = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-20/apod.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2026-01-20')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

apod = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-20/apod.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
apod = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-20/apod.csv", DataFrame)
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

### `apod.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
|copyright       |character |The name of the copyright holder. |
|date            |Date |Date of image. |
|explanation     |character |The supplied text explanation of the image. |
|media_type      |character |The type of media (data) returned. May either be ‘image’ or ‘video’ depending on content. |
|title           |character |The title of the image. |
|url             |character |The URL of the APOD image or video of the day. |
|hdurl           |character |The URL for any high-resolution image for that day. Will be omitted in the response IF it does not exist originally at APOD. |

## Cleaning Script

```r
remotes::install_github("eringrand/astropic")

# Dataset inside the {{astropic}} R package on GitHub.
library(astropic)
library(dplyr)
data("hist_apod")

# Remove one column with constant values
apod <- hist_apod |> 
  select(-service_version)

```
