|variable|class|description|
|:--|:--|:--|
|datastore_row_id|double|Internal CKAN DataStore row identifier. This is not a property, condominium-unit, title-deed, or transaction identifier.|
|condominium_id|double|Thailand Treasury Department condominium identifier. Distinct values are not counts of physical units or transactions.|
|condominium_name_th|character|Condominium name in Thai, preserved from the source.|
|building_name_th|character|Building label preserved from the source. A hyphen is a source sentinel and is not converted to missing.|
|province_code|double|Thai province code. Every row in this curated extract has numeric code 83 for Phuket.|
|province_name_th|character|Province name in Thai. Every row in this curated extract is ภูเก็ต (Phuket).|
|district_code|double|District code preserved from the source.|
|district_name_th|character|District name in Thai, preserved from the source.|
|subdistrict_code_source|character|Subdistrict code exactly as supplied. The literal text `NULL` is preserved and is not an inferred missing value.|
|subdistrict_name_th_source|character|Subdistrict name in Thai exactly as supplied. The literal text `NULL` is preserved and is not an inferred missing value.|
|land_office_branch_code|double|Land-office branch code preserved from the source.|
|land_office_branch_name_th|character|Land-office branch name in Thai, preserved from the source.|
|floor_or_range_source|character|Floor, floor range, or other floor label exactly as supplied. Some values contain Thai month abbreviations and are not reconstructed.|
|floor_value_has_thai_month_token|logical|Whether `floor_or_range_source` contains a Thai month abbreviation, flagging 578 potentially spreadsheet-coerced labels for cautious use.|
|use_category_th|character|Use-category label in Thai exactly as supplied. The 108 raw variants are intentionally not normalized.|
|assessed_value_thb_per_sqm|double|Official statutory assessed value rate in Thai baht per square metre. This is not an asking price, transaction price, market valuation, current availability, or tax bill.|
|value_basis|character|Constant machine-readable warning: `official_statutory_assessment_rate_not_market_price`.|
