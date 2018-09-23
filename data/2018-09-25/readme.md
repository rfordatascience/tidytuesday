# Week 26 - Invasive Species in Africa

## Data Sources

[Paini et al, 2016](http://www.pnas.org/content/113/27/7575) report on "Global threat to agriculture from invasive species". Developing countries in Africa are some of the most sensitive to invasive species damage to agriculture.

Table data from [tables](http://www.pnas.org/content/113/27/7575/tab-figures-data) in the Appendix.

All invasive species data for Africa from [http://www.griis.org/](http://www.griis.org/).

## Raw data

Raw data is what the "raw" data looks like from the paper's tables. If you want to practice your `tidy` skills this would be a good starting place! An example tidying script is also posted if you get stuck.

## Table Data

Tidy and cleaned data for the tables from Paini et al, 2016.

* **Table 1**: Ranking of all threatened countries by overall invasion threat (`invasion_threat`).
* **Table 2**: Ranking of all threatened countries by total invasion cost (`invasion_cost`).
* **Table 3**: Ranking of all threatened countries by total invasion cost (`invasion_cost`) as a proportion (`gdp_proportion`) of mean GDP (`gdp_mean`).
* **Table 4**: Ranking of all **source** countries by total invasion cost (`invasion_cost`)
* **Table 6**: List of 140 species and their **maximum** recorded **percentage** impact on one of their known host crops (source: CABI Crop Protection Compendium)

![Figure 1](http://www.pnas.org/content/pnas/113/27/7575/F1.large.jpg?width=800&height=600&carousel=1)
* **Figure 1** World map representation of model outputs. (A) The overall invasion threat (`Table 1`) to each threatened country, (B) the total invasion cost (`Table 2`) (in millions of US dollars) to threatened countries; (C) the total invasion cost (`Table 3`) (in millions of US dollars) to threatened countries, as a proportion of GDP; and (D) the total invasion cost (`Table 4`) (in millions of US dollars) from source countries. Those countries without color were not included in the analysis.

## Invasive Species by African Countries

Developing countries in Africa appear to be most vulnerable to invasive species damage to agriculture. 
`africa_species.csv` contains the known invasive species for African countries from `griis.org`.
