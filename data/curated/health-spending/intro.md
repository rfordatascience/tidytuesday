This week we're exploring global health spending data from the [WHO Global Health Expenditure Database (GHED)](https://apps.who.int/nha/database).

How countries fund their health systems and what they prioritise is a critical determinant of health outcomes. 
Global health spending has grown substantially over the past two decades, but remains deeply unequal: high-income countries 
account for the vast majority of spending, and many low-income countries struggle to meet basic health needs.

How much countries spend on health care is only part of the story. What they spend on, and how they finance it, also 
matters. When health systems rely heavily on out-of-pocket payments rather than pooled financing arrangements, 
the cost of care falls directly on households. Similarly, how spending is allocated across health care functions
matters: countries that invest adequately in preventive care tend to achieve better population health outcomes at lower 
long-term cost, yet globally, curative care dominates health budgets while prevention receives a smaller and often 
fragile share of spending.

The data is organised into three datasets:

- **`health_spending`** — Aggregate health spending and its breakdown by funding source. Current health expenditure (CHE) is the total, split into three mutually exclusive sources: domestic government spending (GGHE-D), domestic private spending (PVT-D), and external aid (EXT). Together, `gghed + pvtd + ext = che`.
- **`financing_schemes`** — Health spending by financing scheme: government schemes, voluntary payment schemes, household out-of-pocket payments, rest of the world, and unspecified.
- **`spending_purpose`** — Health spending by health care function: curative care, rehabilitative care, long-term care, ancillary services, medical goods, preventive care, governance and administration, and other services.

Some questions to explore:

- Which countries rely most heavily on out-of-pocket payments for health care?
- How has the balance between government, private, and external aid changed over time?
- What is the split between curative and preventive care spending across countries?
- How did the COVID-19 pandemic impact health spending patterns?

Visit the [GHED portal](https://apps.who.int/nha/database/) or use the open-source [`bblocks-data-importers` Python package](https://github.com/ONEcampaign/bblocks_data_importers)
for additional indicators and data beyond what is included here, or explore related analyses at [ONE Data](https://data.one.org).
