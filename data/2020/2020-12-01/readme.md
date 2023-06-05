![](https://images.thestar.com/9oIR9sHln01gWNL9lck-n_vISyA=/1086x815/smart/filters:cb(2700061000)/https://www.thestar.com/content/dam/thestar/opinion/commentary/2017/05/18/homeless-shelters-belong-in-all-communities/img1960.jpg)

# Toronto Shelters

The data this week comes from Sharla Gelfand's [`opendatatoronto`](https://github.com/sharlagelfand/opendatatoronto) R package. The site website has additional details and all sorts of great datasets.

[`opendatatoronto` package website](https://sharlagelfand.github.io/opendatatoronto/). Quick intro/vignette can also be found [here](https://sharlagelfand.github.io/opendatatoronto/articles/opendatatoronto.html).

Data originally sourced from [open.toronto.ca](https://open.toronto.ca/).

[Article](https://rabble.ca/blogs/bloggers/cathy-crowes-blog/2019/03/twitter-truth-torontos-homeless-emergency) around Homeless Shelters in Toronto.  

> In his response to "where will homeless people go (when the respite closes)?" Ross tweeted:
> 
> "Other respites will also work to accommodate. As respites, typically, see their highest usage in the winter months, we anticipate an easing of demand for respites with the warmer weather. Will be keeping a close watch, of course."

A list of places to donate to in Toronto:  
- [Foodbanks](https://www.blogto.com/eat_drink/2020/04/food-banks-toronto/)

- [Encampment Support Network Toronto](https://www.patreon.com/esntoronto) - ESN is an ad-hoc, volunteer-run network of neighbours building community and supporting people living in encampments in 6 locations throughout Toronto. Every day since the beginning of June 2020, outreach volunteers from the network visit encampments to deliver basic supplies, such as water and tents, ice, sleeping bags, fire safety equipment, and snacks, which the City of Toronto has consistently refused to provide (despite recommendations from Ontario's Chief Coroner to do so).

- [Toronto Tiny Shelters](https://ca.gofundme.com/f/toronto-tiny-shelters) - Khaleel Seivwright is a carpenter and raising money to build durable insulated tiny shelters for homeless people across Toronto who might be living outside this winter. 

Shelters from [Reddit post](https://www.reddit.com/r/toronto/comments/7ocm1t/list_of_homeless_shelters_that_accept_donations/)

- Covenant House - They're an incredible foundation that works with homeless youth. [http://www.covenanthousetoronto.ca/homeless-youth/Donate](http://www.covenanthousetoronto.ca/homeless-youth/Donate)  

- Eva's Initiatives for Homeless Youth - Same as above. Eva's is fantastic and runs shelters across the city. [http://www.evas.ca](http://www.evas.ca)  

- Red Door Family Shelter - They have two shelters, one for women fleeing domestic violence and also one for families. [https://www.reddoorshelter.ca](https://www.reddoorshelter.ca)  

- Na-Me-Res - Provides temporary, transitional and permanent housing to Aboriginal men experiencing homelessness. [https://www.canadahelps.org/en/charities/na-me-res-native-mens-residence/](https://www.canadahelps.org/en/charities/na-me-res-native-mens-residence/)  

- Sojourn House - They provide short-term emergency shelter to refugees. [http://www.sojournhouse.org/get-involved/donate/](http://www.sojournhouse.org/get-involved/donate/)  

- Bethlehem United Shelter - The only shelter in Toronto that allows for pets to accompany their owners into the shelter. The parent organization, Fred Victor, also runs a women's hostel. [http://www.fredvictor.org/bethlehem_united_shelter](http://www.fredvictor.org/bethlehem_united_shelter)  

- Christie-Ossington Neighbourhood Shelter - Provides overnight shelter and supports the well-being of 68 men each night in Toronto's West End who are homeless, street-oriented and facing mental health challenges, substance use issues, unemployment and other barriers to maintaining adequate housing. [https://www.conccommunity.org/shelter-housing-lansdowne/](https://www.conccommunity.org/shelter-housing-lansdowne/)  

- Horizons for Youth - Provides emergency accommodation for up to 45 youth each night. They also have a lot of additional programs for homeless youth. [https://horizonsforyouth.org](https://horizonsforyouth.org)  

- Youth Without Shelter - Offers emergency accommodation for up to 33 youth each night and, like above, also provide additional support to homeless youth. [http://www.yws.on.ca](http://www.yws.on.ca)  

- YMCA Housing - Like the two above, it provides support for homeless youth. [https://ymcagta.org/youth-programs/youth-housing](https://ymcagta.org/youth-programs/youth-housing)  

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-12-01')
tuesdata <- tidytuesdayR::tt_load(2020, week = 49)

shelters <- tuesdata$shelters

# Or read in the data manually

shelters <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-12-01/shelters.csv')

```
### Data Dictionary

# `shelters.csv`

|variable            |class     |description |
|:-------------------|:---------|:-----------|
|id                  |integer   |.           |
|occupancy_date      |character |.           |
|organization_name   |character |.           |
|shelter_name        |character |.           |
|shelter_address     |character |.           |
|shelter_city        |character |.           |
|shelter_province    |character |.           |
|shelter_postal_code |character |.           |
|facility_name       |character |.           |
|program_name        |character |.           |
|sector              |character |.           |
|occupancy           |integer   |.           |
|capacity            |integer   |.           |

### Cleaning Script

```{r}
library(opendatatoronto)
library(tidyverse)
library(lubridate)

packages <- list_packages(limit = 10)
packages$excerpt

all_data <- search_packages("Daily Shelter Occupancy") %>% 
  list_package_resources() %>% 
  slice(2,4,6) %>%
  group_split(name) %>% 
  map_dfr(get_resource)

all_data %>% 
  janitor::clean_names() %>% 
  write_csv("2020/2020-12-01/shelters.csv")

```
