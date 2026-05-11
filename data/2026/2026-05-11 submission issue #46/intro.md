## Income Distribution  

The dataset this week comes from the [**OECD**](he OECD (Organisation for Economic Co-operation and Development)) (*Organisation for Economic Co-operation and Development*). 
The OECD is comprised of 38 member nations, a group of mostly high-income, developed economies committed to democracy and market-based economies, and acts as a forum for member countries to compare policy experiences, seek answers to common problems, and identify good practices.  

Income distribution is essentially a look at the 'typical' experience of a citizen, moving beyond simple averages to see the gap between the highest and lowest earners. Understanding this spread helps us visualize how economic growth actually translates into the daily lives of different communities.  

Dataset overview:  

> The OECD [**Income Distribution Database**](https://data-explorer.oecd.org/vis?lc=en&df[ds]=dsDisseminateFinalDMZ&df[id]=DSD_WISE_IDD%40DF_IDD&df[ag]=OECD.WISE.INE&dq=.A.......&pd=%2C&to[TIME_PERIOD]=false&vw=ov) (*IDD*) offers data on levels and trends 
in income inequality and poverty and is updated on a rolling basis, two to 
three times a year.  

Some questions you can answer:  

* On average, how has the earning power between age groups changed over the years in Luxembourg?  
* Was there a significant impact on Canada's CPI in 2019~2020?  

Thank you to [Jake Kaupp](https://github.com/jkaupp) for suggesting the OECD.  
Thank you to [Ntobeko Sosibo](https://github.com/afrikaniz3d-za) for curating
this week's dataset.  

&nbsp;  

### Sample plot  

```r
# Question being answered:
# How has

library(dplyr)
library(ggplot2)
library(tidyplots)
library(ggtext) 

# loading the data
income_distribution <- read.csv("income_distribution.csv")

# choosing explored variables
target_measures <- c(
  "Income from self-employment",
  "Income from self-employment and from goods produced for own consumption")
target_country <- "Estonia"

# filtering the data 
self_employed_estonia <- income_distribution |>
  filter(
    income_distribution$`Reference area` %in% target_country,
    income_distribution$`Measure` %in% target_measures
    ) |>
  mutate(
    yr = factor(TIME_PERIOD)
  )

# generating the plot
sample_income_distribution_plot <- self_employed_estonia |>
  tidyplot(x = yr, y = OBS_VALUE, color = Measure) |>
  add_mean_bar() |>
  add_title("How has the Self-employed Estonian fared?") |>
  add_caption("On average, self-employed Estonians that practice some form of self-subsistence earn more than those that didn't. Thid, however, wasn't the case  
  in **2004** and **2005**. A likely cause was the economic boom from **joining the EU**. The gap between the two measures returns post-2006 as as the  
              economy matured and some returned to the additional comforts afforded by the self-sufficient lifestyle.") |>
  adjust_y_axis_title("Mean income (€)") |>
  adjust_size(width = 360, height = 120) |>
  theme_tidyplot() +
  theme(
    plot.title = element_text(family = "Plus Jakarta Sans", size = 26, face = "bold", margin = margin(b = 20)),
    axis.title.y = element_text(size = 16, margin = margin(r = 18)),
    axis.title.x = element_blank(),
    axis.text.x  = element_text(size = 11),
    axis.text.y  = element_text(size = 11),
    plot.caption = ggtext::element_markdown(size = 14, hjust = 0, margin = margin(t = 40), lineheight = 1.6),
    legend.position = "top",
    legend.title = element_blank(),
    legend.text = element_text(size = 14)
  ) +
  scale_fill_manual(values = c("#56b4e9", "#004379")) +
  scale_color_manual(values = c("#56b4e9", "#004379"))

# saving/exporting the plot
ggsave(
  "sample_income_distribution_plot.png",
  plot = sample_income_distribution_plot,
  width = 16,
  height = 8,
  dpi = 300
)
```
