# Basotho Wool

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

Thank you to [Ntobeko Sosibo](https://github.com/afrikaniz3d-za) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-08-04')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 31)

basotho_wool <- tuesdata$basotho_wool

# Option 2: Read directly from GitHub

basotho_wool <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-04/basotho_wool.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-08-04')

# Option 2: Read directly from GitHub and assign to an object

basotho_wool = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-04/basotho_wool.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-08-04")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

basotho_wool = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-04/basotho_wool.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
basotho_wool = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-04/basotho_wool.csv", DataFrame)
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.

## Data Dictionary

### `basotho_wool.csv`

|variable               |class     |description                           |
|:----------------------|:---------|:-------------------------------------|
|ref_period_id          |integer   |Reference period identifier representing the timeframe of the trade flow, typically formatted as YYYY for annual data or YYYYMM for monthly data. |
|ref_year               |integer   |Reference year in which the trade flow occurred. |
|ref_month              |integer   |Reference month number in which the trade flow occurred, ranging from 1 to 12. |
|period                 |character |Combined time period string matching the exact statistical data reporting window. |
|reporter_code          |integer   |Numerical country code assigned by the United Nations Statistics Division to the country reporting the trade flow. |
|reporter_iso           |character |Three-letter ISO alpha-3 code of the country reporting the trade data. |
|reporter_desc          |character |Official standard English name of the reporting country or geographic territory. |
|flow_code              |character |Code indicating the direction of the trade transaction, such as import or export. |
|classification_code    |character |Code designating the commodity classification system used to categorize the goods, such as HS for Harmonized System. |
|cmd_code               |character |Specific commodity code identifying the traded product under the selected classification system. |
|cmd_desc               |character |Detailed English text description corresponding to the specific commodity code. |
|qty_unit_code          |integer   |Internal numerical identifier representing the metric used to measure product quantity. |
|qty_unit_abbr          |character |Abbreviated name of the unit of measurement used for the primary quantity, such as kg for kilograms. |
|qty                    |double    |Total quantity of the traded commodity measured in the primary unit of measurement. |
|is_qty_estimated       |logical   |Boolean flag indicating whether the primary quantity value was estimated or modeled by the United Nations Statistics Division rather than directly reported. |
|alt_qty_unit_code      |integer   |Internal numerical identifier representing the alternative metric used to measure product quantity if applicable. |
|alt_qty_unit_abbr      |character |Abbreviated name of the unit of measurement used for the secondary or alternative quantity. |
|alt_qty                |double    |Total quantity of the traded commodity measured in the alternative unit of measurement. |
|net_wgt                |double    |Net weight of the traded commodity in kilograms, excluding packaging. |
|is_net_wgt_estimated   |logical   |Boolean flag indicating whether the net weight value was estimated or modeled by the United Nations Statistics Division. |
|cifvalue               |double    |Total trade value inclusive of cost, insurance, and freight costs, reported in United States Dollars. |
|fobvalue               |double    |Total trade value measured free on board, capturing the value of the goods at the exporter's border excluding international shipping costs, reported in United States Dollars. |
|primary_value          |double    |Principal monetary value used for primary trade analysis, reported in United States Dollars. |
|legacy_estimation_flag |integer   |Status flag denoting processing classifications or historical estimation techniques applied to older records within the database. |

## Cleaning Script

```r
# Creating a free UN Comtrade Plus account to access the data via their API ----

# To access the data yourself you need an account and primary key
  # 1. Navigate to https://comtradeplus.un.org/ and register a free account
  # 2. Once logged in, navigate to the bottom left of the page and click on
  #    "Developer Portal". This will take you to the backend.
  # 3. Click on the white "Explore APIs" button. This takes you to the "UN
  #    Comtrade Database" page.
  # 4. Click on the Free APIs tier or option listed there, and look for a button
  #    that says "Subscribe".
  # 5. After subscribing with any name you want, click on your username/profile 
  #    name in the top right corner of the Developer Portal and select Profile.
  # 6. You will see a section labeled Your Subscriptions. Under the primary
  #    subscription, look for Primary Key. Click the "Show" button next to it to
  #    reveal your API key string, then copy it.
  # 7. Once you copy that primary key, you can jump straight back into R, plug
  #    it into set_primary_comtrade_key("PASTE-YOUR-KEY-HERE")

# Getting the monthly data ----

library(comtradr)
library(purrr)
library(dplyr)

# Letting the API know who's accessing the data
set_primary_comtrade_key("PASTE-YOUR-KEY-HERE")

# Free accounts are capped at 12-year windows for each query, so this dataset
# needed two (2)

# Querying what the world is importing from Lesotho (LSO) from 2001 to 2012
lesotho_wool_global_monthly_2001_2012 <- map_df(2001:2012, function(yr) {
  message(paste("Fetching global monthly rows for:", yr))
  
  ct_get_data(
    reporter = "all_countries",
    partner = "LSO",
    commodity_code = c("5101", "5103"),
    flow_direction = "import",
    frequency = "M",                  
    start_date = paste0(yr, "-01"),   
    end_date = paste0(yr, "-12")      
  )
})

# Querying what the world is importing from Lesotho (LSO) from 2013 to 2024
lesotho_wool_global_monthly_2013_2024 <- map_df(2013:2024, function(yr) {
  message(paste("Fetching global monthly rows for:", yr))
  
  ct_get_data(
    reporter = "all_countries",
    partner = "LSO",
    commodity_code = c("5101", "5103"),
    flow_direction = "import",
    frequency = "M",                  
    start_date = paste0(yr, "-01"),   
    end_date = paste0(yr, "-12")      
  )
})

# Creating the final table ----

library(dplyr)
library(tidyr)

# Merging the two tables
basotho_wool <- bind_rows( # Basotho is the culturally-respectful term
  lesotho_wool_global_monthly_2001_2012,
  lesotho_wool_global_monthly_2013_2024
  ) |>
  # Cleaning
  drop_na(ref_period_id) |> # a block of the first few columns are NA
  arrange(ref_year, ref_period_id) |>
  # Pruning these columns to lighten csv file size
  select(
    -c(
      count,                       # all rows are NA
      type_code,                   # all the same value ("C")
      freq_code,                   # all the same value ("M" - Monthly)
      flow_desc,                   # all the same value ("Import")
      partner_code,                # all the same value ("426" - Lesotho's code)
      partner_iso,                 # all the same value ("LSO" - Lesotho's ISO code)
      partner_desc,                # all the same value ("Lesotho")
      partner2code,                # all the same value ("0" - no additional partner)
      partner2iso,                 # all the same value ("W00")
      partner2desc,                # all the same value ("World")
      classification_search_code,  # all the same value ("HS")
      is_original_classification,  # all the same value ("TRUE")
      aggr_level,                  # all the same value ("4")
      is_leaf,                     # all the same value ("FALSE")
      customs_code,                # all the same value ("C00")
      customs_desc,                # all the same value ("TOTAL CPC")
      mos_code,                    # all the same value ("0")
      mot_code,                    # all the same value ("0")
      mot_desc,                    # all the same value ("TOTAL MOT")
      gross_wgt,                   # all the same value ("0")
      is_gross_wgt_estimated,      # all the same value ("FALSE")
      is_alt_qty_estimated,        # all the same value ("FALSE")
      is_reported,                 # all the same value ("FALSE")
      is_aggregate                 # all the same value ("TRUE")
      )
    )

```
