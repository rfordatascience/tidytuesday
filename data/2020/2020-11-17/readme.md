![](https://blkindata.github.io/bidweek2020/banner-schedule.png)

# `#BlackInDataWeek`

> Amplifying Black folx in `#informatics`, `#datascience`, & `#coding` around the world  

Follow along via the [`#BlackInDataWeek` hashtag](https://twitter.com/hashtag/BlackInDataWeek).  

A week-long celebration `#BlackInDataWeek` to:  

- (1) highlight the valuable work and experiences of Black people in the field of Data  
- (2) provide community  
- (3) educational and professional resources.  

To sign up for events, click [here](https://www.eventbrite.com/e/blackindataweek-2020-tickets-127652703673)!

To learn more about `#BlackInDataWeek`, please see [their website](https://blkindata.github.io/).

The `#TidyTuesday` community will be taking a break from our own data this week and asking you to engage with, promote, and support Black people in data.

You're welcome to revisit older datasets from `#TidyTuesday` this week, but especially on Thursday Nov 19th, please create space and engage with the [`#BlackInDataViz` hashtag](https://twitter.com/search?q=%23blackindataviz&src=typed_query) on Twitter rather than promoting your own work.

![](https://blkindata.github.io/project/blackindataviz/featured_hu2fed1b541976b7992f47975751508e6e_230350_720x0_resize_lanczos_2.png)

From the [`#BlackInDataViz` website](https://blkindata.github.io/project/blackindataviz/):  

> Creating space for Black people in data to share their work in the form of favourite data visualisation images. Also hosting a competition for data visualisation using a shared dataset, further reinforcing community. We will also host a ‘Data Viz in a Day' skills workshop, focusing on instructing beginners on creating data visualizations.

We don't have our own dataset this week, but the data below returns the purpose, date, hashtag, and link to each day's events to follow along with.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-11-17')
tuesdata <- tidytuesdayR::tt_load(2020, week = 47)

black_in_data <- tuesdata$black_in_data

# Or read in the data manually

black_in_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-17/black_in_data.csv')

```
### Data Dictionary

# `black_in_data.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|date     |date    | Date of Event |
|hashtag  |character | Hashtag for specific event |
|purpose   |character | Purpose of event |
|link |character | URL/Link to the event page |

### Cleaning Script

```{r}
black_in_data <- data.frame(
  date = seq(as.Date("2020-11-16"), as.Date("2020-11-21"), 1),
  hashtag = c("#BlackInDataRollCall",
              "#BlackInDataJourney",
              "#BlackInDataSkills",
              "#BlackInDataViz",
              "#BlackInDataJustice", 
              "#BlackInDataMentorship"),
  purpose = c(
    "Giving Black people in data a space to introduce themselves and their work. Introducing and valuing intersecting parts of their identities. We welcome contributions from a wide spectrum of Data Fields including but not limited to Informatics, Technology, Data Science, Coding, Social Science and Data Analytics.",
    "Further fostering community for Black people in data, by encouraging them to share their varied journeys in data.",
    "Discussing the skills Black people in data have learned, communal sharing of resources and advice for skills development.",
    "Creating space for Black people in data to share their work in the form of favourite data visualisation images.",
    "Hosting forums for learning and discussion of bias in the data field (and possible paths to address biases in data).",
    "Join us for career development and mentorship events!"
  ),
  link = c(
    "https://blkindata.github.io/project/blackindatarollcall/",
    "https://blkindata.github.io/project/blackindatajourney/",
    "https://blkindata.github.io/project/blackindataskills/",
    "https://blkindata.github.io/project/blackindataviz/",
    "https://blkindata.github.io/project/blackindatajustice/",
    "https://blkindata.github.io/project/blackindatacommunity/"
  )
)






```
