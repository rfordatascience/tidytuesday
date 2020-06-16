![Large brewing kettles](https://images.unsplash.com/photo-1559526642-c3f001ea68ee?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80)

# Beer Production

The data this week comes from the [Alcohol and Tobacco Tax and Trade Bureau (TTB)](https://www.ttb.gov/beer/statistics). H/t to [Bart Watson](https://twitter.com/brewersstats?lang=en) for sharing the source of the data.

There's a literal treasure trove of data here:
- State-level beer production by year (2008-2019)
- Number of brewers by production size by year (2008-2019)
- Monthly beer stats aggregated across the US (2008-2019)

Some considerations:
- A barrel of beer for this data is 31 gallons
- Most data is in barrels removed/taxed or produced
- Removals = "Total barrels removed subject to tax by the breweries comprising the named strata of data", essentially how much was produced and removed for consumption.
- A LOT of data came from PDFs - I included all the code I used to grab data and tidy it up, take a peek and try out your own mechanism for getting the tables out.

Massive shoutout to [`pdftools`](https://docs.ropensci.org/pdftools/) by ROpenSci and [`stringr`](https://stringr.tidyverse.org/index.html) for doing a lot of heavy lifting with the datacleaning and prep here.


### Get the data here

```{r}
# Get the Data

brewing_materials <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/brewing_materials.csv')
beer_taxed <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/beer_taxed.csv')
brewer_size <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/brewer_size.csv')
beer_states <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/beer_states.csv')

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO USE tidytuesdayR version ? from GitHub

# Either ISO-8601 date or year/week works!

# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-03-31')
tuesdata <- tidytuesdayR::tt_load(2020, week = 14)


brewing_materials <- tuesdata$brewing_materials
```
### Data Dictionary

# `brewing_materials.csv`

|variable         |class     |description |
|:----------------|:---------|:-----------|
|data_type        |character | Pounds of Material - this is a sub-table from beer_taxed|
|material_type    |character | Grain product, Totals, Non-Grain Product (basically hops vs grains)|
|year             |double    | Year |
|month            |integer   | Month |
|type             |character | Actual line-item from material type |
|month_current    |double    | Current number of barrels for this year/month |
|month_prior_year |double    | Prior year number of barrels for same month |
|ytd_current      |double    | Cumulative year to date of current year |
|ytd_prior_year   |double    | Cumulative year to date for prior year |

# `beer_states.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|state    |character | State abbreviated |
|year     |integer   | Year |
|barrels  |double    | Barrels produced within each type |
|type     |character | Type of production/use (On premise, Bottles/Cans, Kegs/Barrels) |

# `beer_taxed.csv`

|variable         |class     |description |
|:----------------|:---------|:-----------|
|data_type        |character | Barrels Produced |
|tax_status       |character | The Tax Status, factor with Totals, Taxable, Sub Total Taxable, Tax Free, Sub Total Tax-Free|
|year             |double    | Year |
|month            |integer   | Month |
|type             |character | Type of production, either Total Production (Production) or specific sub-category and sub-totals |
|month_current    |double    | Current number of barrels for this year/month |
|month_prior_year |double    | Prior year number of barrels for same month |
|ytd_current      |double    | Cumulative year to date of current year |
|ytd_prior_year   |double    | Cumulative year to date for prior year |

# `brewer_size.csv`

|variable         |class     |description |
|:----------------|:---------|:-----------|
|year             |integer   | Year  |
|brewer_size      |character | Range of production for brewer size, number of barrels produced |
|n_of_brewers     |double    | Number of brewers at that brewer size |
|total_barrels    |double    | Total barrels of beer produced at that brewer size |
|taxable_removals |double    | Taxable barrels for removals - removals for consumption under taxation |
|total_shipped    |double    | Total barrels shipped - produced beer that is not taxed |

### Cleaning Script

Please see download script via [`download_beer.R`](download_beer.R)

Please see cleaning scripts via [`scrape_beers.R`](scrape_beers.R)