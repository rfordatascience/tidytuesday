# evidence-graded power rankings of fictional characters

This week we're exploring evidence-graded power rankings of fictional characters from [Cited Feats](https://citedfeats.com), a fan-run site that ranks who is strongest inside 21 franchises, from Marvel and Star Wars to One Piece, Berserk, Westeros and Dungeons & Dragons. Every placement rests on citations to the works themselves (a chapter, an episode, a page, a game location), and every citation is graded by what kind of evidence it is: **shown** on page or screen, **stated** by a character, narrator or guidebook, or **scaled** by comparison with someone else's feat.

The site also records who killed whom, and whether the death was later undone. That makes it possible to ask how much of "who's strongest" a story actually shows, and how often it takes its deaths back. The ranks and grades are the site's editorial judgements, not measurements, and the deaths are only those recorded against ranked characters, not every death in each franchise. Coverage is uneven: some franchises have dozens of recorded deaths, others one or two. The SCP Foundation ranking is left out of this week's data because the site licenses it under different terms.

> A stated figure is something a source asserted, not something established. A grade is part of the claim it is attached to; quote one without the other and the claim changes.
>
> Cited Feats, open data readme

- Which franchises lean most on "stated" evidence, and does it depend on the medium (manga, novels, games, rulebooks)?
- Do higher-ranked characters rest on more citations, or on weaker ones?
- Which franchises undo their deaths most often? Is there a relationship between how often deaths are undone and how much is shown on page?
- Who are the most prolific killers in each franchise, and how many of their kills were reversed?
- How often does a lower-ranked character kill a higher-ranked one (an "upset")?

Thank you to Cited Feats for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-11-10')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 45)

fiction_citations <- tuesdata$fiction_citations
fiction_deaths <- tuesdata$fiction_deaths
fiction_rankings <- tuesdata$fiction_rankings

# Option 2: Read directly from GitHub

fiction_citations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_citations.csv')
fiction_deaths <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_deaths.csv')
fiction_rankings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_rankings.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-11-10')

# Option 2: Read directly from GitHub and assign to an object

fiction_citations = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_citations.csv')
fiction_deaths = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_deaths.csv')
fiction_rankings = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_rankings.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-11-10")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

fiction_citations = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_citations.csv")
fiction_deaths = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_deaths.csv")
fiction_rankings = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_rankings.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
fiction_citations = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_citations.csv", DataFrame)
fiction_deaths = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_deaths.csv", DataFrame)
fiction_rankings = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-10/fiction_rankings.csv", DataFrame)
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.

## Data Dictionary

### `fiction_citations.csv`

