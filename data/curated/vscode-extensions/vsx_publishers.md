# `vsx_publishers.csv`

One row per publisher, 50,446 rows, derived from `vsx_extensions.csv`.

|variable|class|description|
|---|---|---|
|publisher|character|Publisher id. Joins to `vsx_extensions$publisher`.|
|n_extensions|integer|Number of that publisher's extensions in this sample.|
|total_installs|integer|Sum of `installs` across them.|
|median_installs|integer|Median of `installs` across them.|
|max_installs|integer|Largest single `installs` value.|
|first_release|date|Earliest `released` among them.|
|last_update|date|Latest `updated` among them.|

**86.1% of publishers have exactly one extension** and the median publisher has one,
so publisher-level and extension-level statistics answer different questions. The largest
single publisher here has 286 extensions.
