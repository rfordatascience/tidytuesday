|variable               |class     |description                           |
|:----------------------|:---------|:-------------------------------------|
|ref_period_id          |integer   |Reference period identifier representing the timeframe of the trade flow, typically formatted as YYYY for annual data or YYYYMM for monthly data. |
|ref_year               |integer   |Reference year in which the trade flow occurred. |
|ref_month              |integer   |Reference month number in which the trade flow occurred, ranging from 1 to 12. |
|period                 |character |Combined time period string matching the exact statistical data reporting window. |
|reporter_code          |integer   |Numerical country code assigned by the United Nations Statistics Division to the country reporting the trade flow. |
|reporter_iso           |character |Three-letter ISO alpha-3 code of the country reporting the trade data. |
|reporter_desc          |character |Official standard English name of the reporting country or geographic territory. |
|flow_code              |character |Code indicating the direction of the trade transaction, such as import or export. |
|classification_code    |character |Code designating the commodity classification system used to categorize the goods, such as HS for Harmonized System. |
|cmd_code               |character |Specific commodity code identifying the traded product under the selected classification system. |
|cmd_desc               |character |Detailed English text description corresponding to the specific commodity code. |
|qty_unit_code          |integer   |Internal numerical identifier representing the metric used to measure product quantity. |
|qty_unit_abbr          |character |Abbreviated name of the unit of measurement used for the primary quantity, such as kg for kilograms. |
|qty                    |double    |Total quantity of the traded commodity measured in the primary unit of measurement. |
|is_qty_estimated       |logical   |Boolean flag indicating whether the primary quantity value was estimated or modeled by the United Nations Statistics Division rather than directly reported. |
|alt_qty_unit_code      |integer   |Internal numerical identifier representing the alternative metric used to measure product quantity if applicable. |
|alt_qty_unit_abbr      |character |Abbreviated name of the unit of measurement used for the secondary or alternative quantity. |
|alt_qty                |double    |Total quantity of the traded commodity measured in the alternative unit of measurement. |
|net_wgt                |double    |Net weight of the traded commodity in kilograms, excluding packaging. |
|is_net_wgt_estimated   |logical   |Boolean flag indicating whether the net weight value was estimated or modeled by the United Nations Statistics Division. |
|cifvalue               |double    |Total trade value inclusive of cost, insurance, and freight costs, reported in United States Dollars. |
|fobvalue               |double    |Total trade value measured free on board, capturing the value of the goods at the exporter's border excluding international shipping costs, reported in United States Dollars. |
|primary_value          |double    |Principal monetary value used for primary trade analysis, reported in United States Dollars. |
|legacy_estimation_flag |integer   |Status flag denoting processing classifications or historical estimation techniques applied to older records within the database. |

