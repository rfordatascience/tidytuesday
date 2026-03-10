# Paste code used to create the curated dataset here. Include comments as
# necessary. If you did not need to clean the data, use a comment like the one
# below, but also load the data with readr::read_csv() to ensure the data can be
# loaded, and to use with `saving.R`. Delete this block of comments.

# Clean data provided by Norwegian Veterinary Institute.
# No cleaning was necessary.
# The data is published at https://apps.vetinst.no/laksetap/
# Here only two datasets are shared, but people may investigate
# the other datasets as well. Files are downloaded manually.

library(tidytuesdayR)

monthly_mortality_data <- readr::read_csv("tt_submission/data-raw/monthly_mortality_data_2026-03-09.csv")

monthly_losses_data <- readr::read_csv("tt_submission/data-raw/monthly_losses_data_2026-03-09.csv")

tt_save_dataset(monthly_mortality_data)
tt_save_dataset(monthly_losses_data)

tt_intro()

tt_meta(
  title = "Salmonid Mortality Data",
  article_title = "https://www.vetinst.no/arrangementer/lansering-av-fiskehelserapporten-2026",
  article_url = "Launch of the Fish Health Report (in Norwegian)",
  source_title = "Norwegian Veterinary Institute",
  source_url = "https://apps.vetinst.no/laksetap/",
  image_filename = "Laks-i-merd-13-10-2014_2_web.jpg",
  image_alt = "Salmon in cage. Photo: Rudolf Svensen",
  attribution = "Novica Nakov",
  github = "novica",
  bluesky = "novica",
  linkedin = "novica"
)

tt_submit()
