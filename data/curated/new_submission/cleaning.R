# Clean data provided by Norwegian Veterinary Institute. No cleaning was
# necessary. The data is published at https://apps.vetinst.no/laksetap/ Here
# only two datasets are shared, but people may investigate the other datasets as
# well. Manually download data to local path tt_submission/data-raw/

monthly_mortality_data <- readr::read_csv(
  "tt_submission/data-raw/monthly_mortality_data_2026-03-09.csv"
)

monthly_losses_data <- readr::read_csv(
  "tt_submission/data-raw/monthly_losses_data_2026-03-09.csv"
)
