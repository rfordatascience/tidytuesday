# Paste code used to create the curated dataset here. Include comments as
# necessary. If you did not need to clean the data, use a comment like the one
# below, but also load the data with readr::read_csv() to ensure the data can be
# loaded, and to use with `saving.R`. Delete this block of comments.

# Data provided by <source of data>. Some cleaning was necessary.
income_distribution <- readr::read_csv("https://sdmx.oecd.org/public/rest/data/OECD.WISE.INE,DSD_WISE_IDD@DF_IDD,/all?dimensionAtObservation=AllDimensions&format=csvfilewithlabels")

# dropping NA columns, contain the same value, add no value
  # STRUCTURE, STRUCTURE_ID, STRUCTURE_NAME, ACTION, FREQ, 
  # `Frequency of observation`, `Time period`, `Observation value`,
  # UNIT_MULT, `Unit multiplier`, DECIMALS (?), `Decimals` (?),
  # `Base period`, CONF_STATUS, `Confidentiality status`
  
# A lot of the columns above would be more useful in cases where you
  # were joining with other datasets, but they aren't contributing much
  # in this case.

cleaning <- income_distribution |>
  dplyr::select(
    -c(STRUCTURE,
       STRUCTURE_ID,
       STRUCTURE_NAME,
       ACTION,
       FREQ,
       `Frequency of observation`,
       `Time period`,
       `Observation value`,
       UNIT_MULT,
       `Unit multiplier`,
       DECIMALS,
       Decimals,
       PRICE_BASE,
       `Price base`,
       `Base period`,
       CONF_STATUS,
       `Confidentiality status`
       )
      )
  
# Next, would be cleaning variable names, but the way they're set up in the 
  # lends itself to dashboards and interactive builds, so the remaining colnames
  # were left untouched,

income_distribution <- cleaning
