This dataset is a curated sample of 50,000 cannabis transactions in Washington State between January 2024 and March 2025.

It is derived from mandatory inventory and sales reports submitted to the Washington State Liquor and Cannabis Board (WSLCB) by licensed retailers, processors, and producers.

The full dataset contains over 19 million rows. This version was stratified monthly to ensure a representative temporal sample for learning, analysis, and modeling.

### Columns include:
- `sale_date_month`: Transaction month
- `retail_wholesale_desc`: Retail vs. wholesale sales
- `product_name`, `strain_type`, `inventory_type`: Product details
- `retail_sales_amt`, `sales_qty`: Financial and volume data
- `licensee_dba` : Business (non-personal) info
- `sold_to_licensee_dba`: Business (non-personal) info, NA = public citizen/consumer

### Example questions:
- How do sales volumes and prices change over time?
- Are there seasonal trends in retail cannabis activity?
- What categories of cannabis products are most frequently sold?
- How does product pack size relate to price per gram?
- Do different licensee types or retail chains show pricing patterns?

This dataset is ideal for time series forecasting, product analysis, price modeling, and policy evaluation related to cannabis regulation.