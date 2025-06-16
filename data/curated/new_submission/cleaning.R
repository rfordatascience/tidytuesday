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
