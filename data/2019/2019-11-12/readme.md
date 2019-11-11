# Code in CRAN Packages

This week's data is from the [CRAN](https://cran.r-project.org/src/contrib/) courtesy of [Phillip Massicotte](https://www.pmassicotte.com/post/analyzing-the-programming-languages-used-in-r-packages/).

He analyzed the lines of code and the different languages in all of the R packages on CRAN.

# Get the data!

```
cran_code <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-12/loc_cran_packages.csv")

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# Either ISO-8601 date or year/week works!
# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load("2019-11-12")
tuesdata <- tidytuesdayR::tt_load(2019, week = 46)

cran_code <- tuesdata$loc_cran_packages
```

# Data Dictionary

## `loc_cran_packages.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|file     |double    | Number of files |
|language |character | Programming Language |
|blank    |double    | Blank Lines |
|comment  |double    | Commented Lines |
|code     |double    | Lines of Code |
|pkg_name |character | Package Name |
|version  |character | Package Version |


# Scripts

Phillip's script can be found at his [blog](https://www.pmassicotte.com/post/analyzing-the-programming-languages-used-in-r-packages/).
