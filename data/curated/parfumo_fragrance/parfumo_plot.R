###_____________________________________________________________________________
### Produce a plot .png file for the Tidy Tuesday Parfumo Dataset!
###_____________________________________________________________________________

library(tidyverse)
library(paletteer)
library(sysfonts)
library(showtext)
library(fontawesome)
library(ggtext)

###_____________________________________________________________________________
### Set up a cool caption!
###_____________________________________________________________________________

# You may need to run this to get the font awesome 6 brands font
# you can also download the fonts from
# https://fontawesome.com/download
# and add them directly to your C:\Windows\Fonts folder

sysfonts::font_add(family = "Font Awesome 6 Brands",
                   regular = "C:/Users/ndfos/Documents/fontawesome-free-6.6.0-desktop/otfs/Font Awesome 6 Brands-Regular-400.otf")

# activate showtext for RStudio
showtext::showtext_auto()

showtext::showtext_opts(dpi = 300)

# LinkedIn icon
linkedin_icon <- "&#xf08c"
linkedin_user <- "nicolas-foss"

# Github
github_icon <- "&#xf09b"
github_user <- "nicolasfoss"

# make a cool caption!

social_caption <- glue::glue("<span style='font-family:\"Font Awesome 6 Brands\";'>&#xf08c;</span> <span style='color: #03617A;'>{linkedin_user}</span> &nbsp;|&nbsp; <span style='font-family:\"Font Awesome 6 Brands\";'>&#xf09b;</span> <span style='color: #03617A;'>{github_user}</span>")

# palettes

quant_palettes <- paletteer::palettes_c_names

# data already loaded from cleaning.R
# a sample bar plot

parfumo_data_bar <- parfumo_data_clean |>
  filter(Release_Year >= 1900) |> 
  summarize(total_ratings = sum(Rating_Count, na.rm = T),
            .by = Release_Year
            ) |> 
  ggplot(aes(x = Release_Year, y = total_ratings, fill = total_ratings)) + 
  geom_col(position = "dodge") + 
  scale_fill_paletteer_c(palette = "ggthemes::Orange-Blue Diverging", direction = -1
                         ) + 
  labs(title = "Evolution of Fragrance Ratings Years 1900 - Present",
       subtitle = "Parfumo Fragance Dataset | Kaggle",
       x = "Year",
       y = "Release Count",
       fill = "Ratings Count",
       caption = social_caption
       ) + 
  theme_minimal() + 
  theme(plot.background = element_blank(), 
        panel.grid = element_blank(),
        plot.caption = element_textbox_simple(),
        text = element_text(color = "darkslategray"),
        plot.title = element_text(color = "dodgerblue"),
        plot.subtitle = element_text(color = "darkgray"),
        legend.title = element_text(color = "dodgerblue", size = 7),
        axis.title = element_text(color = "darkgray"),
        legend.position = "right",
        legend.position.inside = c(0.25, 0.5),
        legend.text = element_text(size = 6)
        )

ggsave(
  "parfumo_data_bar.png",
  plot = parfumo_data_bar,
  path = "C:/Users/ndfos/Documents/tidytuesday/data/curated/parfumo_fragrance/",
  width = 3 * (16 / 9),
  height = 3,
  units = "in",
  dpi = 300, 
  bg = "white"
)

# a sample scatterplot

parfumo_data_scatter <- parfumo_data_clean |>
  filter(Release_Year >= 1900) |> 
  ggplot(aes(x = Rating_Count, y = Rating_Value, color = Rating_Value)) + 
  geom_point(
    position = position_jitterdodge(
      jitter.width = 0.5,
      jitter.height = 0.5,
      seed = 1984
    ),
    alpha = 0.25
  ) +
  scale_color_paletteer_c(palette = "ggthemes::Orange-Blue Diverging", direction = -1) + 
  labs(title = "Relationship Between Rating Count and Actual Rating",
       subtitle = "Parfumo Fragance Dataset | Kaggle",
       x = "Count",
       y = "Rating",
       color = "Rating",
       caption = social_caption
  ) + 
  theme_minimal() + 
  theme(plot.background = element_blank(), 
        panel.grid = element_blank(),
        plot.caption = element_textbox_simple(),
        text = element_text(color = "darkslategray"),
        plot.title = element_text(color = "dodgerblue"),
        plot.subtitle = element_text(color = "darkgray"),
        legend.title = element_text(color = "dodgerblue"),
        axis.title = element_text(color = "darkgray")
  )

ggsave(
  "parfumo_data_scatter.png",
  plot = parfumo_data_scatter,
  path = "C:/Users/ndfos/Documents/tidytuesday/data/curated/parfumo_fragrance/",
  width = 3 * (16 / 9),
  height = 3,
  units = "in",
  dpi = 300,
  bg = "white"
)
