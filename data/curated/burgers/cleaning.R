# Mostly clean data provided by Steven Ponce (@poncest) via the {bobsburgersR} R
# package. Cleaning based on
# https://stevenponce.netlify.app/projects/standalone_visualizations/sa_2024-11-11.html

# pak::pak("poncest/bobsburgersR")
# pak::pak("tidytext")
# pak::pak("textdata")
library(bobsburgersR)
library(tidyverse)
library(tidytext)

transcript_data <- 
  bobsburgersR::transcript_data |> 
  dplyr::mutate(
    dplyr::across(
      c(season, episode),
      as.integer
    )
  )

# Calculate metrics. You will have to acknowledge downloading of afinn data if
# you have not used it before.
episode_metrics <-
  transcript_data |>
  dplyr::filter(!is.na(dialogue)) |>
  dplyr::summarize(
    # Basic dialogue metrics
    dialogue_density = dplyr::n() / max(line),
    avg_length       = mean(stringr::str_length(dialogue)),
    
    # Sentiment analysis - AFINN Sentiment Lexicon
    sentiment_variance = dialogue |>
      tibble::tibble(text = _) |>
      tidytext::unnest_tokens(word, text) |>
      dplyr::inner_join(tidytext::get_sentiments("afinn"), by = "word") |>
      dplyr::pull(value) |>
      var(na.rm = TRUE),
    
    # Word and punctuation metrics  
    unique_words      = dialogue |>
      # Using boundary() instead of "\\s+" as in the blog results in differences
      # in unique word counts, since punctuation doesn't get grouped with the
      # word it touches. See ?stringr::boundary for details. I also converted
      # all text to lowercase before counting.
      stringr::str_split(stringr::boundary("word")) |>
      unlist() |>
      tolower() |> 
      dplyr::n_distinct(),
    question_ratio    = mean(stringr::str_detect(dialogue, "\\?")),
    exclamation_ratio = mean(stringr::str_detect(dialogue, "!")),
    .by = c(season, episode)
  )

# You may wish to see the blog post for further preparation steps!
