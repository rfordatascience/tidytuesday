|variable      |class     |description |
|:-------------|:---------|:-----------|
|snapshot_date |date      |UTC date the job boards were read (2026-11-03 for every row). |
|company       |character |Employer name. |
|provider      |character |Applicant tracking system hosting the job board: "greenhouse", "lever" or "ashby". |
|title         |character |Job title as posted. |
|role_family   |character |Title family assigned by the title rule: "sales engineer", "solutions engineer", "solutions consultant", "presales", "value engineer/consultant", "forward deployed engineer" or "solutions architect (sales context)". Solutions architect ads count only when the ad text has sales context. |
|seniority     |character |Seniority read from the title only: "entry or associate", "senior", "staff, principal or lead", "manager or above" or "not stated in title". |
|location      |character |Location text as posted. May list several places. |
|region        |character |Region derived from the location text by keyword: "North America", "Europe, Middle East, Africa", "Asia Pacific", "Latin America", "multiple" or "unknown". |
|work_mode     |character |"remote" if the workplace type, location or title says remote, "hybrid" if one says hybrid, otherwise "on-site or not stated". |
|url           |character |Link to the original ad on the employer's job board. Ads close over time, so some links will stop working. |
|tags          |character |Semicolon-separated list of terms the title plus ad text mentions (a mention, not necessarily a requirement): ai_genai (LLMs, generative AI, AI agents, agentic, prompting), ai_ml (machine learning, ML), ai_any, meddic_family (MEDDIC, MEDDICC, MEDDPICC), other_sales_methodology (Command of the Message, Challenger, SPIN, Solution Selling, Force Management, Sandler), poc_pov (proof of concept or value), demo, discovery, python, sql, javascript (JavaScript, TypeScript, Node.js), coding_any, aws, azure, gcp, cloud_any, value_selling (value selling, business case, ROI). NA when no term matches. |
|pay_min       |double    |Lower bound of the posted annual pay range in pay_currency. NA when no pay was found. |
|pay_max       |double    |Upper bound of the posted annual pay range in pay_currency. NA when no pay was found. |
|pay_currency  |character |ISO 4217 currency code of the pay range, for example "USD", "EUR", "CAD", "GBP". A bare "$" in ad text is read as USD. |
|pay_interval  |character |Pay interval. Always "year" when pay is present (hourly figures were skipped). |
|pay_source    |character |"structured" when pay came from the provider's salary field (Lever or Ashby), "text" when it is the first currency range found in the ad text. |
|pay_basis     |character |"OTE" or "base" when that label appears just before a text range, "unspecified" otherwise, and "unspecified (OTE mentioned in text)" when the ad mentions OTE elsewhere. Base and OTE ranges are not comparable as earnings. |
