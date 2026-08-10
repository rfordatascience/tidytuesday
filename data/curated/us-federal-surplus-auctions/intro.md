This week we're exploring what the U.S. federal government sells off when it is finished with it. Every year, federal agencies dispose of surplus property through public auction: fleet vehicles, lab and medical equipment, IT gear, industrial tools, aircraft parts, office furniture, and a long tail of genuinely strange one-off lots. This dataset covers roughly 10,000 completed lots sold through GSA Auctions, the General Services Administration's public sale channel.

The data is aggregated by [GovAuctions](https://govauctions.app), which indexes government surplus auctions, and is published as a free CC BY 4.0 dataset. GSA listings are works of the U.S. government and so are not subject to copyright under 17 U.S.C. 105, which makes this slice clean to redistribute.

> One row per completed federal surplus lot sold through GSA Auctions, with the
> lot title, category, condition, location, bid activity and closing date. The
> bid figure is the last bid level observed, not a confirmed hammer price.
> Auction prices are heavily right-skewed, so medians are more meaningful than
> means.

Two caveats worth passing on to anyone plotting this. `current_or_final_bid` is a bid level rather than a settled sale price, and it is missing for the roughly 37% of lots that drew no recorded bid. And the price range across categories is enormous, from a median of about $25 for office furniture to about $3,300 for vehicles, which makes a linear axis close to unreadable.

- How far apart are the categories once you put median bid on a log scale, and does a bar chart mislead here?
- Which states move the most surplus, and does that hold up once you adjust for population or for federal employment?
- Does bid count predict the final bid level, and does the relationship differ by category?
- What share of lots go unsold, and which categories struggle most to attract a bid?
- What is the weirdest thing you can find in the `title` column?
