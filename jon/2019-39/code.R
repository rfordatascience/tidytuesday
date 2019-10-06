# New repository: https://github.com/jonthegeek/dataviz

# Inspired by https://twitter.com/spren9er/status/1177810296607522816

# This took a ton of RAM to render, so I don't library full packages unless I need
# them. However, these are the package needed for this:

# library(dplyr)
# library(readr)
# library(janitor)
# library(tidygraph)
# library(ggraph)
# library(gganimate)
# library(transformr)
library(magrittr)

data_dir <- "data/2019/2019-09-24/"
save_dir <- "jon/2019-39"

n_schools <- 12217
circle_sides <- 6

# Load and clean data -----------------------------------------------------

data <- readr::read_csv(fs::path(data_dir, 'school_diversity.csv')) %>%
  janitor::clean_names()

clean_data <- data %>%
  dplyr::select(leaid, total, school_year, diverse) %>%
  dplyr::rename(school = leaid) %>%
  dplyr::mutate(
    school_year = stringr::str_sub(school_year, 1, 4)
  ) %>%
  tidyr::drop_na() %>%
  # Only keep schools that have data for both years.
  dplyr::group_by(school) %>%
  dplyr::mutate(count = dplyr::n()) %>%
  dplyr::ungroup() %>%
  dplyr::filter(count == 2) %>%
  dplyr::select(-count) %>%
  # I want the totals to be integers.
  dplyr::mutate(
    total = as.integer(total)
  )

rm(data)

# It doesn't work below to use all 12k schools. Randomly choose N. Increase N
# once it works once to see how high it can be.
clean_data <- clean_data %>%
  dplyr::filter(school %in% sample(unique(clean_data$school), n_schools))

# glimpse(clean_data)


# Set up graph ------------------------------------------------------------

# Ok, I *think* I finally have it. Nodes have total_1994 and total_2016
# properties. EDGES also have a year property. We change the filter by edge
# year, and change the weight from total_1994 to total_2016. Let's see if ggraph
# and gganimate will let me do that...
school_nodes <- clean_data %>%
  tidyr::pivot_wider(
    names_from = school_year,
    values_from = c(diverse, total)
  ) %>%
  dplyr::select(
    name = school,
    diverse_1994,
    diverse_2016,
    total_1994,
    total_2016
  ) %>%
  dplyr::mutate(node_type = "school")

diverse_nodes <- clean_data %>%
  dplyr::group_by(school_year, diverse) %>%
  dplyr::summarize(
    total = sum(total)
  ) %>%
  tidyr::pivot_wider(
    names_from = school_year,
    values_from = total,
    names_prefix = "total_"
  ) %>%
  dplyr::rename(name = diverse) %>%
  dplyr::mutate(
    diverse_1994 = name,
    diverse_2016 = name,
    node_type = "diversity"
  )

all_nodes <- dplyr::bind_rows(school_nodes, diverse_nodes)

# Ok, now the edges.
all_edges <- clean_data %>%
  dplyr::select(
    from = diverse,
    to = school,
    school_year
  )

graph_data <- tidygraph::tbl_graph(
  nodes = all_nodes, edges = all_edges
)

rm(all_edges, all_nodes, diverse_nodes, school_nodes, clean_data)

# Calculate Layouts -------------------------------------------------------

layout_1994 <- graph_data %>%
  tidygraph::activate(edges) %>%
  tidygraph::filter(
    school_year == "1994"
  ) %>%
  ggraph::create_layout("circlepack", weight = total_1994) %>%
  dplyr::as_tibble()

layout_2016 <- graph_data %>%
  tidygraph::activate(edges) %>%
  tidygraph::filter(
    school_year == "2016"
  ) %>%
  ggraph::create_layout("circlepack", weight = total_2016) %>%
  dplyr::as_tibble()


# Adjust main groups ------------------------------------------------------

