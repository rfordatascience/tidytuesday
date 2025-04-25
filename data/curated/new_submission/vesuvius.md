|variable              |class         |description                           |
|:---------------------|:-------------|:-------------------------------------|
|event_id              |integer       |Unique identifier for each seismic event recorded. |
|time                  |datetime<UTC> |Date and time when the seismic event occurred, in UTC format. |
|latitude              |double        |Geographic latitude of the seismic event location in decimal degrees. |
|longitude             |double        |Geographic longitude of the seismic event location in decimal degrees. |
|depth_km              |double        |Depth of the seismic event epicenter in kilometers below the surface. |
|duration_magnitude_md |double        |Duration magnitude (Md) of the seismic event, a measure of its energy release. Md is often used for smaller magnitude events, and negative values can indicate very small events (microearthquakes). |
|md_error              |double        |Estimated error margin ("plus or minus") for the duration magnitude measurement. |
|area                  |character     |Geographic area where the seismic event was recorded. In this case, the Mt. Vesuvius area. |
|type                  |character     |Classification of the seismic event, such as "earthquake" or "eruption." |
|review_level          |character     |Level of review the data has undergone. The data might be raw (preliminary) or revised (reviewed by someone). |
|year                  |integer       |Calendar year when the seismic event occurred. |
