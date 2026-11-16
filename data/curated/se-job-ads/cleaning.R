# SE Job Ad Index, snapshot of 2026-11-03, by Jacob Top Møller.
# Source repository (CC BY 4.0): https://github.com/jacobtop-tcg/se-job-ad-index
# The CSV there was built with the Python scripts in the repository's scripts/
# folder, which read the public Greenhouse, Lever and Ashby job board APIs of
# 250 selected B2B software companies. METHOD.md in the repository has the
# title rule, the tag patterns and the pay extraction.
#
# The only cleaning step: provider salary fields say "1 YEAR" and ranges found
# in ad text say "year". Both are annual, so they are unified as "year".

library(tidyverse)

se_job_ads <- readr::read_csv(
  "https://raw.githubusercontent.com/jacobtop-tcg/se-job-ad-index/409c6f71afda12c58f156c6d4c92992b2e0cd9e4/data/2026-11-03/postings.csv"
) |>
  dplyr::mutate(
    pay_interval = dplyr::if_else(pay_interval == "1 YEAR", "year", pay_interval)
  )
