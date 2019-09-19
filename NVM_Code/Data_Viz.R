##Author: Natalie Von Tress
##Date: 9/18/19
##Dataset: tidytuesday 2019-09-17 National Park Visits, national_parks.csv
##Description: The dataset includes information for public lands and number of visitors. This dataset classifies parks by type, region, state, etc. 


# Get the data:
##Provided by tidytuesday
park_visits <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-17/national_parks.csv")

view(park_visits)

#Plot: 
ggplot(data = park_visits) + geom_col(mapping = aes(x = region, y = visitors, fill = state), alpha = 1/5, position = "identity") + labs(x = "Region", y = "Number of Visitors", legend = "State", title = "Public Lands Visitors in Different Regions of the United States") + theme_bw()

ggsave("nationalparks_tidytuesday.pdf", width = 11, height = 8.5, units = "in")
