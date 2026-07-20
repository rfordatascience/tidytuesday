# Near-Death Experiences (NDERF)

This week we're exploring near-death experiences (NDEs) reported to the [Near Death Experience Research Foundation](https://nderf.org/) (NDERF). The dataset contains 589 individual NDE records scraped from the [NDERF Search](https://search.nderf.org/) site, which embeds structured JSON metadata for each experience. Each record includes demographics, a Greyson NDE Scale score, and AI-detected experience features. No narrative text is included in the extracted dataset, respecting NDERF's copyright.

Near-death experiences are reported by 10–23% of cardiac arrest survivors in prospective studies. They typically involve out-of-body perception, a feeling of peace, seeing a bright light, and encountering deceased relatives. The Greyson NDE Scale (0–32) is the standard validated instrument for measuring NDE depth. Score of 7 or higher indicates a genuine NDE.

> "62 patients (18%) reported NDE, of whom 41 (12%) described a core experience. Occurrence of the experience was not associated with duration of cardiac arrest or unconsciousness, medication, or fear of death before cardiac arrest." — Van Lommel et al. 2001, The Lancet

- What features most commonly co-occur in NDEs? Are out-of-body experiences correlated with ESP or unity?
- How does the Greyson score distribution differ between genders or countries?
- Are distressing NDEs more common in certain demographics or time periods?
- How has the rate of NDERF submissions changed over time (1999–2025)?
- Do deeper NDEs (higher Greyson scores) tend to have longer narratives?

