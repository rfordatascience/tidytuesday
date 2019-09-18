## Tidy Tuesday 9.18.19
## Kat Racine
## Code Originated- 9.17.19

###

ggplot(data = gas_price) + 
  geom_point(mapping = aes(x = year, y = gas_current, color = "Retail Gas Price"), size = 4) + 
  geom_smooth(mapping = aes(x = year, y = gas_current), se = FALSE, color = "black") + 
  geom_point(mapping = aes(x = year, y = gas_constant, color = "2015 Relative Gas Price"), shape = 18, size = 4) + 
  geom_smooth(mapping = aes(x = year, y = gas_constant), se = FALSE, color = "black") + 
  theme_dark() + theme_classic() +
  labs(x = "Year", y = "Dollars per Gallon", title = "Average Historical Annual Gasoline Pump Price, 1929 - 2015", 
       caption = "Data Souce: Office of Energy Efficiency & Renewable Energy", 
       color = "") + 
  theme(legend.position = "top")

ggsave("tidey_tuesday_gas_plot.pdf")

  



