![IKEA logo](https://fivethirtyeight.com/wp-content/uploads/2016/10/ap_114334808154.jpg?w=575)

# IKEA Furniture

The data this week comes from [Kaggle](https://www.kaggle.com/ahmedkallam/ikea-sa-furniture-web-scraping). Original source on [IKEA](https://www.ikea.com/sa/en/cat/furniture-fu001/)

Article about Ikea from [FiveThirtyEight](https://fivethirtyeight.com/features/the-weird-economics-of-ikea/)

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-11-03')
tuesdata <- tidytuesdayR::tt_load(2020, week = 45)

ikea.csv <- tuesdata$ikea.csv

# Or read in the data manually

ikea <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-03/ikea.csv')

```
### Data Dictionary

# `ikea.csv`

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|item_id           |double    | item id wich can be used later to merge with other IKEA dataframes |
|name              |character | the commercial name of items |
|category          |character | the furniture category that the item belongs to (Sofas, beds, chairs, Trolleys,…) |
|price             |double    | the current price in Saudi Riyals as it is shown in the website by 4/20/2020 |
|old_price         |character | the price of item in Saudi Riyals before discount |
|sellable_online   |logical   | Sellable online TRUE or FALSE |
|link              |character | the web link of the item |
|other_colors      |character | if other colors are available for the item, or just one color as displayed in the website (Boolean) |
|short_description |character | a brief description of the item |
|designer          |character | The name of the designer who designed the item. this is extracted from the full_description column. |
|depth             |double    | Depth of the item in Centimeter |
|height            |double    | Height of the item in Centimeter|
|width             |double    | Width of the item in Centimeter|

### Cleaning Script

No cleaning today!