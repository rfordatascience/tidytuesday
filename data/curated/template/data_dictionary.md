<!-- Include a header (#) and table for each dataset file. In R, you can create 
a dictionary template with this function: 
create_tt_dict <- function(x) {
  tibble::tibble(variable = names(x)) |>
    dplyr::mutate(
      class = purrr::map(x, class),
      description = variable
    ) |>
    knitr::kable() |> 
    cat(sep = "\n")
}
Delete this comment.
-->
### Data Dictionary

# `FILENAME.csv`

DICTIONARY