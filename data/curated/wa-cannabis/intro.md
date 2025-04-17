This week, we’re exploring Washington State’s legal cannabis market through a dataset of retail transactions and inventory classifications reported by licensed businesses.

Since the legalization of recreational cannabis in Washington, the Washington State Liquor and Cannabis Board (WSLCB) has mandated that all licensed producers, processors, and retailers report detailed inventory movements and sales. This dataset is a cleaned, anonymized sample of 50,000 transactions from January 2024 through March 2025.

- Product type and strain
- Sale date (month-year)
- Retail price, quantity sold, and taxes
- Basic licensee-to-licensee and retailer-to-consumer transactions
- Inventory categories and subcategories (e.g., flower, concentrate, edibles)

Transformed variables include:
- `price_gram_wavg = mean(calc_price_per_gram, weighted by sales_qty)`
- `price_absolute_diff = abs(calc_price_per_gram - price_gram_wavg)`
- `price_percent_diff = 100 * (calc_price_per_gram - price_gram_wavg) / price_gram_wavg`

Personally identifiable licensee information (PII) has been removed, retaining only the “Doing Business As” (DBA) names for interpretability.

Participants this week can explore trends in pricing, product popularity, retail behaviors, and market structure over time. The dataset is right-sized for time series forecasting, market basket analysis, price modeling, and regulatory policy analysis.
