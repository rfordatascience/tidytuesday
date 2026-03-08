# Data downloaded from https://dashboard.repairmonitor.org/?language=en as
# "repairs-en.xlsx". Cleaning applied to fix variable names and data types.

library(tidyverse)
library(readxl)
library(janitor)

# Update this to point to your downloaded file.
repairs_xlsx_file <- "repairs-en.xlsx"

repairs_all <- readxl::read_xlsx(repairs_xlsx_file, col_types = "text") %>%
  janitor::clean_names() %>%
  dplyr::rename(
    model = model_type_number_and_or_serial_number,
    problem_description = problem_description_probable_cause,
    repaired = has_the_product_been_repaired,
    repair_method = if_yes_what_did_you_do_to_repair_it,
    partial_repair_notes = if_half_repaired_what_did_you_do_what_advice_did_you_give,
    failure_reasons = if_not_repaired_why_could_you_not_repair_it_list,
    failure_reason_open = if_not_repaired_why_could_you_not_repair_it_open_answer,
    repairability = reparability_of_product_1_difficult_10_easy,
    used_repair_info = did_you_use_repair_information,
    repair_info_source = where_did_this_information_come_from,
    repair_info_url = source_repair_information_url_website,
    suggestions = do_you_have_any_suggestions_for_other_repairers_of_this_or_similar_product
  ) %>%
  dplyr::mutate(
    repair_date = ymd(repair_date),
    repair_cafe_number = as.integer(repair_cafe_number),
    estimated_year_of_production = as.integer(estimated_year_of_production),
    repairability = as.integer(repairability)
  )

# Split off detail/free-text columns to keep repairs.csv under 20 MB.
repairs_text_cols <- c(
  "model",
  "defect_found",
  "problem_description",
  "repair_method",
  "partial_repair_notes",
  "failure_reasons",
  "failure_reason_open",
  "used_repair_info",
  "repair_info_source",
  "repair_info_url",
  "suggestions"
)

repairs <- dplyr::select(repairs_all, -tidyselect::all_of(repairs_text_cols))
repairs_text <- dplyr::select(
  repairs_all,
  repair_id,
  tidyselect::all_of(repairs_text_cols)
)
