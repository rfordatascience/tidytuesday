![Friends logo - credit to TurboLogo](https://turbologo.com/articles/wp-content/uploads/2019/12/friends-logo-font.png.webp)

# Friends

The data this week comes from the [`friends` R package](https://github.com/EmilHvitfeldt/friends) for the Friends transcripts and additional information.

h/t to [Emil Hvitfeldt](https://twitter.com/Emil_Hvitfeldt) for aggregating, packaging and sharing this data with us!

[Friends Wikipedia](https://en.wikipedia.org/wiki/Friends):  

> Friends is an American television sitcom, created by David Crane and Marta Kauffman, which aired on NBC from September 22, 1994, to May 6, 2004, lasting ten seasons. With an ensemble cast starring Jennifer Aniston, Courteney Cox, Lisa Kudrow, Matt LeBlanc, Matthew Perry and David Schwimmer, the show revolves around six friends in their 20s and 30s who live in Manhattan, New York City. The series was produced by Bright/Kauffman/Crane Productions, in association with Warner Bros. Television. The original executive producers were Kevin S. Bright, Kauffman, and Crane.

The `friends` package can be installed from CRAN with `install.packages("friends")`. 

This [ceros interactive article](https://www.ceros.com/originals/friends-scripts-25th-anniversary-catchphrase-scenes-quotes/) looks at which characters appear together. 

There's text, appearance, ratings, and many other datasets here - if you're trying out Text Analysis, check out the [`tidytext` mining book/package](https://www.tidytextmining.com/) or the newly released [Supervised Machine Learning for Text Analysis in R](https://smltar.com/) book, both which are freely available online at the respective links.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-09-08')
tuesdata <- tidytuesdayR::tt_load(2020, week = 37)

friends <- tuesdata$friends

# Or read in the data manually

friends <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-08/friends.csv')
friends_emotions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-08/friends_emotions.csv')
friends_info <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-08/friends_info.csv')

```

### Data Dictionary

# `friends.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|text      |character    | Dialogue as text |
|speaker     |character    | Name of the speaker |
|season       |double | Season Number |
|episode |double    | Episode Number |
|scene |double    | Scene Number |
|utterance    |double | Utterance Number|

# `friends_emotions.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|season       |integer | Season Number |
|episode |integer    | Episode Number |
|scene |integer    | Scene Number |
|utterance    |integer | Utterance Number|
| emotion | character | One of 7 emotions |

# `friends_entities` data (within package)

|variable    |class     |description |
|:-----------|:---------|:-----------|
|season       |integer | Season Number |
|episode |integer    | Episode Number |
|scene |integer    | Scene Number |
|utterance    |integer | Utterance Number|
| entities | list | Character entities |

# `friends_info.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|season       |integer | Season Number |
|episode |integer    | Episode Number |
|title |character    | Title |
|directed_by    |character | Name of director(s)|
| written_by | character | Name of writer(s) |
| air_date | date | Original Airing date in USA |
| us_views_millions | double | Viewers in USA in millions |
| imdb_rating | double | IMDB Rating (10 is best) |

### Cleaning Script

No cleaning this week!

