# R Package Structure

Happy Boxing Day!
While you're dealing with your physical packages, we're looking into R packages!

The dataset this week comes from ["Historical Trends in R Package Structure and Interdependency on CRAN"](https://mpadge.github.io/pkgstats-analyses/articles/pkgstats.html) by Mark Padgham and Noam Ross.
In that paper, they use the [{pkgstats}](https://cran.r-project.org/package=pkgstats) R package to analyze the structure of R packages over time, using an archive of all packages on [CRAN](https://cran.r-project.org/) as of 2022-11-22.
We've provided csv versions of two of [the datasets from that paper](https://zenodo.org/records/7414296).

The paper focuses on package characteristics over time.
It might be interesting to look at the distribution of similar features (such as lines of code) across packages.

If you're unfamiliar with some of the terminology in this dataset, you might find the [R Packages](https://r-pkgs.org/) book by Hadley Wickham and Jennifer Bryan helpful.

## The Data


```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-12-26')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 52)

cran_20221122 <- tuesdata$cran_20221122
external_calls <- tuesdata$external_calls
internal_calls <- tuesdata$internal_calls

# Option 2: Read directly from GitHub

cran_20221122 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-26/cran_20221122.csv')
external_calls <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-26/external_calls.csv')
internal_calls <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-26/internal_calls.csv')
```

If you would like to dive deeper, you can download the larger dataset with this code:

```{r}
cran_all_20221122 <- readr::read_rds("https://zenodo.org/records/7414296/files/pkgstats-CRAN-all.Rds?download=1")
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `cran_20221122.csv`

|variable                   |class     |description                |
|:--------------------------|:---------|:--------------------------|
|package                    |character |The name of the package |
|version                    |character |The package version |
|date                       |double    |The release date of that version of the package |
|license                    |character |License information |
|files_R                    |double    |Number of files in the /R directory, where numbers are recursively counted in all sub-directories |
|files_src                  |double    |Number of files in the /src directory, where numbers are recursively counted in all sub-directories |
|files_inst                 |double    |Number of files in the /inst/include directory, where numbers are recursively counted in all sub-directories |
|files_vignettes            |double    |Number of files in the /vignettes directory, where numbers are recursively counted in all sub-directories |
|files_tests                |double    |Number of files in the /tests directory, where numbers are recursively counted in all sub-directories |
|loc_R                      |double    |Total lines of code across all files in the /R directory |
|loc_src                    |double    |Total lines of code across all files in the /src directory |
|loc_inst                   |double    |Total lines of code across all files in the /inst/include directory |
|loc_vignettes              |double    |Total lines of code across all files in the /vignettes directory |
|loc_tests                  |double    |Total lines of code across all files in the /tests directory |
|blank_lines_R              |double    |Total numbers of blank lines across all files in the /R directory |
|blank_lines_src            |double    |Total numbers of blank lines across all files in the /src directory |
|blank_lines_inst           |double    |Total numbers of blank lines across all files in the /inst directory |
|blank_lines_vignettes      |double    |Total numbers of blank lines across all files in the /vignettes directory |
|blank_lines_tests          |double    |Total numbers of blank lines across all files in the /tests directory |
|comment_lines_R            |double    |Total numbers of comment lines across all files in the /R directory |
|comment_lines_src          |double    |Total numbers of comment lines across all files in the /src directory |
|comment_lines_inst         |double    |Total numbers of comment lines across all files in the /inst directory |
|comment_lines_vignettes    |double    |Total numbers of comment lines across all files in the /vignettes directory |
|comment_lines_tests        |double    |Total numbers of comment lines across all files in the /tests directory |
|rel_space                  |double    |Measure of relative white space across all files in the /R, /src, and /inst directories |
|rel_space_R                |double    |Measure of relative white space across all files in the /R directory |
|rel_space_src              |double    |Measure of relative white space across all files in the /src directory |
|rel_space_inst             |double    |Measure of relative white space across all files in the /inst directory |
|rel_space_vignettes        |double    |Measure of relative white space across all files in the /vignettes directory |
|rel_space_tests            |double    |Measure of relative white space across all files in the /tests directory |
|indentation                |double    |The number of spaces used to indent code, with values of -1 indicating indentation with tab characters |
|nexpr                      |double    |The median number of nested expression per line of code, counting only those lines which have any expressions |
|num_vignettes              |double    |Number of vignettes |
|num_demos                  |double    |Number of demos |
|num_data_files             |double    |Number of data files |
|data_size_total            |double    |Total size of all package data |
|data_size_median           |double    |Median size of package data files |
|translations               |character |List of translations where package includes translations files, given as a comma-separated list of (spoken) language codes |
|urls                       |character |Package URL(s) |
|bugs                       |character |URL for BugReports |
|desc_n_aut                 |double    |Number of contributors with role of author |
|desc_n_ctb                 |double    |Number of contributors with role of contributor |
|desc_n_fnd                 |double    |Number of contributors with role of funder |
|desc_n_rev                 |double    |Number of contributors with role of reviewer |
|desc_n_ths                 |double    |Number of contributors with role of thesis advisor |
|desc_n_trl                 |double    |Number of contributors with role of translator (relating to translation between computer and not spoken languages) |
|depends                    |character |Comma-separated character entries for all depends packages |
|imports                    |character |Comma-separated character entries for all imports packages |
|suggests                   |character |Comma-separated character entries for all suggests packages |
|enhances                   |character |Comma-separated character entries for all enhances packages |
|linking_to                 |character |Comma-separated character entries for all linking_to packages |
|n_fns_r                    |double    |Numbers of functions in R |
|n_fns_r_exported           |double    |Numbers of exported R functions |
|n_fns_r_not_exported       |double    |Numbers of non-exported R functions |
|n_fns_src                  |double    |Number of functions (or objects) in other computer languages, including functions in both src and inst/include directories |
|n_fns_per_file_r           |double    |Number of functions (or objects) per individual file in /R |
|n_fns_per_file_src         |double    |Number of functions (or objects) per individual file in source directories other than /R |
|npars_exported_mn          |double    |Mean number of parameters per exported R function |
|npars_exported_md          |double    |Median number of parameters per exported R function |
|loc_per_fn_r_mn            |double    |Mean lines of code per function in /R |
|loc_per_fn_r_md            |double    |Median lines of code per function in /R |
|loc_per_fn_r_exp_mn        |double    |Mean lines of code per exported function in /R |
|loc_per_fn_r_exp_md        |double    |Median lines of code per exported function in /R |
|loc_per_fn_r_not_exp_mn    |double    |Mean lines of code per non-exported function in /R |
|loc_per_fn_r_not_exp_md    |double    |Median lines of code per non-exported function in /R |
|loc_per_fn_src_mn          |double    |Mean lines of code per in other source directories |
|loc_per_fn_src_md          |double    |Median lines of code per in other source directories |
|languages                  |character |languages                  |
|doclines_per_fn_exp_mn     |double    |Mean lines of documentation per exported function in /R |
|doclines_per_fn_exp_md     |double    |Median lines of documentation per exported function in /R |
|doclines_per_fn_not_exp_mn |double    |Mean lines of documentation per non-exported function in /R |
|doclines_per_fn_not_exp_md |double    |Median lines of documentation per non-exported function in /R |
|doclines_per_fn_src_mn     |double    |Mean lines of code per in other source directories |
|doclines_per_fn_src_md     |double    |Median lines of code per in other source directories |
|docchars_per_par_exp_mn    |double    |Mean number of documentation characters per parameter of exported R functions |
|docchars_per_par_exp_md    |double    |Median number of documentation characters per parameter of exported R functions |
|n_edges                    |double    |Number of edges connecting functions (and other objects) across all languages in package code |
|n_edges_r                  |double    |Number of edges connecting R functions (and other objects) |
|n_edges_src                |double    |Number of edges connecting functions (and other objects) in other languages |
|n_clusters                 |double    |Number of distinct clusters in package network |
|centrality_dir_mn          |double    |Mean centrality of all network edges, calculated from directed representation of network |
|centrality_dir_md          |double    |Median centrality of all network edges, calculated from directed representation of network |
|centrality_dir_mn_no0      |double    |Mean centrality of all network edges, calculated from directed representation of network, excluding edges with centrality of zero |
|centrality_dir_md_no0      |double    |Median centrality of all network edges, calculated from directed representation of network, excluding edges with centrality of zero |
|centrality_undir_mn        |double    |Mean centrality of all network edges, calculated from undirected representation of network |
|centrality_undir_md        |double    |Median centrality of all network edges, calculated from undirected representation of network |
|centrality_undir_mn_no0    |double    |Mean centrality of all network edges, calculated from undirected representation of network, excluding edges with centrality of zero |
|centrality_undir_md_no0    |double    |Median centrality of all network edges, calculated from undirected representation of network, excluding edges with centrality of zero |
|num_terminal_edges_dir     |double    |Numbers of terminal edges, calculated from directed representation of network |
|num_terminal_edges_undir   |double    |num_terminal_edges_undir, calculated from undirected representation of network   |
|node_degree_mn             |double    |Mean node degree |
|node_degree_md             |double    |Median node degree |
|node_degree_max            |double    |Maximum node degree |
|cpl_instability_pkg        |double    |Coupling instability, a measure of the extent to which packages depend on external functionality without other packages in turn depending on them |

# `external_calls.csv`

|variable     |class     |description  |
|:------------|:---------|:------------|
|package_from |character |The package that makes the call |
|package_to   |character |The package that the source package calls |
|n_total      |double    |The total number of calls from package_from to package_to |
|n_unique     |double    |The number of unique calls from package_from to package_to |

# `internal_calls.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|package  |character |The package being evaluated |
|n_total  |double    |The total number of calls from functions in one file to functions in another file within the package |
|n_unique |double    |The number of unique calls from functions in one file to functions in another file within the package |


### Cleaning Script

The authors provided mostly [clean data](https://zenodo.org/records/7414296.
We chose one of their datasets, lightly cleaned the data, and saved it as a CSV.
We also split the `external_calls` data into two files, one for calls to functions in other files in the same package (`internal_calls.csv`) and one for calls to functions in other packages (`external_calls.csv`).

``` r
library(tidyverse)
library(here)
library(fs)

working_dir <- here::here("data", "2023", "2023-12-26")

cran_20221122_url <- "https://zenodo.org/records/7414296/files/pkgstats-CRAN-current.Rds?download=1"
cran_20221122 <- readr::read_rds(cran_20221122_url) |>
  dplyr::ungroup() |>
  dplyr::mutate(
    dplyr::across(
      c(translations, depends:linking_to, languages, external_calls),
      \(x) {
        dplyr::na_if(x, "NA") |> 
          dplyr::na_if("")
      }
    )
  )
dplyr::glimpse(cran_20221122)


calls_20221122 <- cran_20221122 |>
  dplyr::select(package_from = package, external_calls) |>
  tidyr::separate_longer_delim(
    external_calls,
    ","
  ) |>
  # In at least one case, an extra "L:" prefix was picked up from a 1:10-style
  # range.
  dplyr::mutate(
    external_calls = stringr::str_remove(external_calls, "^L:")
  ) |> 
  tidyr::separate_wider_delim(
    external_calls,
    ":",
    names = c("package_to", "n_total", "n_unique")
  )

cran_20221122$external_calls <- NULL

external_calls <- calls_20221122 |> 
  dplyr::filter(package_from != package_to)
internal_calls <- calls_20221122 |> 
  dplyr::filter(package_from == package_to) |> 
  dplyr::select(package = package_from, n_total, n_unique)

readr::write_csv(
  cran_20221122,
  fs::path(working_dir, "cran_20221122.csv")
)
readr::write_csv(
  external_calls,
  fs::path(working_dir, "external_calls.csv")
)
readr::write_csv(
  internal_calls,
  fs::path(working_dir, "internal_calls.csv")
)
```
