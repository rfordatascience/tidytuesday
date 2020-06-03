# GOAL: Do some marbles race better than others? Who would I put my money on in
# season 2 of Marbula One? … If any of these questions interest you, read on and
# I’ll answer some of them.

# libraries ---------------------------------------------------------------
library(tidyverse)
library(grid)
library(gridExtra)  

# data --------------------------------------------------------------------
df <- read_csv("data/2020/2020-06-02/marbles.csv")



# position distributions --------------------------------------------------

# data manipulation
race_position <- df %>% 
  filter(!is.na(time_s)) %>% 
  mutate(race = as.factor(race)) %>% 
  group_by(race) %>%
  arrange(time_s, by_group = TRUE) %>% 
  mutate(position = seq(1, n(), 1)) %>% 
  ungroup() %>% 
  mutate(marble_name = reorder(marble_name, desc(position)))

# plot 
position_plot <- race_position %>% 
  ggplot(aes(x = position, y = marble_name)) + 
    geom_boxplot(width = 0.5, col = "dodgerblue4") + 
    scale_x_continuous(breaks = seq(1, 16, 2), position = "top") + 
    labs(
      x = "Race positions", 
      y = "Marble Name"
    ) + 
    theme(
      axis.line.x = element_line(size = 0.2), 
      axis.ticks.y = element_blank(),
      text = element_text(size = 13),
      panel.background = element_blank()
      )


# points plot -------------------------------------------------------------

# plot
points_plot <- df %>% 
  filter(!is.na(time_s), !is.na(points)) %>% 
  mutate(
    marble_name = factor(
      marble_name, 
      levels = levels(race_position$marble_name)
      )
    ) %>% 
  group_by(marble_name) %>% 
  summarise(points = sum(points, na.rm = TRUE)) %>% 
  ungroup() %>% 
  ggplot(aes(x = points, y = marble_name)) +
    geom_col(fill = "dodgerblue4", width = 0.35) + 
    geom_text(
      aes(label = points, hjust = -0.2), 
      col = "dodgerblue4", size = 3.5
      ) + 
    scale_x_continuous(breaks = seq(0, 60, 10),
                       limits = c(0, 61),
                       position = "top") + 
    labs(
      x = "Points"
    ) + 
    theme(
      panel.background = element_blank(), 
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(), 
      axis.title.y = element_blank(), 
      axis.line = element_blank(), 
      text = element_text(size = 13)
    )


# joining plots -----------------------------------------------------------
final_plot <- grid.arrange(
  position_plot, points_plot, nrow = 1, 
  top = textGrob("Marble positions vs. total points", gp = gpar(fontsize = 15)), 
  bottom = textGrob(
    "Data from Jelle's Marble Runs", 
    gp = gpar(fontface = 3, fontsize = 9), 
    hjust = 1, 
    x = 1
    ))


