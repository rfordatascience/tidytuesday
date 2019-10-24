##Author: Natalie Von Tress
##Date: 10/23/19
##Dataset: tidytuesday Board Games 2019/03/12
##Description: Statistics regarding board game play time, number of players, game name, ratings, and more.


# Prepare Workspace and Obtain Data ---------------------------------------
##Clear workspace and load libraries
rm(list=ls(all=TRUE))
library(tidyverse)
library(ggplot2)

#Obtain data
board_games <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-12/board_games.csv")


# Explore Data ------------------------------------------------------------

View(board_games)
str(board_games)
summary(board_games)
head(board_games)
tail(board_games)
dim(board_games)


# Organize Data for Plotting ----------------------------------------------
##Filter every game that isn't monopoly
board_games %>%
  separate_rows(name, sep = " ") %>% 
  filter(name == "Monopoly" | name == "Monopoly:") -> monopoly_separated
monopoly_id <- monopoly_separated$game_id
board_games %>%
  filter(game_id %in% monopoly_id) -> monopoly_data
View(monopoly_data)


# Plotting ----------------------------------------------------------------
##Plot 1
monopoly_data %>%
  ggplot(aes(year_published, average_rating)) +
  geom_smooth(color = "black") +
  labs(title = "Average Rating Based on Year Published") +
  scale_x_continuous(name = "Year Game Published", expand = c(0,0)) +
  scale_y_continuous(name = "Average Rating", expand = c(0,0)) +
  theme_minimal() + theme(plot.title = element_text(hjust = 0.5))

monopoly_data %>%
  filter(users_rated > 900) %>%
  ggplot(aes(name, users_rated, fill = name)) +
  geom_bar(stat = "identity", width = 1) + 
  guides(fill = guide_legend(ncol = 1, byrow = TRUE)) + 
  scale_x_discrete(name = "Game", labels = NULL, expand = c(0,0)) + 
  scale_y_continuous(name = "Number of Users Who Rated the Game", expand = c(0,0)) + 
  scale_fill_brewer(palette = "Set3", name = "Game Name") + 
  labs(title = "Most Rated Monopoly Games") +
  theme_minimal() + theme(plot.title = element_text(hjust = 0.5))
