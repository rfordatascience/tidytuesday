# Data provided by Grady Smith.

# Getting the data ----
library(tidyverse)
library(openxlsx)

# Extract the Spreadsheet ID from the Google Sheet URL
# The full link is: https://drive.google.com/file/d/1lz-xpqufGggdPh4gUeIdYvtB2s8ePewn/view
sheet_id <- "1lz-xpqufGggdPh4gUeIdYvtB2s8ePewn"

# Construct the direct export URL
export_url <- paste0(
  "https://docs.google.com/spreadsheets/d/",
  sheet_id,
  "/export?format=xlsx"
)

# Download to a temporary file
temp_xlsx <- tempfile(fileext = ".xlsx")
download.file(export_url, destfile = temp_xlsx, mode = "wb")

# Read using openxlsx
country_lyrics <- read.xlsx(temp_xlsx, sheet = 1) |>
  # Cleaning column names and drop empty column
  select(
    song = Song,
    artist = Artist,
    featuring = Featuring,
    entered_top_30_in = `Entered.Top.30.In:`,
    lyrics = Lyrics,
    writers = `Writers`,
    producer = `Producer`,
    rough_order = `Rough.Order`
  )
writers_producers <- read.xlsx(temp_xlsx, sheet = 2)

# Splitting the writers_producers table into the three categories ----

# Table 1: Primary Writers Summary
top_primary_writers <- writers_producers |>
  select(
    writer = Writer,
    song_count = `#.songs`
  ) |>
  drop_na()

# Table 2: All Co-Writers Summary
top_all_writers <- writers_producers |>
  select(
    writer = Writers,
    song_count = `#.Songs`
  ) |>
  drop_na()

# Table 3: Record Producers Summary
top_producers <- writers_producers |>
  select(producer = Producers, song_count = `#.Songsss`) |>
  drop_na()

