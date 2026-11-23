# AmphibiaWeb

This week we're exploring **Frogs and Toads** through [**AmphibiaWeb**](https://amphibiaweb.org/index.html)'s massive dataset! The quote below is taken from one of the many weekly articles linked in their **Amphibian News!** portal, with entries going all the way back to 2009.  

> Understanding why biodiversity is unevenly distributed is fundamental to ecology and evolution. Should we look to contemporary climate to explain where species diversity is highest, or look deeper into the past? Jongsma et al. (2026) tackled this question in the Lower Guinean Forests of Central Africa... Pleistocene forest stability explained 65-71% of spatial variance in species richness and phylogenetic diversity, which far exceeds contemporary temperature, precipitation, or forest cover.
> 
> -- **Greg Jongsma via [AmphibiaWeb News](https://amphibiaweb.org/resources/amphibian_news.html)** (referencing [Jongsma et al., 2026](https://doi.org/10.1002/ece3.73207))

#### Citation
Jongsma, G. F. M., N. Barve, J. M. Allen, H. L. Owens, and D. C. Blackburn. 2026. "Pleistocene Forest Stability Predicts Patterns of Frog Diversity in Central Africa." *Ecology and Evolution* 16 (3): e73207. [https://doi.org/10.1002/ece3.73207](https://doi.org/10.1002/ece3.73207).

The article above needn't be the only place to draw inspiration. [AmphibiaWeb News](https://amphibiaweb.org/resources/amphibian_news.html) highlights an amphibian-related journal article every week!

Here are a few questions you might answer with your visualisations this week:

- Which frog families contain the highest species counts, and how is diversity distributed across genera?
- Which countries host the highest numbers of native frog/toad species?
- How do IUCN status designations (`interntnl_status`) vary across families or geographical regions?
- Can historical geographic range notes or habitat descriptions explain current regional species clustering?

Thank you to [Ntobeko Sosibo](https://github.com/afrikaniz3d-za) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-10-13')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 41)

frogs_and_toads_amphibiaweb <- tuesdata$frogs_and_toads_amphibiaweb

# Option 2: Read directly from GitHub

frogs_and_toads_amphibiaweb <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-13/frogs_and_toads_amphibiaweb.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-10-13')

# Option 2: Read directly from GitHub and assign to an object

frogs_and_toads_amphibiaweb = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-13/frogs_and_toads_amphibiaweb.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-10-13")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

frogs_and_toads_amphibiaweb = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-13/frogs_and_toads_amphibiaweb.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
frogs_and_toads_amphibiaweb = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-13/frogs_and_toads_amphibiaweb.csv", DataFrame)
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

### `frogs_and_toads_amphibiaweb.csv`

|variable           |class     |description                           |
|:------------------|:---------|:-------------------------------------|
|amphib_id          |integer   |Unique identifier assigned to the species record in AmphibiaWeb. |
|clade              |character |The taxonomic clade to which the individual belongs, representing a monophyletic group of frogs or toads sharing a common ancestor. |
|comments           |character |General notes, taxonomic discussions, or miscellaneous observations regarding the species record. |
|common_name        |character |Primary vernacular or English common name (often NA if none exists). |
|description        |character |Free-text narrative detailing physical features, morphology, or coloration. |
|distribution       |character |Geographic range description, country codes, or regional distribution notes. |
|edit_date          |date      |Date when the species account was last edited or updated. |
|editedby           |character |Editor(s) who reviewed or revised the account entry. |
|family             |character |Taxonomic family (e.g., Hylidae, Bufonidae). |
|genus              |character |Taxonomic genus name. |
|interntnl_status   |character |International conservation status designation (e.g., IUCN Red List category). |
|intro_isocc        |character |ISO country codes indicating regions where the species has been introduced. |
|isocc              |character |ISO country codes representing the native range and occurrence of the species. |
|lannoo             |character |Account summary or commentary derived from Lannoo's Amphibian Declines reference texts. |
|larva              |character |Morphological description, traits, or ecology of the larval or tadpole stage. |
|life_history       |character |Habitat, ecology, breeding behavior, clutch size, or larval traits. |
|national_status    |character |Conservation or legal status of the species within specific national jurisdictions. |
|ordr               |character |Higher taxonomic order (Anura, Caudata, Gymnophiona). |
|refs               |character |Citations and bibliographic references supporting the species account. |
|regional_status    |character |Local or regional conservation assessment status. |
|relation_to_humans |character |Anthropogenic interaction, pet trade notes, or cultural significance. |
|specificepithet    |character |Specific epithet / species name. |
|subfamily          |character |Taxonomic subfamily designation beneath family. |
|submit_date        |date      |Date when the species account was originally submitted to AmphibiaWeb. |
|submittedby        |character |Author/contributor who compiled or updated the species account. |
|trends_and_threats |character |Known threats (e.g., chytrid fungus, habitat loss) and population trend notes. |

## Cleaning Script

```r
# ==============================================================================
# AmphibiaWeb (Order Anura - Frogs & Toads)
#
# NOTE:
# AmphibiaWeb enforces Cloudflare Turnstile protection, which blocks automated
# HTTP script downloads. 
#
# INSTRUCTIONS:
# 1. Download 'amphib_dump.xml' manually from the link at the bottom of
#    https://amphibiaweb.org/api/ws.html
# 2. Place 'amphib_dump.xml' into your working directory.
# 3. Run this script to parse, filter, clean, and export the final dataset.
# ==============================================================================

library(tidyverse)
library(xml2)

raw_xml_file <- "amphib_dump.xml"

# 1. Check for required local XML dump
if (!file.exists(raw_xml_file)) {
  stop(
    "\n[ERROR] Missing source file: 'amphib_dump.xml'\n",
    "Please download the XML file directly from https://amphibiaweb.org/api/ws.html\n",
    "and save it in your project directory before running this script."
  )
}

message("Reading local AmphibiaWeb XML dump...")

# 2. Read XML document with recovery mode enabled for minor syntax tolerance
xml_doc <- read_xml(raw_xml_file, options = "RECOVER")

# 3. Extract species nodes
species_nodes <- xml_find_all(xml_doc, "//species")
message(paste("Successfully found", length(species_nodes), "total species records in XML."))

# 4. Unnest XML nodes into a wide data frame
message("Unnesting XML nodes into tabular format...")
raw_df <- map_dfr(species_nodes, function(node) {
  children <- xml_children(node)
  keys <- xml_name(children)
  vals <- xml_text(children)
  
  tibble(key = keys, val = vals) %>% 
    group_by(key) %>% 
    summarise(val = paste(val, collapse = " | "), .groups = "drop") %>% 
    pivot_wider(names_from = key, values_from = val)
})

# 5. Clean column names and locate order field
raw_df_clean <- raw_df %>% 
  rename_with(str_to_lower)

order_col <- names(raw_df_clean)[str_detect(names(raw_df_clean), "^ordr$|^order$")][1]

if (is.na(order_col)) {
  stop("Could not locate an 'ordr' or 'order' column in the parsed XML dataset.")
}

message(paste("Filtering records on order column:", order_col))

# 6. Filter strictly for Order Anura (Frogs & Toads)
anura_df <- raw_df_clean %>% 
  filter(str_trim(str_to_lower(.data[[order_col]])) == "anura")

# 7. Clean whitespace, convert empty strings to NA, and parse column data types
message("Curating columns and parsing data types...")
anura_curated <- anura_df %>% 
  # 7.1. Strip leading/trailing whitespace and \n characters across all character columns
  mutate(across(where(is.character), str_trim)) %>% 
  
  # 7.2. Convert empty strings ("") or whitespace-only strings to true R NAs
  mutate(across(where(is.character), ~ na_if(.x, ""))) %>% 
  
  # 7.3. Explicitly parse numeric and date columns
  mutate(
    amphib_id   = as.integer(amphib_id),
    submit_date = ymd(submit_date),
    edit_date   = ymd(edit_date),
    interntnl_status = as.character(interntnl_status)
  )

# 8. Print dataset dictionary summary table
message("Dataset Schema Overview:")
tibble(
  column_name  = names(anura_curated),
  data_type    = map_chr(anura_curated, ~ class(.x)[1]),
  sample_value = map_chr(anura_curated, ~ as.character(na.omit(.x))[1] %||% NA_character_)
) %>% 
  print(n = Inf)

```
