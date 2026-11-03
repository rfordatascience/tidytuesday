This week we're exploring sales engineering job ads. The dataset comes from the [SE Job Ad Index](https://github.com/jacobtop-tcg/se-job-ad-index), which read the public job boards of 250 selected B2B software companies on Greenhouse, Lever and Ashby on 3 November 2026. Of the 20,665 open postings on those boards, 1,502 are SE-type roles: sales engineer, solutions engineer or consultant, presales, value engineer, forward deployed engineer, and solutions architect when the ad has sales context.

Each row is one posting with the company, title, location, a link to the original ad, a set of tags for terms the ad mentions, and the posted pay range when one was found (722 of the 1,502). The ad text itself is not included. A tag counts a mention, so it can come from company boilerplate rather than the job requirements. The 250 companies were selected by hand and lean toward US software, data and AI companies, and Databricks alone has 270 of the postings, so the data describes this sample rather than the whole job market.

> On 3 November 2026, 250 selected B2B software companies had 1,502 open SE-type postings on their public job boards. Nearly half mention at least one of the AI-related terms we searched for; one in twenty mentions a term in the MEDDIC family.

Some questions to explore:

- How do the tags differ between title families, for example forward deployed engineer versus sales engineer ads?
- How much does one large employer change a share? Compare the share of postings with the average of each company's own share.
- Which regions and work modes post pay most often, and how do the annual USD ranges compare across seniority levels?
- Are base and OTE ranges different enough that mixing them changes a median?
