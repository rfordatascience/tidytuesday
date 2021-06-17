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

# I'm going to need to know the totals down below to rescale the squares.
totals <- clean_data %>%
  dplyr::group_by(school_year, diverse) %>%
  dplyr::summarize(
    total = sum(total)
  )

diverse_nodes <- totals %>%
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

# Experiment with transferring it to a treemap. 1 square to 1 square, or 3
# squares to 3 squares? Hmm. Answer: 3 to 3; you lose the divisions for 2016 if
# not (duh, since we're coloring by the 1994 value)
# graph_data %>%
#   tidygraph::activate(nodes) %>%
#   tidygraph::filter(
#     diverse_1994 == "Diverse"
#   ) %>%
#   tidygraph::activate(edges) %>%
#   tidygraph::filter(
#     school_year == "1994"
#   ) %>%
#   ggraph::ggraph("treemap", weight = total_1994) +
#   ggraph::geom_node_tile(ggplot2::aes(fill = diverse_1994)) +
#   ggplot2::coord_fixed() +
#   ggplot2::scale_fill_viridis_d()

# Later I'll play around to choose the weight variable by year, but I'll
# probably wrap some things earlier in this process into a function that will
# make that easier.
diversity_names <- c("Diverse", "Undiverse", "Extremely undiverse")
layouts_1994 <- purrr::map_dfr(
  diversity_names,
  function(this_diversity) {
    graph_data %>%
      tidygraph::activate(nodes) %>%
      tidygraph::filter(
        diverse_1994 == this_diversity
      ) %>%
      tidygraph::activate(edges) %>%
      tidygraph::filter(
        school_year == "1994"
      ) %>%
      ggraph::create_layout("treemap", weight = total_1994) %>%
      dplyr::as_tibble() %>%
      # This section scales each layout by its size.
      dplyr::mutate(
        conversion_factor = sqrt(max(total_1994)) / sqrt(maximum_total),
        x = x * conversion_factor,
        y = y * conversion_factor,
        width = width * conversion_factor,
        height = height * conversion_factor,
        year = "1994"
      ) %>%
      dplyr::select(
        year,
        node_type,
        x,
        y,
        width,
        height,
        name,
        diverse_1994
      )
  }
)

layouts_2016 <- purrr::map_dfr(
  diversity_names,
  function(this_diversity) {
    graph_data %>%
      tidygraph::activate(nodes) %>%
      tidygraph::filter(
        diverse_2016 == this_diversity
      ) %>%
      tidygraph::activate(edges) %>%
      tidygraph::filter(
        school_year == "2016"
      ) %>%
      ggraph::create_layout("treemap", weight = total_2016) %>%
      dplyr::as_tibble() %>%
      # This section scales each layout by its size.
      dplyr::mutate(
        conversion_factor = sqrt(max(total_2016)) / sqrt(maximum_total),
        x = x * conversion_factor,
        y = y * conversion_factor,
        width = width * conversion_factor,
        height = height * conversion_factor,
        year = "2016"
      ) %>%
      dplyr::select(
        year,
        node_type,
        x,
        y,
        width,
        height,
        name,
        diverse_1994,
        # For this one we also need to know diverse_2016 for layout, and for
        # fill of the big squares.
        diverse_2016
      )
  }
)

all_layouts <- dplyr::bind_rows(layouts_1994, layouts_2016) %>%
  dplyr::mutate(
    diverse_1994 = factor(
      diverse_1994,
      levels = c("Extremely undiverse", "Undiverse", "Diverse"),
      ordered = TRUE
    ),
    diverse_2016 = factor(
      diverse_2016,
      levels = c("Extremely undiverse", "Undiverse", "Diverse"),
      ordered = TRUE
    )
  )

# Adjust layout placement ------------------------------------------------------

# We want to distribute the squares vertically and horizontally. As-is,
# everything is aligned based on their bottom-left corner, but everything is
# positioned by their center.

category_squares <- all_layouts %>%
  dplyr::filter(node_type == "diversity")

# Move to the right a constant amount such that the left edge of all is past the
# largest 1994 square by a spacer amount.
spacer <- min(category_squares$width)/2

right_edge_1994 <- category_squares %>%
  dplyr::filter(year == "1994") %>%
  dplyr::mutate(
    right = x + width/2
  ) %>%
  dplyr::pull(right) %>%
  max()

target_left_edge_2016 <- right_edge_1994 + spacer

