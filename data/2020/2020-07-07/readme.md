![Coffee beans - Mae Mu @picoftasty](https://images.unsplash.com/photo-1550681560-af9bc1cb339e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80)

# Coffee ratings

The data this week comes from [Coffee Quality Database](https://github.com/jldbc/coffee-quality-database) courtesy of Buzzfeed Data Scientist [James LeDoux](https://twitter.com/jmzledoux). The original data can be found on [James' github](https://github.com/jldbc/coffee-quality-database). The data was re-posted to [Kaggle](https://www.kaggle.com/volpatto/coffee-quality-database-from-cqi?select=merged_data_cleaned.csv). 

"These data were collected from the Coffee Quality Institute's review pages in January 2018."

[Thrillist](https://www.thrillist.com/drink/nation/the-world-s-best-coffee-growing-countries-ethiopia-kenya-colombia-and-more) has an article on the top coffee-producing countries.

[Yorgos Askalidis](https://towardsdatascience.com/the-data-speak-ethiopia-has-the-best-coffee-91f88ed37e84) analyzed this data as well.

There is data for both Arabica and Robusta beans, across many countries and professionally rated on a 0-100 scale. All sorts of scoring/ratings for things like acidity, sweetness, fragrance, balance, etc - may be useful for either separating into visualizations/categories or for modeling/recommenders.

[Wikipedia on Coffee Beans](https://en.wikipedia.org/wiki/Coffee_bean):  

> The two most economically important varieties of coffee plant are the Arabica and the Robusta; ~60% of the coffee produced worldwide is Arabica and ~40% is Robusta. Arabica beans consist of 0.8–1.4% caffeine and Robusta beans consist of 1.7–4% caffeine.

[Wiki on Cupping](https://en.wikipedia.org/wiki/Coffee_cupping)

> Coffee cupping, or coffee tasting, is the practice of observing the tastes and aromas of brewed coffee. It is a professional practice but can be done informally by anyone or by professionals known as "Q Graders". A standard coffee cupping procedure involves deeply sniffing the coffee, then loudly slurping the coffee so it spreads to the back of the tongue. The coffee taster attempts to measure aspects of the coffee's taste, specifically the body (the texture or mouthfeel, such as oiliness), sweetness, acidity (a sharp and tangy feeling, like when biting into an orange), flavour (the characters in the cup), and aftertaste. Since coffee beans embody telltale flavours from the region where they were grown, cuppers may attempt to identify the coffee's origin.

Importantly - there is the concept of ethical or [Fair Trade coffee](https://www.fairtradecertified.org/why-fair-trade) - we'll be covering more of the production numbers of Coffee in a future dataset.

> Based on the simple idea that the products bought and sold every day are connected to the livelihoods of others, fair trade is a way to make a conscious choice for a better world.

Fair Trade Coffee definition from [Wikipedia](https://en.wikipedia.org/wiki/Fair_trade_coffee):  

> Fair trade coffee is coffee that is certified as having been produced to fair trade standards by fair trade organizations, which create trading partnerships that are based on dialogue, transparency and respect, with the goal of achieving greater equity in international trade. These partnerships contribute to sustainable development by offering better trading conditions to coffee bean farmers. Fair trade organizations support producers and sustainable environmental farming practices and prohibit child labor or forced labor.

If you're looking to buy some coffee - check out this list of [12 Black-Owned Coffee Brands](https://www.refinery29.com/en-us/black-owned-coffee-brands#slide-1).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-07-07')
tuesdata <- tidytuesdayR::tt_load(2020, week = 28)

coffee_ratings <- tuesdata$coffee_ratings

# Or read in the data manually

coffee_ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-07/coffee_ratings.csv')

```
### Data Dictionary

# `coffee_ratings.csv`

Note full description/examples at: [Coffee Quality Institute](https://database.coffeeinstitute.org/coffee/357789/grade)

|variable              |class     |description |
|:---------------------|:---------|:-----------|
|total_cup_points      |double    | Total rating/points (0 - 100 scale) |
|species               |character | Species of coffee bean (arabica or robusta) |
|owner                 |character | Owner of the farm |
|country_of_origin     |character | Where the bean came from |
|farm_name             |character | Name of the farm |
|lot_number            |character | Lot number of the beans tested |
|mill                  |character | Mill where the beans were processed |
|ico_number            |character | International Coffee Organization number |
|company               |character | Company name |
|altitude              |character | Altitude - this is a messy column - I've left it for some cleaning  |
|region                |character | Region where bean came from |
|producer              |character | Producer of the roasted bean |
|number_of_bags        |double    | Number of bags tested |
|bag_weight            |character | Bag weight tested |
|in_country_partner    |character | Partner for the country |
|harvest_year          |character | When the beans were harvested (year) |
|grading_date          |character | When the beans were graded|
|owner_1               |character | Who owns the beans|
|variety               |character | Variety of the beans |
|processing_method     |character | Method for processing|
|aroma                 |double    | Aroma grade |
|flavor                |double    | Flavor grade |
|aftertaste            |double    | Aftertaste grade |
|acidity               |double    | Acidity grade |
|body                  |double    | Body grade |
|balance               |double    | Balance grade |
|uniformity            |double    | Uniformity grade |
|clean_cup             |double    | Clean cup grade |
|sweetness             |double    | Sweetness grade |
|cupper_points         |double    | Cupper Points|
|moisture              |double    | Moisture Grade|
|category_one_defects  |double    | Category one defects (count) |
|quakers               |double    | quakers|
|color                 |character | Color of bean |
|category_two_defects  |double    |Category two defects (count)  |
|expiration            |character | Expiration date of the beans |
|certification_body    |character | Who certified it |
|certification_address |character | Certification body address |
|certification_contact |character | Certification contact |
|unit_of_measurement   |character | Unit of measurement |
|altitude_low_meters   |double    | Altitude low meters|
|altitude_high_meters  |double    | Altitude high meters |
|altitude_mean_meters  |double    | Altitude mean meters |

### Cleaning Script

```{r}
library(tidyverse)

raw_arabica <- read_csv("https://raw.githubusercontent.com/jldbc/coffee-quality-database/master/data/arabica_data_cleaned.csv") %>% 
  janitor::clean_names()

raw_robusta <- read_csv("https://raw.githubusercontent.com/jldbc/coffee-quality-database/master/data/robusta_data_cleaned.csv",
                        col_types = cols(
                          X1 = col_double(),
                          Species = col_character(),
                          Owner = col_character(),
                          Country.of.Origin = col_character(),
                          Farm.Name = col_character(),
                          Lot.Number = col_character(),
                          Mill = col_character(),
                          ICO.Number = col_character(),
                          Company = col_character(),
                          Altitude = col_character(),
                          Region = col_character(),
                          Producer = col_character(),
                          Number.of.Bags = col_double(),
                          Bag.Weight = col_character(),
                          In.Country.Partner = col_character(),
                          Harvest.Year = col_character(),
                          Grading.Date = col_character(),
                          Owner.1 = col_character(),
                          Variety = col_character(),
                          Processing.Method = col_character(),
                          Fragrance...Aroma = col_double(),
                          Flavor = col_double(),
                          Aftertaste = col_double(),
                          Salt...Acid = col_double(),
                          Balance = col_double(),
                          Uniform.Cup = col_double(),
                          Clean.Cup = col_double(),
                          Bitter...Sweet = col_double(),
                          Cupper.Points = col_double(),
                          Total.Cup.Points = col_double(),
                          Moisture = col_double(),
                          Category.One.Defects = col_double(),
                          Quakers = col_double(),
                          Color = col_character(),
                          Category.Two.Defects = col_double(),
                          Expiration = col_character(),
                          Certification.Body = col_character(),
                          Certification.Address = col_character(),
                          Certification.Contact = col_character(),
                          unit_of_measurement = col_character(),
                          altitude_low_meters = col_double(),
                          altitude_high_meters = col_double(),
                          altitude_mean_meters = col_double()
                        )) %>% 
  janitor::clean_names() %>% 
  rename(acidity = salt_acid, sweetness = bitter_sweet,
         aroma = fragrance_aroma, body = mouthfeel,uniformity = uniform_cup)


all_ratings <- bind_rows(raw_arabica, raw_robusta) %>% 
  select(-x1) %>% 
  select(total_cup_points, species, everything())

all_ratings %>% 
  skimr::skim()

all_ratings %>% 
  write_csv("2020/2020-07-07/coffee_ratings.csv")
```