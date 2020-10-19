![GABF Logo](https://i2.wp.com/thebeertravelguide.com/wp-content/uploads/2018/07/Great-American-Beer-Festival-Logo.jpg?ssl=1)

# Beer Awards

The data this week comes from [Great American Beer Festival](https://www.greatamericanbeerfestival.com/the-competition/winners/).

> The Professional Judge Panel awards gold, silver or bronze medals that are recognized around the world as symbols of brewing excellence. These awards are among the most coveted in the industry and heralded by the winning brewers in their national advertising.
> 
> Five different three-hour judging sessions take place over the three-day period during the week of the festival. Judges are assigned beers to evaluate in their specific area of expertise and never judge their own product or any product in which they have a concern.

[Best States for Beer](https://beerconnoisseur.com/articles/all-50-states-ranked-beer)

[2018 GABF Medal Winner Analysis](https://www.brewersassociation.org/insights/2018-gabf-medal-winners-analyzed/)
[2019 GABF Medal Winner Analysis](https://www.brewersassociation.org/insights/gabf-medal-winners-analyzed-2019-edition/)


NOTE - There are a few missing data points unfortunately

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-10-20')
tuesdata <- tidytuesdayR::tt_load(2020, week = 43)

beer_awards <- tuesdata$beer_awards

# Or read in the data manually

beer_awards <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-10-20/beer_awards.csv')

```
### Data Dictionary

# `beer_awards.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|medal     |character | Medal awarded (Gold, Silver, Bronze) |
|beer_name |character | Beer Name |
|brewery   |character | Brewery Name |
|city      |character | City of Brewery |
|state     |character | State of Brewery |
|category  |character | Category for beer award |
|year      |character | Year of Competition |

### Cleaning Script

No cleaning script listed today.