![Sabancaya volcano erupting, Peru in 2017](https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Erupci%C3%B3n_en_el_volc%C3%A1n_Sabancaya%2C_Per%C3%BA.jpg/1280px-Erupci%C3%B3n_en_el_volc%C3%A1n_Sabancaya%2C_Per%C3%BA.jpg)
# Volcano Eruptions

The data this week comes from [The Smithsonian Institution](https://volcano.si.edu/).

[Axios](https://www.axios.com/chart-every-volcano-that-erupted-since-krakatoa-467da621-41ba-4efc-99c6-34ff3cb27709.html) put together a lovely  plot of volcano eruptions since Krakatoa (after 1883) by elevation and type. 

For more information about volcanoes check out the below Wikipedia article or specifically about VEI (Volcano Explosivity Index) see the Wikipedia article [here](https://en.wikipedia.org/wiki/Volcanic_Explosivity_Index). Lastly, [Google Earth](https://earth.google.com/web/@8.53508511,-2.91442364,-23163.5821626a,31750897.4603d,35y,0h,0t,0r/data=Ci4SLBIgZmU2MjU5Y2E0Y2FiMTFlODgxOGM3MTM3ODRlMDYzMjMiCGxheWVyc18w) has an interactive site on "10,000 Years of Volcanoes"!

Per [Wikipedia](https://en.wikipedia.org/wiki/Volcano):

> A volcano is a rupture in the crust of a planetary-mass object, such as Earth, that allows hot lava, volcanic ash, and gases to escape from a magma chamber below the surface.
>
> Earth's volcanoes occur because its crust is broken into 17 major, rigid tectonic plates that float on a hotter, softer layer in its mantle. Therefore, on Earth, volcanoes are generally found where tectonic plates are diverging or converging, and most are found underwater. 

> Erupting volcanoes can pose many hazards, not only in the immediate vicinity of the eruption. One such hazard is that volcanic ash can be a threat to aircraft, in particular those with jet engines where ash particles can be melted by the high operating temperature; the melted particles then adhere to the turbine blades and alter their shape, disrupting the operation of the turbine. Large eruptions can affect temperature as ash and droplets of sulfuric acid obscure the sun and cool the Earth's lower atmosphere (or troposphere); however, they also absorb heat radiated from the Earth, thereby warming the upper atmosphere (or stratosphere). Historically, volcanic winters have caused catastrophic famines.

### VEI

[Volcano Explosivity Index:](https://en.wikipedia.org/wiki/Volcanic_Explosivity_Index)

<p align="left">
  <img width="342" height="414" src="https://upload.wikimedia.org/wikipedia/commons/0/01/VEIfigure_en.svg">
</p>

Volcano eruptions also can affect the global climate, a [Nature Article](https://www.nature.com/articles/nature14565#Sec26) has open-access data for a specific time-period of eruptions along with temperature anomolies and tree growth. More details can be found from [NASA](https://earthdata.nasa.gov/learn/sensing-our-planet/volcanoes-and-climate-change) and the [UCAR](https://scied.ucar.edu/shortcontent/how-volcanoes-influence-climate). A summary of the pay-walled Nature article can be found via the [Smithsonian](https://www.smithsonianmag.com/science-nature/sixth-century-misery-tied-not-one-two-volcanic-eruptions-180955858/)

>The researchers detected 238 eruptions from the past 2,500 years, they report today in Nature. About half were in the mid- to high-latitudes in the northern hemisphere, while 81 were in the tropics. (Because of the rotation of the Earth, material from tropical volcanoes ends up in both Greenland and Antarctica, while material from northern volcanoes tends to stay in the north.) The exact sources of most of the eruptions are as yet unknown, but the team was able to match their effects on climate to the tree ring records.
> 
> The analysis not only reinforces evidence that volcanoes can have long-lasting global effects, but it also fleshes out historical accounts, including what happened in the sixth-century Roman Empire. The first eruption, in late 535 or early 536, injected large amounts of sulfate and ash into the atmosphere. According to historical accounts, the atmosphere had dimmed by March 536, and it stayed that way for another 18 months.
> 
> Tree rings, and people of the time, recorded cold temperatures in North America, Asia and Europe, where summer temperatures dropped by 2.9 to 4.5 degrees Fahrenheit below the average of the previous 30 years. Then, in 539 or 540, another volcano erupted. It spewed 10 percent more aerosols into the atmosphere than the huge eruption of Tambora in Indonesia in 1815, which caused the infamous "year without a summer". More misery ensued, including the famines and pandemics. The same eruptions may have even contributed to a decline in the Maya empire, the authors say. 

There are additional datasets from the [Nature article](https://www.nature.com/articles/nature14565#Sec26) available as Excel files, but they are a bit more complicated - feel free to explore at your own discretion! If you use any of the Nature data, please cite w/ DOI: https://doi.org/10.1038/nature14565.

### Get the data here

```{r}
# Get the Data

volcano <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2020/2020-05-12/volcano.csv')
eruptions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2020/2020-05-12/eruptions.csv')
events <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2020/2020-05-12/events.csv')
tree_rings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2020/2020-05-12/tree_rings.csv')
sulfur <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2020/2020-05-12/sulfur.csv')

# Or read in with tidytuesdayR package (https://github.com/dslc-io/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO USE tidytuesdayR version ? from GitHub

# Either ISO-8601 date or year/week works!

# Install via pak::pak("dslc-io/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-05-12')
tuesdata <- tidytuesdayR::tt_load(2020, week = 20)


volcano <- tuesdata$volcano
```
### Data Dictionary

# `volcano.csv`

|variable                 |class     |description |
|:------------------------|:---------|:-----------|
|volcano_number           |double    | Volcano unique ID |
|volcano_name             |character | Volcano name |
|primary_volcano_type     |character | Volcano type (see wikipedia above for full details) |
|last_eruption_year       |character | Last year erupted |
|country                  |character | Country |
|region                   |character | Region |
|subregion                |character | Sub region|
|latitude                 |double    | Latitude|
|longitude                |double    | Longitude|
|elevation                |double    | Elevation |
|tectonic_settings        |character | Plate tectonic settings (subduction, intraplate, rift zone) + crust |
|evidence_category        |character | Type of evidence |
|major_rock_1             |character | Major rock type |
|major_rock_2             |character |Major rock type |
|major_rock_3             |character |Major rock type |
|major_rock_4             |character |Major rock type |
|major_rock_5             |character |Major rock type |
|minor_rock_1             |character |Minor rock type |
|minor_rock_2             |character |Major rock type |
|minor_rock_3             |character |Minor rock type|
|minor_rock_4             |character |Minor rock type|
|minor_rock_5             |character |Minor rock type|
|population_within_5_km   |double    | Total population within 5 km of volcano|
|population_within_10_km  |double    | Total population within 10 km of volcano|
|population_within_30_km  |double    |Total population within 30 km of volcano|
|population_within_100_km |double    |Total population within 100 km of volcano|

# `eruptions.csv`

|variable               |class     |description |
|:----------------------|:---------|:-----------|
|volcano_number         |double    | Volcano unique ID|
|volcano_name           |character | Volcano name |
|eruption_number        |double    | Eruption number |
|eruption_category      |character | Type of eruption |
|area_of_activity       |character | Area of activity |
|vei                    |double    | Volcano Explosivity Index (0-8) see wikipedia above |
|start_year             |double    | Start year |
|start_month            |double    | Start month |
|start_day              |double    | Start day|
|evidence_method_dating |character | Evidence for dating volcano eruption |
|end_year               |double    | End year|
|end_month              |double    | End Month|
|end_day                |double    | End day|
|latitude               |double    | Latitude |
|longitude              |double    | Longitude|

# `events.csv`

|variable            |class     |description |
|:-------------------|:---------|:-----------|
|volcano_number      |double    | Volcano Unique ID |
|volcano_name        |character | Volcano name |
|eruption_number     |double    | Eruption number|
|eruption_start_year |double    | Eruption start year |
|event_number        |double    | Event number |
|event_type          |character | Event type |
|event_remarks       |character | Event remarks |
|event_date_year     |double    | Event year |
|event_date_month    |double    | Event month |
|event_date_day      |double    | Event day |

# `tree_rings.csv`

|variable          |class   |description |
|:-----------------|:-------|:-----------|
|year              |integer | Year of observation CE |
|n_tree            |double  | Tree ring z-scores relative to year = 1000-1099 (a [z-score](https://en.wikipedia.org/wiki/Standard_score) is a measure of variability from the mean - either positive or negative) |
|europe_temp_index |double  | Pages 2K Temperature for Europe in Celsius relative to 1961 to 1990 |


# `sulfur.csv`

|variable |class  |description |
|:--------|:------|:-----------|
|year     |double | Year w/ decimal CE|
|neem     |double | Sulfur detected in ng/g from NEEM - ice cores from Greenland, data collected from melting ice cores, data range was 500 to 705 CE |
|wdc      |double | Sulfur detected in ng/g from WDC - ice cores from Antartica, data collected from melting ice cores, data range was 500 to 705 CE |

### Cleaning Script

```{r}
library(readxl)
library(tidyverse)

eruption_list <- read_csv("2020/2020-05-12/eruption_list.csv", skip = 1) %>% 
  janitor::clean_names() %>% 
  select(-contains("modifier"), -contains("uncertainty"))

event_list <- read_csv("2020/2020-05-12/event_list.csv", skip = 1) %>% 
  janitor::clean_names() %>% 
  select(-contains("modifier"), -contains("uncertainty"))

volcano_list <- read_csv("2020/2020-05-12/volcano_list.csv", skip = 1) %>% 
  janitor::clean_names()

eruption_list %>% 
  write_csv("2020/2020-05-12/eruptions.csv")

event_list %>% 
  write_csv("2020/2020-05-12/events.csv")

volcano_list %>% 
  write_csv("2020/2020-05-12/volcano.csv")
```
