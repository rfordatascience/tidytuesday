# NPSpecies - The National Park Service biodiversity database.   
# https://irma.nps.gov/npspecies/       
# Accessed September 2nd, 2024   
devtools::install_github("frankiethull/NPSpecies")

# get rdb data from curated pkg ----
# uh-oh, it is 96MB, dslc notes that cannot exceed 20MB #
nps_species_data <- NPSpecies::species

# let's focus on most visited parks! ----
# note that I'm filtering on NPs and 2023: 
# https://irma.nps.gov/Stats/Reports/Park
# https://irma.nps.gov/Stats/SSRSReports/National%20Reports/Annual%20Park%20Ranking%20Report%20(1979%20-%20Last%20Calendar%20Year)

# top 10-20 parks but do not exceed 20MB
top_visited <- c("GRSM", "GRCA", "ZION", "YELL", "ROMO", 
                 "YOSE", "ACAD", "GRTE", "JOTR", "OLYM", 
                 "GLAC", "CUVA", "INDU", "HOSP", "BRCA")

most_visited_nps_species_data <-
nps_species_data |>
  dplyr::filter(ParkCode %in% top_visited) |>
  # removed a few columns, already lots of info
  dplyr::select(-c(CategorySort, TaxonCode, TSN)) 
