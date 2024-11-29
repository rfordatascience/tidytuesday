# Dungeons and Dragons Spells (2024)

This week we're exploring magical spells from the recently released Dungeons and Dragons Free Rules (2024 edition).

> Many characters have the ability to cast spells, which have a huge variety of effects. Some spells are mostly useful in combat, by dealing damage or imposing conditions. Other spells have utility in exploration. If you’re playing a spellcaster, look for a mix of combat-effective and utilitarian spells to help deal with varied challenges.

- Which class has the most options for spells to cast on themselves, or on targets they can touch?
- Which classes have the most spells that require concentration? Which classes have spells that last without concentration?
- Are there any interesting patterns in the text descriptions of the spells?

Thank you to [Jon Harmon](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-12-17')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 51)

spells <- tuesdata$spells

# Option 2: Read directly from GitHub

spells <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-17/spells.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `spells.csv`

|variable                   |class     |description                           |
|:--------------------------|:---------|:-------------------------------------|
|name                       |character |The name of the spell. |
|level                      |integer   |The level of the spell, from 0 ("cantrip") to 9. This number represents the power and difficulty of the spell within the game. |
|school                     |character |The school (broad category) of magic to which the spell belongs. One of "abjuration", "conjuration", "divination", "enchantment", "evocation", "illusion", "necromancy", or "transmutation". |
|bard                       |logical   |Whether the spell can be cast by bards. |
|cleric                     |logical   |Whether the spell can be cast by clerics. |
|druid                      |logical   |Whether the spell can be cast by druids. |
|paladin                    |logical   |Whether the spell can be cast by paladins. |
|ranger                     |logical   |Whether the spell can be cast by rangers. |
|sorcerer                   |logical   |Whether the spell can be cast by sorcerers. |
|warlock                    |logical   |Whether the spell can be cast by warlocks. |
|wizard                     |logical   |Whether the spell can be cast by wizards. |
|casting_time               |character |How long it takes to cast the spell. Can be an in-game unit ("action", "bonus action", "reaction", "ritual"), or a longer, descriptive unit. These times are broken down in the next 6 columns. |
|action                     |logical   |Whether the spell can be cast as an "action," the basic thing a character can do on their turn. |
|bonus_action               |logical   |Whether the spell can be cast as a "bonus action", a faster, "extra" thing a character can do on their turn. |
|reaction                   |logical   |Whether the spell can be cast as a "reaction", a thing a character can do on someone else's turn. |
|ritual                     |logical   |Whether the spell can be cast as a ritual. Casting a spell as a ritual adds 10 minutes to the casting time, is usually easier for characters to perform. |
|casting_time_long          |character |Other casting times, usually in minutes or hours. |
|trigger                    |character |Whether the spell requires a trigger to cast. Most common for reaction spells. |
|range                      |character |How far away the spell can appear from the caster. |
|range_type                 |character |The general category of range for the spell. One of "feet" (the most common category of ranges), "self" (the spell can be cast on the caster), "touch" (the spell can be cast on someone the caster can touch), "sight" (the spell can be cast on anyone the caster can see), or "other" (the spell has some other range, such as miles). |
|verbal_component           |logical   |Whether the spell requires a verbal component (the casting character must be able to speak). |
|somatic_component          |logical   |Whether the spell requires a somatic component (a movement or gesture by the casting character). |
|material_component         |logical   |Whether the spell requires a material component (a physical object that the casting character must possess, which might be consumed in the casting of the spell). |
|material_component_details |character |More details about any material components of the spell. |
|duration                   |character |How long the spell lasts, in rounds (sets of turns in combat, equivalent to about 6 seconds), minutes, hours, days, or other measurements. An "instantaneous" duration means the spell does whatever it does, potentially enacting a permanent change. "Concentration" is described in the next column. |
|concentration              |logical   |Whether the spell requires "concentration" -- the casting character must continue to focus on the spell to keep it active. Concentration can be interrupted by the caster taking damage in combat, for example. |
|description                |character |The full text description of the spell. |

### Cleaning Script

```r
library(rvest)
library(purrr)
library(dplyr)
library(tibble)
library(stringr)

src <- "https://www.dndbeyond.com/sources/dnd/free-rules/spell-descriptions"

# Open the page to help create the extraction code
# browseURL(src).

# Read the HTML content.
page <- rvest::read_html(src)

# Extract spell names (within the h3 tag).
spell_names <- page |>
  rvest::html_elements("h3.heading-anchor a.spell-tooltip") |>
  rvest::html_text2()

# Extract spell schools, etc (within the first p tag after the h3 tag).
spell_schools <- page |>
  rvest::html_elements("h3.heading-anchor + p") |>
  rvest::html_text2()

# Extract casting times (within div with class spell-components).
casting_times <- page |>
  rvest::html_elements(".spell-components p:nth-child(1)") |>
  rvest::html_text2() |>
  stringr::str_remove("Casting Time: ")

# Extract ranges.
ranges <- page |>
  rvest::html_elements(".spell-components p:nth-child(2)") |>
  rvest::html_text2() |>
  stringr::str_remove("Range: ")

# Extract components.
components <- page |>
  rvest::html_elements(".spell-components p:nth-child(3)") |>
  rvest::html_text2() |>
  stringr::str_remove("Component(s?): ")

# Extract durations.
durations <- page |>
  rvest::html_elements(".spell-components p:nth-child(4)") |>
  rvest::html_text2() |>
  stringr::str_remove("Duration: ")

# Extract descriptions (all <p>'s between the <div class="spell-components"> and
# <hr class="separator">).
next_sibling <- function(node) {
  rvest::html_element(node, xpath = "following-sibling::*[1]")
}

compile_description <- function(node) {
  desc <- character()
  node <- next_sibling(node)
  while (length(node) && rvest::html_name(node) != "hr") {
    desc <- c(desc, rvest::html_text2(node))
    node <- next_sibling(node)
  }
  return(stringr::str_trim(paste(desc, collapse = "\n")))
}

description_blocks <- page |>
  rvest::html_elements(".spell-components") |>
  purrr::map_chr(compile_description)

# Combine everything into a tibble.
spells <- tibble::tibble(
  name = spell_names,
  school_etc = spell_schools,
  casting_time = casting_times,
  range = ranges,
  components = components,
  duration = durations,
  description = description_blocks
) |> 
  
  # Process school_etc.
  dplyr::mutate(
    # Extract level: if "Cantrip" is present, set it to 0, otherwise extract the
    # level.
    level = dplyr::if_else(
      stringr::str_detect(school_etc, "Cantrip"), 
      0L, 
      stringr::str_extract(school_etc, "Level (\\d+)", 1) |> 
        as.integer()
    ),
    # Extract school by removing the level or "Cantrip".
    school = stringr::str_remove(school_etc, "Cantrip|(Level \\d+ )") |> 
      stringr::str_extract("^\\w+") |> 
      tolower(),
    # Extract class by capturing everything after the parentheses.
    class = stringr::str_extract(school_etc, "\\(([^)]+)\\)") |> 
      stringr::str_remove_all("[()]") |> 
      tolower(),
    .keep = "unused",
    .after = "name"
  ) |>
  dplyr::mutate(
    bard = stringr::str_detect(class, "bard"),
    cleric = stringr::str_detect(class, "cleric"),
    druid = stringr::str_detect(class, "druid"),
    paladin = stringr::str_detect(class, "paladin"),
    ranger = stringr::str_detect(class, "ranger"),
    sorcerer = stringr::str_detect(class, "sorcerer"),
    warlock = stringr::str_detect(class, "warlock"),
    wizard = stringr::str_detect(class, "wizard"),
    .keep = "unused",
    .after = "school"
  ) |> 
  
  # Extract casting time details.
  dplyr::mutate(
    # Detect if "Action", "Bonus Action", "Reaction", or "Ritual" is present.
    action = stringr::str_detect(casting_time, "Action(?!, which you take)") |>
      dplyr::if_else(TRUE, FALSE),
    bonus_action = stringr::str_detect(casting_time, "Bonus Action") |>
      dplyr::if_else(TRUE, FALSE),
    reaction = stringr::str_detect(casting_time, "Reaction") |>
      dplyr::if_else(TRUE, FALSE),
    ritual = stringr::str_detect(casting_time, "Ritual") |>
      dplyr::if_else(TRUE, FALSE),
    # Extract casting_time_long for specific times like "1 minute" or "24 hours"
    casting_time_long = stringr::str_extract(
      casting_time,
      "\\d+ (minute(s?)|hour(s?)|day(s?)|week(s?))"
    ) |> 
      stringr::str_trim() |> 
      dplyr::na_if(""),
    # Extract trigger details for reactions or special cases.
    trigger = stringr::str_extract(casting_time, ", which you take .+") |>
      stringr::str_remove("^, which you take ") |> 
      stringr::str_remove("^when|immediately after|in response to") |>
      stringr::str_trim() |> 
      dplyr::na_if(""),
    .after = "casting_time"
  ) |> 
  
  # Process components.
  tidyr::separate_wider_regex(
    components,
    patterns = c(
      verbal_component = "V?",
      ",?\\s?",  # Optional separator between components
      somatic_component = "S?",
      ",?\\s?",  # Optional separator between components
      material_component = "M?",
      "\\s*", # Optional spacer
      material_component_details = ".*"
    ),
    too_few = "align_start"
  ) |>
  # Convert components to boolean flags.
  dplyr::mutate(
    verbal_component = !is.na(verbal_component) & verbal_component == "V",
    somatic_component = !is.na(somatic_component) & somatic_component == "S",
    material_component = !is.na(material_component) & material_component == "M",
    material_component_details = stringr::str_remove_all(
      material_component_details,
      "[()]"
    ) |> 
      dplyr::na_if(""),
    .keep = "unused"
  ) |> 
  
  # Assign range type.
  dplyr::mutate(
    range_type = stringr::str_extract(
      tolower(range),
      "self|touch|range|feet|sight"
    ) |> 
      tidyr::replace_na("other"),
    .after = "range"
  ) |> 
  
  # Process durations.
  dplyr::mutate(
    concentration = stringr::str_detect(tolower(duration), "concentration"),
    .after = "duration"
  )

dplyr::glimpse(spells)
```
