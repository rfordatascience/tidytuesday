library(httr)
library(tidyverse)
library(jsonlite)

# first httr request to get ranking data

req <- GET("api.henleypassportindex.com/api/v3/countries")

parsed <- req$content |> 
  rawToChar() |> 
  fromJSON()

# Data by year was nested into a list. 
# Here we separate them out so that each year has its own row.

rank_by_year <- parsed$countries |> 
  filter(has_data) |> 
  tidyr::unnest_longer(col = data) |> 
  select(code, country, region, data, year = data_id) |> 
  unnest_wider(col = data)


# The data for country_lists is pulled in with multiple httr requests.
# We can run a query for a single country at a time, and we get back a list
# with the country's name and code, and several data frames that show the 
# names and codes of the countries a passport owner has different visa access to. 

# We can define a function to transform the list into a data frame with columns that contain 
# these additional data frames. In order to meet Tidy Tuesday requirements,
# this data was transformed into JSON to be saved into a csv file.

list_to_nested_df <- function(input_list) {
  processed_data <- lapply(input_list, function(x) {
    if(is.data.frame(x)) {
      toJSON(I(list(x)))
    } else {
      x 
    }
  })
  
  df <- data.frame(processed_data)
  
  return(df)
}


country_lists <- data.frame()

for (i in unique(rank_by_year$code)) {
  print(i)
  
  req2 <- GET(paste0("api.henleypassportindex.com/api/v3/visa-single/", i))
  parsed2 <- req2$content |> 
    rawToChar() |> 
    fromJSON()
  
  add <- list_to_nested_df(parsed2)
  country_lists <-  rbind(add, country_lists)
  
  Sys.sleep(2)
}

# After the data is loaded in, you can run the following code to 
# transform the JSON back into nested data frames or tibbles:
#
# country_lists |>
#   mutate(across(c(3:7),
#                 ~map(.x, ~fromJSON(.x)[[1]] |> tibble()))) 