diverse_circles_1994 <- layout_1994 %>%
  dplyr::filter(!leaf) %>%
  dplyr::select(
    name,
    x0 = x,
    y0 = y,
    r,
    diverse_1994
  ) %>%
  dplyr::mutate(
    diverse_1994 = factor(
      diverse_1994,
      levels = c("Extremely undiverse", "Undiverse", "Diverse"),
      ordered = TRUE
    )
  )

radii_1994 <- diverse_circles_1994 %>%
  dplyr::arrange(diverse_1994) %>%
  dplyr::pull(r)
names(radii_1994) <- diverse_circles_1994 %>%
  dplyr::arrange(diverse_1994) %>%
  dplyr::pull(name)

spacer <- max(radii_1994)/3

diverse_circles_1994_adjusted <- diverse_circles_1994 %>%
  dplyr::mutate(
    diverse_1994 = factor(
      diverse_1994,
      levels = c("Extremely undiverse", "Undiverse", "Diverse"),
      ordered = TRUE
    ),
    original_x0 = x0,
    original_y0 = y0,
    x0 = 0,
    y0 = dplyr::case_when(
      name == "Diverse" ~ 0,
      name == "Undiverse" ~ radii_1994[["Diverse"]] +
        spacer +
        radii_1994[["Undiverse"]],
      name == "Extremely undiverse" ~ radii_1994[["Diverse"]] +
        spacer +
        2*radii_1994[["Undiverse"]] +
        spacer +
        radii_1994[["Extremely undiverse"]]
    ),
    x_offset = x0 - original_x0,
    y_offset = y0 - original_y0
  ) %>%
  dplyr::select(
    -original_x0, -original_y0
  )

diverse_circles_2016_adjusted <- layout_2016 %>%
  dplyr::filter(!leaf) %>%
  dplyr::select(
    name,
    r,
    diverse_1994,
    diverse_2016, # For connecting to the school data below
    original_x0 = x,
    original_y0 = y
  ) %>%
  dplyr::left_join(
    dplyr::select(
      diverse_circles_1994_adjusted,
      name, x0, y0
    ),
    by = "name"
  ) %>%
  dplyr::mutate(
    diverse_1994 = factor(
      diverse_1994,
      levels = c("Extremely undiverse", "Undiverse", "Diverse"),
      ordered = TRUE
    ),
    x0 = 3*max(radii_1994),
    x_offset = x0 - original_x0,
    y_offset = y0 - original_y0
  ) %>%
  dplyr::select(
    -original_x0, -original_y0
  )

all_diverse_circles <- diverse_circles_2016_adjusted %>%
  dplyr::select(-diverse_2016) %>%
  dplyr::bind_rows(diverse_circles_1994_adjusted) %>%
  dplyr::select(-x_offset, -y_offset)

# Adjust school data --------------------------------------------------

school_1994_plot_data <- layout_1994 %>%
  dplyr::filter(leaf) %>%
  dplyr::select(
    name,
    x0 = x,
    y0 = y,
    r,
    diverse_1994
  ) %>%
  dplyr::mutate(
    diverse_1994 = factor(
      diverse_1994,
      levels = c("Extremely undiverse", "Undiverse", "Diverse"),
      ordered = TRUE
    )
  ) %>%
  dplyr::left_join(
    dplyr::select(
      diverse_circles_1994_adjusted,
      diverse_1994, x_offset, y_offset
    ),
    by = "diverse_1994"
  ) %>%
  dplyr::mutate(
    x0 = x0 + x_offset,
    y0 = y0 + y_offset,
    school_year = factor("1994", levels = c("1994", "2016"), ordered = TRUE)
  ) %>%
  dplyr::select(-x_offset, -y_offset)

