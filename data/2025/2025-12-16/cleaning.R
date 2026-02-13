# Data read in from roundabouts package, cleaning removes strange tags, separates country, town, county, and state columns. 
# Separates lat and long columns and fixes data types

roundabouts <- roundabouts::roundabouts

roundabouts_clean <- roundabouts |>
  dplyr::mutate(address = stringr::str_remove(address, stringr::fixed("<![CDATA["))) |>  # remove strange tags from address field
  dplyr::mutate(address = stringr::str_remove(address, stringr::fixed("]]>"))) |>
  dplyr::mutate(country = stringr::str_extract(address, "\\([^)]+\\)$"), # extract string within last bracket
                country = stringr::str_remove_all(country, "[\\(\\)]"),  # remove brackets
                address2 = stringr::str_remove(address, "\\s*\\([^)]+\\)$")) |>  # remove last () from original address
  tidyr::separate(address2, into = c("town_city", "county_area", "state_region"), sep = ",") |> # separate address by comma
  tidyr::separate(coordinates, into = c("lat", "long"), sep = ",") |> # separate latitude longitude by comma
  dplyr::select(name, address, town_city, county_area, state_region, country, lat, long, everything()) |> # reorder variables
  dplyr::mutate(lat = as.numeric(lat), long = as.numeric(long), # fix data types
                year_completed = as.integer(year_completed), 
                approaches = as.integer( approaches), 
                driveways = as.integer(driveways))

