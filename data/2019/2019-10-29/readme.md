# NYC Squirrel Census

This week's data is from the [NYC Squirrel Census](https://www.thesquirrelcensus.com/) - raw data at [NY Data portal](https://data.cityofnewyork.us/Environment/2018-Central-Park-Squirrel-Census-Squirrel-Data/vfnx-vebw).

H/t to [Sara Stoudt](https://twitter.com/sastoudt) for sharing this data, and [Mine Cetinkaya-Rundel](https://twitter.com/minebocek) for her [squirrel data package](https://github.com/mine-cetinkaya-rundel/nycsquirrels18) using the same data.

CityLab's [Linda Poon](https://twitter.com/linpoonsays) wrote an [article](https://www.citylab.com/life/2019/06/squirrel-census-results-population-central-park-nyc/592162/) using this data. 


# Get the data!

```
nyc_squirrels <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-29/nyc_squirrels.csv")
```

# Data Dictionary

## `nyc_squirrels.csv`

|variable                                   |class     |description |
|:---|:---|:-----------|
|long                                       |double    | Longitude|
|lat                                        |double    | Latitude|
|unique_squirrel_id                         |character | Identification tag for each squirrel sightings. The tag is comprised of "Hectare ID" + "Shift" + "Date" + "Hectare Squirrel Number." |
|hectare                                    |character | ID tag, which is derived from the hectare grid used to divide and count the park area. One axis that runs predominantly north-to-south is numerical (1-42), and the axis that runs predominantly east-to-west is roman characters (A-I).|
|shift                                      |character | Value is either "AM" or "PM," to communicate whether or not the sighting session occurred in the morning or late afternoon. |
|date                                       |double    | Concatenation of the sighting session day and month.|
|hectare_squirrel_number                    |double    | Number within the chronological sequence of squirrel sightings for a discrete sighting session.|
|age                                        |character | Value is either "Adult" or "Juvenile."|
|primary_fur_color                          |character | Value is either "Gray," "Cinnamon" or "Black."|
|highlight_fur_color                        |character | Discrete value or string values comprised of "Gray," "Cinnamon" or "Black."|
|combination_of_primary_and_highlight_color |character | A combination of the previous two columns; this column gives the total permutations of primary and highlight colors observed.|
|color_notes                                |character | Sighters occasionally added commentary on the squirrel fur conditions. These notes are provided here.|
|location                                   |character | Value is either "Ground Plane" or "Above Ground." Sighters were instructed to indicate the location of where the squirrel was when first sighted.|
|above_ground_sighter_measurement           |character | For squirrel sightings on the ground plane, fields were populated with a value of “FALSE.”|
|specific_location                          |character | Sighters occasionally added commentary on the squirrel location. These notes are provided here.|
|running                                    |logical   | Squirrel was seen running.|
|chasing                                    |logical   | Squirrel was seen chasing.|
|climbing                                   |logical   |  Squirrel was seen climbing.|
|eating                                     |logical   |  Squirrel was seen eating. |
|foraging                                   |logical   | Squirrel was seen foraging.|
|other_activities                           |character | Other activities   |
|kuks                                       |logical   | Squirrel was heard kukking, a chirpy vocal communication used for a variety of reasons.|
|quaas                                      |logical   | Squirrel was heard quaaing, an elongated vocal communication which can indicate the presence of a ground predator such as a dog.|
|moans                                      |logical   | Squirrel was heard moaning, a high-pitched vocal communication which can indicate the presence of an air predator such as a hawk.|
|tail_flags                                 |logical   | Squirrel was seen flagging its tail. Flagging is a whipping motion used to exaggerate squirrel's size and confuse rivals or predators. Looks as if the squirrel is scribbling with tail into the air.|
|tail_twitches                              |logical   | Squirrel was seen flagging its tail. Flagging is a whipping motion used to exaggerate squirrel's size and confuse rivals or predators. Looks as if the squirrel is scribbling with tail into the air.|
|approaches                                 |logical   | Squirrel was seen approaching human, seeking food.|
|indifferent                                |logical   | Squirrel was indifferent to human presence.|
|runs_from                                  |logical   |.Squirrel was seen running from humans, seeing them as a threat.|
|other_interactions                         |character | Sighter notes on other types of interactions between squirrels and humans.|
|lat_long                                   |character | Combined lat long|
|zip_codes                                  |double    | zip codes|
|community_districts                        |double    | Community districts|
|borough_boundaries                         |double    | Borough boundaries|
|city_council_districts                     |double    | City council districts|
|police_precincts                           |double    | Police precincts |
