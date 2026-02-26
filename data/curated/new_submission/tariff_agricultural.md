|variable             |class     |description                           |
|:--------------------|:---------|:-------------------------------------|
|hts8                 |character |8-digit Harmonized Tariff Schedule code (legal tariff line). Join with `tariff_codes` for product descriptions. |
|begin_effective_date |date      |Beginning effective date for tariff rate (rates can change mid-year). |
|end_effective_date   |date      |Ending effective date for tariff rate. Far-future dates (e.g., 2050-12-31, 2100-12-31) indicate no scheduled change. |
|agreement            |character |Trade agreement or rate type code. Join with `agreements` table for full names and notes. Asterisk (`*`) or plus (`+`) suffix indicates restrictions (e.g., `"cbi*"` = certain products/countries excluded). |
|rate_type_code       |character |Duty calculation method code. See https://www.usitc.gov/applications/dataweb/td-codes.pdf for details (0=free, 1-6=specific formulas, 7=ad valorem, 9=derived duty, K/X/T=see HTS). |
|ad_val_rate          |double    |Ad valorem (percentage) portion of the duty rate (0.05 = 5%). |
|specific_rate        |double    |Specific (per-unit) portion of the duty rate in dollars (0.05 = $0.05 per unit of quantity). |
