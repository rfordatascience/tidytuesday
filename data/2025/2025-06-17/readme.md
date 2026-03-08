# API Specs

This week we're exploring Web APIs! 
The lead volunteer for TidyTuesday (Jon Harmon) is writing a book about working with [Web APIs with R](https://dslc.io/wapir) as well as [a series of R packages to make it easier to create API-wrapping R packages](https://beekeeper.api2r.org/).
On Thursday, 2025-06-19, Jon will present a talk on this package ecosystem at the [Ghana R Conference 2025](https://ghana-rusers.org/ghana-r-conference-2025/).
While working on the packages and the talk, Jon explored a list of APIs from the website [APIs.guru](https://apis.guru).
That dataset is provided here.

> [APIs.guru's] goal is to create a machine-readable Wikipedia for Web APIs in the OpenAPI Specification format.

- What API specs are provided by APIs.guru? Are these the same as the origin specs?
- How many different APIs ("services") do providers provide?
- What licenses do APIs use?
- Are any APIs listed more than once in the dataset?

Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-06-17')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 24)

api_categories <- tuesdata$api_categories
api_info <- tuesdata$api_info
api_logos <- tuesdata$api_logos
api_origins <- tuesdata$api_origins
apisguru_apis <- tuesdata$apisguru_apis

# Option 2: Read directly from GitHub

api_categories <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_categories.csv')
api_info <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_info.csv')
api_logos <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_logos.csv')
api_origins <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_origins.csv')
apisguru_apis <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/apisguru_apis.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-06-17')

# Option 2: Read directly from GitHub and assign to an object

api_categories = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_categories.csv')
api_info = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_info.csv')
api_logos = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_logos.csv')
api_origins = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_origins.csv')
apisguru_apis = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/apisguru_apis.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-06-17')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

api_categories = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_categories.csv")
api_info = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_info.csv")
api_logos = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_logos.csv")
api_origins = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_origins.csv")
apisguru_apis = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/apisguru_apis.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
api_categories = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_categories.csv", DataFrame)
api_info = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_info.csv", DataFrame)
api_logos = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_logos.csv", DataFrame)
api_origins = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/api_origins.csv", DataFrame)
apisguru_apis = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-17/apisguru_apis.csv", DataFrame)
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

### `api_categories.csv`

|variable          |class     |description                           |
|:-----------------|:---------|:-------------------------------------|
|name              |character |apis.guru's designation for this API. |
|apisguru_category |character |Sorting category of this API on apis.guru. If an API is listed in multiple categories, it has more than one row in this table. |

### `api_info.csv`

|variable         |class     |description                           |
|:----------------|:---------|:-------------------------------------|
|name             |character |apis.guru's designation for this API. |
|contact_name     |character |The name of the person or entity responsible for this API. |
|contact_url      |character |The url to check for information about this API. |
|description      |character |A brief description of this API. |
|title            |character |The title of this API.. |
|provider_name    |character |The provider of this API. This is more meaningful if a provider has multiple APIs in the apis.guru database. |
|service_name     |character |The service that this API covers within the provider. Pressent when a provider has multiple APIs in the apis.guru database. |
|license_name     |character |The name of the license associated with this API, if available. |
|license_url      |character |The URL of the license, if available. |
|terms_of_service |character |The url of terms of service for this API, if available. |

### `api_logos.csv`

|variable         |class     |description                           |
|:----------------|:---------|:-------------------------------------|
|name             |character |apis.guru's designation for this API. |
|background_color |character |Hex code (in the format #RRGGBB) intended to show behind the logo. Missing values either mean that no color is expected (the background can be transparent), or that there isn't a valid logo available for this API. |
|url              |character |Path to the logo on apis.guru. |
|alt_text         |character |Text to provide for this logo visually impaired users. |

### `api_origins.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|name     |character |apis.guru's designation for this API. |
|format   |character |The format of the original API spec, if available. One of "apiBlueprint", "google", "openapi", "postman", "swagger", or "wadl". |
|url      |character |The path to the original API spec. Note: Some of these paths are no longer valid. |
|version  |character |The version of the format used by this API spec. Each format has its own list of possible values. |

### `apisguru_apis.csv`

|variable                  |class         |description                           |
|:-------------------------|:-------------|:-------------------------------------|
|name                      |character     |apis.guru's designation for this API. |
|version                   |character     |Version of the API. Data is filtered to only the "preferrred" versions. |
|added                     |datetime      |When the API was added to apis.guru. |
|updated                   |datetime      |When the API was updated on apis.guru. |
|swagger_url               |character     |The path to this API spec on apis.guru. |
|openapi_ver               |character     |The version of the OpenAPI (or swagger) spec of this API on apis.guru. |
|link                      |character     |The path to this information (plus some fields we don't include here) for this API on apis.guru. |
|external_docs_description |character     |A short description of external documentation, if provided. |
|external_docs_url         |character     |The location of the external documentation, if provided. |

## Cleaning Script

```r
# This dataset was compiled using funcionality from my in-progress ecosystem of
# packages described at https://beekeeper.api2r.org/. On Thursday, 2025-06-19, I
# will present a talk on this ecosystem at the Ghana R Conference 2025
# (https://ghana-rusers.org/ghana-r-conference-2025/).

# I use information about APIs from https://apis.guru to test various aspects of
# {beekeeper} and related packages. Here we use {nectar}
# (https://nectar.api2r.org/) and {tibblify}
# (https://mgirlich.github.io/tibblify/) to download and process the list of
# APIs from apis.guru.

# {nectar} is not available on CRAN. The rest of the packages can be installed
# via install.packages.
# install.packages("pak")
# pak::pak("jonthegeek/nectar")

library(nectar)
library(tibblify)
library(dplyr)
library(tidyr)
library(janitor)

# This section replicates functionality from the in-progress package {apisguru}
# (https://jonthegeek.github.io/apisguru/). At the time that this dataset was
# compiled, {apisguru} was not yet updated for the current version of {nectar},
# so I'm not using it directly. Watch its progress as the {beekeeper} ecosystem
# solidifies!

.schema_api_spec <- function() {
  tibblify::tspec_df(
    .tib_datetime("added"),
    tibblify::tib_chr("preferred"),
    tibblify::tib_df(
      "versions",
      .names_to = "version",
      .schema_api_version_spec()
    )
  )
}

.schema_api_version_spec <- function() {
  tibblify::tspec_df(
    .tib_datetime("added"),
    tibblify::tib_variant("info"),
    .tib_datetime("updated"),
    tibblify::tib_chr("swaggerUrl"),
    tibblify::tib_chr("swaggerYamlUrl"),
    tibblify::tib_chr("openapiVer"),
    tibblify::tib_chr("link", required = FALSE),
    tibblify::tib_variant("externalDocs", required = FALSE)
  )
}

.tib_datetime <- function(key, ..., required = TRUE) {
  tibblify::tib_scalar(
    key = key,
    ptype = vctrs::new_datetime(tzone = "UTC"),
    required = required,
    ptype_inner = character(),
    transform = .quick_datetime,
    ...
  )
}

.quick_datetime <- function(x, tzone = "UTC") {
  as.POSIXct(gsub("T", " ", x), tz = tzone)
}

req <- nectar::req_prepare(
  "https://api.apis.guru/v2",
  path = "/list.json",
  tidy_fn = nectar::resp_tidy_json,
  tidy_args = list(
    spec = tibblify::tspec_df(
      .names_to = "name",
      .schema_api_spec()
    )
  )
)
resp <- nectar::req_perform_opinionated(req, max_reqs = Inf)
apisguru_apis <- nectar::resp_tidy(resp) |>
  dplyr::select("name", "preferred", "versions") |>
  tidyr::unnest("versions") |>
  dplyr::filter(
    .data$preferred == .data$version
  ) |>
  tidyr::unnest_wider("externalDocs", names_sep = "_") |>
  dplyr::select(-"preferred", -"externalDocs_x-sha1", -"swaggerYamlUrl") |>
  janitor::clean_names()

dplyr::glimpse(apisguru_apis)

api_info <- apisguru_apis |>
  dplyr::select("name", "info") |>
  tidyr::unnest_wider("info") |>
  tidyr::unnest_wider("contact", names_sep = "_") |>
  tidyr::unnest_wider("license", names_sep = "_") |>
  dplyr::select(
    "name",
    "contact_name",
    "contact_url",
    "description",
    "title",
    apisguru_category = "x-apisguru-categories",
    logo = "x-logo",
    origin = "x-origin",
    provider_name = "x-providerName",
    service_name = "x-serviceName",
    "license_name",
    "license_url",
    terms_of_service = "termsOfService"
  )
apisguru_apis$info <- NULL
dplyr::glimpse(api_info)

api_categories <- api_info |>
  dplyr::select("name", "apisguru_category") |>
  tidyr::unnest_longer("apisguru_category")
api_info$apisguru_category <- NULL

api_logos <- api_info |>
  dplyr::select("name", "logo") |>
  tidyr::unnest_wider("logo") |>
  janitor::clean_names() |>
  dplyr::select(-"href")
api_info$logo <- NULL

api_origins <- api_info |>
  dplyr::select("name", "origin") |>
  tidyr::unnest_longer("origin") |>
  tidyr::unnest_wider("origin") |>
  dplyr::select("name":"version") |>
  # Some of the entries are duplicated.
  dplyr::distinct()
api_info$origin <- NULL

```
