|variable               |class     |description                           |
|:----------------------|:---------|:-------------------------------------|
|symbol                 |character |Ticker symbol the company traded under before it was delisted. |
|company                |character |Company name. |
|exchange               |character |US exchange the stock was delisted from (NYSE, Nasdaq or NYSE American). |
|year                   |integer   |Year the company left the exchange: year of the deal closing date if known, else of the SEC Form 25 filing, else of the last trading day. 2021 starts on October 18; 2026 runs through October. |
|outcome                |factor    |What happened: acquired (bought by another company), taken_private (bought by a private equity firm or investor group), merged (merger of equals or merger into a new entity), left_us_exchange (left the US exchange but shares keep trading abroad: voluntary exits, Chinese state-owned companies in 2022, Russian ADRs halted in 2022), other (bankruptcy, SPAC liquidation or reason not confirmed). |
|buyer                  |character |Buyer or merger partner, if any. Several buyers are separated by "and". |
|payment                |character |How shareholders were paid: cash, stock or cash_and_stock. NA when not applicable or unknown. |
|terms                  |character |Deal terms per share as announced, for example "$56.50 per share in cash". |
|deal_value             |character |Deal value as reported in news coverage, in the original wording (for example "about $27.8 billion" or "about $10.9 billion including debt"). |
|deal_value_usd_bn      |double    |deal_value parsed to billions of US dollars. NA when there is no value or it was reported in another currency. Some values include debt, so they are not strictly comparable. |
|announced              |character |Month the deal was announced, as YYYY-MM. |
|closed                 |date      |Date the deal closed. |
|summary                |character |One-sentence plain-English summary of what happened to the company. |
|source_url             |character |News article or press release that confirms the outcome. |
|cik                    |character |SEC Central Index Key of the company. |
|sic_code               |character |Standard Industrial Classification code assigned by the SEC. |
|sic_description        |character |SEC description of the SIC code, for example "Pharmaceutical Preparations". |
|state_of_incorporation |character |State or country of incorporation, per SEC EDGAR. |
|form25_type            |character |Type of the SEC Form 25 delisting notice: 25-NSE (filed by the exchange, usually after a merger closes) or 25 (filed by the company for a voluntary delisting). NA when no Form 25 was found near the last trading day. |
|form25_date            |date      |Filing date of that Form 25. |
|form25_url             |character |Link to the Form 25 filing on SEC EDGAR. |
