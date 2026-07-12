|variable |class |description |
|:--------|:-----|:-----------|
|country_name |character |Country or territory name as used by WHO. |
|iso3_code |character |ISO 3166-1 alpha-3 country code. |
|year |integer |Year of observation. |
|indicator_code |character |GHED indicator code. Suffix indicates unit: <code>_che</code> = % of CHE, <code>_usd2023</code> = constant 2023 US$. <br><br>Indicators: <br><code>che</code> — Current health expenditure (total, only <code>_usd2023</code>). <br><code>gghed</code> — Domestic general government health expenditure (GGHE-D). <br><code>pvtd</code> — Domestic private health expenditure (PVT-D). <br><code>ext</code> — External health expenditure (EXT). |
|expenditure_type |character |Type of health expenditure. |
|value |double |Indicator value in the unit specified. |
|unit |character |Unit of measurement: <code>% of current health expenditure</code> or <code>constant 2023 US$</code>. |

