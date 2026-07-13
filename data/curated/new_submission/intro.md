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

