This week, we are exploring mountaineering data from the [Himalayan Dataset](https://www.himalayandatabase.com/index.html)!

The Himalayan Database is a comprehensive archive documenting mountaineering expeditions in the Nepal Himalaya. It continues the pioneering work of [Elizabeth Hawley](https://www.himalayandatabase.com/history.html), a journalist who dedicated much of her life to cataloging climbing history in the region. Her meticulous records were initially compiled from a wide range of sources, including books, alpine journals, and direct correspondence with Himalayan climbers.

Originally published in 2004 by the American Alpine Club as a CD-ROM booklet, the Himalayan Database became a critical resource for the climbing community. In 2017, a non-profit organization named The Himalayan Database was formed to continue Hawley's legacy. This marked the release of Version 2 of the database, now freely available for download via the [internet](https://www.himalayandatabase.com/downloads.html).

These data are rich in historical value, detailing the peaks, expeditions, climbing statuses, and geographic information of numerous Himalayan summits. We will explore these data in two tidy tibbles, making it easier to analyze trends in mountaineering expeditions, including seasonality, success rates, and national participation over time.  Participants this week will be able to use the peaks and expeditions datasets.  To manage file size, the expeditions file was filtered down to 2020-2024.


* What is the distribution of climbing status (PSTATUS) across different mountain ranges (HIMAL_FACTOR)?
* Which mountain range (HIMAL_FACTOR) has the highest average peak height (HEIGHTM)?
* What is the distribution of peak heights (HEIGHTM) for peaks that are open (OPEN) versus those that are not?
* Which climbing routes (ROUTE1, ROUTE2, ROUTE3, ROUTE4) have the highest success rates (SUCCESS1, SUCCESS2, SUCCESS3, SUCCESS4) across all expeditions?
* How does the use of supplemental oxygen (O2USED, O2NONE) affect summit success rates?
* How often does bad weather (TERMREASON = 4) play a role in termination compared to technical difficulty (TERMREASON = 10)?
* Are expeditions with no hired personnel (NOHIRED) associated with higher or lower death rates?