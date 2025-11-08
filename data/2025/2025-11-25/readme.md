# Statistical Performance Indicators

The World Bank has developed Statistical Performance Indicators (SPI) to monitor the statistical performance of countries. The SPI focuses on five key dimensions of a country’s statistical performance: (i) data use, (ii) data services, (iii) data products, (iv) data sources, and (v) data infrastructure. This set of countries covers 99 percent of the world population. The data extend from 2016-2023, with some indicators going back to 2004.

> The purpose of the SPI is to help countries assess and improve the performance of their statistical systems.

In relation to these indicators, it should be noted that:

> Small differences between countries should not be highlighted since they can reflect imprecision arising from the currently available indicators rather than meaningful differences in performance.

* How has the statistical performance of a country changed over time?
* Is statistical performance related to a country's income level or population?
* Which pillar do countries score lowest in?

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-12-02')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 48)

spi_indicators <- tuesdata$spi_indicators

# Option 2: Read directly from GitHub

spi_indicators <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-02/spi_indicators.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-12-02')

# Option 2: Read directly from GitHub and assign to an object

spi_indicators = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-02/spi_indicators.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-12-02')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

spi_indicators = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-02/spi_indicators.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
spi_indicators = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-02/spi_indicators.csv", DataFrame)
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

### `spi_indicators.csv`

|variable                  |class     |description                           |
|:-------------------------|:---------|:-------------------------------------|
|iso3c                     |character |ISO3 country code. |
|country                   |character |Country name. |
|region                    |character |Region name. |
|income                    |character |Income level of country. |
|year                      |integer    |Year. |
|population                |double    |Population of the country. |
|overall_score             |double    |Overall statistical performance score. |
|data_use_score            |double    |Score relating to Pillar 1 - Data use. |
|data_services_score       |double    |Score relating to Pillar 2 - Data services. |
|data_products_score       |double    |Score relating to Pillar 3 - Data products. |
|data_sources_score        |double    |Score relating to Pillar 4 - Data sources. |
|data_infrastructure_score |double    |Score relating to Pillar 5 - Data infrastructure. |

## Cleaning Script

```r
library(tidyverse)

raw_data <- read_csv("https://datacatalogfiles.worldbank.org/ddh-published/0037996/8/DR0046108/SPI_index.csv")

spi_indicators <- raw_data |>
  select(
    iso3c, country, region, income, date, population,
    SPI.INDEX, starts_with("SPI.INDEX.")
  ) |>
  rename(
    year = date,
    overall_score = SPI.INDEX,
    data_use_score = SPI.INDEX.PIL1,
    data_services_score = SPI.INDEX.PIL2,
    data_products_score = SPI.INDEX.PIL3,
    data_sources_score = SPI.INDEX.PIL4,
    data_infrastructure_score = SPI.INDEX.PIL5
  )

```
