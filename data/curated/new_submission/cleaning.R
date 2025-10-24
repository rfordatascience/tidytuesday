# Paste code used to create the curated dataset here. Include comments as
# necessary. If you did not need to clean the data, use a comment like the one
# below, but also load the data with readr::read_csv() to ensure the data can be
# loaded, and to use with `saving.R`. Delete this block of comments.

## burn duration ----
# https://github.com/philshem/Sechselaeuten-data
burn_duration <- readr::read_csv(file = "https://raw.githubusercontent.com/philshem/Sechselaeuten-data/refs/heads/master/boeoegg_burn_duration.csv") |> 
  dplyr::mutate(duration = round(burn_duration_seconds / 60, digits = 2)) |> 
  dplyr::select(year, duration)

## variable selection ----
variable_selection <- c("tre200m0", "tre200mn", "tre200mx", "sre000m0", "sremaxmv", "rre150m0")

## climate metadaata ----
climate_metadata <- readr::read_delim(
  file = "https://data.geo.admin.ch/ch.meteoschweiz.ogd-smn/ogd-smn_meta_parameters.csv", 
  delim = ";"
  ) |> 
  dplyr::select(c(1, ends_with("_en"), 10:13)) |> 
  dplyr::filter(parameter_granularity == "M") |> 
  dplyr::filter(parameter_shortname %in% variable_selection) |> 
  dplyr::select(variable = parameter_shortname, description = parameter_description_en)

## climate data ----
climate_data <- readr::read_delim(
  file = "https://data.geo.admin.ch/ch.meteoschweiz.ogd-smn/sma/ogd-smn_sma_m.csv", 
  delim = ";"
  ) |>
  dplyr::select(date = reference_timestamp, dplyr::any_of(variable_selection)) |>
  dplyr::mutate(date = lubridate::dmy_hm(date), year = lubridate::year(date), month = lubridate::month(date)) |>
  dplyr::filter(month %in% 6:8) |>
  dplyr::group_by(year) |> 
  dplyr::summarise(dplyr::across(.cols = -c(date, month), .fns = \(x) mean(x, na.rm = TRUE))) |>
  dplyr::ungroup() |> 
  dplyr::mutate(sre000m0 = sre000m0 / 60) |> 
  dplyr::mutate(dplyr::across(.cols = -c(year), .fns = \(x) round(x, digits = 2))) |> 
  dplyr::mutate(dplyr::across(.cols = -c(year), .fns = \(x) ifelse(is.nan(x), NA, x)))

## combine datasets ----
sechselaeuten <- dplyr::left_join(x = burn_duration, y = climate_data, by = dplyr::join_by(year)) |> 
  dplyr::mutate(record = ifelse(tre200m0 >= 19, TRUE, FALSE))

## plot ----
p <- ggplot2::ggplot(data = sechselaeuten, mapping = ggplot2::aes(x = duration, y = tre200m0)) +
  ggplot2::geom_point(size = 1, colour = "#f7b801") +
  ggplot2::geom_smooth(method = "lm", formula = "y ~ x", se = FALSE, colour = "#3d348b") +
  ggplot2::geom_smooth(method = "lm", formula = "y ~ x", se = TRUE, colour = "#7678ed") +
  ggplot2::geom_text(
    data = dplyr::filter(sechselaeuten, record == TRUE), 
    mapping = ggplot2::aes(x = duration, y = tre200m0, label = year), 
    colour = "#d90429",
    position = ggplot2::position_jitter(width = 0.5, height = 0.5)
  ) +
  ggplot2::scale_x_continuous(breaks = seq(0, 60, 10), limits = c(0, 60)) +
  ggplot2::scale_y_continuous(breaks = seq(14, 22, 2), limits = c(14, 22)) +
  ggplot2::labs(
    title = "Can an exploding snowman predict the summer season?",
    subtitle = "Zurich's Boeoeg as a weather oracle, 1923-2025",
    x = "Duration until head exploded (minutes)", 
    y = "Average summer temperature (°C)"
  ) +
  ggplot2::theme_bw(base_size = 6)

print(p)  

ggplot2::ggsave(filename = "sechselaeuten.png", plot = p, path = "tt_submission/", width = 10, height = 6, units = "cm", bg = "white")
