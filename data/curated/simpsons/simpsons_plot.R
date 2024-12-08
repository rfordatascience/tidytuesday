###_____________________________________________________________________________
### The Simpson's data!
### Script to clean the data sourced from Kaggle
###_____________________________________________________________________________

# packages
library(httr)
library(tidyverse)
library(jsonlite)
library(fontawesome) # for some icons
library(showtext) #fonts look GREAT
library(sysfonts) #for some helper functions
library(ggtext)

###_____________________________________________________________________________
### Setup graph text / icons
###_____________________________________________________________________________

# You may need to run this to get the font awesome 6 brands font
# you can also download the fonts from
# https://fontawesome.com/download
# and add them directly to your C:\Windows\Fonts folder

sysfonts::font_add(family = "Font Awesome 6 Brands",
                   regular = "C:/Users/ndfos/Documents/fontawesome-free-6.6.0-desktop/otfs/Font Awesome 6 Brands-Regular-400.otf")

# activate showtext for RStudio
showtext_auto()

showtext_opts(dpi = 300)

# LinkedIn icon
linkedin_icon <- "&#xf08c"
linkedin_user <- "nicolas-foss"

# Github
github_icon <- "&#xf09b"
github_user <- "nicolasfoss"

# make a cool caption!

social_caption <- glue::glue("<span style='font-family:\"Font Awesome 6 Brands\";'>&#xf08c;</span> <span style='color: #03617A;'>{linkedin_user}</span> &nbsp;|&nbsp; <span style='font-family:\"Font Awesome 6 Brands\";'>&#xf09b;</span> <span style='color: #03617A;'>{github_user}</span>")

# Assume you already loaded your Simpson's data...

simpsons_episodes_plot <- simpsons_episodes |> 
  #mutate(us_viewers_in_millions = us_viewers_in_millions * 1000000) |> 
  dplyr::summarize(avg_views = mean(us_viewers_in_millions, na.rm = T),
            .by = original_air_year
            ) |> 
  ggplot2::ggplot(aes(original_air_year, avg_views)) + 
  ggplot2::geom_line(linejoin = "round", lineend = "round", color = "darkgray",
                     linewidth = 1.5
                     ) + 
  labs(title = "The Simpsons Avg Views Over the Years",
       subtitle = "Simpsons Dataset | Kaggle",
       x = "",
       y = "Views",
       fill = "",
       caption = social_caption
  ) +
  scale_y_continuous(labels = function(x) stringr::str_c(x, "m"), 
                     limits = c(0, 30)
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


# save
ggsave(
  "simpsons_line.png",
  plot = simpsons_episodes_plot,
  path = "C:/Users/ndfos/Documents/tidytuesday/data/curated/simpsons/",
  width = 3 * (16 / 9),
  height = 3,
  units = "in",
  dpi = 300, 
  bg = "white"
)

################################################################################
### End ########################################################################
################################################################################