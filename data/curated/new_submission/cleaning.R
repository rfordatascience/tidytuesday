# This work includes material from the System Reference Document 5.2.1 (“SRD
# 5.2.1”) by Wizards of the Coast LLC, available at
# https://www.dndbeyond.com/srd. The SRD 5.2.1 is licensed under the Creative
# Commons Attribution 4.0 International License, available at
# https://creativecommons.org/licenses/by/4.0/legalcode.

library(dplyr)
library(here)
library(pdftools)
library(purrr)
library(rvest)
library(stringr)
library(tibble)
library(tidyr)
library(withr)

srd_url <- rvest::read_html("https://www.dndbeyond.com/srd") |>
  rvest::html_nodes(".download-link") |>
  rvest::html_node("a") |>
  rvest::html_attr("href") |>
  _[[1]]

target_path <- withr::local_tempfile(fileext = ".pdf")
download.file(srd_url, target_path, mode = "wb")

# Extract the raw text from the PDF.
srd_raw <- pdftools::pdf_text(target_path)

# Extract the index of monsters, to help us identify monster headers.
#
# The first page is weird, so handle it special.
monster_index1 <- srd_raw[[2]] |>
  stringr::str_split("\\n") |>
  _[[1]] |>
  _[46:86] |>
  stringr::str_extract("\\s{2,}([^.]+)\\.[. ]+(2|3)\\d{2}", 1)
monster_index1 <- monster_index1[!is.na(monster_index1)]

monster_index2 <- srd_raw[3:4] |>
  stringr::str_split("\\n") |>
  purrr::map(
    \(page) {
      page <- stringr::str_subset(page, "\\.{3,}")
      stringr::str_squish(unlist(stringr::str_split(page, "\\.[. ]+\\d{1,3}")))
    }
  ) |>
  unlist()
monster_index2 <- monster_index2[nchar(monster_index2) > 0]

monster_index <- sort(c(monster_index1, monster_index2))

# Monster descriptions are on p258-364.
monsters_raw <- srd_raw[258:364] |>
  stringr::str_split("\\n") |>
  purrr::map(
    \(page) {
      # If there's a second column, it will begin somewhere after column 60. It
      # can be a largish gap if there's spacing in column 2, like if column 2
      # just has the "MOD SAVE" headers. It "begins" when there's a non-space
      # (\S) after at least 3 spaces (\s). There can be large spaces earlier
      # that aren't columns, though, so it makes sense to do this by character
      # count.
      col2_start <- stringr::str_locate(
        substr(page, 60, nchar(page)),
        "\\s{3}\\S"
      )[,"end"] + 60 - 1

      col1_end <- col2_start - 1
      col1_end <- ifelse(is.na(col1_end), nchar(page), col1_end)

      # Turn everything into a single vector of text for this page.
      single_column <- c(
        stringr::str_trim(substr(page, 1, col1_end)),
        stringr::str_trim(substr(page, col2_start, nchar(page)))
      )
      # Blank rows appear semi-randomly, so let's not count on them as dividers.
      single_column[!is.na(single_column) & nchar(single_column) > 0] |>
        stringr::str_subset("System Reference Document", negate = TRUE)
    }
  ) |>
  # Pages don't tell us anything special.
  unlist()

# Use the index to find where monster entries begin. The name appears alone on a
# line.
monster_start_lines <- which(monsters_raw %in% monster_index)

# The line before a monster name is sometimes the group to which that monster
# belongs.
potential_monster_category_lines <- monster_start_lines - 1
# It's only a category if it only contains letters (or ’-), and isn't all caps.
monster_category_lines <- potential_monster_category_lines[
  stringr::str_which(
    monsters_raw[potential_monster_category_lines],
    "^[A-Z][a-z’-]+[A-Za-z ]*$"
  )
]

# Often the category is the same as the monster name, so remove categories from
# the individual monster starts.
monster_start_lines <- setdiff(monster_start_lines, monster_category_lines)
all_start_lines <- sort(c(monster_start_lines, monster_category_lines))

