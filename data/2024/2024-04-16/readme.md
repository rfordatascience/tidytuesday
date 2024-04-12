# Shiny Packages 

It's time for [ShinyConf2024](https://www.shinyconf.com)!

> ShinyConf is more than just an event; it's a global gathering of diverse Shiny community, creating a shared space for learning, networking, and collaborative exploration. Connect with like-minded enthusiasts from all corners of the world!

Your TidyTuesday maintainers -- [Tracy Teal](https://www.shinyconf.com/keynote-speakers#tracy) and [Jon Harmon](https://www.shinyconf.com/speakers-list#:~:text=Jon-,Harmon,-Executive%20Director%2C%20DSLC) -- are both speaking at ShinyConf on Thursday, 2024-04-18.
We look forward to seeing you there!

What is the most popular way in which packages are connected to Shiny?
Can you create a Shiny app to explore this data?


## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-04-16')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 16)

shiny_revdeps <- tuesdata$shiny_revdeps
package_details <- tuesdata$package_details

# Option 2: Read directly from GitHub

shiny_revdeps <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-16/shiny_revdeps.csv')
package_details <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-16/package_details.csv')

```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `shiny_revdeps.csv`

|variable        |class     |description     |
|:---------------|:---------|:---------------|
|child           |character |A package in the shiny reverse-dependency tree |
|dependency_type |character |How the package is connected to on another package |
|parent          |character |The package that the child is connected to |

# `package_details.csv`

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
|Additional_repositories |character |Additional repositories |
|Author                  |character |who wrote the package |
|Authors@R               |character |a refined and machine-readable description of the package “authors” (in particular specifying their precise roles) |
|Biarch                  |character |used on Windows to select the INSTALL option --force-biarch for this package |
|BugReports              |character |a single URL to which bug reports about the package should be submitted |
|BuildKeepEmpty          |logical   |BuildKeepEmpty          |
|BuildManual             |logical   |BuildManual             |
|BuildResaveData         |character |BuildResaveData         |
|BuildVignettes          |character |can be set to a false value to stop R CMD build from attempting to build the vignettes, as well as preventing R CMD check from testing this |
|ByteCompile             |character |controls if the package R code is to be byte-compiled on installation |
|Classification/ACM      |logical   |subject classifications for the content of the package [Computing Classification System of the Association for Computing Machinery](https://www.acm.org/publications/class-1998) |
|Classification/ACM-2012 |logical   |subject classifications for the content of the package [Computing Classification System of the Association for Computing Machinery](https://www.acm.org/publications/class-2012) |
|Classification/JEL      |logical   |subject classifications for the content of the package [Journal of Economic Literature Classification System](https://www.aeaweb.org/econlit/jelCodes.php) |
|Classification/MSC      |character |subject classifications for the content of the package [Mathematics Subject Classification of the American Mathematical Society](https://mathscinet.ams.org/msc/msc2000.html) |
|Classification/MSC-2010 |logical   |subject classifications for the content of the package [Mathematics Subject Classification of the American Mathematical Society](https://mathscinet.ams.org/msc/msc2010.html) |
|Collate                 |character |used for controlling the collation order for the R code files in a package when these are processed for package installation |
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
|X-CRAN-Comment          |logical   |X-CRAN-Comment          |
|Published               |double    |Published               |
|Reverse depends         |character |Reverse depends         |
|Reverse imports         |character |Reverse imports         |
|Reverse linking to      |character |Reverse linking to      |
|Reverse suggests        |character |Reverse suggests        |
|Reverse enhances        |character |Reverse enhances        |


### Cleaning Script

```{r}
library(tidyverse)
library(janitor)
library(here)
library(fs)

working_dir <- here::here("data", "2024", "2024-04-16")

get_revdeps <- function(pkgs) {
  dependency_types <- c("Depends", "Imports", "LinkingTo", "Suggests")
  revdeps <- purrr::map(
    dependency_types,
    \(dependency_type) {
      these_revdeps <- tools::package_dependencies(
        pkgs,
        which = dependency_type,
        reverse = TRUE
      )
      tibble::enframe(
        these_revdeps,
        name = "parent",
        value = "child"
      ) |> 
        dplyr::mutate(
          dependency_type = tolower(dependency_type),
          .before = "child"
        ) |> 
        tidyr::unnest_longer(child, indices_include = FALSE) |> 
        # Make it readable as a sentence
        dplyr::select(child, dependency_type, parent)
    }
  )
  purrr::list_rbind(revdeps)
}

get_all_revdeps <- function(pkgs) {
  new_packages <- pkgs
  known_packages <- character()
  all_revdeps <- tibble::tibble(
    child = character(),
    dependency_type = character(),
    parent = character()
  )
  while (length(new_packages)) {
    new_revdeps <- get_revdeps(new_packages)
    known_packages <- union(known_packages, new_packages)
    all_revdeps <- dplyr::bind_rows(all_revdeps, new_revdeps)
    new_packages <- setdiff(new_revdeps$child, known_packages)
  }
  all_revdeps
}

shiny_revdeps <- get_all_revdeps("shiny")
shiny_family <- sort(union(
  shiny_revdeps$parent,
  shiny_revdeps$child
))

package_details <- tools::CRAN_package_db() |> 
  tibble::as_tibble() |> 
  dplyr::distinct(Package, .keep_all = TRUE) |>
  dplyr::filter(Package %in% shiny_family) |> 
  janitor::clean_names() |> 
  janitor::remove_empty("cols")

readr::write_csv(
  shiny_revdeps,
  fs::path(working_dir, "shiny_revdeps.csv")
)
readr::write_csv(
  package_details,
  fs::path(working_dir, "package_details.csv")
)
```
