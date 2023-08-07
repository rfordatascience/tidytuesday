# Hot Ones Episodes 

The data this week comes from Wikipedia articles: [*Hot Ones*](https://en.wikipedia.org/wiki/Hot_Ones) and [List of Hot Ones episodes](https://en.wikipedia.org/wiki/List_of_Hot_Ones_episodes). Thank you to [Carl Börstell](https://github.com/borstell) for the [suggestion and cleaning script](https://github.com/rfordatascience/tidytuesday/issues/591)!

> Hot Ones is an American YouTube talk show, created by Chris Schonberger, hosted by Sean Evans and produced by First We Feast and Complex Media. Its basic premise involves celebrities being interviewed by Evans over a platter of increasingly spicy chicken wings.

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-08-08')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 32)

episodes <- tuesdata$episodes
sauces <- tuesdata$sauces
seasons <- tuesdata$seasons

# Option 2: Read directly from GitHub

episodes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-08-08/episodes.csv')
sauces <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-08-08/sauces.csv')
seasons <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-08-08/seasons.csv')
```

### Data Dictionary

# `episodes.csv`

|variable                |class     |description             |
|:-----------------------|:---------|:-----------------------|
|season                  |integer   |The season number.      |
|episode_overall         |integer   |The overall count of this episode, from 1-300.|
|episode_season          |integer   |The count of this episode within this season.|
|title                   |character |The title of the episode.|
|original_release        |date      |The date on which the episode was originally available on YouTube.|
|guest                   |character |The name of the guest. |
|guest_appearance_number |integer   |The number of appearances by this guest so far as of this date. |
|finished                |logical   |Whether the guest finished trying all of the sauces. |

# `sauces.csv`

|variable     |class     |description  |
|:------------|:---------|:------------|
|season       |integer   |The season number. |
|sauce_number |integer   |The number of this sauce, from 1 (least hot) to 10 (hottest). |
|sauce_name   |character |The name of the sauce. |
|scoville     |integer   |The rating of the sauce in [Scoville heat units](https://en.wikipedia.org/wiki/Scoville_scale). |

# `seasons.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
|season           |integer   |The season number. |
|episodes         |integer   |The count of episodes in this season. |
|note             |character |Notes about this season. |
|original_release |date      |The date of the first episode in this season. |
|last_release     |date      |The date of the last episode of this season (if that episode has aired at the time of scraping). |

### Cleaning Script

``` r
### Suggested TidyTuesday dataset: 
### 300 Hot Ones episodes (guests and sauces), seasons 1-21 (current)
### Original script by Carl Börstell (@borstell)

library(tidyverse)
library(rvest)
library(here)
library(data.table)

# Season information
seasons <- rvest::read_html("https://en.wikipedia.org/wiki/Hot_Ones") |>
  rvest::html_table(header = TRUE) |> 
  _[[2]][-1,] |>
  purrr::set_names(c("season", 
                     "episodes", 
                     "episodes2", 
                     "original_release", 
                     "last_release")) |>
  dplyr::select(-episodes2) |> 
  tidyr::separate_wider_delim(
    episodes, " + ", 
    names = c("episodes", "note"),
    too_few = "align_start"
  ) |> 
  dplyr::mutate(
    # Season 21 coerced to NA since it isn't finished.
    episodes = as.integer(episodes),
    dplyr::across(
      dplyr::ends_with("_release"),
      \(date_string) {
        # Date format is "March 12, 2015 (2015-03-12)"
        stringr::str_extract(date_string, "\\d{4}-\\d{2}-\\d{2}") |> 
          lubridate::ymd()
      }
    )
  )

# List of sauces for each season
sauces <- rvest::read_html("https://en.wikipedia.org/wiki/Hot_Ones") |> 
  rvest::html_table(header = TRUE) |>
  _[3:23] |>
  purrr::list_rbind(names_to = "season") |>
  purrr::set_names(c("season", 
                     "sauce_number", 
                     "sauce_name", 
                     "scoville")) |>
  dplyr::mutate(scoville = as.integer(gsub("[^0-9]", "", scoville)))

# Guests who did not finish all wings
hall_of_shame <- rvest::read_html("https://en.wikipedia.org/wiki/Hot_Ones") |> 
  rvest::html_elements("ul") |>
  rvest::html_text() |>
  dplyr::as_tibble() |>
  dplyr::filter(dplyr::row_number() == 48) |> # removes a footnote row
  tidyr::separate_longer_delim(value, "\n") |>
  dplyr::rename(guest = value) |>
  tidyr::separate_wider_delim(guest, delim = " (", 
                              names = c("guest", "comment"),
                              too_few = "align_start") |>
  dplyr::mutate(comment = gsub("\\)", "", comment)) |> 
  # Turn that into usable data.
  dplyr::mutate(
    guest_appearance_number = dplyr::if_else(
      is.na(comment), 1L, 2L
    ),
    finished = FALSE
  ) |> 
  dplyr::select(-comment)

# Guest names semi-automatically extracted from
# https://en.wikipedia.org/wiki/List_of_Hot_Ones_episodes
guests <- {
  tibble(
    guest = c(
      "Tony Yayo",
      "Anthony Rizzo",
      "Machine Gun",
      "Gunplay",
      "Ja Rule",
      "B.o.B.",
      "Prince Amukamara",
      "DJ Khaled",
      "Curren$y",
      "Tinashe",
      "Tommy Chong",
      "T.J. Miller",
      "Coolio",
      "Joey Fatone",
      "Michael Rapaport",
      "Key & Peele",
      "Riff Raff",
      "Eddie Huang",
      "Chris D'Elia",
      "Mike Epps",
      "Jim Gaffigan",
      "Carly Aquilino",
      "Redman",
      "Rob Gronkowski",
      "Rob Corddry",
      "Jeff Ross",
      "David Cross",
      "Eric André",
      "Joe Budden",
      "Matty Matheson",
      "RZA and Paul Banks",
      "Bert Kreischer",
      "YG",
      "Jay Pharoah",
      "Harley Morenstein",
      "Travis Kelce",
      "Hasan Minhaj",
      "Kevin Hart",
      "Martin Garrix",
      "Bobby Lee",
      "Tony Hawk",
      "Action Bronson",
      "T-Pain",
      "Rachael Ray",
      "Tom Colicchio",
      "Post Malone",
      "N.O.R.E.",
      "James Franco and Bryan Cranston",
      "Padma Lakshmi",
      "Joey (CoCo) Diaz",
      "Danny Brown",
      "Ricky Gervais",
      "Charlie Day",
      "Mac DeMarco",
      "Russell Brand",
      "Charlie Sloth",
      "Kyle Kinane",
      "Dax Shepard",
      "H3H3 Productions",
      "Keke Palmer",
      "Charlamagne Tha God",
      "DJ Snake",
      "Guy Fieri",
      "Kevin Love",
      "Neil deGrasse Tyson",
      "Thomas Middleditch",
      "Andy Cohen",
      "Tom Arnold",
      "Coyote Peterson",
      "Nick Kroll",
      "Brett Baker (superfan)",
      "Seth Rogen and Dominic Cooper",
      "Cara Delevingne",
      "Liam Payne",
      "Steve-O",
      "Vince Staples",
      "Adam Richman",
      "ASAP Ferg",
      "Kevin Durant",
      "Henry Rollins",
      "Dillon Francis",
      "Joji",
      "Wanda Sykes",
      "Terry Crews",
      "Gary Vaynerchuk",
      "Artie Lange",
      "Chris Jericho",
      "Gabrielle Union",
      "Wale",
      "Bob Saget",
      "Mario Batali",
      "Alexa Chung",
      "Logic",
      "Casey Neistat",
      "NA",
      "Chili Klaus",
      "Taraji P. Henson",
      "Sasha Banks",
      "Von Miller",
      "Rich Brian",
      "Hannibal Buress",
      "Michael B. Jordan",
      "Ty Burrell",
      "Charlize Theron",
      "Adam Rippon",
      "Gabriel Iglesias",
      "Shawn Mendes",
      "Philip DeFranco",
      "Trick Daddy",
      "Tyra Banks",
      "Alton Brown",
      "John Mayer",
      "Johnny Knoxville",
      "Natalie Portman",
      "Marques Brownlee",
      "Joel Embiid",
      "Tom Segura",
      "Joji and Rich Brian",
      "Wiz Khalifa",
      "Al Roker",
      "Michael Cera",
      "Issa Rae",
      "Rhett & Link",
      "Jeff Goldblum",
      "Eddie Huang",
      "Chrissy Teigen",
      "Tenacious D",
      "Anderson .Paak",
      "Adam Carolla",
      "Lil Yachty",
      "E-40",
      "Lilly Singh",
      "Blake Griffin",
      "Bill Burr",
      "Pete Holmes",
      "Vanessa Hudgens",
      "Weird Al Yankovic",
      "Gordon Ramsay",
      "Abbi and Ilana",
      "Seth Meyers",
      "Ken Jeong",
      "Desus and Mero",
      "Offset",
      "Billie Eilish",
      "Shaq",
      "Theo Von",
      "Jimmy Butler",
      "Chelsea Handler",
      "Scarlett Johansson",
      "The Jonas Brothers",
      "Halle Berry",
      "Trevor Noah",
      "Aubrey Plaza",
      "Schoolboy Q",
      "Adam Devine",
      "Kumail Nanjiani",
      "Binging with Babish",
      "Juice WRLD",
      "Idris Elba",
      "Kristen Bell",
      "Stone Cold Steve Austin",
      "Jay Pharoah",
      "Shia LaBeouf",
      "Ashton Kutcher",
      "Noel Gallagher",
      "Liza Koshy",
      "Paul Rudd",
      "Maisie Williams",
      "Nick Offerman",
      "DaBaby",
      "Kristen Stewart",
      "Chance the Rapper",
      "Brad Leone",
      "John Boyega",
      "Margot Robbie",
      "Zoë Kravitz",
      "Will Ferrell",
      "Halsey",
      "Pete Davidson",
      "David Dobrik",
      "Big Sean",
      "Zac Efron",
      "Justin Timberlake",
      "Tom Segura",
      "Brie Larson",
      "Eric André",
      "Dan Levy",
      "Dua Lipa",
      "T-Pain",
      "Adam Richman",
      "Action Bronson",
      "Drew Barrymore",
      "Joseph Gordon-Levitt",
      "Jessica Alba",
      "Ronda Rousey",
      "Naomi Campbell",
      "Matthew McConaughey",
      "Sam Smith",
      "Saweetie",
      "Thundercat",
      "The Undertaker",
      "Lil Nas X",
      "Daniel Radcliffe",
      "NA",
      "Priyanka Chopra Jonas",
      "Dustin Poirier",
      "Kevin James",
      "Awkwafina",
      "Kenan Thompson",
      "Anthony Mackie",
      "Paris Hilton",
      "Jennifer Garner",
      "J Balvin",
      "Jeffrey Dean",
      "Russell Brand",
      "Steve-O",
      "Jack Harlow",
      "Kamaru Usman",
      "Quavo",
      "Elizabeth Olsen",
      "Olivia Rodrigo",
      "Malcolm Gladwell",
      "Ed Sheeran",
      "David Harbour",
      "Michael Che",
      "Lorde",
      "Matt Damon",
      "Elijah Wood",
      "Jimmy Kimmel",
      "Derrick Lewis",
      "Jon Bernthal",
      "Megan Thee Stallion",
      "CL",
      "Mila Kunis",
      "Salma Hayek",
      "Jeremy Renner",
      "David Chang",
      "Brad Underwood",
      "Rob Lowe",
      "Simu Liu",
      "Tom Holland",
      "Gordon Ramsay",
      "Seth Rogen",
      "Tracee Ellis Ross",
      "Ed Helms",
      "Sebastian Stan",
      "Andrew Zimmern",
      "Dave Grohl",
      "Colin Farrell",
      "Courteney Cox",
      "Jacob Elordi",
      "Pusha T",
      "Leslie Mann",
      "Josh Brolin",
      "Post Malone",
      "Millie Bobby Brown",
      "Queen Latifah",
      "Kevin Bacon",
      "Khloé Kardashian",
      "Andrew Callaghan",
      "Tessa Thompson",
      "Daniel Kaluuya",
      "Bear Grylls",
      "Mark Rober",
      "Lizzo",
      "Neil Patrick Harris",
      "David Blaine",
      "Kid Cudi",
      "Viola Davis",
      "Cole Bennett",
      "Cate Blanchett",
      "Emma Chamberlain",
      "James Corden",
      "Ramy Youssef",
      "Israel Adesanya",
      "Zoe Saldaña",
      "Kate Hudson",
      "Paul Dano",
      "Anna Kendrick",
      "Bryan Cranston",
      "Lenny Kravitz",
      "Austin Butler",
      "LL Cool J",
      "Jenna Ortega",
      "Pedro Pascal",
      "Niall Horan",
      "Bob Odenkirk",
      "Florence Pugh",
      "Kieran Culkin",
      "Jake Gyllenhaal",
      "Jason Sudeikis",
      "Julia Louis-Dreyfus",
      "Rosalía",
      "Melissa McCarthy",
      "Jennifer Lawrence",
      "John Mulaney",
      "Lewis Capaldi",
      "Harry Kane",
      "John Stamos",
      "Stephen Curry"
    )
  )
}

# Episodes across seasons (with guests added)
episodes <- rvest::read_html("https://en.wikipedia.org/wiki/List_of_Hot_Ones_episodes") |> 
  rvest::html_table(header = TRUE) |>
  _[3:23] |>
  purrr::list_flatten() |>
  data.table::rbindlist(fill = TRUE) |>
  dplyr::as_tibble() |>
  dplyr::filter(
    row_number() != 257
  ) |>
  dplyr::select(-V1) |>
  purrr::set_names(c("episode_overall", 
                     "episode_season", 
                     "title", 
                     "original_release")) |>
  dplyr::mutate(
    episode_overall = as.integer(gsub("[^0-9]", "", episode_overall)),
    episode_season = as.integer(gsub("[^0-9]", "", episode_season)),
    # Change "Bonus" episode to 999
    episode_season = if_else(is.na(episode_season), 999L, episode_season),
    title = stringr::str_remove_all(title, "\\\""),
    original_release = stringr::str_extract(
      original_release, "\\d{4}-\\d{2}-\\d{2}"
    ) |> 
      lubridate::ymd()
  ) |>
  dplyr::mutate(
    season = cumsum(episode_season == 1),
    .before = episode_overall
  ) |>
  # Guests are only processed for the first 300 episodes.
  dplyr::filter(episode_overall <= 300) |> 
  dplyr::bind_cols(guests) |> 
  dplyr::mutate(
    guest_appearance_number = dplyr::row_number(),
    .by = guest
  ) |> 
  dplyr::left_join(
    hall_of_shame,
    by = dplyr::join_by(guest, guest_appearance_number)
  ) |> 
  dplyr::mutate(
    finished = tidyr::replace_na(finished, TRUE)
  )

readr::write_csv(
  episodes,
  here::here(
    "data",
    "2023",
    "2023-08-08",
    "episodes.csv"
  )
)
readr::write_csv(
  sauces,
  here::here(
    "data",
    "2023",
    "2023-08-08",
    "sauces.csv"
  )
)
readr::write_csv(
  seasons,
  here::here(
    "data",
    "2023",
    "2023-08-08",
    "seasons.csv"
  )
)
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
