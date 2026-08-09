|variable                     |class     |description |
|:----------------------------|:---------|:-----------|
|model                        |character |Normalized DJI aircraft model name used as the aggregation key. |
|source_listing_labels        |character |Public catalog listing labels combined into the normalized aircraft model. |
|source_row_count             |integer   |Number of source listing rows included in the model-level aggregate. |
|configurations_tracked       |integer   |Number of public catalog configurations represented by the aggregate. |
|listed_price_low_usd         |double    |Lowest observed public listed price for the model, in US dollars. This is not a completed-sale price. |
|listed_price_high_usd        |double    |Highest observed public listed price for the model, in US dollars. This is not a completed-sale price. |
|median_listed_price_usd      |double    |Median observed public listed price across the tracked configurations, in US dollars. |
|snapshot_date                |date      |Date on which the public catalog snapshot was captured. |
|release_quarter              |character |Calendar quarter assigned to this archived dataset release. |
|observation_unit             |character |Unit represented by each row; here, an aircraft model-level aggregate. |
|quality_status               |character |Publication-gate result assigned after documented validation checks. |
|source_url                   |character |Public Reboot Hub page describing the dataset and source boundary. |
|methodology_note             |character |Plain-language explanation of the aggregation and what the values do not represent. |
|non_affiliation_note         |character |Disclosure that Reboot Hub is independent and is not affiliated with or officially authorized by DJI. |
