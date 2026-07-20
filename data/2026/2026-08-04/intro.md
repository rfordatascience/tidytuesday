This week we're exploring **Lesotho's Wool Trade**. The dataset comes from the
[UN Comtrade Database](https://comtradeplus.un.org/) using the `comtradr` package.
The country is known as "Lesotho", and its people are referred to as "Basotho" (pronounced "ba-soo-too"). 

Extract from the article "**The mountain men behind Lesotho’s wool wealth** -
*More than 80,000 herders tend the country’s sheep and goats*" by Sechaba Mokhethi for [GroundUp News](https://groundup.org.za/article/the-mountain-men-behind-lesothos-wool-wealth/):  

> For generations, Lesotho’s economy depended heavily on migrant labour to South African mines. But as mining jobs declined, many rural households turned back to livestock production. Today, wool and mohair have become one of the country’s most valuable agricultural exports.
> 
> “During the 2024–2025 season alone, around M800-million entered the country through wool and mohair sales,” says Thinyane. That does not include the sale of animals for meat or breeding.
> 
> “Our wool is sold on the international market through Port Elizabeth in South Africa, where the International Wool Textile Organisation testing centre is located,” he explains. “Before wool is sold, it is tested there. Buyers then compete through auctions, and prices are determined.”
> 
> Thinyane says Lesotho is internationally known for high-quality mohair from Angora goats, prized in luxury fashion and textile industries for its softness and durability.
> 
> But the industry’s success depends heavily on the painstaking work done by herders like Tšoeu who spend freezing winters and scorching summers caring for livestock in the remote mountains.


Some questions you can answer:  

- Does Winter (being in the Southern hemisphere, these are the months **June**, **July** and **August**) impact Basotho wool quantity/volume exported and revenue?  
- Which country imports the most Basotho wool at time on average?  

Here's the code used to generate the sample chart:
```r
library(dplyr)
library(ggplot2)
library(tidyplots)
library(ggtext) 
library(scales) 

basotho_wool_2023 <- basotho_wool |>
  filter(ref_year == 2023) |>
  group_by(reporter_desc) |>
  summarise(total_primary_value = sum(primary_value, na.rm = TRUE)) |>
  ungroup() |>
  arrange(total_primary_value) |>
  mutate(reporter_desc = factor(reporter_desc, levels = reporter_desc))

# generating the horizontal bar chart
basotho_wool_plot <- basotho_wool_2023 |>
  tidyplot(x = total_primary_value, y = reporter_desc, color = reporter_desc) |>
  add_sum_bar(alpha = 0.8) |>
  add_title("Global Basotho Wool Imports (2023)") |>
  add_caption("Using mirror trade statistics, this plot shows the principal monetary value of wool items recorded by global importing partners from Lesotho in **2023**.  
              By focusing on **primary_value**, the dataset captures the main statistical focus value standardized by the UN Comtrade database, bypassing  
              inconsistencies between CIF and FOB declarations across different regions.") |>
  adjust_x_axis(labels = scales::label_dollar(scale_cut = scales::cut_short_scale())) |> 
  adjust_x_axis_title("Total Import Value (Primary Value USD)") |>
  adjust_size(width = 370, height = 60) |> 
  theme_tidyplot() +
  geom_text(
    aes(label = scales::dollar(total_primary_value, scale_cut = scales::cut_short_scale())),
    hjust = -0.15,
    size = 5,
    fontface = "bold",
    color = "black"
  ) +
  theme(
    plot.title = element_text(family = "Plus Jakarta Sans", size = 26, face = "bold", margin = margin(b = 20)),
    axis.title.x = element_text(size = 16, margin = margin(t = 18)),
    axis.title.y = element_blank(),
    axis.line.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.text.x  = element_blank(),
    axis.text.y  = element_text(size = 14, margin = margin(r = 10)),
    axis.line.y = element_blank(),
    axis.ticks.y = element_blank(),
    plot.caption = ggtext::element_markdown(size = 14, hjust = 0, margin = margin(t = 40), lineheight = 1.6),
    legend.position = "none" 
  )

# saving/exporting the plot
ggsave(
  "sample_basotho_wool_2023_primary_value_plot.jpg",
  plot = basotho_wool_plot,
  width = 9,
  height = 3,
  dpi = 300
)
```

