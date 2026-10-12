|variable                    |class     |description                           |
|:---------------------------|:---------|:-------------------------------------|
|sample_code                 |character |Unique identifier for the oil sample (e.g., EV1, R3, U6). The prefix indicates the labeled grade: EV for extra virgin, R for refined, and U for unspecified. |
|grade_labeled               |character |Grade claimed on the bottle label: extra virgin, refined, or unspecified. |
|purchasing_method           |character |Where the sample was purchased: Online or In store. |
|expiration_date             |character |Best-by date printed on the bottle in month-year format (e.g., Oct-21). NA if not listed. |
|product_origin              |character |Country or region of origin listed on the label (e.g., California, Mexico, Brazil). |
|cost_per_fl_oz              |double    |Retail price in US dollars per fluid ounce at the time of purchase. |
|packaging_type              |character |Container material and color (e.g., Dark glass, Clear plastic, Tin bottle). |
|oxidized                    |logical   |Whether the sample showed signs of oxidation (high free fatty acidity or peroxide values) before its expiration date. NA for confirmed soybean oil samples where oxidation status is not meaningful. |
|purity_result               |character |Purity classification: pure (consistent with authentic avocado oil), adulterated (confirmed substitution with another oil), or suspected (chemical profile outside the normal avocado oil range but not conclusively adulterated). |
|adulterant                  |character |Identity of the adulterant oil if detected: soybean oil, sunflower/safflower oil, or NA if pure. |
|alpha_tocopherol_mg_kg      |double    |Alpha-tocopherol (vitamin E) content in milligrams per kilogram of oil. The primary form of vitamin E in most avocado oils. |
|gamma_beta_tocopherol_mg_kg |double    |Combined gamma and beta tocopherol content in mg/kg. Elevated levels may indicate soybean oil adulteration. NA if not detected. |
|delta_tocopherol_mg_kg      |double    |Delta-tocopherol content in mg/kg. Presence at high levels is characteristic of soybean oil. NA if not detected. |
|total_tocopherols_mg_kg     |double    |Total tocopherol (vitamin E) content in mg/kg, summing all measured forms. |
|c14_0_pct                   |double    |Myristic acid (C14:0) as a percent of total fatty acids. NA if not detected. |
|c16_0_palmitic_pct          |double    |Palmitic acid (C16:0) as a percent of total fatty acids. Typically 10 to 18 percent in avocado oil. |
|c16_1_palmitoleic_pct       |double    |Palmitoleic acid (C16:1) as a percent of total fatty acids. A key marker: high values (5 to 9 percent) indicate authentic avocado oil, while near-zero values suggest adulteration. |
|c18_0_stearic_pct           |double    |Stearic acid (C18:0) as a percent of total fatty acids. Elevated values (above 2 percent) may indicate sunflower or safflower adulteration. |
|c18_1_oleic_pct             |double    |Oleic acid (C18:1) as a percent of total fatty acids. The dominant fatty acid in authentic avocado oil, typically 55 to 70 percent. |
|c18_2_linoleic_pct          |double    |Linoleic acid (C18:2) as a percent of total fatty acids. Authentic avocado oil typically has 9 to 20 percent; values above 50 percent indicate soybean oil. |
|c18_3_linolenic_pct         |double    |Linolenic acid (C18:3) as a percent of total fatty acids. Values above 3 percent strongly suggest soybean oil adulteration. |
|c20_0_pct                   |double    |Arachidic acid (C20:0) as a percent of total fatty acids. NA if not detected. |
|c20_1_pct                   |double    |Gondoic acid (C20:1) as a percent of total fatty acids. |
|c22_0_pct                   |double    |Behenic acid (C22:0) as a percent of total fatty acids. NA if not detected. |
|c24_0_pct                   |double    |Lignoceric acid (C24:0) as a percent of total fatty acids. NA if not detected. |
|brassicasterol_pct          |double    |Brassicasterol as a percent of total sterols. NA if not detected. |
|campesterol_pct             |double    |Campesterol as a percent of total sterols. Values above 15 percent suggest soybean oil adulteration (soybean is typically around 20 percent). |
|stigmasterol_pct            |double    |Stigmasterol as a percent of total sterols. Elevated values (above 10 percent) are a strong indicator of soybean oil. |
|delta7_campesterol_pct      |double    |Delta-7-campesterol as a percent of total sterols. NA if not detected. |
|clerosterol_pct             |double    |Clerosterol as a percent of total sterols. NA if not detected. |
|beta_sitosterol_pct         |double    |Beta-sitosterol as a percent of total sterols. The dominant sterol in avocado oil, typically 75 to 90 percent. Values near 55 percent indicate soybean oil. |
|delta5_avenasterol_pct      |double    |Delta-5-avenasterol as a percent of total sterols. |
|delta7_stigmasterol_pct     |double    |Delta-7-stigmasterol as a percent of total sterols. NA if not detected. |
|delta7_avenasterol_pct      |double    |Delta-7-avenasterol as a percent of total sterols. NA if not detected. |
|total_sterols_mg_kg         |double    |Total sterol content in milligrams per kilogram of oil. |

