# ggplot2 & gganimate code adapted from the example at
# https://towardsdatascience.com/create-animated-bar-charts-using-r-31d09e5841da

# Requires the dev build of ggplot2:
# devtools::install_github("tidyverse/ggplot2#3506")

library(fs)
library(readr)
library(dplyr)
library(stringr)
library(purrr)
library(ggplot2)
library(gganimate)
library(scales)

# To-do: Add logos of designers. Also: Understand the units in ggplot better so
# I don't have to place things so much by trial and error.

data_dir <- "data/2019/2019-09-03/"
save_dir <- "jon/2019-36"
cpu_path <- fs::path(data_dir, "cpu.csv")
gpu_path <- fs::path(data_dir, "gpu.csv")
ram_path <- fs::path(data_dir, "ram.csv")

cpu_data <- readr::read_csv(cpu_path) %>%
  dplyr::select(
    year = date_of_introduction,
    transistors = transistor_count,
    designer,
    processor
  ) %>%
  dplyr::mutate(type = "cpu")

gpu_data <- readr::read_csv(gpu_path) %>%
  dplyr::select(
    year = date_of_introduction,
    transistors = transistor_count,
    designer = designer_s,
    processor
  ) %>%
  dplyr::mutate(
    # There are a couple designers that are virtually the same here as in
    # cpu_data, but coded differently. Standardize.
    designer = stringr::str_replace_all(designer, ", ", "/"),
    type = "gpu"
  )

chip_data <- cpu_data %>%
  dplyr::bind_rows(gpu_data) %>%
  dplyr::arrange(year) %>%
  dplyr::mutate(
    year = as.integer(year)
  ) %>%
  dplyr::filter(
    !is.na(transistors),
    !is.na(year)
  ) %>%
  # For ranking, the dataset for each year is the dataset for that year *and all
  # previous years.* Let's use purrr::map to expand our list. Make sure all
  # years are covered, even if they don't have a cpu release (that's why I
  # switched from unique(.$year) to the current construct).
  purrr::map_dfr(
    min(.$year):max(.$year), function(this_year, chip_data) {
      chip_data %>%
        dplyr::filter(year <= this_year) %>%
        dplyr::mutate(year_included = this_year)
    },
    chip_data = .
  )

# We'll base the prediction on the count of transistors at the start of the
# dataset.
starting_count <- chip_data %>%
  dplyr::filter(year == min(year)) %>%
  dplyr::pull(transistors) %>%
  max()

moore_prediction_simple <- dplyr::tibble(
  year = (min(chip_data$year) + 1):(max(chip_data$year))
) %>%
  dplyr::mutate(
    transistors = round(
      starting_count * 2^((year - min(chip_data$year))/2)
    ),
    designer = "Moore's Law",
    processor = "(prediction)",
    year_included = year
  )

full_dataset <- chip_data %>%
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

# levels(full_dataset$designer) %>%
#   setdiff(names(designer_logo_colors))

# I spent too much time looking up logos of the various designers to find a
# color for each. Most are blue, green, or red, though, so this isn't super
# helpful.
designer_logo_colors <- c(
  `3dfx` = "#d67600",
  Acorn = "#0cf41f",
  `Acorn/DEC/Apple` = "#A3AAAE",
  AMD = "#4aaa4e",
  Apple = "#A3AAAE",
  ArtX = "#4aaa4e",
  ATI = "#4aaa4e",
  `Bell Labs` = "#00a3da",
  `DEC WRL` = "#0060a1",
  Flare = "#cd4e31",
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
  `Nvidia/Sony` = "#8ac34b",
  Oracle = "#f10000",
  Qualcomm = "#3152d6",
  RCA = "#d84041",
  Sega = "#12559a",
  SGI = "#73217c",
  `Sony/IBM/Toshiba` = "#dddb4d",
  `Sony/Toshiba` = "#dddb4d",
  `Sun/Oracle` = "#f10000",
  `Texas Instruments` = "#b9352e",
  Toshiba = "#f80000",
  VideoLogic = "#f27b05",
  WDC = "#ea782d",
  Zilog = "#f8bd20"
)

static_plot <- full_dataset %>%
  # While tweaking, it can be helpful to only look at a subset of the data.
  dplyr::filter(
    year_included >= 1971,
    year_included <= 1974
  ) %>%
  ggplot2::ggplot() +
  ggplot2::aes(
    x = transistors,
    y = rank,
    fill = designer,
    color = designer
  ) +
  ggplot2::geom_col() +
  ggplot2::geom_text(
    ggplot2::aes(
      # Place it at 1 if you do a log transform, because that will become 0 with
      # the log transform.
      x = 0,
      label = paste(processor, " ")
    ),
    vjust = 0.2,
    hjust = 1,
    size = 5,
    color = "white"
  ) +
  ggplot2::geom_text(
    ggplot2::aes(label = scales::comma(transistors)),
    hjust = -0.1,
    size = 5,
    color = "white"
  ) +
  ggplot2::guides(color = FALSE, fill = FALSE) +
  ggplot2::scale_y_reverse() +
  # I did a lot of work to get a log-transformed scale working, but I think it
  # hides the advancement. Leave it untransformed.
  # ggplot2::scale_y_continuous(trans = "log2") +
  # The towardsdatascience example used a ton of element_blanks specified in the
  # theme call. Instead I'm using theme_void and then tweaking the few actual
  # tweaks.
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
  # In the animation, I'm basically going to do a "facet_frame", so it can be
  # helpful to look at the plot with a facet_wrap to kinda see what will happen
  # in the animation.
  ggplot2::facet_wrap(ggplot2::vars(year_included), scales = "free_x") +
  # A NULL at the end of a ggplot + chain makes it easy to comment things out.
  NULL

static_plot

# Animation ---------------------------------------------------------------

animation <- static_plot +
  gganimate::transition_states(
    year_included,
    transition_length = 4,
    state_length = 1
  ) +
  gganimate::view_follow(fixed_y = TRUE) +
  ggplot2::labs(
    title = "Moore's Law: Predictions vs Reality",
    subtitle  = "@jonthegeek | #TidyTuesday | 2019 week 36",
    caption = "{previous_state}"
  )

# Swap this flag depending on whether you're tweaking the UI or rendering.
tweaking <- TRUE

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
  renderer = gganimate::gifski_renderer(fs::path(save_dir, "moore.gif")),
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
