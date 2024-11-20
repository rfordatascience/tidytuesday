cbp_resp <- bind_rows(
  read_csv("https://www.cbp.gov/sites/default/files/assets/documents/2023-Nov/nationwide-encounters-fy20-fy23-aor.csv"),
  read_csv("https://www.cbp.gov/sites/default/files/2024-10/nationwide-encounters-fy21-fy24-aor.csv")
) |>
  janitor::clean_names() |>
  unique()

cbp_state <- bind_rows(
  read_csv("https://www.cbp.gov/sites/default/files/assets/documents/2023-Nov/nationwide-encounters-fy20-fy23-state.csv"),
  read_csv("https://www.cbp.gov/sites/default/files/2024-10/nationwide-encounters-fy21-fy24-state.csv")
) |>
  janitor::clean_names() |>
  unique()
