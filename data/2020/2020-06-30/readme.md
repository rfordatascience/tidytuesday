![](xmen-hero.png)

# Uncanny X-men

The data this week comes from the [Claremont Run Project](http://www.claremontrun.com/) and Malcom Barret(https://twitter.com/malco_barrett) who put these datasets into a R data package. The Claremont Run project has a nice [Foreward](http://www.claremontrun.com/Foreword.html) capturing some of the reasoning behind this dataset. "The Claremont Run is a SSHRC-funded academic initiative micro-publishing data-based analysis of Chris Claremont's 16 year run on Uncanny X-Men #97-278."

> From 1975-1991, Chris Claremont wrote X-men, forming the longest stint of any mainstream superhero writer on a single title. During his tenure, X-men went from a B-list title on the verge of cancellation, to the best-selling comic book in the world, and Claremont holds the Guinness World Record to this day for the bestselling single issue comic of all-time.

> Claremont’s work is too culturally important to lose touch with. A generation of writers, filmmakers, and artists were all but weaned on the stories he told, and Claremont’s fingerprints are all over the media landscape that we have today – structures and strategies and dynamics. But exposing a new generation of readers and scholars to the Claremont run (in all its scope) is challenging to say the least.

> And that’s where our humble website comes in. By building an expansive data set on the Claremont run, this project hopes to open new doors of exploration and consideration for the next generation of comics scholars. In this sense, this project is looking both to the past (in order to deconstruct and chronicle the landmark contribution of a comics artist to the field of popular culture as a whole) and to the future (in order to facilitate yet-to-come discussions of the author’s work, enabling and empowering future breakthroughs).

The Claremont Project has a Twitter handle - please reference them when using this data: [@ClaremontRun](https://twitter.com/ClaremontRun)

Malcom Barret(https://twitter.com/malco_barrett) put these datasets into a R data package: [`claremontrun`](https://github.com/malcolmbarrett/claremontrun), which is where we got the data for this week.

To Install the `claremontrun` package:  
- `remotes::install_github("malcolmbarrett/claremontrun")`  

Or use the raw CSVs from this repo with `tidytuesdayR`.

> `claremontrun` is an R data package that provides data from the [Claremont
Run](http://www.claremontrun.com/) project. This project collects data on [Chris Claremont’s](https://www.wikiwand.com/en/Chris_Claremont) iconic run on [Uncanny X-Men](https://www.wikiwand.com/en/Uncanny_X-Men).

Note that while the `claremontrun` has information about the Bechdel test, it doesn't include gender as a measure. You may therefore want to also explore the 2018 TidyTuesday dataset that had more metadata about specific comic book characters:  

[2018 - Week 9](https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018/2018-05-29/week9_comic_characters.csv)

Load that data with: `tidytuesdayR::tt_load(2020, week = 9)`

These datasets could be joined by character names.

claremontrun includes 7 data sets relevant to the Claremont run:

  - `character_visualization`, counts of character speech, thought, narrative, or visual depictions  
  - `characters`, descriptions of character actions  
  - `comic_bechdel`, whether or not an issue of another (non-X-Men) comic series met the Bechdel test  
  - `covers`, data on covers of issues of Uncanny X-Men  
  - `issue_collaborators`, data about other collaborators on each issue, such as editors  
  - `location`, locations that appear in each issue  
  - `xmen_bechdel`, whether or not an issue of Uncanny X-Men met the Bechdel test  

The Bechdel Test according to [wikipedia](https://en.wikipedia.org/wiki/Bechdel_test):  

> The Bechdel Test is a measure of the representation of women in fiction. It asks whether a work features at least two women who talk to each other about something other than a man. The requirement that the two women must be named is sometimes added.
> 
> About half of all films meet these criteria, according to user-edited databases and the media industry press. Passing or failing the test is not necessarily indicative of how well women are represented in any specific work. Rather, the test is used as an indicator for the active presence of women in the entire field of film and other fiction, and to call attention to gender inequality in fiction. Media industry studies indicate that films that pass the test perform better financially than those that do not.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest!

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-06-30')
tuesdata <- tidytuesdayR::tt_load(2020, week = 27)

comic_bechdel <- tuesdata$comic_bechdel
characters <- tuesdata$characters

# Or read in manually with read_csv()

comic_bechdel <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-30/comic_bechdel.csv')

character_visualization <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-30/character_visualization.csv')

characters <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-30/characters.csv')

xmen_bechdel <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-30/xmen_bechdel.csv')

covers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-30/covers.csv')

issue_collaborators <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-30/issue_collaborators.csv')

locations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-06-30/locations.csv')

```
### Data Dictionary

# `comic_bechdel.csv`

|variable     |class     |description |
|:------------|:---------|:-----------|
|series       |character | Series title |
|issue        |integer   | Issue number |
|title        |character | Title of the comic issue |
|writer       |character | Writer |
|artist       |character | Comic artist |
|cover_artist |character | Cover artist|
|pass_bechdel |character | Does it pass the bechdel test? |
|page_number  |character | Page Number|
|notes        |character | Notes |

# `xmen_bechdel.csv`

|variable     |class     |description |
|:------------|:---------|:-----------|
|issue        |double    | Issue number|
|pass_bechdel |character | Does it pass the bechdel test? |
|notes        |character | Notes |
|reprint      |logical   | Reprint? |

# `character_visualization.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|issue     |double    | Issue number |
|costume   |integer   | In costume or not in costume |
|character |character | Character name (secret identity and their superhero name) |
|speech    |double    | Speech bubble in that issue |
|thought   |double    | Thought bubble in that issue |
|narrative |double    | Narrative statements in that issue |
|depicted  |double    | NUmber of depictions in that issue |

# `characters.csv`

|variable                                      |class     |description |
|:---------------------------------------------|:---------|:-----------|
|issue                                         |double    | Issue number |
|character                                     |character | Character name |
|rendered_unconcious                           |double    | Number of times rendered unconscious |
|captured                                      |double    | Number of times captured|
|declared_dead                                 |double    | Number of times declared dead |
|redressed                                     |double    | Number of times re-dressed |
|depowered                                     |double    | Number of times depowered |
|clothing_torn                                 |double    | Number of times clothing torn |
|subject_to_torture                            |double    | Number of times tortured |
|quits_team                                    |double    | Number of times quits team |
|surrenders                                    |double    | Number of times surrenders |
|number_of_kills_humans                        |double    | Number of humans killed |
|number_of_kills_non_humans                    |double    | Number of non-humans killed |
|initiates_physical_conflict                   |character | Number of times initiates physical conflict |
|expresses_reluctance_to_fight                 |double    | Number of times expresses reluctance to fight |
|on_a_date_with_which_character                |character | Number of times on a data with specific character |
|kiss_with_which_character                     |character | Number of times kissing with a character |
|hand_holding_with_which_character             |character | Number of times holding hands with character |
|dancing_with_which_character                  |character | Number of times dancing with a character |
|flying_with_another_character                 |character | Number of times flying with a character |
|arm_in_arm_with_which_character               |character | Number of times arm in arm with character |
|hugging_with_which_character                  |character | Number of times hugging with a character |
|physical_contact_other                        |character | Number of times with physical contact with a character |
|carrying_with_which_character                 |character | Number of times carrying a character |
|shared_bed_with_which_character               |logical   | Number of times sharing bed with character |
|shared_room_domestically_with_which_character |logical   | Number of times sharing room domestically with character |
|explicitly_states_i_love_you_to_whom          |character | Number of times saying I love you to whom |
|shared_undress                                |character | Number of times sharing undress |
|shower_number_of_panels_shower_lasts          |double    | Number of times showering number of panels |
|bath_number_of_panels_bath_lasts              |double    | Number of times/panels bathing |
|depicted_eating_food                          |double    | Number of times eating food |
|visible_tears_number_of_panels                |double    | Number of panels with tears (crying) |
|visible_tears_number_of_intances              |double    | Visible tears number of instances |
|special_notes                                 |character | Special notes |

# `covers.csv`

|variable              |class     |description |
|:---------------------|:---------|:-----------|
|issue                 |double    | Isse number |
|cover_artist          |character | Cover artist |
|narrative_captions    |character | Narrative captions |
|characters_visualized |character | Which characters visualized |
|characters_speaking   |character | Which characters speaking|
|dialog_text           |character | Dialog text on cover|

# `issue_collaborators.csv`

|variable        |class     |description |
|:---------------|:---------|:-----------|
|issue           |double    | Issue number |
|editor_in_chief |character | Editor in chief of issue |
|editor          |character | Editor of issue |
|penciller       |character | Penciller of issue |

# `locations.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|issue    |double    | Issue number |
|location |character | Location |
|context  |character | Context - what's going on |
|notes    |character | Notes|

### Cleaning Script

No cleaning script today - this data came pre-cleaned.
