This week, we are exploring mountaineering data from the [Himalayan Dataset](https://www.himalayandatabase.com/index.html)!

The Himalayan Database is a comprehensive archive documenting mountaineering expeditions in the Nepal Himalaya. It continues the pioneering work of [Elizabeth Hawley](https://www.himalayandatabase.com/history.html), a journalist who dedicated much of her life to cataloging climbing history in the region. Her meticulous records were initially compiled from a wide range of sources, including books, alpine journals, and direct correspondence with Himalayan climbers.

Originally published in 2004 by the American Alpine Club as a CD-ROM booklet, the Himalayan Database became a critical resource for the climbing community. In 2017, a non-profit organization named The Himalayan Database was formed to continue Hawley's legacy. This marked the release of Version 2 of the database, now freely available for download via the [internet](https://www.himalayandatabase.com/downloads.html).

These data are rich in historical value, detailing the peaks, expeditions, climbing statuses, and geographic information of numerous Himalayan summits. We will explore this data in a tidy tibble format, making it easier to analyze trends in mountaineering expeditions, including seasonality, success rates, and national participation over time.

Thank you to [Nicolas Foss](www.linkedin.com/in/nicolas-foss) this week's dataset.

* What is the distribution of climbing status (PSTATUS) across different mountain ranges (HIMAL_FACTOR)?
* Which mountain range (HIMAL_FACTOR) has the highest average peak height (HEIGHTM)?
* How does the status of a peak (PSTATUS) vary by region (REGION_FACTOR) and trekking status (TREKKING)?
* What is the distribution of peak heights (HEIGHTM) for peaks that are open (OPEN) versus those that are not?