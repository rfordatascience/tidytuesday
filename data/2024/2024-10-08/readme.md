# National Park Species

This week we're exploring species at the most visited National Parks in the USA! NPSpecies contains species listed by National Parks maintained by National Parks Service (NPS). Given the size of the dataset, we're focusing on the 15 most visited parks. The data comes from https://irma.nps.gov/NPSpecies/Search/SpeciesList. 

> The information in NPSpecies is available to the public. The exceptions to this are records for some sensitive, threatened, or endangered species, where widespread distribution of information could potentially put a species at risk.   
>
> An essential component of NPSpecies is evidence; that is, observations, vouchers, or reports that document the presence of a species in a park. Ideally, every species in a park that is designated as “present in park” will have at least one form of credible evidence substantiating the designation

If you are looking for more detailed information on the dataset, here is the glossary for column names, field options, and tag meanings: 
https://irma.nps.gov/content/npspecies/Help/docs/NPSpecies_User_Guide.pdf


To properly cite NPSpecies use the following: 
**NPSpecies - The National Park Service biodiversity database.**
**https://irma.nps.gov/npspecies/. Accessed date/time. **

*This data was accessed on September 2nd, 2024.*

If you are interested in additional data, the curated dataset for all national parks is available at [https://github.com/frankiethull/NPSpecies](https://github.com/frankiethull/NPSpecies).

Thank you to [f. hull](https://github.com/frankiethull) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-10-08')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 41)

most_visited_nps_species_data <- tuesdata$most_visited_nps_species_data

# Option 2: Read directly from GitHub

most_visited_nps_species_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-10-08/most_visited_nps_species_data.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `most_visited_nps_species_data.csv`

|variable             |class     |description                           |
|:--------------------|:---------|:-------------------------------------|
|ParkCode             |character |National Park Code. |
|ParkName             |character |National Park Full Name. |
|CategoryName         |character |Species Category. |
|Order                |character |Species Order. |
|Family               |character |Species Family. |
|TaxonRecordStatus    |character |whether or not the taxon is active. |
|SciName              |character |scientific name for the species. |
|CommonNames          |character |common name of the species. |
|Synonyms             |list      |other names the species may go by. |
|ParkAccepted         |logical   |whether or not the park accepts this species. |
|Sensitive            |logical   |whether or not the species is 'sensitive'. |
|RecordStatus         |character |whether or not nps approved the species. |
|Occurrence           |character |The current status of existence or presence of each species in each park. Applicable only to scientific names with Park Accepted Status of "Accepted". Possible values reflect a combination of confidence, and availability and currency of verifiable evidence. |
|OccurrenceTags       |character | additional sighting informational tag. |
|Nativeness           |character | whether or not the species is native. |
|NativenessTags       |character | additional native informational tag. |
|Abundance            |character | how abundant is the species in the park. |
|NPSTags              |character | NPSpecies system-wide attributes and tags are standard categories and designations that apply across all parks and species. |
|ParkTags             |character | parks can create their own custom attributes, called “park tags,” and apply them to their park species records. For example, perhaps a park wants to set up a list of spring wildflowers, or identify the park subunits in which species occur. |
|References           |integer   | four columns that display the number of associated evidence records that substantiate the status of the species in the park: Observations, Vouchers, References, and External Links. A document, publication, article, database, or other information resource that contains information on one or more park species. |
|Observations         |integer   | four columns that display the number of associated evidence records that substantiate the status of the species in the park: Observations, Vouchers, References, and External Links. An observation is subjective evidence (no physical proof taken) as to the identity and the location of an organism. |
|Vouchers             |integer   | four columns that display the number of associated evidence records that substantiate the status of the species in the park: Observations, Vouchers, References, and External Links. Physical evidence used to confirm identity and prove an organism was found in a particular location. Forms of physical evidence include a voucher specimen at a museum or herbarium (including whole or piece of organism), or in some cases a photo image (i.e. digital or hardcopy) |
|ExternalLinks        |character | four columns that display the number of associated evidence records that substantiate the status of the species in the park: Observations, Vouchers, References, and External Links.  |
|TEStatus             |character | indicates any FWS Threatened or Endangered species status. |
|StateStatus          |character | Many states and US territories maintain their own lists of species of concern, or may have other status categories that are assigned to species within a state/territory. |
|OzoneSensitiveStatus |character | Plant species found within National Park boundaries that are known to have a negative response to high ozone exposure. Ground-level ozone can cause visible leaf injury (e.g. bleaching or dark stippling), growth and yield reductions, and altered sensitivity to stressors (e.g. pests, diseases, or drought). |
|GRank                |character | Global ranks assess the level of rarity or abundance of a taxon throughout its range. |
|SRank                |character | State ranks assess rarity or abundance of a taxon within a state. |

### Cleaning Script

```r
# NPSpecies - The National Park Service biodiversity database.   
# https://irma.nps.gov/npspecies/       
# Accessed September 2nd, 2024   
devtools::install_github("frankiethull/NPSpecies")

# get rdb data from curated pkg ----
# uh-oh, it is 96MB, dslc notes that cannot exceed 20MB #
nps_species_data <- NPSpecies::species

# let's focus on most visited parks! ----
# note that I'm filtering on NPs and 2023: 
# https://irma.nps.gov/Stats/Reports/Park
# https://irma.nps.gov/Stats/SSRSReports/National%20Reports/Annual%20Park%20Ranking%20Report%20(1979%20-%20Last%20Calendar%20Year)

# top 10-20 parks but do not exceed 20MB
top_visited <- c("GRSM", "GRCA", "ZION", "YELL", "ROMO", 
                 "YOSE", "ACAD", "GRTE", "JOTR", "OLYM", 
                 "GLAC", "CUVA", "INDU", "HOSP", "BRCA")

most_visited_nps_species_data <-
nps_species_data |>
  dplyr::filter(ParkCode %in% top_visited) |>
  # removed a few columns, already lots of info
  dplyr::select(-c(CategorySort, TaxonCode, TSN)) 
```
