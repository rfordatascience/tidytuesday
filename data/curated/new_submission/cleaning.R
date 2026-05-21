library(tidyverse)
library(readxl)

# Download XLSX file from https://zenodo.org/records/17648712
raw_data <- read_xlsx("EPLP/EPLP_Dataset_Workbook_v2.xlsx", sheet = 2, skip = 1)

eplp <- raw_data |>
  # Missing
  mutate(
    across(
      where(is.numeric), ~replace_values(.x, -99 ~ NA)
    )
  ) |>
  mutate(
    across(
      where(is.character), ~replace_values(.x, "-99" ~ NA)
    )
  ) |>
  # Not applicable
  mutate(
    across(
      where(is.character), ~replace_values(.x, "-98" ~ "Not applicable")
    )
  )

