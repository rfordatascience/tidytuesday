# UK Baby Names

This week's dataset explores baby names in the UK. 

There are three datasets which cover baby names across England and Wales from the [Office for National Statistics](https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/livebirths/datasets/babynamesinenglandandwalesfrom1996), Northern Ireland from the [Northern Ireland Statistics and Research Agency](https://www.nisra.gov.uk/publications/baby-names-2025), and Scotland from [National Records of Scotland](https://www.nrscotland.gov.uk/publications/babies-first-names-2025/).

> Dearest gentle reader… we can report that Daphne, Eloise and Penelope have all increased in popularity this year, with the name of each Bridgerton character reaching joint 172nd, 91st, and 71st place respectively, up from 476th, 124th, and 81st in 2024. 

* How does the ranking of most popular names compare between the three datasets?
* Are boys' or girls' names more likely to be unique?
* Can you show the *Bridgerton trend* in charts?

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-06-16')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 24)

england_wales_names <- tuesdata$england_wales_names
ni_names <- tuesdata$ni_names
scotland_names <- tuesdata$scotland_names

# Option 2: Read directly from GitHub

england_wales_names <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/england_wales_names.csv')
ni_names <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/ni_names.csv')
scotland_names <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/scotland_names.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-06-16')

# Option 2: Read directly from GitHub and assign to an object

england_wales_names = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/england_wales_names.csv')
ni_names = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/ni_names.csv')
scotland_names = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/scotland_names.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-06-16")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

england_wales_names = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/england_wales_names.csv")
ni_names = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/ni_names.csv")
scotland_names = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/scotland_names.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
england_wales_names = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/england_wales_names.csv", DataFrame)
ni_names = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/ni_names.csv", DataFrame)
scotland_names = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/scotland_names.csv", DataFrame)
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

### `england_wales_names.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|Year     |integer   |Year. |
|Sex      |character |Whether the name relates to baby boys or girls. |
|Name     |character |Name. Similar names with different spellings have been counted separately. |
|Number   |integer   |Number of babies born in that year with each name. Names with a count of 2 or less have been redacted in order to protect the confidentiality of individuals. `NA` values have been excluded to reduce file size. |
|Rank     |integer   |Rank of the name for that year and sex. |

### `ni_names.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|Year     |integer   |Year. |
|Sex      |character |Whether the name relates to baby boys or girls. |
|Name     |character |Name. Similar names with different spellings have been counted separately. However, names containing accents have been recorded without those accents. |
|Number   |integer   |Number of babies born in that year with each name. Totals for names with a count of less than 3 have been suppressed. |
|Rank     |integer   |Rank of the name for that year and sex. |

### `scotland_names.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|Year     |integer   |Year. |
|Sex      |character |Whether the name relates to baby boys or girls. |
|Name     |character |Name. Similar names with different spellings have been counted separately. However, names containing accents have been recorded without those accents. |
|Number   |integer   |Number of babies born in that year with each name. Names with a count of 2 or less have been redacted in order to protect the confidentiality of individuals. |
|Rank     |integer   |Rank of the name for that year and sex. |

## Cleaning Script

```r
# Scotland
download.file("https://www.nrscotland.gov.uk/media/0ytjopcq/all-names-given-to-babies-between-1974-to-2025.zip", destfile = "baby-names/scotland.zip")
unzip("baby-names/scotland.zip", exdir = "baby-names")
scotland_names <- readr::read_csv("baby-names/full-list-1974-2025.csv")

# England and Wales
ew_data_boys <- openxlsx::read.xlsx("https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/livebirths/datasets/babynamesinenglandandwalesfrom1996/1996to2024/babynames1996to2024.xlsx", sheet = "Table_2", startRow = 5)
ew_boys <- ew_data_boys |>
  tidyr::pivot_longer(-Name) |>
  tidyr::separate_wider_delim(name, delim = ".", names = c("Year", "Data")) |>
  tidyr::pivot_wider(names_from = "Data", values_from = "value") |>
  dplyr::mutate(Sex = "Boy") |>
  dplyr::select(Year, Sex, Name, Number = Count, Rank) |>
  dplyr::mutate(
    dplyr::across(c(Year, Rank, Number), as.numeric)
  ) |>
  dplyr::arrange(
    Year, Name
  )
ew_data_girls <- openxlsx::read.xlsx("https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/livebirths/datasets/babynamesinenglandandwalesfrom1996/1996to2024/babynames1996to2024.xlsx", sheet = "Table_1", startRow = 5)
ew_girls <- ew_data_girls |>
  tidyr::pivot_longer(-Name) |>
  tidyr::separate_wider_delim(name, delim = ".", names = c("Year", "Data")) |>
  tidyr::pivot_wider(names_from = "Data", values_from = "value") |>
  dplyr::mutate(Sex = "Girl") |>
  dplyr::select(Year, Sex, Name, Number = Count, Rank) |>
  dplyr::mutate(
    dplyr::across(c(Year, Rank, Number), as.numeric)
  ) |>
  dplyr::arrange(
    Year, Name
  )
england_wales_names <- rbind(ew_boys, ew_girls) |>
  tidyr::drop_na()

# Northern Ireland
ni_boys_data <- openxlsx::read.xlsx("https://www.nisra.gov.uk/files/nisra/documents/2026-04/Full_Name_List_NI_97_25.xlsx", sheet = "Table 1", startRow = 6)
ni_boys_list <- ni_boys_data |>
  split.default(ceiling(seq_along(ni_boys_data) / 3)) |>
  lapply(\(x) { names(x) <- paste0("V", 1:3); x })
all_years <- data.frame(cols = colnames(ni_boys_data)) |>
  dplyr::filter(
    stringr::str_detect(cols, "Name")
  ) |>
  dplyr::mutate(cols = readr::parse_number(cols)) |>
  unlist() |>
  unname()
names(ni_boys_list) <- all_years
ni_boys <- ni_boys_list |>
  dplyr::bind_rows(.id = "Year") |>
  tibble::as_tibble() |>
  dplyr::mutate(Sex = "Boy") |>
  dplyr::select(Year, Sex, Name = V1, Number = V2, Rank = V3) |>
  dplyr::mutate(
    Number = dplyr::if_else(Number == "-", "0", Number)
  ) |>
  dplyr::mutate(
    dplyr::across(c(Year, Rank, Number), as.numeric)
  ) |>
  dplyr::arrange(
    Year, Name
  )
ni_girls_data <- openxlsx::read.xlsx("https://www.nisra.gov.uk/files/nisra/documents/2026-04/Full_Name_List_NI_97_25.xlsx", sheet = "Table 2", startRow = 6)
ni_girls_list <- ni_girls_data |>
  split.default(ceiling(seq_along(ni_girls_data) / 3)) |>
  lapply(\(x) { names(x) <- paste0("V", 1:3); x })
all_years <- data.frame(cols = colnames(ni_girls_data)) |>
  dplyr::filter(
    stringr::str_detect(cols, "Name")
  ) |>
  dplyr::mutate(cols = readr::parse_number(cols)) |>
  unlist() |>
  unname()
names(ni_girls_list) <- all_years
ni_girls <- ni_girls_list |>
  dplyr::bind_rows(.id = "Year") |>
  tibble::as_tibble() |>
  dplyr::mutate(Sex = "Girl") |>
  dplyr::select(Year, Sex, Name = V1, Number = V2, Rank = V3) |>
  dplyr::mutate(
    Number = dplyr::if_else(Number == "-", "0", Number)
  ) |>
  dplyr::mutate(
    dplyr::across(c(Year, Rank, Number), as.numeric)
  ) |>
  dplyr::arrange(
    Year, Name
  )
ni_names <- rbind(ni_boys, ni_girls)

```
