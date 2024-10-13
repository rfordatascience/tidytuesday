# Data scraped from https://www.whaleresearch.com/ and cleaned (imperfectly) with the {orcas} R package (https://github.com/jadeynryan/orcas).

# Scraping and cleaning script can be found at https://github.com/jadeynryan/orcas/blob/master/data-raw/data_cwr.R.

orcas <- readr::read_csv(
  "https://raw.githubusercontent.com/jadeynryan/orcas/refs/heads/master/data-raw/cwr_tidy.csv"
)