category_squares_x_shifted <- category_squares %>%
  dplyr::mutate(
    x = dplyr::if_else(
      year == "1994",
      x,
      x + target_left_edge_2016
    ),
    x_offset = dplyr::if_else(
      year == "1994",
      0,
      target_left_edge_2016
    )
  )

# Move up a constant amount *per category* such that the bottom edge is above
# the previous top edge by spacer.
# Diverse: 0
# Undiverse: max(height(Diverse)) + spacer
# Extremely undiverse: max(heigh(Undiverse)) + spacer
heights_df <- category_squares_x_shifted %>%
  dplyr::group_by(name) %>%
  dplyr::summarize(
    category_top = max(height)
  )

heights <- heights_df$category_top
names(heights) <- heights_df$name

category_squares_xy_shifted <- category_squares_x_shifted %>%
  dplyr::mutate(
    y_orig = y,
    y = dplyr::case_when(
      name == "Diverse" ~ y,
      name == "Undiverse" ~ y +
        heights[["Diverse"]] + spacer,
      name == "Extremely undiverse" ~ y +
        heights[["Diverse"]] + spacer +
        heights[["Undiverse"]] + spacer
    ),
    y_offset = y - y_orig
  ) %>%
  dplyr::select(-y_orig)

school_rectangles_1994 <- all_layouts %>%
  dplyr::filter(node_type == "school", year == "1994") %>%
  dplyr::left_join(
    category_squares_xy_shifted %>%
      dplyr::select(year, diverse_1994, x_offset, y_offset),
    by = c("year", "diverse_1994")
  ) %>%
  dplyr::mutate(x = x + x_offset, y = y + y_offset) %>%
  dplyr::select(year, x, y, width, height, name, diverse_1994)

school_rectangles_2016 <- all_layouts %>%
  dplyr::filter(node_type == "school", year == "2016") %>%
  dplyr::left_join(
    category_squares_xy_shifted %>%
      dplyr::select(year, diverse_2016, x_offset, y_offset),
    by = c("year", "diverse_2016")
  ) %>%
  dplyr::mutate(x = x + x_offset, y = y + y_offset) %>%
  dplyr::select(year, x, y, width, height, name, diverse_1994)

school_rectangles <- dplyr::bind_rows(
  school_rectangles_1994,
  school_rectangles_2016
)

labels <- dplyr::tibble(
  x = c(min(category_squares_xy_shifted$x), max(category_squares_xy_shifted$x)),
  y = category_squares_xy_shifted %>%
    dplyr::mutate(top = y + height/2) %>%
    dplyr::pull(top) %>%
    max() + spacer/2,
  text = c("1994", "2016")
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
pause_seconds <- 3
pause_frames <- ceiling(pause_seconds*fps)
# pause_start <- ceiling(pause_seconds*fps/2)

animation <- school_rectangles %>%
  ggplot2::ggplot() +
  ggplot2::aes(
    x = x,
    y = y,
    width = width,
    height = height,
    fill = diverse_1994
  ) +
  ggplot2::geom_tile(
    data = dplyr::select(category_squares_xy_shifted, -year),
    alpha = 0.5
  ) +
  ggplot2::geom_tile(color = "#222222") +
  ggplot2::scale_fill_viridis_d(
    guide = ggplot2::guide_legend(
      title = "Diversity (1994)"
    ),
    alpha = 0.8
  ) +
  ggplot2::coord_fixed() +
  ggplot2::theme_void() +
  ggplot2::geom_text(
    ggplot2::aes(x = x, y = y, label = text),
    data = labels,
    inherit.aes = FALSE,
    size = 18/ggplot2::.pt,
    fontface = "bold"
  ) +
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
    ),
    legend.title = ggplot2::element_text(
      face = "bold",
      size = 16,
      hjust = 0.5
    )
  ) +
  gganimate::transition_states(year, wrap = TRUE) +
  # gganimate::shadow_mark(alpha = 0.25) +
  gganimate::ease_aes("cubic-in-out")
# animation

start_time <- lubridate::now()
gganimate::animate(
  plot = animation,
  nframes = frames,
  fps = fps,
  width = 850,
  height = 800,
  renderer = gganimate::gifski_renderer(fs::path(save_dir, "school_diversity_sqiare.gif")),
  start_pause = 0,
  end_pause = pause_frames
)
lubridate::now() - start_time
