# Mostly clean data provided by the {usdatasets} R package
# (https://cran.r-project.org/package=usdatasets). No cleaning was necessary.

# pak::pak("usdatasets")
library(usdatasets)
cia_factbook <- usdatasets::cia_factbook_tbl_df |> 
  dplyr::mutate(
    dplyr::across(
      c("area", "internet_users"),
      as.integer
    )
  )
