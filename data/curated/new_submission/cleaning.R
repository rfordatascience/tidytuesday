# Scotland
download.file("https://www.nrscotland.gov.uk/media/0ytjopcq/all-names-given-to-babies-between-1974-to-2025.zip", destfile = "baby-names/scotland.zip")
unzip("baby-names/scotland.zip", exdir = "baby-names")
scotland_names <- readr::read_csv("baby-names/full-list-1974-2025.csv")


# England and Wales
ew_data_boys <- openxlsx::read.xlsx("https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/livebirths/datasets/babynamesinenglandandwalesfrom1996/1996to2024/babynames1996to2024.xlsx", sheet = "Table_2", startRow = 5)
ew_boys <- ew_data_boys |>
  tidyr::pivot_longer(-Name) |>
  tidyr::separate_wider_delim(name, delim = ".", names = c("Year", "Data")) |>
  tidyr::pivot_wider(names_from = "Data", values_from = "value") |>
  dplyr::mutate(Sex = "Boy") |>
  dplyr::select(Year, Sex, Name, Number = Count, Rank) |>
  dplyr::mutate(
    dplyr::across(c(Year, Rank, Number), as.numeric)
  ) |>
  dplyr::arrange(
    Year, Name
  )
ew_data_girls <- openxlsx::read.xlsx("https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/livebirths/datasets/babynamesinenglandandwalesfrom1996/1996to2024/babynames1996to2024.xlsx", sheet = "Table_1", startRow = 5)
ew_girls <- ew_data_girls |>
  tidyr::pivot_longer(-Name) |>
  tidyr::separate_wider_delim(name, delim = ".", names = c("Year", "Data")) |>
  tidyr::pivot_wider(names_from = "Data", values_from = "value") |>
  dplyr::mutate(Sex = "Girl") |>
  dplyr::select(Year, Sex, Name, Number = Count, Rank) |>
  dplyr::mutate(
    dplyr::across(c(Year, Rank, Number), as.numeric)
  ) |>
  dplyr::arrange(
    Year, Name
  )
england_wales_names <- rbind(ew_boys, ew_girls) |>
  tidyr::drop_na()


# Northern Ireland
ni_boys_data <- openxlsx::read.xlsx("https://www.nisra.gov.uk/files/nisra/documents/2026-04/Full_Name_List_NI_97_25.xlsx", sheet = "Table 1", startRow = 6)
ni_boys_list <- ni_boys_data |>
  split.default(ceiling(seq_along(ni_boys_data) / 3)) |>
  lapply(\(x) { names(x) <- paste0("V", 1:3); x })
all_years <- data.frame(cols = colnames(ni_boys_data)) |>
  dplyr::filter(
    stringr::str_detect(cols, "Name")
  ) |>
  dplyr::mutate(cols = readr::parse_number(cols)) |>
  unlist() |>
  unname()
names(ni_boys_list) <- all_years
ni_boys <- ni_boys_list |>
  dplyr::bind_rows(.id = "Year") |>
  tibble::as_tibble() |>
  dplyr::mutate(Sex = "Boy") |>
  dplyr::select(Year, Sex, Name = V1, Number = V2, Rank = V3) |>
  dplyr::mutate(
    Number = dplyr::if_else(Number == "-", "0", Number)
  ) |>
  dplyr::mutate(
    dplyr::across(c(Year, Rank, Number), as.numeric)
  ) |>
  dplyr::arrange(
    Year, Name
  )
ni_girls_data <- openxlsx::read.xlsx("https://www.nisra.gov.uk/files/nisra/documents/2026-04/Full_Name_List_NI_97_25.xlsx", sheet = "Table 2", startRow = 6)
ni_girls_list <- ni_girls_data |>
  split.default(ceiling(seq_along(ni_girls_data) / 3)) |>
  lapply(\(x) { names(x) <- paste0("V", 1:3); x })
all_years <- data.frame(cols = colnames(ni_girls_data)) |>
  dplyr::filter(
    stringr::str_detect(cols, "Name")
  ) |>
  dplyr::mutate(cols = readr::parse_number(cols)) |>
  unlist() |>
  unname()
names(ni_girls_list) <- all_years
ni_girls <- ni_girls_list |>
  dplyr::bind_rows(.id = "Year") |>
  tibble::as_tibble() |>
  dplyr::mutate(Sex = "Girl") |>
  dplyr::select(Year, Sex, Name = V1, Number = V2, Rank = V3) |>
  dplyr::mutate(
    Number = dplyr::if_else(Number == "-", "0", Number)
  ) |>
  dplyr::mutate(
    dplyr::across(c(Year, Rank, Number), as.numeric)
  ) |>
  dplyr::arrange(
    Year, Name
  )
ni_names <- rbind(ni_boys, ni_girls)



