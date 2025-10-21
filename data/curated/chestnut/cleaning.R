# Paste code used to create the curated dataset here. Include comments as
# necessary. If you did not need to clean the data, use a comment like the one
# Data provided by <https://www.swissinfo.ch/eng/swiss-oddities/spring-begins-in-geneva-when-the-horse-chestnut-tree-blossoms/88756963>. 
chestnut <- readr::read_csv("data/curated/chestnut/data-Xup3Z.csv") |> 
  dplyr::select(year, date) |> 
  dplyr::mutate(date = lubridate::dmy(paste0(stringr::str_sub(date, start = 1L, end = 6L), year))) |> 
  dplyr::mutate(start_date = lubridate::dmy(paste0("01-01-", year))) |> 
  dplyr::mutate(days = as.numeric(date - start_date)) |> 
  dplyr::select(year, date, days)

chestnut[chestnut$days == 362, ]$year <- 2003
chestnut[chestnut$days == 362, ]$days <- chestnut[chestnut$days == 362, ]$days - 365

# View(chestnut)

chestnut_caption <- "Source: Marronnier officiel. https://ge.ch/grandconseil/m/secretariat/marronnier/"

# p <- ggplot2::ggplot(data = chestnut, mapping = ggplot2::aes(x = year, y = days)) +
#   ggplot2::geom_line() +
#   ggplot2::labs(
#     title = "The leaves of the official horse chestnut tree are opening earlier and earlier",
#     subtitle = "Days passed since January 1st until the appearance of the first official horse chestnut leaves of the year (1818-2024)",
#     x = NULL, y = NULL,
#     caption = stringr::str_wrap(chestnut_caption)
#   ) +
#   ggplot2::theme_bw(base_size = 24)
# 
# print(p)
# 
# ggplot2::ggsave(filename = "chestnut.png", plot = p, path = "data/curated/chestnut/", bg = "white", width = 24, height = 12)
