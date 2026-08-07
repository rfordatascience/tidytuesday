This week we're exploring digital products for sale on [Gumroad](https://gumroad.com), a
marketplace where independent creators sell templates, courses, design assets and software.
The data is a snapshot of Gumroad's Discover search taken in August 2026: 42 category
searches, every listing they returned, with its asking price, currency, star rating and
rating count.

> The top 1% of products hold 33.4% of all 62,134 ratings in the sample, and the least-rated
> half of products hold 0.5% between them. Asking prices cluster far more tightly: the median
> paid product asks $36.99, and most sit under $50.

Two things worth knowing before you start: one product can rank for several category
searches, which is why this ships as two tables joined on `product_id`, and Gumroad localises
displayed prices, so use `price_usd` to compare across listings. A rating count is a floor on
the number of buyers, not a sales estimate.

- How does the price distribution differ between categories — which ones are cheap and
  crowded, and which sustain high prices?
- Free products are far more likely to carry ratings (97%) than paid ones (64%). Does that
  hold within categories?
- Which categories overlap most, according to `gumroad_categories`?
- Does a "Top creator" badge line up with price, with rating count, or with neither?

The collection is CC BY 4.0 and archived at
[doi:10.5281/zenodo.21830103](https://doi.org/10.5281/zenodo.21830103).
