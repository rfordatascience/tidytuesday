# Adoptable dogs

This week’s data is from [The Pudding](https://github.com/the-pudding/data/blob/master/dog-shelters/README.md). The data was cleaned, collected and story written by [Amber Thomas](https://twitter.com/proquesasker), with design by [Sacha Maxim](https://twitter.com/sacha_maxim).

Their article [Finding Forever Homes](https://pudding.cool/2019/10/shelters/) examines data on all adoptable dogs from [Petfinder.com](https://www.petfinder.com/) in the USA on `2019-09-20`.

There are a number of datasets, where the `dog_travel` and `dog_descriptions` datasets can be joined via the common id column.

The premise of the story in Amber's own words:

> "If you’re looking to add a new furry friend to your family, you may be encouraged to “adopt not shop”. That is, to find a new dog at a local shelter or rescue organization rather than a pet store or breeder.
> 
> But where do adoptable dogs come from?"


```{r}
# Get the Data

dog_moves <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-17/dog_moves.csv')
dog_travel <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-17/dog_travel.csv')
dog_descriptions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-17/dog_descriptions.csv')

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)

# Either ISO-8601 date or year/week works!

# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2019-12-17') 
tuesdata <- tidytuesdayR::tt_load(2019, week = 51)


dog_moves <- tuesdata$dog_moves

```

# Dictionary

### `dog_moves.csv`

|variable |class     |description |
|:---|:---|:-----------|
|location |character | The full name of the US state or country|
|exported |double    | The number of adoptable dogs available in the US that originated in this location but were available for adoption in another location|
|imported |double    |The number of adoptable dogs available in this state that originated in a different location|
|total    |double    |The total number of adoptable dogs availabe in a given state. |
|inUS     |logical   |Whether or not a location is in the US or not. Here, US territories will return `FALSE`|

### `dog_travel.csv`

|variable      |class     |description |
|:---|:---|:-----------|
|id  |double    | The unique PetFinder identification number for each animal|
|contact_city  |character | The rescue/shelter's listed city |
|contact_state |character | The rescue/shelter's listed State |
|description   |character |The full description of each animal as entered by the rescue/shelter|
|found         |character | Where the animal was found. |
|manual        |character |. |
|remove        |logical   | Animal removed from location |
|still_there   |logical   | `TRUE`/`FALSE` - Whether the animal is still located in their origin location and will be transported to their final destination **after** adoption. |


### `dog_descriptions.csv`

|variable        |class     |description |
|:---|:---|:-----------|
|id    |double    |The unique PetFinder identification number for each animal. |
|org_id          |character |The unique identification number for each shelter or rescue. |
|url   |character |The URL for each animal's listing. |
|species         |character |Species of animal. |
|breed_primary   |character |The primary (assumed) breed assigned by the shelter or rescue. |
|breed_secondary |character |The secondary (assumed) breed assigned by the shelter or rescue. |
|breed_mixed     |logical   |Whether or not an animal is presumed to be mixed breed. |
|breed_unknown   |logical   |Whether or not the animal's breed is completely unknown. |
|color_primary   |character |The most prevalent color of an animal. |
|color_secondary |character |The second most prevalent color of an animal. |
|color_tertiary  |character |The third most prevalent color of an animal. |
|age   |character |The assumed age class of an animal (`Baby`, `Young`, `Adult`, or `Senior`). |
|sex   |character |The sex of an animal (`Female`, `Male`, or `Unknown`). |
|size  |character |The general size class of an animal (`Small`, `Medium`, `Large`, `Extra Large`). |
|coat  |character |Coat Length for each animal (`Curly`, `Hairless`, `Long`, `Medium`, `Short`, `Wire`). |
|fixed |logical   |Whether or not an animal has been spayed/neutered. |
|house_trained   |logical   |Whether or not an animal is trained to not go to the bathroom in the house. |
|declawed        |logical   |Whether or not the animal has had its dewclaws removed. |
|special_needs   |logical   | Whether or not the animal is considered to have special needs (this can be a long-term medical condition or particular temperament that requires extra care). |
|shots_current   |logical   |Whether or not the animal is up to date on all of their vaccines and other shots. |
|env_children    |logical   |Whether or not the animal is recommended for a home with children. |
|env_dogs        |logical   |Whether or not the animal is recommended for a home with other dogs. |
|env_cats        |logical   |Whether or not the animal is recommended for a home with cats. |
|name  |character |The animal’s name (as given by the shelter/rescue). |
|tags  |character |Any tags given to the dog by the shelter rescue (pipe `\|` separated). |
|photo |character |The URL to the animal’s primary photo. |
|status          |character |Whether the animal is `adoptable` or not. |
|posted          |character |The date that this animal was first listed on PetFinder . |
|contact_city    |character |The rescue/shelter’s listed city. |
|contact_state   |character |The rescue/shelter’s listed state. |
|contact_zip     |character |The rescue/shelter’s listed zip code. |
|contact_country |character |The rescue/shelter’s listed country. |
|stateQ          |character |The state abbreviation queried in the API to return this result . |
|accessed        |double    |The date that this data was acquired from the PetFinder API. |
|type  |character |The type of animal. |
|description     |character |The full description of an animal, as entered by the rescue or shelter. This is the only field returned by the V1 API. |


# Cleaning

All the code/cleaning can be found on [The Pudding Github](https://github.com/the-pudding/data/tree/master/dog-shelters).
