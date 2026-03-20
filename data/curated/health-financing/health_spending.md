Aggregate health spending and its breakdown by funding source. Current health expenditure (CHE) is the
total, which is split into three mutually exclusive sources: domestic government spending, domestic private
spending, and external (foreign) aid. Together, `gghed + pvtd + ext = che`.

### Indicators

| Code | Name | Definition |
|:-----|:-----|:-----------|
| `che` | Current health expenditure (CHE) | Total spending on health in a country in a given year. This is the broadest measure of health spending and includes all spending on health care goods and services, regardless of the source of funding. Only available in constant 2023 US$ (there is no `_che` variant since CHE is itself the denominator). |
| `gghed` | Domestic general government health expenditure (GGHE-D) | Health spending from domestic public sources, including central and local government budgets, social health insurance contributions, and other compulsory prepayment schemes. This excludes external funding channelled through government. |
| `pvtd` | Domestic private health expenditure (PVT-D) | Health spending from domestic private sources, including voluntary health insurance, household out-of-pocket payments, and spending by non-profit institutions and corporations. |
| `ext` | External health expenditure (EXT) | Health spending from foreign sources, including bilateral and multilateral development aid, grants from international NGOs, and other cross-border transfers earmarked for health. |

### Variables

|variable       |class     |description |
|:--------------|:---------|:-----------|
|country_name   |character |Country or territory name as used by WHO. |
|iso3_code      |character |ISO 3166-1 alpha-3 country code. |
|year           |integer   |Year of observation. |
|indicator_code |character |GHED indicator code (e.g. `che_usd2023`, `gghed_che`). |
|indicator_name |character |Human-readable indicator name from WHO. |
|value          |double    |Indicator value in the unit specified. |
|unit           |character |Unit of measurement: `% of current health expenditure` or `constant 2023 US$`. |
