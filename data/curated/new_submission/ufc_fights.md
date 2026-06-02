|variable             |class     |description                           |
|:--------------------|:---------|:-------------------------------------|
|fight_url            |character |Character. URL for the fight details page on [http://ufcstats.com/](http://ufcstats.com/) |
|event_name_succ      |double    |Number of successful strikes or actions associated with the event name field, if parsed from source tables. Often missing. |
|event_name_att       |double    |Number of attempted strikes or actions associated with the event name field, if parsed from source tables. Often missing. |
|date                 |date      |Date of the UFC event. |
|location             |character |Event location, usually formatted as city and country or city and state. |
|f1_name              |character |Name of the first listed fighter. |
|f1_result            |character |Result for the first listed fighter, typically '"W"' for win or '"L"' for loss. Missing for scheduled or incomplete bouts. |
|f2_name              |character |Name of the second listed fighter. |
|f2_result            |character |Result for the second listed fighter, typically '"W"' for win or '"L"' for loss. Missing for scheduled or incomplete bouts. |
|weight_class         |character | Weight class or bout category, such as '"Bantamweight Bout"' or '"Heavyweight Bout"'. |
|method               |character |Method of victory, such as '"Decision - Unanimous"', '"KO/TKO"', or '"Submission"'. Missing for scheduled or incomplete bouts. |
|round                |double    |Round in which the fight ended. Missing for scheduled or incomplete bouts. |
|time                 |Period    |Time elapsed in the final round when the fight ended. Missing for scheduled or incomplete bouts. |
|time_format          |character |Scheduled fight format, such as '"3 Rnd (5-5-5)"' or '"5 Rnd (5-5-5-5-5)"'. |
|referee              |character |Name of the referee. Missing for scheduled or incomplete bouts. |
|judging_details_succ |double    |Successful or winning-side judging detail extracted from the source, where available. Often missing for non-decision fights or incomplete bouts. |
|judging_details_att  |double    |Attempted or opposing-side judging detail extracted from the source, where available. Often missing for non-decision fights or incomplete bouts. |
