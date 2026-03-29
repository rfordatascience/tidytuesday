This week we're exploring global health spending data. The
[WHO Global Health Expenditure Database (GHED)](https://apps.who.int/nha/database)
provides comparable data on health expenditure for 195 countries and territories since 2000.

The data tracks how much countries spend on health care, where the money comes from (government, private,
or external sources), how it is channelled through financing schemes (e.g. government programmes, 
voluntary insurance, out-of-pocket payments), and what it is spent on (e.g. curative care, 
preventive care, medical goods). How health systems are funded and how resources are allocated directly 
shapes health outcomes, progress toward universal health coverage, and whether households face financial 
hardship when accessing care. These indicators are essential to inform health policy decisions.

The data is organised into three datasets:

- **`health_spending`** — Aggregate health spending and its breakdown by funding source (domestic government, domestic private, and external aid).
- **`financing_schemes`** — Health spending by financing scheme (e.g. government schemes, voluntary insurance, out-of-pocket payments).
- **`spending_purpose`** — Health spending by health care function (e.g. curative care, preventive care, medical goods).

Some questions to explore:

- Which countries rely most heavily on out-of-pocket payments for health care?
- How has the balance between government, private, and external aid changed over time?
- What is the split between curative and preventive care spending across countries?
- How did the COVID-19 pandemic impact health spending patterns?

Visit the [GHED portal](https://apps.who.int/nha/database/) or use the open-source [`bblocks-data-importers` Python package](https://github.com/ONEcampaign/bblocks_data_importers)
for additional indicators and data beyond what is included here.

See example visualisations using the same underlying data:

- [Health care spending is not evenly distributed](https://data.one.org/analysis/health-spending-inequality)
- [The hidden fragility of preventive health spending](https://data.one.org/analysis/hidden-fragility-of-prevention-spending)
- [Africa falls short on health spending](https://data.one.org/analysis/african_gov_health-spending-off-track)
- [A turning point in health financing](https://data.one.org/analysis/turning-point-in-health-financing)

The data was processed using [ONE Data](https://data.one.org)'s open-source [`bblocks-data-importers` Python package](https://github.com/ONEcampaign/bblocks_data_importers), and can also be explored interactively through the [Health Financing Agent](https://data.one.org/tools/agents/health-financing).

