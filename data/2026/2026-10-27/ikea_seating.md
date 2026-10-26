|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|country      |character |Two-letter code of the IKEA market, as used in ikea.com addresses (`se`, `us`, `jp`). `gb` is the United Kingdom. |
|language     |character |Language of the listing, English (`en`) wherever the market offers it, otherwise the local language (`fr`, `pl`). |
|category     |character |Category page the product is listed under, `sofas` or `armchairs`. IKEA sometimes files a product outside its type, such as a sofa-bed under `armchairs`. |
|product_name |character |Product name as listed (`EKTORP`, `STOCKHOLM 2025`, `HOLMSTA / FRÖKNABO`), with the Japanese transliteration removed. |
|name         |character |Upper-case first word of the product name (`EKTORP`, `HOLMSTA`), the key for joining to `ikea_places`. Missing for the IKEA PS range. |
|product_type |character |Product description in the listing language (`3-seat sofa`, `Armchair and footstool`, `Fauteuil`). |
|item_no      |character |IKEA article number, shared by the same product in every market (`09509013`). |
|price        |double    |Current price in the local currency. |
|price_usd    |double    |Price converted to US dollars at the exchange rate for 28 September 2026, the download date. |
|currency     |character |ISO 4217 currency code of the price (`SEK`, `EUR`, `USD`). |
|variants     |integer   |Number of other variants of the product, such as different covers or colours. |
|url          |character |Product page on ikea.com. |

