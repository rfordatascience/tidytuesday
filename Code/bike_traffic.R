########################################
# Module 8 Tidy Tuesday
# October 22, 2019
# Data from April 2, 2019 Tidy Tuesday
########################################

library(tidyverse)
library(lubridate)
bike_traffic <- read_csv("data/2019-04-02/bike_traffic.csv")

#1. Plot 1: pie chart by crossing, bike # slice size 
#2. Plot 2: box plot for bike # by time (time on x, bike no on y) OR heat map??

# Convert plots to pdf for Moodle
# Make sure to label script with which graph corresponds to which code
# Include rationale for the plots chosen 
# How plots adhere to key principles of data viz summarised in lecture video 

###########################################################################################
# Plot 1: Pie Chart of bike_traffic
###########################################################################################

head(bike_traffic)

bike_traffic_group <- group_by(bike_traffic, crossing) %>%
  group_by(drop("Sealth Trail"))

bike_traffic_group <- group_by(bike_traffic, crossing) 
bike_traffic_pct <- bike_traffic_group %>%
  summarise(total = sum(bike_count, na.rm = TRUE)) %>%
  mutate(pct = total / sum(total)*100)

bike_traffic_pct %>%
  ggplot(aes(x = "", y = pct, fill = crossing)) +
  geom_bar(color = "white", stat = "identity") +
  coord_polar("y") +
  geom_text(aes(label = paste0(round(pct), "%")),
            position = position_stack(vjust = 0.5), size = 3.5, color = "white") +
  labs(x = NULL, y = NULL, fill = NULL, title = "Total Bike Traffic") +
  theme_minimal()+
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 20),
        legend.position = "bottom") +
  scale_fill_manual(values = c("midnightblue", "slategray4", "goldenrod3", "palegreen4", "hotpink4", "darkcyan", "burlywood4"))
ggsave("total_bike_traffic.pdf", width = 10, height = 8, units = "in")  


###########################################################################################
# Plot 2: Bar Plot of bike_traffic
###########################################################################################

head(bike_traffic)
mdy_hms(bike_traffic$date)
bike_traffic$date <- mdy_hms(bike_traffic$date)
bike_traffic

bike_traffic_time <- bike_traffic %>%
  mutate(hour = hour(date),
         minute = minute(date),
         second = second(date))

bike_traffic_time <- bike_traffic_time %>%
  mutate(indicator_col = ifelse(hour < 12, "Morning", "Evening"))


bike_traffic_time$indicator_col <- factor(bike_traffic_time$indicator_col,
                                          levels = c("Morning", "Evening"),
                                          labels = c("Morning (midnight - 12pm)", "Evening (1pm - midnight)")) 

bike_traffic_time %>%
  ggplot(aes(x = crossing, y = bike_count, fill = indicator_col)) +
  geom_bar(position = 'dodge', stat = "identity", aes(fill = as.factor(indicator_col))) +
  labs(x = NULL, y = "Number of Bikes", title = "Time of Day Bike Traffic") +
  theme_minimal()+ 
  theme(axis.text.x = element_text(angle = -30, vjust = 0, hjust = 0),
        plot.title = element_text(hjust = 0.5, size = 20)) +
  guides(fill = guide_legend(title = "Time of Day")) +
  theme(panel.grid.major = element_line()) +
  scale_color_brewer(palette = "Greys")
ggsave("bike_traffic_bar.pdf")
