# Clean data provided by {animalshelter} R package (https://emilhvitfeldt.github.io/animalshelter/). No cleaning was necessary.
# install.packages("devtools")
# devtools::install_github("EmilHvitfeldt/animalshelter")
library(dplyr)
library(animalshelter)

longbeach <- animalshelter::longbeach |>
  dplyr::mutate(
    was_outcome_alive = as.logical(was_outcome_alive),
    dplyr::across(
      c(
        "animal_type",
        "primary_color",
        "secondary_color",
        "sex",
        "intake_condition",
        "intake_type",
        "intake_subtype",
        "reason_for_intake",
        "jurisdiction",
        "outcome_type",
        "outcome_subtype"
      ),
      as.factor
    )
  ) |> 
    dplyr::select(-"intake_is_dead")
