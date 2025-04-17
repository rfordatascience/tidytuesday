| variable                        | type  | description                                                                 |
|----------------------------------|--------|-----------------------------------------------------------------------------|
| sale_date_month                 | date  | The date (by month) when the sale occurred                                 |
| sale_type                       | chr   | Whether the sale was "Retail" or "Wholesale"                               |
| medical_flag                    | chr   | Whether the sale was for medical use ("Medical" or "Not Medical")          |
| inventory_type                  | chr   | The WSLCB inventory category for the product sold                          |
| inventory_type_category         | chr   | Higher-level product classification (e.g. Flower, Edible)                  |
| inventory_type_sub_category     | chr   | More specific product classification (e.g. Pre-Rolls, Concentrate)         |
| strain_type                     | chr   | Type of cannabis strain (e.g. Hybrid, Indica, Sativa)                      |
| strain_name                     | chr   | Name of the cannabis strain in the product                                 |
| product_name                    | chr   | Name of the product as listed by the licensee                              |
| price_competitive_flag          | chr   | Pricing performance compared to similar products (e.g. Significantly Below)|
| price_tiers_per_gram            | chr   | Categorical price bucket per gram (e.g. Under $5, $5–$10)                  |
| retail_price_with_tax           | dbl   | Total price paid including tax, for the retail product                     |
| unit_price_with_tax             | dbl   | Price per unit sold (with tax included)                                    |
| piece_price_with_tax            | dbl   | Price per "piece" if applicable (e.g., per edible unit)                    |
| tax_percent                     | dbl   | Percentage of the retail price that was tax                                |
| product_pack_size_from_name     | dbl   | Approximate pack size (grams), derived from the product name               |
| price_gram_wavg                 | dbl   | Weighted average price per gram across all transactions                    |
| calc_product_unit_weight_grams  | dbl   | Calculated unit weight of product in grams                                 |
| calc_price_per_gram             | dbl   | Final calculated price per gram                                            |
| unit_price_amt_avg              | dbl   | Average unit price (without taxes)                                         |
| price_absolute_diff             | dbl   | Absolute price difference from benchmark                                   |
| price_percent_diff              | dbl   | Percentage price difference from benchmark                                 |
| discount_amt                    | dbl   | Dollar amount discounted                                                   |
| sales_tax_amt                   | dbl   | Dollar amount of sales tax                                                 |
| excise_tax_amt                  | dbl   | Dollar amount of excise tax                                                |
| total_tax_amt                   | dbl   | Total tax paid on the transaction                                          |
| retail_sales_amt                | dbl   | Total sales amount (including tax and after discounts)                     |
| sales_qty                       | dbl   | Quantity of items sold in the transaction                                  |
| month                           | date  | Truncated month field (used for grouping and sampling)                     |
| sold_to_licensee_dba            | chr   | "Doing Business As" name of the recipient licensee (if applicable)         |
| licensee_dba                    | chr   | "Doing Business As" name of the selling licensee                           |
