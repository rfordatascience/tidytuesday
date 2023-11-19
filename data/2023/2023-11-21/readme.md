# R-Ladies Chapter Events

R-Ladies Global is an inspiring story of community, empowerment, and diversity in the field of data science. Founded by Gabriela de Queiroz, R-Ladies began as a grassroots movement with a simple mission: to promote gender diversity in the R programming community and provide a welcoming space for women and gender minorities to learn, collaborate, and excel in data science. [R-Ladies Global Website](https://rladies.org/)

The data this week comes from [Federica Gazzelloni](https://github.com/Fgazzelloni)'s [presentation](https://youtu.be/EstytFNjrWc) on [R-Ladies Chapters: Making talks work for diverse audiences](https://github.com/Fgazzelloni/RLadies-Chapters-Making-Talks-Work-for-Diverse-Audiences/tree/main) with data from the [rladies meetup-archive](https://github.com/rladies/meetup_archive).


## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-11-21')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 47)

rladies_chapters <- tuesdata$rladies_chapters

# Option 2: Read directly from GitHub

rladies_chapters <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-21/rladies_chapters.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.


### Data Dictionary

# `rladies_chapters.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|id       |double    |event id          |
|chapter  |character |r-ladies chapter name     |
|title    |character |event title       |
|date     |double    |event date        |
|location |character |event location if online or in person    |
|year     |double    |event year        |

### Cleaning Script

Cleaning script from @Fgazzelloni in [her tidytuesday github issue](https://github.com/rfordatascience/tidytuesday/issues/632).

``` r
library(tidyverse)
library(jsonlite)
data <- jsonlite::fromJSON('https://raw.githubusercontent.com/rladies/meetup_archive/main/data/events.json')

chapters <- data %>%
  select(1,2,3,7,8)%>% 
  rename(chapter=group_urlname)%>%
  mutate(location=ifelse(location=="Online event","online","inperson"),
         title=sub(".*-- ","",title),
         title=gsub("\\s*\\([^\\)]+\\)","",title)) %>%
  filter(!str_detect(title,regex("canceled|cancelled",ignore_case=T)),
         !chapter%in%c("RLadiesJeddah","muhq_deleted@4633@rladies-ushuaia",
                      "muhq_deleted@9919@notopic@508502","notopic@544550"))%>%
  arrange(desc(date))%>%
  filter(year(date)<2024)%>%
  mutate(year=year(date))

# to download the n. of attendees
library(meetupr)
# meetupr::get_event_attendees("event-id")

id <- rladies_chapters$id
id1 <- id[1:25]

attendees <- function(id) {
  dat<- meetupr::get_event_attendees(id)%>%
   dim()
    dat[1]
}

mylist <- lapply(id1,attendees)

first25 <- mylist%>%unlist()
first25_events <- rladies_chapters[1:25,]%>%
  cbind(first25)
```

