# US Spending on Kids

The data this week comes from [Urban Institute](https://datacatalog.urban.org/dataset/state-state-spending-kids-dataset) courtesy of [Joshua Rosenberg](https://twitter.com/jrosenberg6432)'s [`tidykids`](https://jrosen48.github.io/tidykids/index.html) package.

Per the Urban Institute: 

> This dataset provides a comprehensive accounting of public spending on children from 1997 through 2016. It draws on the US Census Bureau’s Annual Survey of State and Local Government Finances, as well as several federal and other noncensus sources, to capture state-by-state spending on education, income security, health, and other areas. The data were assembled by Julia Isaacs, Eleanor Lauderback, and Erica Greenberg of the Urban Institute, working in collaboration with Margot Jackson of Brown University for her study of public spending on children and class gaps in child development. This work has been supported (in part) by grant #83-18-23 from the Russell Sage Foundation and (in part) by the Eunice Kennedy Shriver National Institute of Child Health and Human Development of the National Institutes of Health under award #R03HD097421. The content is solely the responsibility of the authors and does not necessarily represent the official views of the foundation or National Institutes of Health.

They provide a raw Excel file, which Joshua cleaned for us into a tidy dataset.

Note you can access this data via `tidytuesdayR` or via `tidykids:tidykids`

Another short article on Education Spending at [Governing.com](https://www.governing.com/gov-data/education-data/state-education-spending-per-pupil-data.html).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-09-15')
tuesdata <- tidytuesdayR::tt_load(2020, week = 38)

kids <- tuesdata$kids

# Or read in the data manually

kids <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-15/kids.csv')

```
### Data Dictionary

# `kids.csv`

NOTE full variable codebook at: [`tidykids` pkgdown site](https://jrosen48.github.io/tidykids/articles/tidykids-codebook.html).

|variable         |class     |description |
|:----------------|:---------|:-----------|
|state            |character | United States state (and the District of Columbia) |
|variable         |character | Variable|
|year             |character | Year |
|raw              |double    |  The value of the variable; a numeric value|
|inf_adj          |double    | The value of the variable, adjusted for inflation, a numeric value |
|inf_adj_perchild |double    | The value of the variable adjusted for inflation, per child; a numeric value|

### Cleaning Script

No cleaning script!