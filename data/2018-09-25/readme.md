# Week 26 - Invasive Species in Africa

## Data Sources

[Paini et al, 2016](http://www.pnas.org/content/113/27/7575) report on "Global threat to agriculture from invasive species". Developing countries in Africa are some of the most sensitive to invasive species damage to agriculture.

Table data from [supplementary tables](http://www.pnas.org/content/113/27/7575/tab-figures-data).

All invasive species data for Africa from [http://www.griis.org/](http://www.griis.org/).

## Raw data

Raw data is what the "raw" data looks like from the paper's tables. An example tidying script is also posted.

## Table Data

* **Table 1**: Ranking of all threatened countries by overall invasion threat (`invasion_threat`).
* **Table 2**: Ranking of all threatened countries by total invasion cost (`invasion_cost`).
* **Table 3**: Ranking of all threatened countries by total invasion cost (`invasion_cost`) as a proportion (`gdp_proportion`) of mean GDP (`gdp_mean`).
* **Table 4**: Ranking of all **source** countries by total invasion cost (`invasion_cost`)
* **Table 6**: List of 140 species and their **maximum** recorded **percentage** impact on one of their known host crops (source: CABI Crop Protection Compendium)


## Invasive Species by African Countries

Developing countries in Africa appear to be most vulnerable to invasive species damage to agriculture. 
`africa_species.csv` contains the known invasive species for African countries from `griis.org`.
