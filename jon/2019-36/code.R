library(tidyverse)
library(gganimate)
library(ggthemes)
library(scales)
library(fs)

# To-do: Add gpus and ram, add logos of designers. Also: Understand the units in
# ggplot better so I don't have to place things so much by trial and error.

data_dir <- "data/2019/2019-09-03/"
save_dir <- "jon/2019-36"
moore_csvs <- c(
  "cpu.csv"
  # "gpu.csv"
  # "ram.csv"
)
full_path <- fs::path(data_dir, moore_csvs)

cpu_data <- readr::read_csv(full_path) %>%
  dplyr::arrange(date_of_introduction) %>%
  dplyr::filter(
    !is.na(transistor_count)
    # ,
    # !is.na(area)
  ) %>%
  dplyr::mutate(
    date_of_introduction = as.integer(date_of_introduction)
  ) %>%
  dplyr::select(
    year = date_of_introduction,
    transistors = transistor_count,
    designer,
    processor
  ) %>%
  # For ranking, the dataset for each year is the dataset for that year *and all
  # previous years.* Let's use purrr::map to expand our list. Make sure all
  # years are covered, even if they don't have a cpu release (that's why I
  # switched from unique(.$year) to the current construct).
  purrr::map_dfr(
    min(.$year):max(.$year), function(this_year, cpu_data) {
      cpu_data %>%
        dplyr::filter(year <= this_year) %>%
        dplyr::mutate(year_included = this_year)
    },
    cpu_data = .
  )

# We'll base the prediction on the count of transistors at the start of the
# dataset.
starting_count <- cpu_data %>%
  dplyr::filter(year == min(year)) %>%
  dplyr::pull(transistors) %>%
  max()

moore_prediction_simple <- dplyr::tibble(
  year = 1972:(max(cpu_data$year))
) %>%
  dplyr::mutate(
    transistors = round(
      starting_count * 2^((year - min(cpu_data$year))/2)
    ),
    designer = "Moore's Law",
    processor = "(prediction)",
    year_included = year
  )

full_dataset <- cpu_data %>%
  dplyr::bind_rows(moore_prediction_simple) %>%
  dplyr::group_by(year_included) %>%
  dplyr::mutate(
    rank = rank(
      -transistors,
      ties.method = "first"
    )
  ) %>%
  dplyr::ungroup() %>%
  dplyr::filter(rank <= 10) %>%
  dplyr::arrange(year_included, rank) %>%
  dplyr::mutate(
    # Make sure these get treated as the same value. Making the processors
    # factors seems to have fixed the "blinking axis labels" issue.
    designer = as.factor(designer),
    processor = as.factor(processor)
  )

# I spent too much time looking up logos of the various designers to find a
# color for each. Most are blue, green, or red, though, so this isn't super
# helpful.
designer_logo_colors <- c(
  Acorn = "#0cf41f",
  `Acorn/DEC/Apple` = "#A3AAAE",
  AMD = "#4aaa4e",
  Apple = "#A3AAAE",
  `Bell Labs` = "#00a3da",
  `DEC WRL` = "#0060a1",
  Fujitsu = "#f70000",
  Graphcore = "#ff6e78",
  Hitachi = "#dd1d23",
  IBM = "#3a65af",
  `IBM/Nintendo` = "#3a65af",
  Intel = "#006ec0",
  Intersil = "#a61546",
  `Microsoft/AMD` = "#4aaa4e",
  MIPS = "#0069b0",
  `Moore's Law` = "#FF00FF",
  `MOS Technology` = "#017ff8",
  Motorola = "#01b6cc",
  NEC = "#13139c",
  Nvidia = "#8ac34b",
  Oracle = "#f10000",
  Qualcomm = "#3152d6",
  RCA = "#d84041",
  `Sony/IBM/Toshiba` = "#dddb4d",
  `Sony/Toshiba` = "#dddb4d",
  `Sun/Oracle` = "#f10000",
  `Texas Instruments` = "#b9352e",
  Toshiba = "#f80000",
  WDC = "#ea782d",
  Zilog = "#f8bd20"
)