|variable       |class     |description                           |
|:--------------|:---------|:-------------------------------------|
|franchise_slug |character |Id of the franchise ranking the citation belongs to. |
|subject_id     |character |Id of the entry or armament the citation backs. Joins fiction_rankings$entry_id when subject_kind is entry. |
|subject_kind   |character |What the citation backs: entry (a ranked character or entity in fiction_rankings) or armament (an item on a franchise's separate ladder of weapons and abilities, not in fiction_rankings). |
|subject_name   |character |Display name of the subject. |
|work           |character |The work cited, named as the edition actually consulted. |
|type           |character |Kind of work: novel, film, episode, comic, game or reference (rulebooks, guidebooks, databooks and in-world documents). |
|locator        |character |Where in the work: a chapter, episode, page or game location (e.g. "Lost Izalith", "opening narration"). NA when it could not be sourced; none is invented. |
|year           |double    |Year the cited work was published or released, when recorded. |
|url            |character |A link to the source where one exists online. Almost always NA: citations point to the work and locator instead. |
|claim          |character |The part of the feat this citation backs, in the site's own words. |
|confidence     |character |Evidence grade: shown (depicted on page or screen), stated (asserted by a character, narrator or guidebook) or scaled (inferred by comparison with someone else's feat, the weakest). |

### `fiction_deaths.csv`

|variable       |class     |description                           |
|:--------------|:---------|:-------------------------------------|
|franchise_slug |character |Id of the franchise ranking the death is recorded on. |
|killer_id      |character |entry_id of the killer in fiction_rankings. |
|killer         |character |Name of the killer. |
|victim         |character |Who or what died, as named in the record. |
|victim_id      |character |entry_id of the victim when the victim is ranked in the same franchise; NA otherwise. |
|work           |character |The work the death happens in. |
|year           |double    |Year of that work, when recorded. |
|confidence     |character |Evidence grade of the death: shown (depicted on page or screen) or stated (reported by a character or narrator). |
|undone         |logical   |Whether the death was later reversed (the character came back, or the timeline was changed). |
|verdict        |character |The site's verdict on whether the death moves the ranking, filled only where a matchup page argues it: confirms (the higher-ranked killed the lower-ranked), upset (the lower-ranked killed the higher-ranked), undone (reversed, so the ranking does not move) or off-scale (one side is unranked). NA otherwise. |
|matchup_url    |character |The citedfeats.com matchup page arguing the verdict, where there is one. |

### `fiction_rankings.csv`

|variable       |class     |description                           |
|:--------------|:---------|:-------------------------------------|
|franchise_slug |character |Id of the franchise ranking the entry belongs to (e.g. marvel, westeros, one-piece); also its URL path on citedfeats.com. |
|franchise      |character |Display name of the franchise. |
|entry_id       |character |Id of the character or entity, unique within its franchise. Joins fiction_citations$subject_id and fiction_deaths$killer_id / victim_id, always together with franchise_slug. |
|name           |character |Name of the character or entity. |
|rank           |double    |Editorial power rank within the franchise, 1 = strongest. NA for an off-scale entry that is listed and argued but deliberately not ranked. |
|tier           |character |Id of the tier the entry is placed in. |
|tier_label     |character |Printed label of the tier, e.g. "Tier 01 · apex". |
|eligible       |logical   |Whether visitors can vote on the entry on the site. Always FALSE for off-scale entries. |
|continuity     |character |The franchise's own continuities the entry appears in (e.g. a game, the manga, canon or legends). Several are separated by ";". |
|media          |character |Media the entry appears in, separated by ";": film, animation, novel, comic, game or television. |
|citations      |double    |Number of citations behind the entry. Equals shown + stated + scaled. |
|shown          |double    |Number of the entry's citations graded shown: depicted on page or screen. |
|stated         |double    |Number of the entry's citations graded stated: asserted by a character, narrator or guidebook. |
|scaled         |double    |Number of the entry's citations graded scaled: inferred by comparison, the weakest grade. |
|url            |character |The entry's page on citedfeats.com. |

## Cleaning Script

```r
# Data from Cited Feats (https://citedfeats.com/data/), licensed CC BY 4.0.
# The site regenerates these files every time it updates. The copies saved
# here are the version as of 2026-10-10, archived at
# https://doi.org/10.5281/zenodo.23278403.
#
# Cleaning: rows for the SCP Foundation ranking (franchise_slug == "scp") are
# dropped, because the site licenses them CC BY-SA 3.0 rather than CC BY 4.0.
# Nothing else is changed. readr parses `eligible` and `undone` as logical, and
# empty fields as NA.

library(dplyr)

read_citedfeats <- function(file) {
  readr::read_csv(
    paste0("https://citedfeats.com/data/", file),
    show_col_types = FALSE
  )
}

# One row per ranked character or entity.
fiction_rankings <- read_citedfeats("rankings.csv") |>
  filter(franchise_slug != "scp")

# One row per citation behind a ranking, each graded shown, stated or scaled.
fiction_citations <- read_citedfeats("citations.csv") |>
  filter(franchise_slug != "scp")

# One row per recorded death, and whether it was later undone.
fiction_deaths <- read_citedfeats("kills.csv") |>
  filter(franchise_slug != "scp")

```
