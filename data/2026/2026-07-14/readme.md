# Many penguins

This dataset gives morphometric data for 93 penguins from 18 species within 6 genera. It was inspired by the
now-classic "Palmer penguins data set". I attended a workshop where students were analyzing the Palmer-penguins
data set with a hierarchical model with individuals grouped by species. However, because there are only three species
represented in the Palmer data set (Adélie, Chinstrap, and Gentoo), this data set is not ideal for that purpose.
I found (with the assistance of a chatbot) the [AVONET dataset](https://opentraits.org/datasets/avonet.html) (Tobias
*et al.* 2022):

> The AVONET database contains comprehensive functional trait data for all birds, including six ecological variables, eleven continuous morphological traits, and information on range size and location. Raw morphological measurements are available from 90020 individuals of 11009 extant bird species sampled from 181 countries.

I selected the penguin data from the database. The data set has 10 different morphometric measurements of penguin beaks, wings, tails, etc. (although up to 12% of some types of measurements are missing). 

- How do trait values covary within/across species and genera? 
- Is there a good way to do ordination/visualization that handles the missingness of some of the traits nicely? 
- Are there interesting ways to visualize these data in >2 dimensions?

I also found some basic phylogenetic (evolutionary relationship) data for these species. It doesn't easily fit into a tidy format, but if you want to use this information in your visualizations, are using R, and have the `ape` and `rotl` packages installed you can get it yourself as follows:

```r
library(rotl)
library(ape)
# Resolve Spheniscidae to an OTT ID
sphen <- rotl::tnrs_match_names("Spheniscidae")
## Pull the full synthetic subtree for all penguins (ignore singleton-node warning)
tree <- suppressWarnings(rotl::tol_subtree(ott_id = ott_id(sphen), label_format = "name"))
## OTL represents some extant species at subspecies level (trinomials like
## Pygoscelis_papua_papua). Collapse to binomials then drop duplicate tips
## so each species appears once.
tree$tip.label <- sub("^([[:alpha:]]+_[[:alpha:]]+)_.*", "\\1", tree$tip.label)
tree <- ape::drop.tip(tree, tree$tip.label[duplicated(tree$tip.label)])
## keep only the part of the tree involving species in our database
penguin_tree <- ape::keep.tip(tree, tree$tip.label[tree$tip.label %in% gsub(" ", "_", levels(many_penguins$species))])
```

Thank you to Ben Bolker, McMaster University for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-07-14')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 28)

many_penguins <- tuesdata$many_penguins

# Option 2: Read directly from GitHub

many_penguins <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-14/many_penguins.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-07-14')

# Option 2: Read directly from GitHub and assign to an object

many_penguins = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-14/many_penguins.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-07-14")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

many_penguins = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-14/many_penguins.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
many_penguins = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-14/many_penguins.csv", DataFrame)
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

### `many_penguins.csv`

|variable           |class         |description                           |
|:------------------|:-------------|:-------------------------------------|
|species            |factor |Penguin species name. |
|genus              |factor |Penguin genus name. |
|shortname          |factor |Abbreviated species name. |
|sex                |factor |Sex of the individual sampled: M = Male; F = Female; U = Unknown. |
|beak.length_culmen |double        |Length from the tip of the beak to the base of the skull (mm).                                                                                                                                             |
|beak.length_nares  |double        |Length from the anterior edge of the nostrils to the tip of the beak (mm).                                                                                                                                 |
|beak.width         |double        |Width of the beak at the anterior edge of the nostrils (mm).                                                                                                                                               |
|beak.depth         |double        |Depth of the beak at the anterior edge of the nostrils (mm).                                                                                                                                               |
|tarsus.length      |double        |Length of the tarsus from the posterior notch between tibia and tarsus (mm).                                                                                                                               |
|wing.length        |double        |Length from the carpal joint (bend of the wing) to the tip of the longest primary on the unflattened wing (mm).                                                                                            |
|kipps.distance     |double        |Length from the tip of the first secondary feather to the tip of the longest primary (mm).                                                                                                                 |
|secondary1         |double        |Length from the carpal joint (bend of the wing) to the tip of the first secondary (mm).                                                                                                                    |
|hand-wing.index    |double        |100*DK/Lw, where DK is Kipp’s distance and Lw is wing length (i.e., Kipp’s distance corrected for wing size). Species average HWI differ from estimates in Sheard et al. (2020) because of much higher sampling of individuals in some species, as well as taxonomic effects in the BirdLife list (mm). |
|tail.length        |double        |Distance between the tip of the longest rectrix and the point at which the two central rectrices protrude from the skin, typically measured using a ruler inserted between the two central rectrices (mm). |

