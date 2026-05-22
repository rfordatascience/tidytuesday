library(tidyverse)
library(readxl)

# If you don't want to automatically download unknown files, download the XLSX file from https://zenodo.org/records/17648712
xlsx_url <- "https://zenodo.org/records/17648712/files/EPLP_Dataset_Workbook_v2.xlsx?download=1"
xlsx_file <- "EPLP_Dataset_Workbook_v2.xlsx"
if (!file.exists(xlsx_file)) {
  download.file(xlsx_url, destfile = xlsx_file, mode = "wb")
}
raw_data <- read_xlsx(xlsx_file, sheet = 2, skip = 1)

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

