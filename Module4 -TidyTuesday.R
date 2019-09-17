> ## Data from 2019-02-05 Recession and Housing Data
  library(tidyverse)
state_hpi <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-05/state_hpi.csv")
mortgage_rates <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-05/mortgage.csv")
recession_dates <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-05/recessions.csv")
View(state_hpi)
## To compare the Housing Price Index over the years 1975-2018 the following ggplot was used
## States are in color to better see the differences and a line was added to show the gerenal trend with all states

ggplot(state_hpi, aes(x = year, y = price_index)) +
  geom_point(aes(colour = state)) +
  geom_smooth(aes(linetype = state), se = FALSE)
ggplot(state_hpi, aes(year, price_index)) +
  geom_point(aes(colour = state)) +
  geom_smooth(se = FALSE) +
  labs(
    title= "Price Index of Houses per State from 1972-2018",
    x = "Year",
    y = "Price Index",
    color= "State"
  )

