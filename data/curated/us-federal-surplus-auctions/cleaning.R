# U.S. federal (GSA) surplus auction lots, published by GovAuctions under
# CC BY 4.0: https://github.com/benswork-space/us-government-surplus-dataset
#
# The published CSV is already tidy (one row per completed lot), so the work
# here is type coercion plus dropping one column that the source never fills.

library(readr)
library(dplyr)

surplus_raw <- read_csv(
  paste0(
    "https://raw.githubusercontent.com/benswork-space/",
    "us-government-surplus-dataset/main/us-gsa-surplus-auctions.csv"
  ),
  show_col_types = FALSE
)

surplus_auctions <- surplus_raw |>
  # `starting_bid` is empty for every row: GSA does not publish an opening price
  # on these listings. Dropped rather than shipped as an all-NA column.
  select(-starting_bid) |>
  mutate(
    # "unknown" is a genuine third state in the source, not a missing value
    # marker, but it has no logical equivalent, so it becomes NA here.
    sold = as.logical(na_if(sold, "unknown")),
    ended_at = as.Date(ended_at),
    across(c(zip, city), ~ na_if(.x, ""))
  )

stopifnot(!anyDuplicated(surplus_auctions$id))
stopifnot(all(surplus_auctions$currency == "USD"))
stopifnot(nrow(surplus_auctions) > 9000)

# A lot with no recorded bid has no bid level, and the two are exactly
# equivalent in the source: every bid_count == 0 row has a missing bid, and
# every bid_count > 0 row has one. Asserted rather than "fixed", because a
# mutate here would be a silent no-op that later looks like real cleaning.
stopifnot(
  with(surplus_auctions, all((bid_count == 0) == is.na(current_or_final_bid)))
)
