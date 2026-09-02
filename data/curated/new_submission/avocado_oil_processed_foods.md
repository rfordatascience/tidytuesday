|variable                      |class     |description                           |
|:-----------------------------|:---------|:-------------------------------------|
|sample_number                 |double    |Unique sample identifier (1-74) matching the supplementary tables in the paper. Consecutive pairs (1-2, 3-4, etc.) represent two lots of the same product. |
|product_id                    |double    |Product identifier grouping two lots of the same product (derived as ceiling of sample_number / 2). |
|lot                           |integer   |Lot number (1 or 2). Each product was purchased in two separately acquired lots to test batch-to-batch consistency. |
|category                      |character |Product type: "chips", "mayonnaise", or "salad_dressing". |
|oil_type                      |character |Simplified oil classification: "avocado" or "olive". |
|declared_oil                  |character |Full oil declaration from the ingredient statement (e.g., "Avocado Oil", "Organic Avocado Oil", "Extra Virgin Olive Oil"). |
|front_label                   |character |Front-of-package oil marketing claim (e.g., "Made with 100% Pure Avocado Oil", "Made With Olive Oil"). |
|other_ingredients             |character |Non-oil ingredients listed on the package. |
|package_size_oz               |double    |Package size in ounces. |
|retail_price_usd              |double    |Retail price in US dollars at time of purchase. |
|purchase_location             |character |Where the product was purchased (retail store name or "Online"). |
|authentic                     |logical   |Whether the sample's fatty acid and sterol profile was consistent with the declared oil type, based on Codex Alimentarius standards with a 10% margin of deviation. TRUE = consistent, FALSE = inconsistent. |
|c6_0_pct                      |double    |Caproic acid (C6:0) as percent of total fatty acids. NA if not detected. |
|c8_0_pct                      |double    |Caprylic acid (C8:0) as percent of total fatty acids. NA if not detected. |
|c10_0_pct                     |double    |Capric acid (C10:0) as percent of total fatty acids. NA if not detected. |
|c12_0_pct                     |double    |Lauric acid (C12:0) as percent of total fatty acids. NA if not detected. |
|c14_0_pct                     |double    |Myristic acid (C14:0) as percent of total fatty acids. NA if not detected. |
|c16_0_palmitic_pct            |double    |Palmitic acid (C16:0) as percent of total fatty acids. Codex range for avocado oil: 11.0-26.0%. |
|c16_1_palmitoleic_pct         |double    |Palmitoleic acid (C16:1) as percent of total fatty acids. Key authenticity marker — Codex range for avocado oil: 4.0-17.1%. Low values indicate adulteration. |
|c17_0_pct                     |double    |Margaric acid (C17:0) as percent of total fatty acids. NA if not detected. |
|c17_1_pct                     |double    |Heptadecenoic acid (C17:1) as percent of total fatty acids. NA if not detected. |
|c18_0_stearic_pct             |double    |Stearic acid (C18:0) as percent of total fatty acids. Codex range for avocado oil: 0.1-1.3%. Elevated values suggest vegetable oil substitution. |
|c18_1_oleic_pct               |double    |Oleic acid (C18:1) as percent of total fatty acids. The dominant fatty acid in authentic avocado oil. Codex range: 42.0-75.0%. |
|c18_1n7_vaccenic_pct          |double    |Cis-vaccenic acid (C18:1 n-7) as percent of total fatty acids. Strong discriminatory marker — authentic avocado oil typically 4-6%, adulterated samples typically 1-2%. |
|c18_2_linoleic_pct            |double    |Linoleic acid (C18:2) as percent of total fatty acids. Codex range for avocado oil: 7.8-19.0%. |
|c18_3_linolenic_pct           |double    |Alpha-linolenic acid (C18:3) as percent of total fatty acids. Codex range for avocado oil: 0.5-2.1%. |
|c20_0_pct                     |double    |Arachidic acid (C20:0) as percent of total fatty acids. |
|c20_1_pct                     |double    |Gondoic acid (C20:1) as percent of total fatty acids. |
|c20_2_pct                     |double    |Eicosadienoic acid (C20:2) as percent of total fatty acids. NA if not detected. |
|c22_0_pct                     |double    |Behenic acid (C22:0) as percent of total fatty acids. NA if not detected. |
|c24_1_pct                     |double    |Nervonic acid (C24:1) as percent of total fatty acids. NA if not detected. |
|brassicasterol_pct            |double    |Brassicasterol as percent of total sterols. Codex limit for avocado oil: ND-0.5%. Presence above trace levels may indicate canola oil substitution. |
|methylene_cholesterol_pct     |double    |24-Methylene cholesterol as percent of total sterols. |
|campesterol_pct               |double    |Campesterol as percent of total sterols. Codex range for avocado oil: 4.0-8.3%. Elevated values indicate vegetable oil substitution. |
|campestanol_pct               |double    |Campestanol as percent of total sterols. |
|stigmasterol_pct              |double    |Stigmasterol as percent of total sterols. Codex range for avocado oil: 0.3-2.0%. Elevated values indicate vegetable oil adulteration. |
|delta7_campesterol_pct        |double    |Delta-7-campesterol as percent of total sterols. |
|clerosterol_pct               |double    |Clerosterol as percent of total sterols. Codex range for avocado oil: 1.0-2.5%. Low values may indicate non-avocado oil. |
|beta_sitosterol_pct           |double    |Beta-sitosterol as percent of total sterols. Codex range for avocado oil: 79.0-93.4%. The dominant sterol in authentic avocado oil. |
|sitostanol_pct                |double    |Sitostanol as percent of total sterols. |
|delta5_avenasterol_pct        |double    |Delta-5-avenasterol as percent of total sterols. Codex range for avocado oil: 2.0-8.0%. |
|delta5_24_stigmastadienol_pct |double    |Delta-5,24-stigmastadienol as percent of total sterols. |
|delta7_stigmastenol_pct       |double    |Delta-7-stigmastenol as percent of total sterols. Codex limit for olive oil: ≤0.5%. |
|delta7_avenasterol_pct        |double    |Delta-7-avenasterol as percent of total sterols. Codex range for avocado oil: ND-1.5%. Elevated values indicate vegetable oil substitution. |
|apparent_beta_sitosterol_pct  |double    |Apparent beta-sitosterol (sum of delta-5,23-stigmastadienol, clerosterol, beta-sitosterol, sitostanol, delta-5-avenasterol, and delta-5,24-stigmastadienol) as percent of total sterols. Codex requirement for olive oil: ≥93.0%. |
