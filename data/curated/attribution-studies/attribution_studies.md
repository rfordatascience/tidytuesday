|variable          |class     |description                           |
|:-----------------|:---------|:-------------------------------------|
|event_name        |character |The name or description of the extreme weather event studied. |
|event_period      |character |The specific time period when the event occurred (extracted from the raw event name). |
|event_year        |character |The year(s) or year range when the event occurred. |
|study_focus       |character |Whether the study focused on a specific event or long-term trends. |
|iso_country_code  |character |Three-character ISO country code(s), with multiple countries separated by commas for multi-country studies (e.g.: "KEN, SOM"). |
|cb_region         |character |The geographic region classification used by Carbon Brief (Based on UN classification). |
|event_type        |character |The type of extreme weather event or trend discussed in the study. |
|classification    |character |How climate change has affected the studied event: "More severe or more likely to occur", "No discernible human influence", "Insufficient data/inconclusive", "Decrease, less severe or less likely to occur". |
|summary_statement |character |The authors' key findings. |
|publication_year  |double    |The year when the study was published. |
|citation          |character |The full citation for the study. |
|source            |character |The source where the study was published. |
|rapid_study       |character |Whether this was a rapid attribution study or not: analysis completed within days of the event occurring ("yes" or "no"). |
|link              |character |The URL link to the original article. |
