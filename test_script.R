# New chunk in R script
library(ggplot2)
data(mpg)
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()