## Cleaning Script

```r
## https://opentraits.org/datasets/avonet.html
library(tidyverse)
library(readxl)
library(rotl)
library(ape)

cleanup <- TRUE ## 

## retrieve full data file (17 MB)
if (!file.exists("ELEData.zip")) {
  download.file("https://ndownloader.figshare.com/files/38429873",
                 destfile = "ELEData.zip", mode = "wb")
}

f0 <- c("AVONET_Raw_Data.csv", "AVONET_Extant_Species_List.csv")
files <- paste0("ELEData/TraitData/", f0) |>
    setNames(c("trait_data", "species_list"))
if (!all(file.exists(files))) unzip("ELEData.zip", files)

## info from species list
spp <- read_csv(files[["species_list"]], col_types = "c") |>
    filter(grepl("Spheniscidae", Family.name)) |>
    select(c(Species.name, Family.name)) |>
    distinct()

many_penguins <- (read_csv(files[["trait_data"]])
  |> right_join(spp, by = c("Species1_BirdLife" = "Species.name"))
  ## omit uninformative columns (e.g. Age=0 for all but one bird)
  |> select(Species = Species1_BirdLife,
            Sex, Beak.Length_Culmen, Beak.Length_Nares,  
            Beak.Width, Beak.Depth, Tarsus.Length,
            Wing.Length, Kipps.Distance, Secondary1,
            "Hand-wing.Index", Tail.Length)
  |> mutate(genus = stringr::str_extract(Species, "^[[:alpha:]]+"),
            .after = 1,
            shortname =
              stringr::str_replace(Species, "^([[:alpha:]])[[:alpha:]]+", "\\1\\."))
  ## alphabetical order is probably fine, don't need to worry about e.g. forcats::fct_inorder()
  |> mutate(across(where(is.character), factor))
  |> rename_with(tolower)
)

## get 'Supplementary dataset 2.xlsx" from the site (contains metadata)
if (!file.exists("Supplementary_dataset_2.xlsx")) {
  download.file(
    url = "https://ndownloader.figshare.com/files/34480862",
    destfile = "Supplementary_dataset_2.xlsx",
    mode = "wb"  # binary mode — required for .xlsx
  )
}
metadata <- read_excel("Supplementary_dataset_2.xlsx")
my_rows <- seq(grep("Sex", metadata$Variable),
               grep("Tail.Length", metadata$Variable))
## non-idempotent, watch out
metadata <- slice(metadata, my_rows) |> select(-Source)
write.csv(metadata, file = "metadata.csv", row.names = FALSE)
# Used to construct data dictionary. Delete when that is finished.

# Resolve Spheniscidae to an OTT ID
sphen <- rotl::tnrs_match_names("Spheniscidae")

## Pull the full synthetic subtree for all penguins
## (don't care about singleton-node warning)
tree <- suppressWarnings(rotl::tol_subtree(ott_id = ott_id(sphen), label_format = "name"))

## OTL represents some extant species at subspecies level (trinomials like
## Pygoscelis_papua_papua). Collapse to binomials then drop duplicate tips
## so each species appears once.
tree$tip.label <- sub("^([[:alpha:]]+_[[:alpha:]]+)_.*", "\\1", tree$tip.label)
tree <- ape::drop.tip(tree, tree$tip.label[duplicated(tree$tip.label)])

penguin_tree <- ape::keep.tip(tree, tree$tip.label[tree$tip.label %in% gsub(" ", "_", levels(many_penguins$species))])
ape::write.tree(penguin_tree, "penguin.nwk")

## data from Subramian et al 2013
# Download manually via web browser
## url <- "https://datadryad.org/downloads/file_stream/438985"  # mitogenome_calibrated.tree
## trees <- read.nexus("~/Downloads/mitogenome_calibrated.tree")  # returns a multiPhylo
## (too complicated: multiple tips per species,
##  species are not necessarily monophyletic based on mitochondrial data ...)

if (cleanup) {
  unlink("ELEData", recursive = TRUE)
  unlink("ELEData.zip")
  unlink("Supplementary_dataset_2.xlsx")
  unlink("metadata.csv")
}

```
