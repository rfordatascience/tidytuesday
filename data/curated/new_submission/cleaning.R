library(tidyverse)

# Read raw file
pi_raw <- read_file(
  "https://raw.githubusercontent.com/eneko/Pi/master/one-million.txt"
)

# Data cleaning ----

# The file contains a header, then a line with "3.", then 1 million digits of
# pi, with 50 digits per line.

# Keep only the part after "3."
pi_raw_clean <- str_split(pi_raw, "3\\.")[[1]][2]

# Add the leading 3 back
pi_digits_str <- paste0("3", gsub("\\s+", "", pi_raw_clean))

# Extract digits only
pi_digits_clean <- str_extract_all(pi_digits_str, "[0-9]") %>% unlist()

# Convert to tibble
pi_digits <- tibble(
  digit_position = seq_along(pi_digits_clean),
  digit = as.integer(pi_digits_clean)
)

glimpse(pi_digits)
