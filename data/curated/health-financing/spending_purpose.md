Health spending broken down by health care function — *what* the money is spent on. These categories
follow the SHA 2011 International Classification for Health Accounts (ICHA-HC) and describe the type of
health care activity or service being funded. Data is available from 2016 onwards.

### Indicators

| Code | Name | Definition |
|:-----|:-----|:-----------|
| `hc1` | Curative care | Services aimed at relieving symptoms or treating illness, injury, or disease. Includes inpatient, outpatient, and day care across all medical specialities. Typically the largest share of health spending. |
| `hc2` | Rehabilitative care | Services to restore or improve functioning in individuals with impairments or disabilities. Includes physical therapy, occupational therapy, and post-acute rehabilitation programmes. |
| `hc3` | Long-term care (health) | Health services for people with chronic conditions or disabilities who require ongoing medical or nursing care over an extended period. Includes care in residential settings and at home. |
| `hc4` | Ancillary services | Supporting health services such as laboratory diagnostics, medical imaging, and patient transportation that are not classified under a specific care function. |
| `hc5` | Medical goods | Pharmaceuticals, medical devices, and other health care goods dispensed to outpatients (i.e. not consumed during an inpatient or outpatient care episode already counted elsewhere). |
| `hc6` | Preventive care | Services designed to prevent illness or its consequences, including immunisation, screening, epidemiological surveillance, and public health programmes. |
| `hc7` | Governance and health system administration | Planning, management, and regulation of the health system, including government health administration, health insurance administration, and oversight functions. |
| `hc9` | Other health care services (n.e.c.) | Health care services not classified elsewhere in the ICHA-HC framework. |

### Variables

|variable       |class     |description |
|:--------------|:---------|:-----------|
|country_name   |character |Country or territory name as used by WHO. |
|iso3_code      |character |ISO 3166-1 alpha-3 country code. |
|year           |integer   |Year of observation. |
|indicator_code |character |GHED indicator code (e.g. `hc1_che`, `hc6_usd2023`). |
|indicator_name |character |Human-readable indicator name from WHO. |
|value          |double    |Indicator value in the unit specified. |
|unit           |character |Unit of measurement: `% of current health expenditure` or `constant 2023 US$`. |
