# Seattle Pet Names

Seattle's open data portal has a dataset of registered pets [here](https://data.seattle.gov/Community/Seattle-Pet-Licenses/jguv-t9rb). While they don't include the sex or age of the animal, they were kind enough to leave in the license issue date, animal's name, species, breed, and zip code. This should open up some fun explorations!

h/t to [Jacqueline Nolis](https://twitter.com/skyetetra/status/1093737135847309312) for sharing this data!

A few articles examined the most popular pet names in 2018, one from [Seattle](https://seattle.curbed.com/2019/1/2/18165658/seattle-popular-pet-names-2018) specifically, and another from [Australia](https://www.countryliving.com/uk/wildlife/pets/a25302522/2018s-popular-pet-names-bella-luna-max/). 


## Get the data!

```
seattle_pets <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-26/seattle_pets.csv")
```

### Data Dictionary

|variable           |class     |description |
|:------------------|:---------|:-----------|
|license_issue_date | date | Date the animal was registered with Seattle           |
|license_number     | numeric | Unique license number          |
|animals_name       |character | Animal's name          |
|species            |character | Animal's species (dog, cat, goat, etc)           |
|primary_breed      |character | Primary breed of the animal          |
|secondary_breed    |character | Secondary breed if mixed          |
|zip_code           | numeric | Zip code animal registered under           |
