# Trash Wheel Collection Data

This week's data is [Trash Wheel Collection Data](https://docs.google.com/spreadsheets/d/1b8Lbe-z3PNb3H8nSsSjrwK2B0ReAblL2/edit#gid=1143432795) from the [Mr. Trash Wheel](https://www.mrtrashwheel.com/) [Baltimore Healthy Harbor](https://www.waterfrontpartnership.org/healthy-harbor-initiative) initiative.

> Mr. Trash Wheel is a semi-autonomous trash interceptor that is placed at the end of a river, stream or other outfall. Far too lazy to chase trash around the ocean, Mr. Trash Wheel stays put and waits for the waste to flow to him. Sustainably powered and built to withstand the biggest storms, Mr. Trash Wheel uses a unique blend of solar and hydro power to pull hundreds of tons of trash out of the water each year.

The Healthy Harbor initiative has four Trash Wheels collecting trash. Mr. Trash Wheel was the first to start, and since then three more have joined the family. The Trash Wheel Family has collected more than 2,362 tons of trash. See more about [how Mr. Trash Wheel works](https://www.mrtrashwheel.com/technology/).

>Data collection methodology

>1. When crew members are on the machine during the time when a dumpster is being filled, they will manually count the number of each of the item types listed on a single conveyor paddle. This process is repeated several times during the dumpster filling process. An average is then calculated for number of each item per paddle. The average is then multiplied by the paddle rate and then by the elapsed time to fill the dumpster.

>Example:
> * Paddle #1- 9 plastic bottles
> * Paddle #2- 14 plastic bottles
> * Paddle #3- 5 plastic bottles
> * Paddle #4- 12 plastic bottles
> * Average = 10 plastic bottles/paddle

>Conveyor speed = 2.5 paddles per minute therefore an average of 25 plastic bottles are loaded each minute. If it takes 100 minutes to fill the dumpster, we estimate that there are 2,500 bottles in that dumpster.

>2. If no crew is present during the loading, we will take random bushel size samples of the collected material and count items in these samples. A full dumpster contains approximately 325 bushels. Therefore, if an average bushel sample from a dumpster contains 3 polystyrene containers, we estimate that the dumpster contains 975 polystyrene containers.

>3. Periodically “dumpster dives” are held where volunteers count everything in an entire dumpster. These events help validate our sampling methods and also look at what materials are dumpster. present that are not included in our sampling categories.

What type of trash is collected the most? Do the different Trash Wheels collect different sets of trash? Are there times of the year when more or less trash is collected? 

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-03-05')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 10)

trashwheel <- tuesdata$trashwheel


# Option 2: Read directly from GitHub

trashwheel <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-05/trashwheel.csv')

```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `trashwheel.csv`

|variable       |class     |description    |
|:--------------|:---------|:--------------|
|ID             |character |Short name for the Trash Wheel             |
|Name           |character |Name of the Trash Wheel           |
|Dumpster       |double    |Dumpster number       |
|Month          |character |Month          |
|Year           |double    |Year           |
|Date           |character |Date           |
|Weight         |double    |Weight in tons         |
|Volume         |double    |Volume in cubic yards          |
|PlasticBottles |double    |Number of plastic bottles |
|Polystyrene    |double    |Number of polystyrene items    |
|CigaretteButts |double    |Number of cigarette butts |
|GlassBottles   |double    |Number of glass bottles   |
|PlasticBags    |double    |Number of plastic bags    |
|Wrappers       |double    |Number of wrappers       |
|SportsBalls    |double    |Number of sports balls    |
|HomesPowered   |double    |Homes Powered - Each ton of trash equates to on average 500 kilowatts of electricity.  An average household will use 30 kilowatts per day.   |


### Cleaning Script

``` r
library(tidyverse)
library(here)

working_dir <- here::here("data", "2024", "2024-03-05")

# Download the csv files from https://docs.google.com/spreadsheets/d/1b8Lbe-z3PNb3H8nSsSjrwK2B0ReAblL2/edit#gid=1143432795

mrtrash <- read_csv("mrtrashwheel.csv")
professortrash <- read_csv("professortrash.csv")
captaintrash <- read_csv("captaintrash.csv")
gwynndatrash <- read_csv("gwynndatrash.csv")


# Check the files
glimpse(mrtrash)
glimpse(professortrash)
glimpse(captaintrash)
glimpse(gwynndatrash)

# Remove empty rows and columns

mrtrash <- head(mrtrash, -1)
mrtrash <- mrtrash[-c(15:16)]
professortrash <- head(professortrash, -1)
captaintrash <- head(captaintrash, -1)
gwynndatrash <- head(gwynnda, -1)

# Rename columns so they don't have spaces

colnames(mrtrash)

mrtrash <- mrtrash %>% 
  rename(
    Weight = "Weight (tons)",
    Volume = "Volume (cubic yards)",
    PlasticBottles = "Plastic Bottles",
    CigaretteButts = "Cigarette Butts",
    GlassBottles = "Glass Bottles",
    PlasticBags = "Plastic Bags",
    SportsBalls = "Sports Balls",
    HomesPowered = "Homes Powered*"
  )

colnames(professortrash)

professortrash <- professortrash %>% 
  rename(
    Weight = "Weight (tons)",
    Volume = "Volume (cubic yards)",
    PlasticBottles = "Plastic Bottles",
    CigaretteButts = "Cigarette Butts",
    GlassBottles = "Glass Bottles",
    PlasticBags = "Plastic Bags",
    HomesPowered = "Homes Powered*"
  )

colnames(captaintrash)

captaintrash <- captaintrash %>% 
  rename(
    Weight = "Weight (tons)",
    Volume = "Volume (cubic yards)",
    PlasticBottles = "Plastic Bottles",
    CigaretteButts = "Cigarette Butts",
    PlasticBags = "Plastic Bags",
    HomesPowered = "Homes Powered*"
  )

colnames(gwynndatrash)

gwynndatrash <- gwynndatrash %>% 
  rename(
    Weight = "Weight (tons)",
    Volume = "Volume (cubic yards)",
    PlasticBottles = "Plastic Bottles",
    CigaretteButts = "Cigarette Butts",
    PlasticBags = "Plastic Bags",
    HomesPowered = "Homes Powered*"
  )

# Add a column with the name of the trash wheel, and columns with "NA" where the dataset doesn't have that information

mrtrash <- data.frame(ID = "mister", Name = "Mister Trash Wheel", mrtrash)

# Add SportsBalls to professor
professortrash <- data.frame(ID = "professor", Name = "Professor Trash Wheel", SportsBalls = NA, professortrash)

# Add SportsBalls and GlassBottles to captain and gwynnda
captaintrash <- data.frame(ID = "captain", Name = "Captain Trash Wheel", SportsBalls = NA, GlassBottles = NA, captaintrash)
gwynndatrash <- data.frame(ID = "gwynnda", Name = "Gwynnda Trash Wheel", SportsBalls = NA, GlassBottles = NA, gwynndatrash)

# Join the dataframes together

trashwheel <- rbind(mrtrash, professortrash, captaintrash, gwynndatrash)



readr::write_csv(
  trashwheel,
  fs::path(working_dir, "trashwheel.csv")
)
```
