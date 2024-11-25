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
