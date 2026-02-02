This week we're exploring US Agricultural Tariffs! The dataset comes from the [USITC Tariff Database](https://dataweb.usitc.gov/tariff/annual), which contains tariff rates for all products imported into the United States from 1997-2025. This week's data focuses on agricultural and food products (HTS Chapters 1-24), covering everything from live animals to beverages.

This is part of a potential series of US tariff datasets exploring different sectors of the Harmonized Tariff Schedule. The data includes Most Favored Nation (MFN) rates that apply to normal trade relations, as well as preferential rates under various trade agreements like NAFTA/USMCA, and individual bilateral agreements with countries like Chile, Australia, and Korea. Tariff rates can include both ad valorem (percentage-based) and specific (per-unit) components, and they can change multiple times within a year.

> Welcome to the U.S. International Trade Commission. We’re an independent, nonpartisan, quasi-judicial federal agency that fulfills a range of trade-related mandates. We provide high-quality, leading-edge analysis of international trade issues to the President and the Congress. The Commission is a highly regarded forum for the adjudication of intellectual property and trade disputes.

* How do tariff rates for agricultural products compare between different trade agreements?
* Which products have seen the largest changes in MFN rates over time?
* Do products with higher MFN rates tend to have more preferential trade agreements?
* How have NAFTA/USMCA rates evolved from the 1990s to today?

This submission was generated with the help of Claude Sonnet 4.5 via Posit Assistant (in private beta at the time of this submission). [Learn more about Posit Assistant and sign up](https://posit.co/products/ai/).

Code for the plot:

```r
library(conflicted)
conflicted::conflict_prefer_all("dplyr", quiet = TRUE)
library(tidyverse)
library(lubridate)
library(ggtext)

# Load the data
tariff_agricultural <- read_csv("tariff_agricultural.csv")
agreements <- read_csv("agreements.csv")

# Add year columns for joining
tariff_with_years <- tariff_agricultural |>
  mutate(
    begin_effective_year = year(begin_effective_date),
    end_effective_year = year(end_effective_date)
  )

# Create all combinations of hts8-agreement pairs with years 2000-2024
tariff_hts_agreement <- tariff_agricultural |>
  distinct(hts8, agreement)

tariff_agricultural_years <- tariff_hts_agreement |>
  crossing(year = 2000:2024)

# Join to get the rates that were in effect for each year
tariff_rates_by_year <- tariff_agricultural_years |>
  left_join(
    tariff_with_years,
    join_by(
      hts8,
      agreement,
      year >= begin_effective_year,
      year <= end_effective_year
    )
  ) |>
  filter(!is.na(ad_val_rate))

# Remove duplicates (rates that apply to same product-agreement-year)
tariff_rates_by_year_clean <- tariff_rates_by_year |>
  distinct(hts8, agreement, year, ad_val_rate, specific_rate)

# Extract HTS section from the first 2 digits of hts8
tariff_rates_with_section <- tariff_rates_by_year_clean |>
  mutate(
    hts_chapter = as.integer(substr(hts8, 1, 2)),
    section = case_when(
      hts_chapter <= 5 ~ "I. Live Animals & Animal Products",
      hts_chapter <= 14 ~ "II. Vegetable Products",
      hts_chapter <= 15 ~ "III. Animal/Vegetable Fats & Oils",
      hts_chapter <= 24 ~ "IV. Prepared Foodstuffs",
      TRUE ~ "Other"
    )
  )

section_colors <- c(
  "I. Live Animals & Animal Products" = "#D55E00",
  "II. Vegetable Products" = "#009E73",
  "III. Animal/Vegetable Fats & Oils" = "#CC79A7",
  "IV. Prepared Foodstuffs" = "#0072B2"
)

mfn_by_section <- tariff_rates_with_section |>
  # Filter for reasonable percentage rates
  filter(ad_val_rate > 0, ad_val_rate < 1) |> 
  left_join(agreements, by = "agreement") |>
  filter(agreement_full == "Most Favored Nation (MFN)") |>
  group_by(year, section) |>
  summarise(
    avg_rate = mean(ad_val_rate, na.rm = TRUE),
    n_products = n(),
    .groups = "drop"
  ) |>
  filter(n_products >= 10) |>
  mutate(
    section_label = case_when(
      section == "I. Live Animals & Animal Products" ~ 
        "<span style='color:#D55E00'>**I. Live Animals & Animal Products**</span>",
      section == "II. Vegetable Products" ~ 
        "<span style='color:#009E73'>**II. Vegetable Products**</span>",
      section == "III. Animal/Vegetable Fats & Oils" ~ 
        "<span style='color:#CC79A7'>**III. Animal/Vegetable Fats & Oils**</span>",
      section == "IV. Prepared Foodstuffs" ~ 
        "<span style='color:#0072B2'>**IV. Prepared Foodstuffs**</span>",
      TRUE ~ section
    ),
    section_label = factor(section_label, levels = c(
      "<span style='color:#D55E00'>**I. Live Animals & Animal Products**</span>",
      "<span style='color:#009E73'>**II. Vegetable Products**</span>",
      "<span style='color:#CC79A7'>**III. Animal/Vegetable Fats & Oils**</span>",
      "<span style='color:#0072B2'>**IV. Prepared Foodstuffs**</span>"
    ))
  )

mfn_background <- select(mfn_by_section, "year", "section", "avg_rate")

p <- ggplot() +
  # Background: all sections in grey
  geom_line(data = mfn_background, 
            aes(x = year, y = avg_rate * 100, group = section),
            color = "grey70", linewidth = 0.5, alpha = 0.6) +
  # Foreground: highlighted section with its color
  geom_line(data = mfn_by_section,
            aes(x = year, y = avg_rate * 100, color = section),
            linewidth = 1.2, show.legend = FALSE) +
  geom_point(data = mfn_by_section,
             aes(x = year, y = avg_rate * 100, color = section),
             size = 1.5, alpha = 0.7, show.legend = FALSE) +
  scale_color_manual(values = section_colors) +
  facet_wrap(~section_label, ncol = 2) +
  scale_x_continuous(breaks = seq(2000, 2024, by = 4)) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "MFN tariff rates are highest for <span style='color:#D55E00'>**Live Animals & Animal Products**</span>",
    subtitle = "Most Favored Nation rates by HTS section (2000-2024), with all sections shown in grey for comparison",
    x = "Year",
    y = "Average Tariff Rate"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_markdown(size = 14),
    plot.subtitle = element_text(size = 10),
    strip.text = element_markdown(size = 9)
  )

p
```