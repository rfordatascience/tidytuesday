Health spending broken down by financing scheme — the institutional arrangements through which health
services are paid for. These categories follow the System of Health Accounts (SHA 2011) classification
and provide a more granular view of *how* health care is financed beyond the broad source-of-funding
split in `health_spending`.

### Indicators

| Code | Name | Definition |
|:-----|:-----|:-----------|
| `hf1` | Government schemes and compulsory contributory health care financing schemes | Spending channelled through government budget allocations and mandatory social health insurance. This is the primary mechanism for public health financing in most countries. |
| `hf2` | Voluntary health care payment schemes | Spending through voluntary prepayment arrangements, including voluntary private health insurance, enterprise financing (employers paying directly for health services), and NPISH (non-profit institutions serving households) financing. |
| `hf3` | Household out-of-pocket payments (OOPS) | Direct payments made by households at the point of service, net of any reimbursement. High reliance on OOPS is associated with financial hardship, catastrophic health expenditure, and impoverishment. |
| `hf4` | Rest of the world financing schemes (non-resident) | Health spending from foreign and international entities, including development agencies, bilateral programmes, and international NGOs. Closely related to `ext` in `health_spending`, but classified by the financing arrangement rather than the revenue source. |
| `hfnec` | Unspecified financing schemes (n.e.c.) | Health spending that cannot be attributed to a specific financing scheme. |

### Variables

|variable       |class     |description |
|:--------------|:---------|:-----------|
|country_name   |character |Country or territory name as used by WHO. |
|iso3_code      |character |ISO 3166-1 alpha-3 country code. |
|year           |integer   |Year of observation. |
|indicator_code |character |GHED indicator code (e.g. `hf1_che`, `hf3_usd2023`). |
|indicator_name |character |Human-readable indicator name from WHO. |
|value          |double    |Indicator value in the unit specified. |
|unit           |character |Unit of measurement: `% of current health expenditure` or `constant 2023 US$`. |
