### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here’s a simple formula for writing alt text for data visualization:
> ### Chart type
> It’s helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you’re including this visual. What does it show that’s meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don’t include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Stranger Things Dialogue

The data this week comes from [8flix.com](https://8flix.com/collections/transcripts/stranger-things-2/) - prepped by [Dan Fellowes](https://twitter.com/FilmicAesthetic) & [Jonathan Kitt](https://twitter.com/KittJonathan).

Repo with cleaning scripts + data: <https://github.com/filmicaesthetic/stringr-things>

8flix: <https://8flix.com/stranger-things/>
Wikipedia - Stranger Things episodes: <https://en.wikipedia.org/wiki/List_of_Stranger_Things_episodes>

> Stranger Things is an American science fiction fantasy horror drama television series created by the Duffer Brothers that is streaming on Netflix. The brothers serve as showrunners and are executive producers along with Shawn Levy and Dan Cohen. The first season of the series was released on Netflix on July 15, 2016, with the second, third, and fourth seasons following in October 2017, July 2019, and May and July 2022, respectively.

[A Statistical Curiosity Voyage Through the Emotion of Stranger Things](https://www.freecodecamp.org/news/a-statistical-curiosity-voyage-through-the-emotion-of-stranger-things-e7bc8b2a6395) by Jordan Dworkin: 

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-10-18')
tuesdata <- tidytuesdayR::tt_load(2022, week = 42)

episodes <- tuesdata$episodes

# Or read in the data manually

episodes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-10-18/episodes.csv')

```
### Data Dictionary

### stranger_things_all_dialogue.csv

| variable        | class     | description                                               |
|:----------------|:----------|:----------------------------------------------------------|
| season          | integer   | Season number                                             |
| episode         | integer   | Episode number within the season                          |
| line            | integer   | Order in which line appears in episode                    |
| raw_text        | character | Original text with both dialogue and stage directions     |
| stage_direction | character | Text describing what’s happening, or who is talking       |
| dialogue        | character | Dialogue spoken within the episode                        |
| start_time      | character | Time within the episode when the line starts being spoken |
| end_time        | character | Time within the episode when the line stops being spoken  |

### episodes.csv

| variable              | class     | description                      |
|:----------------------|:----------|:---------------------------------|
| season                | integer   | Season number                    |
| episode               | integer   | Episode number within the season |
| title                 | character | Title of the episode             |
| directed_by           | character | Director(s) of the episode       |
| written_by            | character | Writer(s) of the episode         |
| original_release_date | character | Release date of the episode      |

### Cleaning Script

Scripts contributed: https://github.com/filmicaesthetic/stringr-things/tree/main/scripts

```r
# load packages
library(pdftools)
library(stringr)
library(dplyr)
library(tidyr)

# tidy script function

tidy_script <- function(pdftext) {
  
  # paste as a single string
  ep_string <- paste(pdftext, sep = " ", collapse = "\\\n")
  
  # split by line with \n
  ep_byline <- str_extract_all(ep_string, "\\\n.*")
  
  # convert to dataframe
  ep_byline_df <- data.frame(ep_byline[[1]])
  
  # tidy text 
  ep_squish <-  ep_byline_df |>
    mutate(ep_byline..1.. = str_squish(ep_byline..1..))
  
  # get row containing page 1 text
  start_line <- which(ep_squish$ep_byline..1.. == "Page |1")
  
  # remove text above page 1
  ep_script <- data.frame(ep_squish[start_line:nrow(ep_squish),])
  
  colnames(ep_script) <- "raw_text"
  
  # filter out irrelevant lines
  ep_filt <- ep_script |>
    filter(!(raw_text %in% c("8FLiX.com TRANSCRIPT DATABASE", "FOR EDUCATIONAL USE ONLY", "\\", "", "This transcript is for educational use only.", "Not to be sold or auctioned.")),
           !(substr(raw_text, 1, 6) == "Page |"),
           !(substr(raw_text, 1, 6) == "P a g "))
  
  ep_split <- ep_filt |>
    mutate(time = ifelse(grepl("-->", raw_text) == TRUE, raw_text, NA),
           line = ifelse(grepl("^[0-9]+$", raw_text) == TRUE, as.numeric(raw_text), NA),
           stage_direction = str_squish(str_extract(raw_text, "\\[(.*?)\\]")),
           dialogue = str_squish(gsub("\\[(.*?)\\]", "", gsub("-", "", raw_text)))) |>
    fill(time, .direction = "down") |>
    fill(line, .direction = "down")
  
  ep_timesplit <- ep_split
  ep_timesplit[c("start_time", "end_time")] <- str_split_fixed(string = ep_timesplit$time, pattern = " --> ", n = 2)
  ep_timesplit <- ep_timesplit |>
    select(-time)
  
  
  ep_tidy <- ep_timesplit |>
    filter(grepl("[a-zA-Z]", raw_text) == TRUE)
  
  ep_groupline <- ep_tidy |>
    group_by(line) |>
    summarise(raw_text = paste0(raw_text, collapse = " "),
              stage_direction = paste0(stage_direction[!is.na(stage_direction)], collapse = " "),
              dialogue = paste0(dialogue, collapse = " "),
              start_time = first(start_time),
              end_time = first(end_time)) |>
    arrange(line) |>
    filter(!is.na(line)) |>
    select(season, episode, line, raw_text, stage_direction, dialogue, start_time, end_time)
  
  return(ep_groupline)
  
}

# Process scripts for all seasons


# read PDFs for season 1 scripts
e101 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-101-Chapter-One-The-Vanishing-of-Will-Byers.pdf")
e102 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-102-Chapter-Two-The-Weirdo-on-Maple-Street.pdf")
e103 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-103-Chapter-Three-Holly-Jolly.pdf")
e104 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-104-Chapter-Four-The-Body.pdf")
e105 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-105-Chapter-Five-The-Flea-and-the-Acrobat.pdf")
e106 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-106-Chapter-Six-The-Monster.pdf")
e107 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-107-Chapter-Seven-The-Bathtub.pdf")
e108 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-108-Chapter-Eight-The-Upside-Down.pdf")

# read PDFs for season 2 scripts
e201 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-201-Chapter-One-MADMAX.pdf")
e202 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-202-Chapter-Two-Trick-or-Treat-Freak.pdf")
e203 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-203-Chapter-Three-The-Pollywog.pdf")
e204 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-204-Chapter-Four-Will-the-Wise.pdf")
e205 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-205-Chapter-Five-Dig-Dug.pdf")
e206 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-206-Chapter-Six-The-Spy.pdf")
e207 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-207-Chapter-Seven-The-Lost-Sister.pdf")
e208 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-208-Chapter-Eight-The-Mind-Flayer.pdf")
e209 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-209-Chapter-Nine-The-Gate.pdf")

# read PDFs for season 3 scripts
e301 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-301-Chapter-One-Suzie-Do-You-Copy.pdf")
e302 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-302-Chapter-Two-The-Mall-Rats.pdf")
e303 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-303-Chapter-Three-The-Case-of-the-Missing-Lifeguard.pdf")
e304 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-304-Chapter-Four-The-Sauna-Test.pdf")
e305 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-305-Chapter-Five-The-Flayed.pdf")
e306 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-306-Chapter-Six-E-Pluribus-Unum.pdf")
e307 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-307-Chapter-Seven-The-Bite.pdf")
e308 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-308-Chapter-Eight-The-Battle-of-Starcourt.pdf")

# read PDFs for season 4 scripts
e401 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-401-Chapter-One-The-Hellfire-Club.pdf")
e402 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-402-Chapter-Two-Vecnas-Curse.pdf")
e403 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-403-Chapter-Three-The-Monster-and-the-Superhero.pdf")
e404 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-404-Chapter-Four-Dear-Billy.pdf")
e405 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-405-Chapter-Five-The-Nina-Project.pdf")
e406 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-406-Chapter-Six-The-Dive.pdf")
e407 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-407-Chapter-Seven-The-Massacre-at-Hawkins-Lab.pdf")
e408 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-408-Chapter-Eight-Papa.pdf")
e409 <- pdf_text("https://8flix.com/assets/transcripts/s/tt4574334/Stranger-Things-transcript-409-Chapter-Nine-The-Piggyback.pdf")

# list of episodes by season
s1 <- list(e101, e102, e103, e104, e105, e106, e107, e108)
s2 <- list(e201, e202, e203, e204, e205, e206, e207, e208, e209)
s3 <- list(e301, e302, e303, e304, e305, e306, e307, e308)
s4 <- list(e401, e402, e403, e404, e405, e406, e407, e308, e209)

# list of seasons
seasons <- list(s1, s2, s3, s4)

# create blank dataframe
all_dialogue <- data.frame()

# process scripts into single dataframe
for (s in 1:length(seasons)) {
  
  # tidy scripts
  for (i in 1:length(seasons[[s]])) {
    
    it <- tidy_script(seasons[[s]][[i]])
    
    it$episode <- i
    it$season <- s
    
    all_dialogue <- rbind(all_dialogue, it)
    
  }
}

# save dataframe
write.csv(all_dialogue, "data/stranger_things_all_dialogue.csv", row.names = FALSE)
```
