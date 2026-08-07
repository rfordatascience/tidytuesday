|variable     |class     |description                                                                                                                            |
|:------------|:---------|:--------------------------------------------------------------------------------------------------------------------------------------|
|product_id   |integer   |Identifier for the product, numbered in order of first appearance. Joins to `gumroad_categories`.                                        |
|currency     |character |Currency symbol Gumroad displayed the price in ($, £ or €). Gumroad localises displayed prices, so a single search returns a mixture.     |
|price_local  |double    |Asking price exactly as displayed, in `currency`. Kept unconverted so the conversion below stays checkable.                               |
|price_usd    |double    |Asking price converted to US dollars at European Central Bank reference rates for 2026-08-06.                                             |
|is_free      |logical   |Whether the product is listed at zero. Gumroad free products are pay-what-you-want with a zero minimum.                                   |
|is_recurring |logical   |Whether the listing is a subscription rather than a one-off purchase.                                                                     |
|rating_score |double    |Mean star rating out of 5, as displayed. `NA` where the product has no ratings.                                                           |
|n_ratings    |integer   |Number of ratings the product has received. Zero where the product is unrated.                                                            |
|is_rated     |logical   |Whether the product has at least one rating. A rating is a floor on buyers, not a sales count.                                            |
|top_creator  |logical   |Whether Gumroad showed its "Top creator" badge on the listing.                                                                            |
|card_text    |character |Text of the product card as rendered in search results, containing the title and seller name. Truncated by Gumroad's own display. One seller had put an email address in their own product title; it is replaced with `[email removed]`. |
