This week we're exploring data from the [WHO Global Health Expenditure Database (GHED)](https://apps.who.int/nha/database), 
which tracks global health spending. The data is sourced 
via the [ONE Health Financing Agent](https://data.one.org/tools/agents/health-financing) and 
the [bblocks-data-importers](https://github.com/ONEcampaign/bblocks-data-importers) Python package.

Health financing — how countries fund their health systems — is a critical determinant of health outcomes. 
In 2023, countries spent over $10 trillion on health globally, but this spending is deeply unequal: high-income 
countries account for the majority of health spending, while low-income countries struggle to meet basic health needs.

How much countries spend on health care is only part of the story. What they spend on, and how they finance it, also matters.
When health systems rely heavily on out-of-pocket payments rather than government schemes or compulsory contributory
financing, the cost of care falls directly on households — pushing families into poverty and deterring people
from seeking treatment altogether. Similarly, how spending is allocated across health care functions matters: countries
that invest adequately in preventive care tend to achieve better population health outcomes at lower long-term cost, yet
globally, curative care dominates health budgets while prevention receives a small and often fragile share of spending.


The three datasets cover aggregate health spending by source, financing scheme breakdowns, and spending
by health care function. Each indicator is available in two units, identified by a suffix in the `indicator_code`:

- `_che` — as a percentage of current health expenditure (CHE)
- `_usd2023` — in constant 2023 US dollars (adjusted for inflation, enabling comparisons over time among countries)

Find more details about each dataset and its indicators in the respective metadata files:
- [Health spending by source](./health_spending.md)
- [Health spending by financing scheme](./financing_schemes.md)
- [Health spending by health care function](./spending_purpose.md)


### Example analyses and visualisations

These articles from [ONE](https://data.one.org) use the same underlying data and include interactive
visualisations that illustrate what can be explored with these datasets:

- **[Out-of-pocket health burden remains high](https://data.one.org/analysis/out-of-pocket-health-burden)** — the impact of out-of-pocket spending on families
- **[Health care spending is not evenly distributed](https://data.one.org/analysis/health-spending-inequality)** — the disparities in health spending across countries
- **[The hidden fragility of preventive health spending](https://data.one.org/analysis/hidden-fragility-of-prevention-spending)** — comparing curative and preventive care spending across countries
- **[Africa falls short on health spending](https://data.one.org/analysis/african_gov_health-spending-off-track)** — the gap between current and recommended government health spending in African countries
- **[A turning point in health financing](https://data.one.org/analysis/turning-point-in-health-financing)** — the changing patterns of health financing in the wake of the COVID-19 pandemic


Some questions to explore:

- Which countries rely most heavily on out-of-pocket payments for health care?
- How has the balance between government and private health spending changed over time?
- What is the split between curative and preventive care spending across countries?
- How did the COVID-19 pandemic impact health spending patterns?
