This week we're exploring Sustainable Energy for all! Beyond the raw metrics, this dataset offers a window into how nations are balancing growth with green initiatives, challenging us to visualize the actual momentum behind the global energy transition.     

> The “**Sustainable Energy for all** (**SE4ALL**)” initiative, launched in 2010 by the UN Secretary General, established three global objectives to be accomplished by 2030: to ensure universal access to modern energy services, to double the global rate of improvement in global energy efficiency, and to double the share of renewable energy in the global energy mix. SE4ALL database supports this initiative and provides country level historical data for access to electricity and non-solid fuel; share of renewable energy in total final energy consumption by technology; and energy intensity rate of improvement.  

Some questions to get you going:  

* Which countries have the lowest capacity for solar energy?    
* What form of renewable energy has, on average, experienced the fasted rate of adoption?

## Creating the sample plot
```r
library(dplyr)
library(tidyplots)
library(ggplot2)
library(ggtext)

# framing: of 3 windy countries, which one has consumed the most wind power?
# A quick Google search suggested Denmark, Ireland, and Norway
target_countries <- c("Denmark", "Ireland", "Norway")
the_windies <- energy_cleaned |>
filter(country_name %in% target_countries) |>
select(
country_name,
yr,
wind_energy_consumption_tfec_pct
)
the_windies <- the_windies |>
mutate(yr = as.numeric(yr))

# creating the plot
sample_plot <- the_windies |>
tidyplot(x = yr, y = wind_energy_consumption_tfec_pct, color = country_name, fill = country_name) |>
add(
ggplot2::geom_area(position = "identity")
) |>
adjust_x_axis_title("Year") |>
adjust_y_axis_title("Wind energy consumption (% in TFEC)") |>
add_title("Wind Power Consumed by Population and Industry (%)") |>
add_caption("Denmark and Ireland maintained an upward trend upto 2010, but
Norway's consumption **levels out from 2007**."
) |>
adjust_size(width = 140, height = 120) |>
theme_tidyplot() +
theme(
plot.title = element_text(family = "roboto",size = 16, face = "bold", vjust = 10, margin = margin(t = 10)),
axis.title.y = element_text(size = 14, margin = margin(r = 18)),
axis.title.x = element_text(size = 14, margin = margin(t = 18)),
axis.text.x  = element_text(size = 11),
axis.text.y  = element_text(size = 11),
plot.caption = element_markdown(size = 12, hjust = 0, margin = margin(t = 20), lineheight = 1.5),
legend.position = "top",
legend.title = element_blank(),
legend.text = element_text(size = 9)
) +
scale_fill_manual(values = c("#009e73", "#56b4e9", "#d55e00")) +
scale_color_manual(values = c("#009e73", "#56b4e9", "#d55e00"))

# saving the plot image
ggsave(
"sample_plot.png",
sample_plot,
width = 10,
height = 8,
limitsize = FALSE
)
```

