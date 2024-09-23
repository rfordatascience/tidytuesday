# code for gt_foxes.png -- 

library(gt)
library(gtUtils)

gt_bob_ross <- BobRossColors::all_palettes |> 
  dplyr::filter(painting_title == "quiet_woods") |> 
  dplyr::pull(divergent)

NPSpecies::species |>
  dplyr::filter(CategoryName == "Mammal") |>
  dplyr::filter(stringr::str_detect(CommonNames, "fox")) |>
  dplyr::filter(stringr::str_detect(CommonNames, "flying fox", negate = TRUE)) |>
  dplyr::filter(stringr::str_detect(CommonNames, "fox squirr", negate = TRUE)) |>
  dplyr::mutate(
    Evidence = Observations + Vouchers + References
  ) |>
  dplyr::filter(Evidence != 0) |> 
  dplyr::select(ParkName, SciName, CommonNames, Evidence) |>
  dplyr::group_by(ParkName, SciName, CommonNames) |> 
  dplyr::summarize(evidence = sum(Evidence)) |>
  dplyr::arrange(desc(evidence)) |>
  dplyr::ungroup() |> 
  head(15) |> 
  gt() |>
  tab_header(title = "National Parks with Evidence of Foxes",
             subtitle = "Most Amount of Evidence (Top 15)") |>
  tab_footnote("Evidence Considered: Observations, Vouchers, and References") |>
  gt_color_pills(evidence, digits = 0, palette = gt_bob_ross) |>
  gt_theme_sofa(style = "dark") |>
  gt_save_crop(file = "gt_foxes.png")
