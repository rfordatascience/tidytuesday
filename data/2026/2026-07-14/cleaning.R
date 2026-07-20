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

