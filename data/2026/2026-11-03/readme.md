# Grambank

This week we're exploring languages! The dataset comes from [**Grambank**](https://grambank.clld.org/), a massive, open-access digital database that maps the grammatical structures of over 2,400 of the world's languages. Instead of looking at the vocabulary, Grambank focuses purely on grammar rules and structural features.  

For any given language, it looks at things like:

• Word Order: Does the language put the subject before the verb (like English "the cat sat") or after?  
• Pronouns: Does the language have a specific word for "we" that means "you and me, but not anyone else"?  
• Grammatical Gender: Does it assign masculine or feminine genders to nouns?  
• Sound and Structure: How are plurals, tenses, or questions formed?  
 
It's a tool built by an international team of linguists to show just how diverse (and how connected) human speech really is.  

> "...An analysis of the consequences of language loss reveals that the reduction in diversity will be strikingly uneven across the major linguistic regions of the world. Without sustained efforts to document and revitalize endangered languages, our linguistic window into human history, cognition, and culture will be seriously fragmented."    

#### Citation
Hedvig Skirgård et al. , *"Grambank reveals the importance of genealogical constraints on linguistic diversity and highlights the impact of language loss"*. Sci. Adv.9,eadg6175(2023). [DOI:10.1126/sciadv.adg6175](https://doi.org/10.1126/sciadv.adg6175)

### Exploring the Data

Here are a few questions you can answer with your visualisations this week:

- How do specific grammatical features (like word order or head-marking) spread spatially across borders compared to within language families?  
- Which typological features frequently co-occur across the world's languages?
- How similar are languages structurally across families and macro-regions?

Thank you to [Ntobeko Sosibo](https://github.com/afrikaniz3d-za) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-11-03')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 44)

grambank_languages <- tuesdata$grambank_languages
grambank_parameters <- tuesdata$grambank_parameters
grambank_values <- tuesdata$grambank_values

# Option 2: Read directly from GitHub

grambank_languages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_languages.csv')
grambank_parameters <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_parameters.csv')
grambank_values <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_values.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-11-03')

# Option 2: Read directly from GitHub and assign to an object

grambank_languages = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_languages.csv')
grambank_parameters = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_parameters.csv')
grambank_values = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_values.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-11-03")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

grambank_languages = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_languages.csv")
grambank_parameters = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_parameters.csv")
grambank_values = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_values.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
grambank_languages = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_languages.csv", DataFrame)
grambank_parameters = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_parameters.csv", DataFrame)
grambank_values = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-03/grambank_values.csv", DataFrame)
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

### `grambank_languages.csv`

|variable      |class     |description                           |
|:-------------|:---------|:-------------------------------------|
|language_id   |character |Unique CLDF identifier for the language variety. |
|language_name |character |Primary name of the language variety in Glottolog. |
|glottocode    |character |Unique 8-character Glottolog alphanumeric identifier. |
|macroarea     |character |Geographic macro-region where the language is spoken (e.g., Africa, Papunesia, Eurasia). |
|latitude      |double    |Geographic latitude coordinate in decimal degrees. |
|longitude     |double    |Geographic longitude coordinate in decimal degrees. |
|family_name   |character |Top-level language family name (e.g., Austronesian, Atlantic-Congo). |
|lineage       |character |Full genealogical path/hierarchy of language families from Glottolog. |

### `grambank_parameters.csv`

|variable            |class     |description                           |
|:-------------------|:---------|:-------------------------------------|
|parameter_id        |character |Unique identifier for the Grambank feature code (e.g., GB020, GB021). |
|feature_name        |character |Concise question title for the structural feature. |
|feature_description |character |Detailed definition and coding guidelines for the typological feature, including the meaning of each code for multi-state features. |
|word_order          |integer   |Weight (0 or 1) of the feature in the verb-initial word order metric. 0 does not mean the feature is unrelated to word order. `NA` if the feature is not used in the metric. |
|locus_of_marking    |integer   |Weight (0 or 1) of the feature in the head-marking metric. 0 does not mean the feature is unrelated to marking. `NA` if the feature is not used in the metric. |

### `grambank_values.csv`

|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|language_id  |character |Identifier for the language variety, joining to `grambank_languages`. |
|parameter_id |character |Identifier for the Grambank feature, joining to `grambank_parameters`. |
|value        |integer   |Coded state for the feature. For binary features, 0 = absent and 1 = present. For multi-state features (e.g., GB024), the integer codes are feature-specific categories (e.g., 1 = numeral before noun, 2 = numeral after noun, 3 = both orders), so 1 does not mean "present"; see `feature_description` in `grambank_parameters` for each feature's definitions. |
|code_id      |character |Specific categorical code identifier (`parameter_id` and `value` joined by a hyphen, e.g., GB024-2) linking the value state to CLDF parameter definitions. |

## Cleaning Script

```r
library(tidyverse)

# 1. Download Grambank v1.0.3 zip directly from Zenodo
zip_url  <- "https://zenodo.org/records/7844558/files/grambank/grambank-v1.0.3.zip?download=1"
temp_zip <- tempfile(fileext = ".zip")
temp_extract <- file.path(tempdir(), "grambank_extracted")

message("Downloading Grambank release v1.0.3...")
download.file(zip_url, destfile = temp_zip, mode = "wb", quiet = TRUE)

# 2. Extract contents to an isolated temporary folder
message("Unzipping repository contents...")
unzip(temp_zip, exdir = temp_extract)

# 3. Locate the 'cldf' directory dynamically
extracted_files <- list.files(temp_extract, recursive = TRUE, full.names = TRUE)
values_path     <- grep("cldf/values\\.csv$", extracted_files, value = TRUE)
languages_path  <- grep("cldf/languages\\.csv$", extracted_files, value = TRUE)
parameters_path <- grep("cldf/parameters\\.csv$", extracted_files, value = TRUE)

# 4. Import the raw CLDF files
message("Importing CLDF tables...")
values_raw     <- read_csv(values_path, show_col_types = FALSE)
languages_raw  <- read_csv(languages_path, show_col_types = FALSE)
parameters_raw <- read_csv(parameters_path, show_col_types = FALSE)

# 5. Clean & subset datasets

# 5.1 Fact Table: Core coded observations
grambank_values <- values_raw |>
  filter(!is.na(Value), Value != "?") |>
  select(
    language_id = Language_ID,
    parameter_id = Parameter_ID,
    value = Value,
    code_id = Code_ID
  ) |>
  mutate(
    value = as.integer(value)
  )

# 5.2 Dimension Table: Language geographic & genealogical metadata
grambank_languages <- languages_raw |>
  select(
    language_id = ID,
    language_name = Name,
    glottocode = Glottocode,
    macroarea = Macroarea,
    latitude = Latitude,
    longitude = Longitude,
    family_name = Family_name,
    lineage
  ) |>
  mutate(
    across(c(latitude, longitude), as.numeric)
  )

# 5.3 Dimension Table: Typological feature look-up
grambank_parameters <- parameters_raw |>
  select(
    parameter_id = ID,
    feature_name = Name,
    feature_description = Description,
    word_order = Word_Order,
    locus_of_marking = Locus_of_Marking
  ) |>
  mutate(
    across(c(word_order, locus_of_marking), as.integer)
  )

# 6. Clean up temporary download artifacts
unlink(temp_zip)
unlink(temp_extract, recursive = TRUE)

message("Success. Grambank datasets ('grambank_values', 'grambank_languages', 'grambank_parameters') are loaded and ready in the environment.")

```
