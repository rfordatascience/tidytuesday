# Carbon Majors Emissions Data

This week we're exploring historical emissions data from [Carbon Majors](https://carbonmajors.org/). They have complied a [database](https://carbonmajors.org/Downloads) of emissions data going back to 1854. h/t [Data is Plural](https://www.data-is-plural.com/archive/2024-05-15-edition/).

> Carbon Majors is a database of historical production data from 122 of the world’s largest oil, gas, coal, and cement producers. This data is used to quantify the direct operational emissions and emissions from the combustion of marketed products that can be attributed to these entities. These entities include:

> 75 Investor-owned Companies, 36 State-owned Companies, 11 Nation States, 82 Oil Producing Entities, 81 Gas Entities, 49 Coal Entities, 6 Cement Entities

> The data spans back to 1854 and contains over 1.42 trillion tonnes of CO2e covering 72% of global fossil fuel and cement emissions since the start of the Industrial Revolution in 1751.

They share data with low, medium and high levels of granularity. This dataset is the 'medium' granularity that contains year, entity, entity type, commodity, commodity production, commodity unit, and total emissions.

Are there any trends or changes that surprised you? 

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-05-21')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 21)

emissions <- tuesdata$emissions


# Option 2: Read directly from GitHub

emissions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-21/emissions.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `emissions.csv`

|variable               |class     |description            |
|:----------------------|:---------|:----------------------|
|year                   |double    |The year of the data point     |
|parent_entity          |character |The entity to whom the emissions are traced to          |
|parent_type            |character |The type of parent_entity. Can be one of: investor-owned company, state-owned entity, nation state.     |
|commodity              |character |Specifies which commodity the production refers to: Oil and NGL, Natural Gas, Anthracite Coal, Bituminous Coal, Lignite Coal, Metallurgical Coal, Sub-Bituminous Coal, Thermal Coal, or Cement.  |
|production_value       |double    |The quantity of production    |
|production_unit        |character |The unit of production (Oil & NGL - million barrels, Natural Gas - billion cubic feet, Coal - million tonnes, Cement - million tonnes CO2 (see methodology for explanation)). Units - Billion cubic feet per year (Bcf/yr), Million barrels per year (Million bbl/yr), or Million tonnes per year (Million tonnes/yr).  |
|total_emissions_MtCO2e |double    |The total emissions traced to
the 'parent_entity' in the 'year'. Units - million tonnes of carbon dioxide equivalent (MtCO2e). |



### Cleaning Script

No data cleaning. Dataset is emissions_medium_granularity.csv from [https://carbonmajors.org/Downloads](https://carbonmajors.org/Downloads).
