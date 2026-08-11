# `vsx_extensions.csv`

One row per distinct extension on the Visual Studio Code Marketplace, 64,464 rows.

|variable|class|description|
|---|---|---|
|id|character|`publisher.name`, the Marketplace's unique identifier for the extension.|
|publisher|character|Publisher id. Joins to `vsx_publishers$publisher`.|
|name|character|Extension id within the publisher's namespace.|
|display|character|Extension display name, as shown in the Marketplace UI.|
|category|character|The category under which the extension was first seen. An extension may belong to several; only the first is recorded, so category counts are a partition of the extensions and not of the memberships.|
|installs|integer|Install count reported by the Marketplace. Cumulative since release. Installs, not active users, and not people who kept the extension.|
|downloads|integer|Raw VSIX download count. Includes CI, mirrors and bots, so it is routinely larger than `installs`; `installs` is the better demand signal.|
|rating|double|Mean rating, 0 when the extension has never been rated.|
|ratings|integer|Number of ratings.|
|trending_weekly|double|The Marketplace's own weekly trending score. Undocumented scale.|
|released|date|Date of first release.|
|updated|date|Date the latest version was published.|
|version|character|Latest version string.|

**A row is not a history.** `installs` is cumulative, so an abandoned extension released in
2016 can outrank an excellent one released this year. Read `updated` alongside it —
65.2% of rows have not been updated in twelve months.

**26 extensions are excluded.** Their `publisher` value is a bare UUID rather
than a namespace, which is the shape of an Open VSX access token, and a public dataset is
not a place to reprint one on the chance that it is live. They are
0.04% of the crawl and
106,096 installs; excluding them moves the median install count not at
all and 2 per-category medians by one install each. `cleaning.R` does
the same drop, so the code in this folder reproduces the file in this folder.