# Some blocks are multi-line. This function helps extract those blocks.
extract_block <- function(this_monster_text, block_name) {
  all_block_names <- c(
    "Skills",
    "Resistances",
    "Vulnerabilities",
    "Immunities",
    "Gear",
    "Senses",
    "Languages",
    "CR"
  )
  block_start <- which(stringr::str_starts(this_monster_text, block_name))
  if (length(block_start)) {
    block_ends <- which(
      stringr::str_starts(
        this_monster_text,
        paste(all_block_names, collapse = "|")
      )
    )
    block_end <- block_ends[block_ends > block_start][[1]] - 1
    block_text <- this_monster_text[block_start[[1]]:block_end] |>
      stringr::str_remove(
        paste0("^", block_name, "\\s*")
      ) |>
      paste(collapse = " ") |>
      stringr::str_squish()
    return(block_text)
  }
  return(NA_character_)
}

monsters <- purrr::map(
  monster_start_lines,
  \(this_monster_start) {
    this_monster <- monsters_raw[[this_monster_start]]

    # Categories appear before one or more monsters in a group, so this
    # monster's category is whichever category is most-recently before this
    # monster.
    this_monster_category <- monsters_raw[
      monster_category_lines[
        max(which(monster_category_lines < this_monster_start))
      ]
    ]

    # Everything except the last monster ends just before the next monster or
    # category.
    later_starts <- which(all_start_lines > this_monster_start)
    if (length(later_starts)) {
      this_monster_end <- all_start_lines[later_starts][[1]] - 1
    } else {
      this_monster_end <- length(monsters_raw)
    }
    this_monster_text <- monsters_raw[this_monster_start:this_monster_end]

    # The monster blocks have a mostly standard format, but there are
    # protections in here to deal with corner cases where lines are out of
    # order or lines that are normally a single line are split.
    tibble::tibble(
      name = this_monster,
      category = this_monster_category,
      cr = stringr::str_subset(this_monster_text, "^CR")[[1]] |>
        stringr::str_extract("CR ([^( ]+)", 1) |>
        stringr::str_squish() |>
        # Deal with fractional challenge ratings.
        stringr::str_replace_all(c(
          "1/2" = "0.5",
          "1/4" = "0.25",
          "1/8" = "0.125"
        )) |>
        as.double(),
      general_details = this_monster_text[[2]],
      ac = this_monster_text[[3]] |>
        stringr::str_extract("AC (\\d+)", 1),
      # Initiative values start with "+" or the minus sign, which is \u2212.
      initiative = stringr::str_subset(
        this_monster_text,
        "Initiative\\s+(\\+|\u2212)"
      )[[1]] |>
        stringr::str_extract("Initiative\\s+((\\+|\u2212)\\d+)", 1) |>
        stringr::str_replace("\u2212", "-") |>
        as.integer(),
      hp = stringr::str_subset(this_monster_text, "^HP")[[1]] |>
        stringr::str_extract("HP (.+)", 1),
      hp_number = stringr::str_extract(.data$hp, "^\\d+") |>
        as.integer(),
      speed = stringr::str_subset(this_monster_text, "^Speed\\s+\\d+")[[1]],
      speed_base_number = stringr::str_extract(.data$speed, "\\d+") |>
        as.integer(),
      # Ability scores are sometimes grouped, sometimes on their own lines.
      # Protect against cases where the abbreviation and number smush together,
      # but don't accidentally grab lines like "Construct".
      str = stringr::str_subset(this_monster_text, "Str[ 0-9]")[[1]] |>
        stringr::str_extract("Str\\s*(\\d+)", 1) |>
        as.integer(),
      dex = stringr::str_subset(this_monster_text, "Dex[ 0-9]")[[1]] |>
        stringr::str_extract("Dex\\s*(\\d+)", 1) |>
        as.integer(),
      con = stringr::str_subset(this_monster_text, "Con[ 0-9]")[[1]] |>
        stringr::str_extract("Con\\s*(\\d+)", 1) |>
        as.integer(),
      int = stringr::str_subset(this_monster_text, "Int[ 0-9]")[[1]] |>
        stringr::str_extract("Int\\s*(\\d+)", 1) |>
        as.integer(),
      wis = stringr::str_subset(this_monster_text, "Wis[ 0-9]")[[1]] |>
        stringr::str_extract("Wis\\s*(\\d+)", 1) |>
        as.integer(),
      cha = stringr::str_subset(this_monster_text, "Cha[ 0-9]")[[1]] |>
        stringr::str_extract("Cha\\s*(\\d+)", 1) |>
        as.integer(),
      str_save = stringr::str_subset(this_monster_text, "Str[ 0-9]")[[1]] |>
        stringr::str_extract("Str\\s*\\d+\\s+\\S+\\s+(\\S+)", 1) |>
        stringr::str_replace("\u2212", "-") |>
        as.integer(),
      dex_save = stringr::str_subset(this_monster_text, "Dex[ 0-9]")[[1]] |>
        stringr::str_extract("Dex\\s*\\d+\\s+\\S+\\s+(\\S+)", 1) |>
        stringr::str_replace("\u2212", "-") |>
        as.integer(),
      con_save = stringr::str_subset(this_monster_text, "Con[ 0-9]")[[1]] |>
        stringr::str_extract("Con\\s*\\d+\\s+\\S+\\s+(\\S+)", 1) |>
        stringr::str_replace("\u2212", "-") |>
        as.integer(),
      int_save = stringr::str_subset(this_monster_text, "Int[ 0-9]")[[1]] |>
        stringr::str_extract("Int\\s*\\d+\\s+\\S+\\s+(\\S+)", 1) |>
        stringr::str_replace("\u2212", "-") |>
        as.integer(),
      wis_save = stringr::str_subset(this_monster_text, "Wis[ 0-9]")[[1]] |>
        stringr::str_extract("Wis\\s*\\d+\\s+\\S+\\s+(\\S+)", 1) |>
        stringr::str_replace("\u2212", "-") |>
        as.integer(),
      cha_save = stringr::str_subset(this_monster_text, "Cha[ 0-9]")[[1]] |>
        stringr::str_extract("Cha\\s*\\d+\\s+\\S+\\s+(\\S+)", 1) |>
        stringr::str_replace("\u2212", "-") |>
        as.integer(),
      skills = extract_block(this_monster_text, "Skills"),
      resistances = extract_block(this_monster_text, "Resistances"),
      vulnerabilities = extract_block(this_monster_text, "Vulnerabilities"),
      immunities = extract_block(this_monster_text, "Immunities"),
      gear = extract_block(this_monster_text, "Gear"),
      senses = extract_block(this_monster_text, "Senses"),
      languages = extract_block(this_monster_text, "Languages"),
      # Also include the full text so users can correct any parsing errors and
      # otherwise dig for additional information.
      full_text = paste(this_monster_text, collapse = "\n")
    ) |>
      # I had trouble separating the general_details into its components purely
      # via regex, so I did so in a few steps.
      tidyr::separate_wider_delim(
        "general_details",
        delim = ", ",
        names = c("size_type", "alignment")
      ) |>
      dplyr::mutate(
        size = stringr::str_extract(
          .data$size_type,
          "^(Tiny|Small|Medium|Large|Huge|Gargantuan)(( or )(Tiny|Small|Medium|Large|Huge|Gargantuan))?"
        ),
        type = stringr::str_remove(.data$size_type, .data$size) |>
          stringr::str_squish(),
        .keep = "unused",
        .before = "size_type"
      ) |>
      tidyr::separate_wider_regex(
        "type",
        patterns = c(
          type = "^[^(]+",
          "\\(",
          descriptive_tags = "[^)]+",
          "\\)$"
        ),
        too_few = "align_start"
      ) |>
      dplyr::mutate(
        dplyr::across(
          c("type", "descriptive_tags"),
          stringr::str_squish
        )
      )
  }
) |>
  purrr::list_rbind()

dplyr::glimpse(monsters)
