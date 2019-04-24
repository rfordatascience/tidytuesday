library(tidyverse)
library(lubridate)
library(ggridges)

tidy_anime <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-23/tidy_anime.csv")

date <- tidy_anime %>%
  mutate(lub_date = ymd(start_date), 
         year = floor_date(lub_date, unit = "year"),
         decade = year(floor_date(lub_date, unit = years(10)))) %>%
  filter(is.na(decade) != TRUE,
         is.na(score) != TRUE)

ggplot(data = date, aes(x = score,
                        y = fct_rev(as.factor(decade)))) +
  geom_density_ridges(quantile_lines = TRUE,
                      quantiles = 2,
                      fill = "#C78283",
                      color = "#DEC9B7",
                      size = 1) +
  scale_x_continuous(breaks = seq(0,10,1)) + 
  labs(title = "Are we living in the golden age of anime?", 
       x = "Fan Score (1-10 from worst to best)",
       y = "Decade", 
       subtitle = "Anime from the last decade has the highest fan ratings",
       caption = "Data from Tam Nguyen and MyAnimeList.net via Kaggle") + 
  theme(
    ### Title, Subtitle, Caption controls
    plot.title = element_text(family = "Futura Medium",
                              size = 20,
                              face = "bold",
                              colour = "#DEC9B7",
                              hjust = -.13),
    plot.subtitle = element_text(family = "Futura Medium", 
                                 colour = "#F4F1F8",
                                 size = 12,
                                 hjust = -.10),
    plot.caption = element_text(family = "Futura Medium", 
                                size = 8, 
                                colour = "#F4F1F8",
                                hjust = -.11), 
    ### Axis controls
    axis.title = element_text(family = "Futura Medium", 
                              face = "bold",
                              size = 12,
                              colour = "#F4F1F8"), 
    axis.text = element_text(family = "Futura Medium",
                             size = 12, 
                             face = "bold", 
                             colour = "#F4F1F8",
                             hjust = 1, 
                             vjust = 0.75), 
    axis.text.x = element_text(family = "Futura Medium"), 
    axis.text.y = element_text(family = "Futura Medium"),
    axis.ticks = element_blank(),
    ### Panel backgrounds
    panel.background = element_rect(fill = "#415A64"), 
    plot.background = element_rect(fill = "#415A64"),
    panel.grid.major = element_line(linetype = "blank"), 
    panel.grid.minor = element_line(linetype = "blank"),
    legend.position = "none",
    ### Margin control
    plot.margin=grid::unit(c(4,0,0,2.5), "mm")) +
  ### So the tops of the ridges don't get cut off
  coord_cartesian(clip = "off")


ggsave("anime_rating_by_year.png")