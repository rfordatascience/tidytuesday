## Burn duration ----
# Burn duration provided by <https://github.com/philshem/Sechselaeuten-data>. No cleaning was necessary.
year_duration <- readr::read_csv("https://raw.githubusercontent.com/philshem/Sechselaeuten-data/refs/heads/master/boeoegg_burn_duration.csv") |> 
  dplyr::mutate(burn_duration_minutes = round(burn_duration_seconds / 60, digits = 1)) |> 
  dplyr::select(year, burn_duration_minutes)

## Temperature ----
# Weather data provided by <https://opendatadocs.meteoswiss.ch/c-climate-data/c1-climate-stations_homogeneous>

# Metaparameters
meta_parameters <- readr::read_delim("https://data.geo.admin.ch/ch.meteoschweiz.ogd-nbcn/ogd-nbcn_meta_parameters.csv", delim = ";") |> 
  dplyr::select(parameter_shortname, dplyr::ends_with("_en"), parameter_granularity, parameter_unit) |> 
  dplyr::filter(parameter_granularity == "M") |> 
  dplyr::filter(parameter_group_en == "Temperature")


### Summer temperature ----
# ths200m0: Air temperature 2 m above ground; homogeneous monthly mean
weather <- readr::read_delim("https://data.geo.admin.ch/ch.meteoschweiz.ogd-nbcn/sma/ogd-nbcn_sma_m.csv", delim = ";") |> 
  dplyr::mutate(date = as.Date(reference_timestamp, format = "%d.%m.%Y %H:%S")) |> 
  dplyr::mutate(year = lubridate::year(date), month = lubridate::month(date)) |> 
  dplyr::select(year, month, ths200m0) |> 
  dplyr::filter(dplyr::between(month, left = 6, right = 8)) |> 
  dplyr::group_by(year) |> 
  dplyr::summarise(summer_temp = round(mean(ths200m0), digits = 1))

## Combine datasets ----
# Combine mean summer temperature in degrees Celsius and burn duration in minutes by year
sechselaeuten <- year_duration |> 
  dplyr::left_join(y = weather, by = dplyr::join_by(year)) |> 
  dplyr::mutate(record = dplyr::if_else(condition = summer_temp > 19, true = TRUE, false = FALSE))

## image ----
p <- ggplot2::ggplot(data = sechselaeuten, mapping = ggplot2::aes(x = burn_duration_minutes, y = summer_temp)) +
  ggplot2::geom_point(size = 4, colour = "brown") +
  ggplot2::geom_text(mapping = ggplot2::aes(x = burn_duration_minutes, y = summer_temp, label = year), data = sechselaeuten |> dplyr::filter(record == TRUE), size = 12, position = ggplot2::position_jitter(width = 0.5, height = 0.5)) +
  ggplot2::geom_smooth(se = FALSE, formula = "y ~ x", method = "lm", color = "red") +
  ggplot2::theme_bw(base_size = 28) +
  ggplot2::labs(
    title = "Zürich's Böög as a Summer Oracle",
    x = "Böög burn time (minutes)", y = "Summer temperature (°C)"
  ) +
  ggplot2::scale_x_continuous(limits = c(0, 60), breaks = seq(0, 60, 10)) +
  ggplot2::scale_y_continuous(limits = c(14, 24), breaks = seq(14, 24, 2))

ggplot2::ggsave(filename = "sechselaeuten.png", plot = p, path = "tt_submission/", width = 24, height = 12, bg = "white")
