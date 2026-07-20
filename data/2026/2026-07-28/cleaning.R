library(dplyr)

manta_rays <- ecotourism::manta_rays |>
  mutate(organism_name = "Manta ray", .after = "sci_name")
gouldian_finch <- ecotourism::gouldian_finch |>
  mutate(organism_name = "Gouldian finch", .after = "sci_name")
orchids <- ecotourism::orchids |>
  mutate(organism_name = "Orchid", .after = "sci_name")
glowworms <- ecotourism::glowworms |>
  mutate(organism_name = "Glowworm", .after = "sci_name")
occurrences <- bind_rows(
  manta_rays, gouldian_finch, orchids, glowworms
)

weather <- ecotourism::weather

tourism <- ecotourism::tourism_quarterly |>
  left_join(tourism_region, by = "region_id") |>
  rename(ws_id = ws_id.x) |>
  select(-ws_id.y)