static_plot <- full_dataset %>%
  ggplot2::ggplot() +
  ggplot2::aes(
    x = rank,
    y = transistors,
    fill = designer,
    color = designer
  ) +
  ggplot2::geom_col() +
  ggplot2::geom_text(
    ggplot2::aes(
      y = 0,
      label = paste(processor, " ")
    ),
    vjust = 0.2,
    hjust = 1,
    size = 5,
    color = "white"
  ) +
  ggplot2::geom_text(
    ggplot2::aes(
      y = transistors,
      label = scales::comma(transistors)
    ),
    hjust = -0.1,
    size = 5,
    color = "white"
  ) +
  ggplot2::guides(color = FALSE, fill = FALSE) +
  # Important note: The "x-axis" is the vertical axis, showing the rank.
  ggplot2::coord_flip(clip = "off", expand = FALSE) +
  ggplot2::scale_x_reverse() +
  # The example at
  # https://towardsdatascience.com/create-animated-bar-charts-using-r-31d09e5841da
  # used a ton of element_blanks specified in the theme call. Instead I'm using
  # theme_void and then tweaking the few actual tweaks.
  ggplot2::theme_void() +
  ggplot2::theme(
    panel.grid.major.x = ggplot2::element_line(
      size = 0.1,
      color = "grey"
    ),
    panel.grid.minor.x = ggplot2::element_line(
      size = 0.1,
      color = "grey"
    ),
    plot.title = ggplot2::element_text(
      size = 40,
      hjust = 0.5,
      face = "bold",
      color = "white"
    ),
    plot.subtitle = ggplot2::element_text(
      size = 16,
      hjust = 1,
      color = "white",
      face = "italic"
    ),
    plot.caption = ggplot2::element_text(
      # I feel like changing this is what caused the blinking. That's... weird.
      size = 120,
      hjust = 1,
      color = "white",
      margin = ggplot2::margin(-2.5, 0, 0, 0, "cm")
    ),
    plot.background = ggplot2::element_rect(fill = "black", color = "black"),
    plot.margin = ggplot2::margin(0, 10, 2, 10, "cm")
  ) +
  ggplot2::scale_fill_manual(values = designer_logo_colors) +
  ggplot2::scale_color_manual(values = designer_logo_colors) +
  # A NULL at the end of a ggplot + chain makes it easy to comment things out.
  NULL

# static_plot

# Animation ---------------------------------------------------------------

animation <- static_plot +
  transition_states(year_included, transition_length = 4, state_length = 1) +
  view_follow(fixed_x = TRUE)  +
  labs(
    title = "Moore's Law: Predictions vs Reality",
    subtitle  = "@jonthegeek | #TidyTuesday | 2019 week 36",
    caption = "{previous_state}"
  )

# Swap this flag depending on whether you're tweaking the UI or rendering.
tweaking <- FALSE

length_seconds <- 45
fps <- ifelse(tweaking, 2, 15)
frames <- length_seconds*fps
pause_seconds <- 3
pause_frames <- ceiling(pause_seconds*fps)

gganimate::animate(
  plot = animation,
  nframes = frames,
  fps = fps,
  width = 1280,
  height = 720,
  renderer = gifski_renderer(fs::path(save_dir, "moore.gif")),
  start_pause = pause_frames,
  end_pause = pause_frames
)

# I also played with an MP4 version, but ended up focusing on the gif.

# mp4_version <- gganimate::animate(
#   plot = animation,
#   nframes = frames,
#   fps = fps,
#   width = 1280,
#   height = 720,
#   renderer = gganimate::ffmpeg_renderer(),
#   start_pause = pause_frames,
#   end_pause = pause_frames
# )
#
# gganimate::anim_save(
#   filename = "Moore.mp4",
#   animation = mp4_version,
#   path = save_dir
# )
