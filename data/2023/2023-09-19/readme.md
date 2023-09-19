# CRAN Package Authors

It's time for [posit::conf(2023L)](https://posit.co/conference/)!
To celebrate, the data this week comes from the [CRAN collaboration graph](https://github.com/schochastics/CRAN_collaboration), a project by David Schoch.

> The CRAN collaboration graph consists of R package developers who are connected if they appear together as authors of an R package in the DESCRIPTION file.

> The “Hadley number” is defined as the distance of R developers to Hadley Wickham in the collaboration graph. 

See the [README of the GitHub project](https://github.com/schochastics/CRAN_collaboration#readme) for a fun exploration of the data, and to see how it was gathered.

## The Data

```{r}
# Scroll to the end of this code block to see how to recombine the data into a
# graph!

# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-09-19')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 38)

cran_20230905 <- tuesdata$cran_20230905
package_authors <- tuesdata$package_authors
cran_graph_nodes <- tuesdata$cran_graph_nodes
cran_graph_edges <- tuesdata$cran_graph_edges

# Option 2: Read directly from GitHub

cran_20230905 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-19/cran_20230905.csv')
package_authors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-19/package_authors.csv')
cran_graph_nodes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-19/cran_graph_nodes.csv')
cran_graph_edges <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-19/cran_graph_edges.csv')

# Reconstruct a graph
library(tidygraph)
cran_graph <- tbl_graph(
  nodes = cran_graph_nodes, edges = cran_graph_edges, directed = FALSE
)

# Fine a particular author in the graph.
target_author <- "Jon Harmon"
target_author_index <- which(igraph::V(cran_graph)$name == target_author)

# Extract that author's Hadley number.
igraph::V(cran_graph)$dist2HW[target_author_index]
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.


### Data Dictionary

# `cran_20230905.csv`

See [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#The-DESCRIPTION-file) for more information about the fields in this dataset.

|variable                |class     |description             |
|:-----------------------|:---------|:-----------------------|
|Package                 |character |the name of the package |
|Version                 |character |the version of the package |
|Priority                |character |'recommended' indicates packages that are recommended to be incuded in every binary distribution of R. A handful of other packages use "optional" here. |
|Depends                 |character |a comma-separated list of package names which this package depends on |
|Imports                 |character |packages whose namespaces are imported from (as specified in the NAMESPACE file) but which do not need to be attached |
|LinkingTo               |character |packages whose header files are used to compile this package's C/C++ code |
|Suggests                |character |packages that are not necessarily needed |
|Enhances                |character |packages “enhanced” by the package at hand, e.g., by providing methods for classes from these packages, or ways to handle objects from these packages |
|License                 |character |license information |
|License_is_FOSS         |logical   |whether the license is considered free, open-source software |
|License_restricts_use   |logical   |whether the license restricts use |
|OS_type                 |character |specifies the OS(es) for which the package is intended |
|Archs                   |character |Archs                   |
|MD5sum                  |character |MD5sum                  |
|NeedsCompilation        |character |should be set to "yes" if the package contains native code which needs to be compiled, otherwise "no" |
|Additional_repositories |character |Additional_repositories |
|Author                  |character |who wrote the package |
|Authors@R               |character |a refined and machine-readable description of the package “authors” (in particular specifying their precise roles) |
|Biarch                  |character |used on Windows to select the INSTALL option --force-biarch for this package |
|BugReports              |character |a single URL to which bug reports about the package should be submitted |
|BuildKeepEmpty          |logical   |BuildKeepEmpty          |
|BuildManual             |logical   |BuildManual             |
|BuildResaveData         |character |BuildResaveData         |
|BuildVignettes          |character |can be set to a false value to stop R CMD build from attempting to build the vignettes, as well as preventing R CMD check from testing this |
|Built                   |logical   |added by the package management tools |
|ByteCompile             |character |controls if the package R code is to be byte-compiled on installation |
|Classification/ACM      |logical   |subject classifications for the content of the package [Computing Classification System of the Association for Computing Machinery](https://www.acm.org/publications/class-1998) |
|Classification/ACM-2012 |logical   |subject classifications for the content of the package [Computing Classification System of the Association for Computing Machinery](https://www.acm.org/publications/class-2012) |
|Classification/JEL      |logical   |subject classifications for the content of the package [Journal of Economic Literature Classification System](https://www.aeaweb.org/econlit/jelCodes.php) |
|Classification/MSC      |character |subject classifications for the content of the package [Mathematics Subject Classification of the American Mathematical Society](https://mathscinet.ams.org/msc/msc2000.html) |
|Classification/MSC-2010 |logical   |subject classifications for the content of the package [Mathematics Subject Classification of the American Mathematical Society](https://mathscinet.ams.org/msc/msc2010.html) |
|Collate                 |character |used for controlling the collation order for the R code files in a package when these are processed for package installation |
|Collate.unix            |logical   |a UNIX-specific version of Collate |
|Collate.windows         |logical   |a Windows-specific version of Collate |
|Contact                 |character |Contact                 |
|Copyright               |character |an optional field to be used when the copyright holder(s) are not the authors |
|Date                    |character |the release date of the current version of the package |
|Date/Publication        |character |Date/Publication        |
|Description             |character |a comprehensive description of what the package does |
|Encoding                |character |used as the encoding of the DESCRIPTION file itself and of the R and NAMESPACE files, and as the default encoding of .Rd files |
|KeepSource              |character |controls if the package code is sourced using keep.source = TRUE or FALSE |
|Language                |character |used to indicate if the package documentation is not in English |
|LazyData                |character |controls whether the R datasets use lazy-loading |
|LazyDataCompression     |character |LazyDataCompression     |
|LazyLoad                |character |was used in versions prior to 2.14.0, but now is ignored |
|MailingList             |character |MailingList             |
|Maintainer              |character |a single name followed by a valid (RFC 2822) email address in angle brackets |
|Note                    |character |Note                    |
|Packaged                |character |added by the package management tools |
|RdMacros                |character |used to hold a comma-separated list of packages from which the current package will import Rd macro definitions |
|StagedInstall           |logical   |controls if package installation is ‘staged’, that is done to a temporary location and moved to the final location when successfully completed |
|SysDataCompression      |logical   |SysDataCompression      |
|SystemRequirements      |character |dependencies external to the R system |
|Title                   |character |a short description of the package |
|Type                    |character |specifies the type of the package |
|URL                     |character |a list of URLs separated by commas or whitespace, for example the homepage of the author or a page where additional material describing the software can be found |
|UseLTO                  |logical   |used to indicate if source code in the package is to be compiled with Link-Time Optimization |
|VignetteBuilder         |character |names (in a comma-separated list) packages that provide an engine for building vignettes |
|ZipData                 |character |has been ignored since R 2.13.0 |
|Path                    |character |Path                    |
|X-CRAN-Comment          |logical   |X-CRAN-Comment          |
|Published               |double    |Published               |
|Reverse depends         |character |Reverse depends         |
|Reverse imports         |character |Reverse imports         |
|Reverse linking to      |character |Reverse linking to      |
|Reverse suggests        |character |Reverse suggests        |
|Reverse enhances        |character |Reverse enhances        |

# `package_authors.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|Package  |character |the name of the package |
|authorsR |character |the author name from Authors@R, one author per row|

# `cran_graph_nodes.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|name     |character |the name of this author |
|x        |double    |x location for graph layout |
|y        |double    |y location for graph layout |
|dist2HW  |double    |distance from this author to Hadley Wickham |
|cc       |double    |`1/igraph::closeness()` for this node; the sum of the distances to all the other vertices in the graph |

# `cran_graph_edges.csv`

|variable |class  |description |
|:--------|:------|:-----------|
|from     |double |the id (row) of the author to link from |
|to       |double |the id (row) of the author to link to |
|weight   |double |a measure of the number of connections between these two authors |


### Cleaning Script

The data was mostly cleaned by [David Schoch](https://github.com/schochastics).
Additional cleaning was performed to save simple representations of the graph, and then to check that it worked.

``` r
library(tidyverse)
library(here)
library(igraph)
library(tidygraph)

working_dir <- here::here("data", "2023", "2023-09-19")

cran_20230905 <- readRDS(url("https://github.com/schochastics/CRAN_collaboration/raw/main/data/2023-09-05_database.RDS")) |> 
  tibble::as_tibble()

package_authors <- readr::read_csv("https://raw.githubusercontent.com/schochastics/CRAN_collaboration/main/processed_data/package_authors.csv")
cran_graph <- readRDS(url("https://github.com/schochastics/CRAN_collaboration/raw/main/processed_data/coauthor-biggest_comp.RDS"))

# me <- "Jon Harmon"
# idx <- which(V(cran_graph)$name == me)
# V(cran_graph)$dist2HW[idx]

cran_tidygraph <- cran_graph |> 
  tidygraph::as_tbl_graph()

cran_graph_nodes <- cran_tidygraph |> 
  tidygraph::activate(nodes) |> 
  tidygraph::as_tibble() |> 
  # The "dist2HW" column is problematic. Simplify!
  dplyr::mutate(dist2HW = as.integer(dist2HW))

cran_graph_edges <- cran_tidygraph |> 
  tidygraph::activate(edges) |> 
  tidygraph::as_tibble()

readr::write_csv(
  cran_20230905,
  here::here(working_dir, "cran_20230905.csv")
)
readr::write_csv(
  package_authors,
  here::here(working_dir, "package_authors.csv")
)
readr::write_csv(
  cran_graph_nodes,
  here::here(working_dir, "cran_graph_nodes.csv")
)
readr::write_csv(
  cran_graph_edges,
  here::here(working_dir, "cran_graph_edges.csv")
)

# Reconstruct
cran_graph_nodes <- readr::read_csv(
  here::here(working_dir, "cran_graph_nodes.csv")
)
cran_graph_edges <- readr::read_csv(
  here::here(working_dir, "cran_graph_edges.csv")
)
cran_tidygraph_reconstructed <- tidygraph::tbl_graph(
  nodes = cran_graph_nodes,
  edges = cran_graph_edges,
  directed = FALSE
)

me <- "Jon Harmon"
idx <- which(igraph::V(cran_tidygraph)$name == me)
idx
igraph::V(cran_tidygraph)$dist2HW[idx]

idx_reconstructed <- which(igraph::V(cran_tidygraph_reconstructed)$name == me)
idx_reconstructed == idx
igraph::V(cran_tidygraph_reconstructed)$dist2HW[idx_reconstructed]
```
