# MTA Permanent Art Catalog

This week we're exploring the (New York) MTA Permanent Art Catalog! Thank you to Georgios Karamanis ([GitHub](https://github.com/gkaramanis) | [Bluesky](https://bsky.app/profile/karaman.is) | [LinkedIn](https://www.linkedin.com/in/georgios-karamanis-a54926153/) for [suggesting this dataset](https://github.com/rfordatascience/tidytuesday/issues/894). Submit your dataset ideas through our [GitHub issue tracker](https://github.com/rfordatascience/tidytuesday/blob/main/.github/dataset_idea.md)!

The [MTA has a dashboard to explore this dataset](https://data.ny.gov/stories/s/u2va-fuuf), but the dashboard is at least partially broken. Can you recreate it in Shiny for R or Python?

> Through the Permanent Art Program, MTA Arts & Design (formerly Arts for Transit) commissions public art that is seen by millions of city-dwellers as well as national and international visitors who use the MTA’s subways and trains. Arts & Design works closely with the architects and engineers at MTA NYC Transit, Long Island Rail Road and Metro-North Railroad to determine the parameters and sites for the artwork that is to be incorporated into each station scheduled for renovation. A diversity of well-established, mid-career and emerging artists contribute to the growing collection of works created in the materials of the system -mosaic, ceramic, tile, bronze, steel and glass. Artists are chosen through a competitive process that uses selection panels comprised of visual arts professionals and community representatives which review and select artists. This data provides the branch or station and the artist and artwork information.

- Can you reproduce the `station_lines` dataset without looking at our Cleaning Script? How does your solution differ from ours?
- Which agency has the most art? Which has the least?
- What are some common materials? How are details such as "hand forged" for bronze denoted in the data? Can you reliably take these details into account in your counts?

Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-07-22')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 29)

mta_art <- tuesdata$mta_art
station_lines <- tuesdata$station_lines

# Option 2: Read directly from GitHub

mta_art <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-22/mta_art.csv')
station_lines <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-22/station_lines.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-07-22')

# Option 2: Read directly from GitHub and assign to an object

mta_art = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-22/mta_art.csv')
station_lines = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-22/station_lines.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-07-22')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

mta_art = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-22/mta_art.csv")
station_lines = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-22/station_lines.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
mta_art = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-22/mta_art.csv", DataFrame)
station_lines = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-22/station_lines.csv", DataFrame)
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

### `mta_art.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
|agency          |character |This is the abbreviated code for an agency. Example: LIRR = Long Island Rail Road, MNR = Metro-North Railroad, NYCT = New York City Transit. |
|station_name    |character |This is the railroad or subway station where the art is located. |
|line            |character |This is the railroad or subway line that is associated with the station. |
|artist          |character |The artist’s name(s). |
|art_title       |character |This is the name of the piece of art. |
|art_date        |double    |This is the year the art was first displayed at the station. |
|art_material    |character |This describes what materials were used in making the art. |
|art_description |character |This is a description of the art along with other interesting facts. |
|art_image_link  |character |This is a link that can take you directly to the MTA website so you may see the available art. |

### `station_lines.csv`

|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|agency       |character |This is the abbreviated code for an agency. Example: LIRR = Long Island Rail Road, MNR = Metro-North Railroad, NYCT = New York City Transit. |
|station_name |character |This is the railroad or subway station where the art is located. |
|line         |character |This is the railroad or subway line that is associated with the station. |

## Cleaning Script

```r
# Clean data provided by the State of New York's data.ny.gov. No cleaning was
# necessary. We split off the station_lines dataset as a demonstration.

library(tidyverse)
mta_art <- readr::read_csv("https://data.ny.gov/resource/4y8j-9pkd.csv")

station_lines <- mta_art |>
  dplyr::select("agency", "station_name", "line") |>
  dplyr::filter(!is.na(.data$line)) |>
  tidyr::separate_longer_delim("line", ",")

```
