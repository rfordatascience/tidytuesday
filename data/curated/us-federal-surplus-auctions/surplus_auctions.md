|variable             |class     |description                           |
|:--------------------|:---------|:-------------------------------------|
|id                   |character |Stable identifier for the lot, derived from the GSA lot number. |
|title                |character |Lot title as published by GSA. Free text, and the source of most of the dataset's character. |
|category             |character |Normalized category. One of eleven values, e.g. vehicles, heavy-equipment, office-furniture, medical-scientific. |
|condition            |character |Condition as reported by GSA, e.g. usable, repairable, salvage. |
|seller_type          |character |Selling level of the disposing agency. |
|state                |character |Two-letter state or territory where the lot is located. 55 distinct values. |
|city                 |character |Lot location city, when published. |
|zip                  |character |Lot location ZIP code, when published. |
|currency             |character |Always USD. |
|current_or_final_bid |double    |The last bid level observed on the lot, in USD. NOT a settled sale price: awards can fall through. Present for about 63% of rows; NA where the lot drew no recorded bid. |
|bid_count            |integer   |Number of bids recorded on the lot. Zero is meaningful here: it means nobody bid. |
|buyer_premium_pct    |double    |Buyer's premium percentage applied on top of the bid, when published. |
|sold                 |logical   |Whether the lot was observed as sold. NA where undeterminable from the listing. |
|ended_at             |date      |Date the auction closed. |
|source_url           |character |Link to the original GSA listing. |