Thank you to [Tony Galvan, Golden Dome Data Science](https://github.com/gdatascience) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-07-21')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 29)

nde_experiences <- tuesdata$nde_experiences

# Option 2: Read directly from GitHub

nde_experiences <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-21/nde_experiences.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-07-21')

# Option 2: Read directly from GitHub and assign to an object

nde_experiences = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-21/nde_experiences.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-07-21")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

nde_experiences = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-21/nde_experiences.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
nde_experiences = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-21/nde_experiences.csv", DataFrame)
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

### `nde_experiences.csv`

|variable         |class         |description                           |
|:----------------|:-------------|:-------------------------------------|
|entry_id         |double        |Unique NDERF experience identifier (numeric page ID on search.nderf.org). |
|gender           |character     |Gender of the experiencer (M or F). |
|classification   |character     |NDERF classification of the experience (NDE, Probable NDE, Possible NDE, etc.). Multiple values separated by semicolons. |
|country          |character     |Country of the experiencer, detected by AI from the narrative text. |
|category         |character     |Experience category assigned by NDERF (e.g., NDE, FDE, STE, OBE). |
|language         |character     |Language of the submitted narrative (e.g., english, french, spanish). |
|greyson_score    |double        |Score on the Greyson NDE Scale (0–32). A score of 7 or higher indicates a validated near-death experience. |
|post_date        |datetime<UTC> |Date the experience was submitted to NDERF. |
|exp_date         |datetime<UTC> |Date the near-death experience occurred (self-reported). |
|narrative_length |double        |Character count of the narrative text (proxy for level of detail in the account). |
|ai_obe           |logical       |Whether AI detected an out-of-body experience in the narrative. |
|ai_unity         |logical       |Whether AI detected a feeling of unity or oneness in the narrative. |
|ai_hellish       |logical       |Whether AI detected distressing or hellish imagery in the narrative. |
|ai_clinical      |logical       |Whether AI detected confirmed clinical death in the narrative. |
|ai_esp           |logical       |Whether AI detected extrasensory perception or seeing distant events in the narrative. |
|ai_past_lives    |logical       |Whether AI detected past life recall in the narrative. |
|ai_world_future  |logical       |Whether AI detected visions of the world's future in the narrative. |
|ai_aliens        |logical       |Whether AI detected alien or extraterrestrial encounters in the narrative. |

## Cleaning Script

```r
# Near-Death Experience (NDE) data scraped from the NDERF Search site
# Source: https://search.nderf.org/
#
# The Near Death Experience Research Foundation (NDERF) collects firsthand NDE
# accounts submitted online. Their search site embeds structured JSON metadata
# for each experience page. This script extracts that metadata (no narrative
# text is reproduced, respecting NDERF's copyright).
#
# The scrape covers IDs 1–10,100. Only ~6% of IDs contain valid structured data,
# yielding ~589 records spanning 1999–2025.

library(httr2)
library(jsonlite)
library(stringr)
library(tibble)
library(purrr)
library(dplyr)
library(readr)

# --- Scraping function ---
# Each NDERF search page embeds a JSON object in a <script> tag: `var exp = {...}`
# We extract structured fields only (no narrative text).
fetch_nderf_record <- function(id) {
  url <- paste0("https://search.nderf.org/en/exp/", id)

  resp <- tryCatch(
    request(url) |>
      req_retry(max_tries = 3, backoff = ~2) |>
      req_throttle(rate = 3 / 1) |>
      req_perform(),
    error = function(e) NULL
  )
  if (is.null(resp)) return(NULL)

  html <- resp_body_string(resp)

  # Extract JSON from "var exp = {...};" line
  json_match <- str_match(html, 'var exp = (\\{.+?\\});\\s*\\n')
  if (is.na(json_match[1, 2])) return(NULL)

  d <- tryCatch(
    fromJSON(json_match[1, 2], simplifyVector = FALSE),
    error = function(e) NULL
  )
  if (is.null(d)) return(NULL)
  if (is.null(d$GENDER)) return(NULL)

  # All types explicitly enforced to prevent bind_rows mismatches

  tibble(
    entry_id = as.integer(id),
    gender = as.character(d$GENDER %||% NA),
    classification = as.character(paste(d$CLASSIFICATION %||% "NA", collapse = ";")),
    country = as.character(d$COUNTRY_AI %||% NA),
    category = as.character(d$Category %||% NA),
    language = as.character(d$LANGUAGE %||% NA),
    greyson_score = as.integer(d$experiences[[1]]$greyson %||% NA),
    post_date = as.character(d$experiences[[1]]$POSTDATE %||% NA),
    exp_date = as.character(d$experiences[[1]]$EXPDATE %||% NA),
    narrative_length = as.integer(d$EXPLEN %||% NA),
    ai_obe = as.logical(d$ai_categories$OBE_AI %||% NA),
    ai_unity = as.logical(d$ai_categories$UNITY_AI %||% NA),
    ai_hellish = as.logical(d$ai_categories$HELLISH_AI %||% NA),
    ai_clinical = as.logical(d$ai_categories$CLINICAL_AI %||% NA),
    ai_esp = as.logical(d$ai_categories$ESP_AI %||% NA),
    ai_past_lives = as.logical(d$ai_categories$PASTLIVES_AI %||% NA),
    ai_world_future = as.logical(d$ai_categories$WORLDFUTURE_AI %||% NA),
    ai_aliens = as.logical(d$ai_categories$ALIENS_AI %||% NA)
  )
}

# --- Scrape with periodic saves (every 250 IDs) ---
cache_path <- "nde_experiences.csv"

all_ids <- 1:10100
batch_size <- 250

for (batch_start in seq(1, length(all_ids), by = batch_size)) {
  batch_end <- min(batch_start + batch_size - 1, length(all_ids))
  batch_ids <- all_ids[batch_start:batch_end]

  # Skip IDs already scraped

  if (file.exists(cache_path)) {
    existing_ids <- read_csv(cache_path, show_col_types = FALSE)$entry_id
    batch_ids <- setdiff(batch_ids, existing_ids)
  }
  if (length(batch_ids) == 0) next

  batch_results <- map(batch_ids, \(id) {
    tryCatch(fetch_nderf_record(id), error = function(e) NULL)
  })

  valid_results <- compact(batch_results)

  if (length(valid_results) > 0) {
    new_batch_df <- bind_rows(valid_results)

    if (file.exists(cache_path)) {
      existing <- read_csv(cache_path, show_col_types = FALSE) |>
        mutate(post_date = as.character(post_date),
               exp_date = as.character(exp_date))
      combined <- bind_rows(existing, new_batch_df) |>
        distinct(entry_id, .keep_all = TRUE) |>
        arrange(entry_id)
    } else {
      combined <- new_batch_df |> arrange(entry_id)
    }
    write_csv(combined, cache_path)
  }

  total <- if (file.exists(cache_path)) nrow(read_csv(cache_path, show_col_types = FALSE)) else 0
  cat(sprintf("[%s] IDs %d-%d | %d valid | Total: %d\n",
              format(Sys.time(), "%H:%M:%S"),
              min(batch_ids), max(batch_ids),
              length(valid_results), total))
}

# --- Load final dataset ---
nde_experiences <- read_csv(cache_path, show_col_types = FALSE)
cat("\nFinal dataset:", nrow(nde_experiences), "records x", ncol(nde_experiences), "columns\n")

```
