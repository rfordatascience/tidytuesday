This week we're exploring digital products for sale on [Gumroad](https://gumroad.com), a
marketplace where independent creators sell templates, courses, design assets, 3D models
and software. The data comes from a snapshot of Gumroad's Discover search taken in August
2026: 42 category searches, every listing they returned, with its asking price, currency,
star rating and rating count.

> Demand is far more concentrated than price is. The top 1% of products hold 33.4% of all
> 62,134 ratings in the sample, and the least-rated half of products hold 0.5% between
> them. Asking prices, by contrast, cluster tightly: the median paid product asks $36.99,
> and most sit under $50.

Two things are worth knowing before you start. First, **a row in the raw collection is a
listing observation, not a product** — one product can rank for several category searches,
and 165 of them do. That is why this dataset ships as two tables: `gumroad_products` has
one row per distinct product, and `gumroad_categories` maps products to the searches they
appeared in. Counting rows instead of products inflates every market-wide figure, because
the products that rank for several searches are the popular ones.

Second, **prices are in mixed currencies.** Gumroad localises what it displays, so a single
search returns dollars, pounds and euros side by side — 40 of the 42 categories contain
more than one. `price_local` is what was displayed and `price_usd` is the conversion at
European Central Bank reference rates for 2026-08-06; use `price_usd` for anything that
compares across listings.

A note on what ratings mean: a rating count is a floor on the number of buyers, not a
sales estimate. This dataset deliberately does not multiply ratings by an assumed review
rate to manufacture revenue figures.

The collection is published under CC BY 4.0 and archived at
[doi:10.5281/zenodo.21830103](https://doi.org/10.5281/zenodo.21830103), which resolves to
the current version.

- How does the price distribution differ between categories — which ones are cheap and
  crowded, and which sustain high prices?
- Free products are far more likely to carry ratings (97%) than paid ones (64%). Does that
  hold within categories, or is it driven by which categories have free products at all?
- Which categories overlap most, according to `gumroad_categories`? Is there a structure to
  which searches return the same products?
- Does a "Top creator" badge line up with price, with rating count, or with neither?