school_2016_plot_data <- layout_2016 %>%
  dplyr::filter(leaf) %>%
  dplyr::select(
    name,
    x0 = x,
    y0 = y,
    r,
    diverse_1994,
    diverse_2016
  ) %>%
  dplyr::mutate(
    diverse_1994 = factor(
      diverse_1994,
      levels = c("Extremely undiverse", "Undiverse", "Diverse"),
      ordered = TRUE
    )
  ) %>%
  dplyr::left_join(
    dplyr::select(
      diverse_circles_2016_adjusted,
      diverse_2016, x_offset, y_offset
    ),
    by = "diverse_2016"
  ) %>%
  dplyr::mutate(
    x0 = x0 + x_offset,
    y0 = y0 + y_offset,
    school_year = factor("2016", levels = c("1994", "2016"), ordered = TRUE)
  ) %>%
  dplyr::select(-diverse_2016, -x_offset, -y_offset)

all_school_data <- school_1994_plot_data %>%
  dplyr::bind_rows(school_2016_plot_data)

labels <- dplyr::tibble(
  x = c(min(all_diverse_circles$x0), max(all_diverse_circles$x0)),
  y = all_diverse_circles %>%
    dplyr::mutate(circle_top = y0 + r) %>%
    dplyr::pull(circle_top) %>%
    max() + spacer/2,
  text = c("1994", "2016")
)

rm(
  diverse_circles_1994,
  diverse_circles_1994_adjusted,
  diverse_circles_2016_adjusted,
  graph_data,
  layout_1994,
  layout_2016,
  school_1994_plot_data,
  school_2016_plot_data,
  radii_1994,
  spacer
)

# Animate! ----------------------------------------------------------------

title_text <- paste(
  "Diversity Changes of",
  scales::comma(n_schools),
  "U.S. School Districts"
)
length_seconds <- 20
fps <- 15
frames <- length_seconds*fps
pause_seconds <- 1
pause_frames <- ceiling(pause_seconds*fps)
# pause_start <- ceiling(pause_seconds*fps/2)

animation <- all_school_data %>%
  # dplyr::filter(
  #   name %in% sample(school_1994_plot_data$name, 100)
  # ) %>%
  ggplot2::ggplot() +
  ggplot2::aes(
    x0 = x0,
    y0 = y0,
    r = r,
    fill = diverse_1994,
    color = diverse_1994
  ) +
  ggforce::geom_circle(
    data = all_diverse_circles,
    show.legend = FALSE,
    alpha = 0.25
  ) +
  ggforce::geom_circle(n = circle_sides) +
  ggplot2::geom_text(
    ggplot2::aes(x = x, y = y, label = text),
    data = labels,
    inherit.aes = FALSE,
    size = 18/ggplot2::.pt,
    fontface = "bold"
  ) +
  ggplot2::coord_fixed() +
  ggplot2::theme_void() +
  ggplot2::scale_fill_viridis_d(
    guide = ggplot2::guide_legend(
      title = ""
    )
  ) +
  ggplot2::scale_color_viridis_d(guide = FALSE) +
  ggplot2::labs(
    title = "School Diversity",
    subtitle = title_text,
    caption = "#tidytuesday 2019.39 | @jonthegeek"
  ) +
  ggplot2::theme(
    plot.title = ggplot2::element_text(
      face = "bold",
      hjust = 0.5,
      size = 24
    ),
    plot.subtitle = ggplot2::element_text(
      face = "plain",
      hjust = 0.5,
      size = 14
    ),
    plot.caption = ggplot2::element_text(
      face = "plain",
      hjust = 0.5,
      size = 12,
      color = "gray"
    ),
    legend.text = ggplot2::element_text(
      face = "bold",
      # hjust = 0.5,
      size = 14
    )
  ) +
  # plot
  gganimate::transition_states(school_year, wrap = FALSE) +
  gganimate::shadow_mark(alpha = 0.5) +
  gganimate::ease_aes("cubic-in-out")
# animation

gganimate::animate(
  plot = animation,
  nframes = frames,
  fps = fps,
  width = 850,
  height = 800,
  renderer = gganimate::gifski_renderer(fs::path(save_dir, "school_diversity.gif")),
  start_pause = 0,
  end_pause = pause_frames
)
