# Creating a free UN Comtrade Plus account to access the data via their API ----

# To access the data yourself you need an account and primary key
  # 1. Navigate to https://comtradeplus.un.org/ and register a free account
  # 2. Once logged in, navigate to the bottom left of the page and click on
  #    "Developer Portal". This will take you to the backend.
  # 3. Click on the white "Explore APIs" button. This takes you to the "UN
  #    Comtrade Database" page.
  # 4. Click on the Free APIs tier or option listed there, and look for a button
  #    that says "Subscribe".
  # 5. After subscribing with any name you want, click on your username/profile 
  #    name in the top right corner of the Developer Portal and select Profile.
  # 6. You will see a section labeled Your Subscriptions. Under the primary
  #    subscription, look for Primary Key. Click the "Show" button next to it to
  #    reveal your API key string, then copy it.
  # 7. Once you copy that primary key, you can jump straight back into R, plug
  #    it into set_primary_comtrade_key("PASTE-YOUR-KEY-HERE")

# Getting the monthly data ----

library(comtradr)
library(purrr)
library(dplyr)

# Letting the API know who's accessing the data
set_primary_comtrade_key("PASTE-YOUR-KEY-HERE")

# Free accounts are capped at 12-year windows for each query, so this dataset
# needed two (2)

# Querying what the world is importing from Lesotho (LSO) from 2001 to 2012
lesotho_wool_global_monthly_2001_2012 <- map_df(2001:2012, function(yr) {
  message(paste("Fetching global monthly rows for:", yr))
  
  ct_get_data(
    reporter = "all_countries",
    partner = "LSO",
    commodity_code = c("5101", "5103"),
    flow_direction = "import",
    frequency = "M",                  
    start_date = paste0(yr, "-01"),   
    end_date = paste0(yr, "-12")      
  )
})

# Querying what the world is importing from Lesotho (LSO) from 2013 to 2024
lesotho_wool_global_monthly_2013_2024 <- map_df(2013:2024, function(yr) {
  message(paste("Fetching global monthly rows for:", yr))
  
  ct_get_data(
    reporter = "all_countries",
    partner = "LSO",
    commodity_code = c("5101", "5103"),
    flow_direction = "import",
    frequency = "M",                  
    start_date = paste0(yr, "-01"),   
    end_date = paste0(yr, "-12")      
  )
})

# Creating the final table ----

library(dplyr)
library(tidyr)

# Merging the two tables
basotho_wool <- bind_rows( # Basotho is the culturally-respectful term
  lesotho_wool_global_monthly_2001_2012,
  lesotho_wool_global_monthly_2013_2024
  ) |>
  # Cleaning
  drop_na(ref_period_id) |> # a block of the first few columns are NA
  arrange(ref_year, ref_period_id) |>
  # Pruning these columns to lighten csv file size
  select(
    -c(
      count,                       # all rows are NA
      type_code,                   # all the same value ("C")
      freq_code,                   # all the same value ("M" - Monthly)
      flow_desc,                   # all the same value ("Import")
      partner_code,                # all the same value ("426" - Lesotho's code)
      partner_iso,                 # all the same value ("LSO" - Lesotho's ISO code)
      partner_desc,                # all the same value ("Lesotho")
      partner2code,                # all the same value ("0" - no additional partner)
      partner2iso,                 # all the same value ("W00")
      partner2desc,                # all the same value ("World")
      classification_search_code,  # all the same value ("HS")
      is_original_classification,  # all the same value ("TRUE")
      aggr_level,                  # all the same value ("4")
      is_leaf,                     # all the same value ("FALSE")
      customs_code,                # all the same value ("C00")
      customs_desc,                # all the same value ("TOTAL CPC")
      mos_code,                    # all the same value ("0")
      mot_code,                    # all the same value ("0")
      mot_desc,                    # all the same value ("TOTAL MOT")
      gross_wgt,                   # all the same value ("0")
      is_gross_wgt_estimated,      # all the same value ("FALSE")
      is_alt_qty_estimated,        # all the same value ("FALSE")
      is_reported,                 # all the same value ("FALSE")
      is_aggregate                 # all the same value ("TRUE")
      )
    )

