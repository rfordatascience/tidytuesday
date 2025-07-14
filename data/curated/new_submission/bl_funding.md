|variable                      |class   |description                           |
|:-----------------------------|:-------|:-------------------------------------|
|year                          |integer |First year of the annual report. Eg, 2016 is for the 2016/2017 annual report. |
|nominal_gbp_millions          |double  |Total reported funding in millions of Great Britain Pounds (GBP). |
|gia_gbp_millions              |double  |Reported funding from grant-in-aid (the official term for the core funding from the UK government). |
|voluntary_gbp_millions        |double  |Reported funding covering all voluntary contributions and donations, including the valuation of donated collection items. |
|investment_gbp_millions       |double  |Reported funding from returns on savings and investments. |
|services_gbp_millions         |double  |Reported funding from service delivery within the remit of being a charity. The main part of this over the years has been the document supply service, which started out as the National Lending Library for Science and Technology. |
|other_gbp_millions            |double  |Reported funding from anything that doesn’t fit into the above categories. |
|year_2000_gbp_millions        |double  |Funding values from the original blog post at https://blog.dshr.org/2017/08/preservation-is-not-technical-problem.html. |
|inflation_adjustment          |double  |The cost in each given year of 1,000,000 GBP in terms of year 2000 GBP. Figures come from the the current (2024) Bank of England inflation calculator: https://www.bankofengland.co.uk/monetary-policy/inflation/inflation-calculator. |
|total_y2000_gbp_millions      |double  |Total reported funding adjusted to Y2000 GBP. |
|percentage_of_y2000_income    |double  |`total_y2000_gbp_millions` / `total_y2000_gbp_millions` for `year == 2000`. |
|gia_y2000_gbp_millions        |double  |Grant-in-aid funding in Y2000 GBP. |
|voluntary_y2000_gbp_millions  |double  |Voluntary funding in Y2000 GBP. |
|investment_y2000_gbp_millions |double  |Investment funding in Y2000 GBP. |
|services_y2000_gbp_millions   |double  |Services funding in Y2000 GBP. |
|other_y2000_gbp_millions      |double  |Other funding in Y2000 GBP. |
|gia_as_percent_of_peak_gia    |double  |`gia_y2000_gbp_millions / max(gia_y2000_gbp_millions)` |
