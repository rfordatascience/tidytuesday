|variable             |class         |description                           |
|:--------------------|:-------------|:-------------------------------------|
|date                 |date          |Date of the Olympic event. |
|discipline_code      |character     |Abbreviated code for the sport discipline (e.g., ALP for Alpine Skiing, CUR for Curling). |
|discipline_name      |character     |Full name of the sport discipline. |
|event_code           |character     |Unique identifier code for the specific event. |
|event_description    |character     |Descriptive name of the event including gender, type, and round. |
|start_datetime_local |datetime<UTC> |Event start date and time in local timezone. |
|end_datetime_local   |datetime<UTC> |Event end date and time in local timezone. |
|start_datetime_utc   |datetime<UTC> |Event start date and time in UTC timezone. |
|end_datetime_utc     |datetime<UTC> |Event end date and time in UTC timezone. |
|is_medal_event       |logical       |Whether the event awards medals (TRUE) or not (FALSE). |
|is_training          |logical       |Whether the event is a training session (TRUE) or competition (FALSE). |
|venue_code           |character     |Abbreviated code for the venue location. |
|venue_name           |character     |Full name of the venue where the event takes place. |
|venue_slug           |character     |URL-friendly identifier for the venue. |
|location_name        |character     |Specific location or area within the venue (e.g., sheet, course). |
|location_code        |character     |Abbreviated code for the specific location within the venue. |
|session_code         |character     |Unique code identifying the event session. |
|estimated_start      |logical       |Whether the start time is estimated (TRUE) or confirmed (FALSE). |
|day_of_week          |character     |Day of the week the event occurs on. |
|start_time           |time          |Event start time without date component. |
|end_time             |time          |Event end time without date component. |
