|variable          |class         |description                           |
|:-----------------|:-------------|:-------------------------------------|
|animal_id         |character     |Unique identification for each animal. |
|animal_name       |character     |Name of the Animal (Blank value means name not known). Animals with "*" are given by shelter staff.  |
|animal_type       |factor        |Species name of the animal. |
|primary_color     |factor        |The predominant color of the animal. |
|secondary_color   |factor        |Additional coloring, less predominant than the primary color. |
|sex               |factor        |Altered Sex of the animal. |
|dob               |date          |Date of Birth (if blank, DOB unknown). |
|intake_date       |date          |Date on which Animal was brought to the shelter . |
|intake_condition  |factor        |Condition of animal at intake. |
|intake_type       |factor        |The reason for intake such as stray capture, wildlife captures, adopted but returned, owner surrendered etc.. |
|intake_subtype    |factor        |The method or secondary manner in which the animal was admitted to the shelter. |
|reason_for_intake |factor        |The reason an owner surrendered their animal. |
|outcome_date      |date          |Exit or Outcome date such as date of adoption or date animal died. |
|crossing          |character     |Intersection/Cross street of intake or capture. |
|jurisdiction      |factor        |Geographical jurisdiction of where an animal originated. |
|outcome_type      |factor        |Outcome associated with animal - adopted, died, euthanized etc. . |
|outcome_subtype   |factor        |Secondary manner in which the animal left the shelter, usually used to identify which program, group, or other data useful in measuring program efficiency. |
|latitude          |double        |The latitude of the crossing. |
|longitude         |double        |The longitude of the crossing. |
|outcome_is_dead   |logical       |Whether animal is dead at outcome. |
|was_outcome_alive |logical       |Whether animal was alive at outcome. |
|geopoint          |character     |Latitude and longitude of crossing. |
