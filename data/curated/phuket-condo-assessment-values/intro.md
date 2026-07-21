This week we're exploring official condominium assessment-rate records for Phuket, Thailand. The [Thailand Treasury Department's Condominium Valuation dataset](https://gdcatalognhic.nha.co.th/dataset/condominium-valuation), distributed by the National Housing Information Center (NHIC), is filtered to records whose province code is 83. The resulting table contains 4,707 assessment-rate records associated with 304 distinct Treasury condominium identifiers.

The unit of observation needs care: a row is a rate-table record for a condominium, building, floor or floor range, and use category. It is **not** one physical home, listing, sale, or transaction. `assessed_value_thb_per_sqm` is an official statutory assessment rate in Thai baht per square metre; it is not an asking price, transaction price, market valuation, current inventory, or tax bill. The source resource reports a data-updated date of 2024-08-14, while its package metadata reports 2024-08-15. No per-row or effective assessment year is published, so the values should not be described as current.

The curation preserves 108 exact Thai use-category variants instead of merging categories. It also preserves 170 pairs of literal `NULL` subdistrict values and flags 578 floor labels that contain Thai month abbreviations, which may reflect spreadsheet coercion. Three exact-content duplicate rows are retained and linked to the earlier CKAN row identifier through `duplicate_of_datastore_row_id`.

The source identifies the data as public under Thailand's [Open Data Common terms](https://standard.dga.or.th/wp-content/uploads/2024/05/%E0%B8%A0%E0%B8%B2%E0%B8%84%E0%B8%9C%E0%B8%99%E0%B8%A7%E0%B8%81-%E0%B8%84-%E0%B8%AA%E0%B8%B1%E0%B8%8D%E0%B8%8D%E0%B8%B2%E0%B8%AD%E0%B8%99%E0%B8%B8%E0%B8%8D%E0%B8%B2%E0%B8%95%E0%B9%83%E0%B8%AB%E0%B9%89%E0%B9%83%E0%B8%8A%E0%B9%89%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%A1%E0%B8%B9%E0%B8%A5-2.pdf). The [English article and reproducibility notes](https://kvartiry-phuket.com/en/phuket-condo-assessment-values/) were prepared by Kvartiry-Phuket.com, a commercial Phuket property website. Kvartiry-Phuket is not sponsored or endorsed by the Treasury Department, NHIC, or Thailand's National Housing Authority. The included chart was created by Kvartiry-Phuket and is available under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

Questions to explore:

- How do assessment-rate distributions differ across Mueang Phuket, Kathu, and Thalang when use categories are kept separate?
- How much within-condominium variation is associated with floor or use-category labels?
- How sensitive are summaries to the three duplicate-equivalent records or to the flagged floor labels?
- What visualization best communicates both the distribution and the unequal number of rate records per condominium?
