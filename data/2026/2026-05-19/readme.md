# State of Crossref metadata by member country

[Crossref](https://www.crossref.org/) is a central pillar of the global research ecosystem, running open infrastructure to create a lasting and reusable scholarly record that underpins open science. While many of us know Crossref for providing Digital Object Identifiers (DOIs), they also maintain a massive repository of metadata, which is the essential data *about* research that makes it discoverable, linkable, and reusable.

This dataset provides a granular look at how that metadata was populated across the globe from December 2018 to April 2026 (with monthly granularity beginning in January 2025). It is split into two files:

- **Member participation statistics by country:** A look at the Crossref members registering DOIs, broken down by region and country, highlighting the geographical diversity of the publishing community.
- **Metadata coverage statistics:** A look at metadata completion at the level of individual outputs, also broken down by region and country, and also by content type. This details the connectedness of research, including adoption metrics for citations, funding, ORCID IDs, and ROR IDs.

By analyzing these files, you can explore themes of global research equity, the adoption of modern publishing standards, and the varying levels of metadata richness across different corners of the world.

> By shifting the lens from global aggregates to country-level insights, this dataset provides a new look at the global landscape of scholarly communication. It serves as a critical benchmark for Crossref's Research Nexus vision — the creation of a rich, reusable open network of relationships connecting research organizations, people, and actions — enabling the community to track progress toward a more transparent and interconnected global research record.

- Which countries or regions show the fastest growth in metadata "richness" over time?
- How does the connectedness of research vary across different work types within a single country?
- Which regions are leading the way in adopting the Research Nexus vision?

Thank you to [Alexandre Bédard-Vallée](https://github.com/bedard-valleea) from [Crossref](https://github.com/crossref) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-05-19')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 20)

member_participation_stats_by_country <- tuesdata$member_participation_stats_by_country
metadata_coverage_stats_by_country <- tuesdata$metadata_coverage_stats_by_country

# Option 2: Read directly from GitHub

member_participation_stats_by_country <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-19/member_participation_stats_by_country.csv')
metadata_coverage_stats_by_country <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-19/metadata_coverage_stats_by_country.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-05-19')

# Option 2: Read directly from GitHub and assign to an object

member_participation_stats_by_country = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-19/member_participation_stats_by_country.csv')
metadata_coverage_stats_by_country = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-19/metadata_coverage_stats_by_country.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-05-19")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

member_participation_stats_by_country = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-19/member_participation_stats_by_country.csv")
metadata_coverage_stats_by_country = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-19/metadata_coverage_stats_by_country.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
member_participation_stats_by_country = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-19/member_participation_stats_by_country.csv", DataFrame)
metadata_coverage_stats_by_country = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-19/metadata_coverage_stats_by_country.csv", DataFrame)
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.

## Data Dictionary

### `member_participation_stats_by_country.csv`

|variable                         |class     |description                                                                                                                                                                          |
|:--------------------------------|:---------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|current_up_to                    |date      |The latest DOI submission date that was taken into account when computing statistics. All Crossref works submitted or updated until this date are accounted for in these statistics. |
|region_id                        |character |Three-letter code identifying the region the member is located in. These codes are sourced from the [World Bank taxonomy](<https://esgdata.worldbank.org/about/faq?lang=en>).        |
|iso3_code                        |character |Three-letter code identifying the country the member is located in. These codes are sourced from the ISO 3166-1 alpha-3 taxonomy.                                                    |
|total_members                    |double    |Number of members with at least one registered DOI.                                                                                                                                  |
|deposits_ref                     |double    |Number of members that have deposited at least one work with references.                                                                                                             |
|deposits_abstract                |double    |Number of members that have deposited at least one work with an abstract.                                                                                                            |
|deposits_license                 |double    |Number of members that have deposited at least one work with [license metadata](https://www.crossref.org/documentation/principles-practices/best-practices/license/).                |
|deposits_crossmark               |double    |Number of members that have deposited at least one work with a [Crossmark update policy](https://www.crossref.org/documentation/crossmark/crossmark-policy-page/).                   |
|deposits_updates                 |double    |Number of members that have deposited at least one [update record](https://www.crossref.org/documentation/register-maintain-records/maintaining-your-metadata/registering-updates/). |
|deposits_textmining              |double    |Number of members that have deposited at least one work with text-mining information.                                                                                                |
|deposits_status_info             |double    |Number of members that have deposited at least one work with preprint status information.                                                                                            |
|acknowledges_funding             |double    |Number of members that have deposited at least one work with funding metadata.                                                                                                       |
|deposits_funder_id               |double    |Number of members that have deposited at least one work acknowledging a [funder ID](https://www.crossref.org/services/funder-registry/).                                             |
|deposits_grant_id                |double    |Number of members that have deposited at least one work with a [grant ID](https://www.crossref.org/documentation/research-nexus/grants/).                                            |
|deposits_orcid                   |double    |Number of members that have deposited at least one work with an [ORCID ID](https://orcid.org/).                                                                                      |
|deposits_orcid_for_authors       |double    |Number of members that have deposited at least one work with an ORCID ID for an author.                                                                                              |
|deposits_orcid_for_chairs        |double    |Number of members that have deposited at least one work with an ORCID ID for a chair.                                                                                                |
|deposits_orcid_for_editors       |double    |Number of members that have deposited at least one work with an ORCID ID for an editor.                                                                                              |
|deposits_orcid_for_translators   |double    |Number of members that have deposited at least one work with an ORCID ID for a translator.                                                                                           |
|deposits_ror_id                  |double    |Number of members that have deposited at least one work with a [ROR ID](https://ror.org/).                                                                                           |
|deposits_ror_id_for_affiliations |double    |Number of members that have deposited at least one work with a ROR ID for an affiliation.                                                                                            |
|deposits_ror_id_for_funders      |double    |Number of members that have deposited at least one work with a ROR ID for a funder.                                                                                                  |
|deposits_ror_id_for_institutions |double    |Number of members that have deposited at least one work with a ROR ID for an institution.                                                                                            |

### `metadata_coverage_stats_by_country.csv`

|variable                                  |class     |description                                                                                                                                                                                 |
|:-----------------------------------------|:---------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|current_up_to                             |date      |The latest DOI submission date that was taken into account when computing statistics. All Crossref works submitted or updated until this date are accounted for in these statistics.        |
|region_id                                 |character |Three-letter code identifying the region the registering members are located in. These codes are sourced from the [World Bank taxonomy](<https://esgdata.worldbank.org/about/faq?lang=en>). |
|iso3_code                                 |character |Three-letter code identifying the country the registering members are located in. These codes are sourced from the ISO 3166-1 alpha-3 taxonomy.                                             |
|document_type                             |character |The type of work. Based off the `type` field of the [Crossref REST API](https://api.crossref.org/types), with book types () merged under `book`.                                            |
|document_subtype                          |character |The subtype of work for which statistics are computed. Applies to type `posted_content` only, null for all others.                                                                          |
|n_dois                                    |double    |Total number of works of the specified type and subtype, registered by members in the country.                                                                                              |
|with_ref                                  |double    |Number of works with at least one reference.                                                                                                                                                |
|with_doi_ref                              |double    |Number of works with at least one reference including a DOI.                                                                                                                                |
|references                                |double    |Number of references from these works.                                                                                                                                                      |
|references_with_dois                      |double    |Number of references with DOIs from these works.                                                                                                                                            |
|references_with_doi_asserted_by_publisher |double    |Number of references with DOIs asserted by the publisher from these works.                                                                                                                  |
|references_with_doi_asserted_by_crossref  |double    |Number of references with DOIs asserted by Crossref from these works.                                                                                                                       |
|citations_received                        |double    |Number of citations received by these works, from other Crossref-registered works only.                                                                                                     |
|with_abstract                             |double    |Number of works with an abstract.                                                                                                                                                           |
|with_license                              |double    |Number of works with license information.                                                                                                                                                   |
|with_crossmark                            |double    |Number of works with a Crossmark update policy registered.                                                                                                                                  |
|with_crossmark_update                     |double    |Number of works that have received at least one Crossmark update.                                                                                                                           |
|crossmark_updates                         |double    |Number of update DOIs.                                                                                                                                                                      |
|update_assertions                         |double    |Number of update assertions made by all update DOIs.                                                                                                                                        |
|update_assertions_from_publisher          |double    |Number of update assertions registered by a Crossref member.                                                                                                                                |
|update_assertions_from_retraction_watch   |double    |Number of update assertions registered through Retraction Watch.                                                                                                                            |
|with_textmining                           |double    |Number of works with at least one registered text-mining link.                                                                                                                              |
|with_status_info                          |double    |Number of works with [preprint status metadata](https://doi.org/10.13003/325070#preprint-status).                                                                                           |
|acknowledges_funding                      |double    |Number of works that include any kind of funding metadata.                                                                                                                                  |
|award_number_assertions                   |double    |Number of acknowledged award numbers.                                                                                                                                                       |
|with_grant_id                             |double    |Number of works that include at least one grant ID.                                                                                                                                         |
|grant_id_assertions                       |double    |Number of acknowledged grant IDs.                                                                                                                                                           |
|with_funder_id                            |double    |Number of works that include at least one funder ID.                                                                                                                                        |
|funder_id_assertions                      |double    |Number of acknowledged funder IDs.                                                                                                                                                          |
|with_orcid                                |double    |Number of works that include at least one ORCID ID.                                                                                                                                         |
|with_orcid_for_authors                    |double    |Number of works that include at least one ORCID ID for an author.                                                                                                                           |
|with_orcid_for_chairs                     |double    |Number of works that include at least one ORCID ID for a chair.                                                                                                                             |
|with_orcid_for_editors                    |double    |Number of works that include at least one ORCID ID for an editor.                                                                                                                           |
|with_orcid_for_translators                |double    |Number of works that include at least one ORCID ID for a translator.                                                                                                                        |
|orcid_assertions                          |double    |Number of ORCID ID assertions.                                                                                                                                                              |
|orcid_for_authors_assertions              |double    |Number of ORCID ID assertions for authors.                                                                                                                                                  |
|orcid_for_chairs_assertions               |double    |Number of ORCID ID assertions for chairs.                                                                                                                                                   |
|orcid_for_editors_assertions              |double    |Number of ORCID ID assertions for editors.                                                                                                                                                  |
|orcid_for_translators_assertions          |double    |Number of ORCID ID assertions for translators.                                                                                                                                              |
|with_ror_id                               |double    |Number of works that include at least one ROR ID.                                                                                                                                           |
|with_ror_id_for_affiliations              |double    |Number of works that include at least one ROR ID for affiliations.                                                                                                                          |
|with_ror_id_for_institutions              |double    |Number of works that include at least one ROR ID for institutions.                                                                                                                          |
|with_ror_id_for_funders                   |double    |Number of works that include at least one ROR ID for funders.                                                                                                                               |
|ror_id_assertions                         |double    |Number of ROR ID assertions.                                                                                                                                                                |
|ror_id_for_affiliations_assertions        |double    |Number of ROR ID assertions for affiliations.                                                                                                                                               |
|ror_id_for_institutions_assertions        |double    |Number of ROR ID assertions for institutions.                                                                                                                                               |
|ror_id_for_funders_assertions             |double    |Number of ROR ID assertions for funders.                                                                                                                                                    |
|preprint_to_article_links                 |double    |Number of links registered between a work of type `posted-content` and subtype `preprint` and a published work (e.g., `journal-article`).                                                   |
|retractions                               |double    |Number of retracted works.                                                                                                                                                                  |

## Cleaning Script

```r
# Clean data provided by Crossref. No cleaning was necessary.
metadata_coverage_stats_by_country <- readr::read_csv("https://zenodo.org/api/records/19928426/files/metadata_coverage_stats_by_country.csv/content")
member_participation_stats_by_country <- readr::read_csv("https://zenodo.org/api/records/19928426/files/member_participation_stats_by_country.csv/content")

```
