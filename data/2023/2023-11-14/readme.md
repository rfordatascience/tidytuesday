# Diwali Sales Data

This week is Diwali, the festival of lights! The data this week comes from [sales data](https://www.kaggle.com/datasets/saadharoon27/diwali-sales-dataset) for a retail store during the Diwali festival period in India. The data is shared on Kaggle by Saad Haroon.

This week we're sharing Python data analysis examples! There's a few out there, but these ones from [Brushan Shelke](https://www.kaggle.com/code/bhushanshelke69/diwali-data-exploration) or [Vikas Vachheta](https://github.com/vikasvachheta08/Diwali_Sales_Analysis_Using_Python) (see the Diwali_Sales_Analysis.ipynb file for the code) are some data exploration analyses.


## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-11-14')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 46)

house <- tuesdata$diwali_sales_data

# Option 2: Read directly from GitHub

house <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-14/diwali_sales_data.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.


### Data Dictionary

# `diwali_sales_data.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
|User_ID          |double    |User identification number        |
|Cust_name        |character |Customer name        |
|Product_ID       |character |Product identification number    |
|Gender           |character |Gender of the customer (e.g. Male, Female)           |
|Age Group        |character |Age group of the customer        |
|Age              |double    |Age of the customer             |
|Marital_Status   |double    |Marital status of the customer (e.g. Married, Single)   |
|State            |character |State of the customer           |
|Zone             |character |Geographic zone of the customer             |
|Occupation       |character |Occupation of the customer       |
|Product_Category |character |Category of the product |
|Orders           |double    |Number of orders made by the customer           |
|Amount           |double    |Amount in Indian rupees spent by the customer           |

### Cleaning Script

Data was downloaded from [Kaggle](https://www.kaggle.com/datasets/saadharoon27/diwali-sales-dataset), and the `Status` and `unnamed1` columns removed. 

``` r
library(tidyverse)

diwali_sales_data <- read_csv("DiwaliSalesData.csv")

diwali_sales_data <- diwali_sales_data %>% select(!(c(Status, unnamed1)))

write_csv(diwali_sales_data, "diwali_sales_data.csv")
```

