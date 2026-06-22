################################################################################
# National Monuments service - Wreck Inventory of Ireland
# https://www.arcgis.com/sharing/rest/content/items/d4b084c880b546fabe38345461b563d2/data
# Accessed 2026-06-10
# Curator: Cormac Monaghan
# A couple of notes ↓
# 1. Accessing the data initially returns a warning message because the some
#    of the dates and years values of the csv file are not consistent.
#    Instead of all rows being in dym format some of them are written as
#    "19th century" or "the 1800s". I could probably try some fancy regex to
#    better format all the dates nicely but I'm really bad at stuff like that.
#    Instead I plan to set these dates as NA but leave in a "descriptive date"
#    column for those potentially interested in these dates.
# 2. Additionally, many of the older wreaks (pre 1945) do not have accurate
#    coordinates and are hardcoded as zeros. However, the National Monuments
#    service is still searching for information on such wreaks. As such rather
#    than removing these I'm just going to recode them as NA as I think it could
#    still lead to some interesting analysis.
################################################################################

# Packages ---------------------------------------------------------------------
library(readr)
library(janitor)
library(dplyr)
library(lubridate)

# Accessing and tidying dataset ------------------------------------------------
wreck_inventory <- readr::read_csv(
  "https://www.arcgis.com/sharing/rest/content/items/d4b084c880b546fabe38345461b563d2/data",
  locale = readr::locale(encoding = "latin1")
) |>
  janitor::clean_names() |>
  dplyr::select(
    date = date_of_loss,
    year = date_of_loss_year_only,
    wreck_name,
    wreck_no,
    classification,
    description,
    descriptive_date = date_of_loss,
    place_of_loss,
    latitude = dd_lat,
    longitude = dd_long,
    source_of_co_ordinate
  ) |>
  # Turning inconsistent dates & years into NA values by making remaking
  # everything to be dmy format.
  # Additionally, setting hardcoded coordinates to be NA
  dplyr::mutate(
    date = lubridate::dmy(date),
    year = lubridate::year(date),
    latitude = ifelse(latitude == 0, NA, latitude),
    longitude = ifelse(longitude == 0, NA, longitude)
  )
