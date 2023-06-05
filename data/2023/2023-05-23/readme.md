### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics
for `#TidyTuesday`.

Twitter provides
[guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions)
for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an
[article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81)
on writing *good* alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> \### Chart type It's helpful for people with partial sight to know
> what chart type it is and gives context for understanding the rest of
> the visual. Example: Line graph \### Type of data What data is
> included in the chart? The x and y axis labels may help you figure
> this out. Example: number of bananas sold per day in the last year
> \### Reason for including the chart Think about why you're including
> this visual. What does it show that's meaningful. There should be a
> point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales \### Link to data or
> source Don't include this in your alt text, but it should be included
> somewhere in the surrounding text. People should be able to click on a
> link to view the source data or dig further into the visual. This
> provides transparency about your source and lets people explore the
> data. Example: Data from the USDA

Penn State has an
[article](https://accessibility.psu.edu/images/charts/) on writing alt
text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users.
> But since they are images, these media provide serious accessibility
> issues to colorblind users and users of screen readers. See the
> [examples on this page](https://accessibility.psu.edu/images/charts/)
> for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post
tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with
alt text programatically.

Need a **reminder**? There are
[extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related)
that force you to remember to add Alt Text to Tweets with media.

# Central Park Squirrel Census

Squirrel data! The data this week comes from the [2018 Central Park Squirrel Census](https://data.cityofnewyork.us/Environment/2018-Central-Park-Squirrel-Census-Squirrel-Data/vfnx-vebw).

> [The Squirrel Census](https://www.thesquirrelcensus.com/) is a multimedia science, design, and storytelling project focusing on the Eastern gray (Sciurus carolinensis). They count squirrels and present their findings to the public. The dataset contains squirrel data for each of the 3,023 sightings, including location coordinates, age, primary and secondary fur color, elevation, activities, communications, and interactions between squirrels and with humans.



### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-05-23')
tuesdata <- tidytuesdayR::tt_load(2023, week = 21)

squirrel_data <- tuesdata$squirrel_data

# Or read in the data manually

squirrel_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-23/squirrel_data.csv')

```

### Data Dictionary

# `squirrel_data.csv`

|variable                                   |class     |description                                |
|:------------------------------------------|:---------|:------------------------------------------|
|X                                          |double    |Longitude coordinate for squirrel sighting point                                          |
|Y                                          |double    |Latitude coordinate for squirrel sighting point                                          |
|Unique Squirrel ID                         |character |Identification tag for each squirrel sightings. The tag is comprised of "Hectare ID" + "Shift" + "Date" + "Hectare Squirrel Number."                        |
|Hectare                                    |character |ID tag, which is derived from the hectare grid used to divide and count the park area. One axis that runs predominantly north-to-south is numerical (1-42), and the axis that runs predominantly east-to-west is roman characters (A-I).                                    |
|Shift                                      |character |Value is either "AM" or "PM," to communicate whether or not the sighting session occurred in the morning or late afternoon.                                      |
|Date                                       |double    |Concatenation of the sighting session day and month.                                       |
|Hectare Squirrel Number                    |double    |Number within the chronological sequence of squirrel sightings for a discrete sighting session.                    |
|Age                                        |character |Value is either "Adult" or "Juvenile."                                        |
|Primary Fur Color                          |character |Primary Fur Color - value is either "Gray," "Cinnamon" or "Black."                          |
|Highlight Fur Color                        |character |Discrete value or string values comprised of "Gray," "Cinnamon" or "Black."                        |
|Combination of Primary and Highlight Color |character |A combination of the previous two columns; this column gives the total permutations of primary and highlight colors observed. |
|Color notes                                |character |Sighters occasionally added commentary on the squirrel fur conditions. These notes are provided here.                                |
|Location                                   |character |Value is either "Ground Plane" or "Above Ground." Sighters were instructed to indicate the location of where the squirrel was when first sighted.                                 |
|Above Ground Sighter Measurement           |character |For squirrel sightings on the ground plane, fields were populated with a value of "FALSE."          |
|Specific Location                          |character |Sighters occasionally added commentary on the squirrel location. These notes are provided here.                         |
|Running                                    |logical   |Squirrel was seen running.                                   |
|Chasing                                    |logical   |Squirrel was seen chasing another squirrel.                                 |
|Climbing                                   |logical   |Squirrel was seen climbing a tree or other environmental landmark.                                  |
|Eating                                     |logical   |Squirrel was seen eating.                                    |
|Foraging                                   |logical   |Squirrel was seen foraging for food.                                  |
|Other Activities                           |character |Other activities squirrels were observed doing.                           |
|Kuks                                       |logical   |Squirrel was heard kukking, a chirpy vocal communication used for a variety of reasons.                                       |
|Quaas                                      |logical   |Squirrel was heard quaaing, an elongated vocal communication which can indicate the presence of a ground predator such as a dog.                                      |
|Moans                                      |logical   |Squirrel was heard moaning, a high-pitched vocal communication which can indicate the presence of an air predator such as a hawk.                                     |
|Tail flags                                 |logical   |Squirrel was seen flagging its tail. Flagging is a whipping motion used to exaggerate squirrel's size and confuse rivals or predators. Looks as if the squirrel is scribbling with tail into the air.                                 |
|Tail twitches                              |logical   |Squirrel was seen twitching its tail. Looks like a wave running through the tail, like a breakdancer doing the arm wave. Often used to communicate interest, curiosity.                              |
|Approaches                                 |logical   |Squirrel was seen approaching human, seeking food.                                 |
|Indifferent                                |logical   |Squirrel was indifferent to human presence.                               |
|Runs from                                  |logical   |Squirrel was seen running from humans, seeing them as a threat.                                 |
|Other Interactions                         |character |Sighter notes on other types of interactions between squirrels and humans.                         |
|Lat/Long                                   |character |Latitude and longitude                                  |

### Cleaning Script

No data cleaning
