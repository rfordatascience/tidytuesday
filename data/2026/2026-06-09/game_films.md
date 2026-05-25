|variable                      |class     |description                           |
|:-----------------------------|:---------|:-------------------------------------|
|category                      |character |Top-level Wikipedia section the film belongs to (e.g. "Theatrical releases", "Direct-to-video", "Television films"). |
|subcategory                   |character |Second-level Wikipedia section within the category (e.g. "English", "Japanese", "Animation"). NA for films with no subsection. |
|title                         |character |Title of the film or production. |
|director                      |character |Director(s) of the film. Multiple directors are separated by " \| ". |
|release_date                  |date      |Parsed release date. For films with regional releases, this is the earliest date. For year-only or month-year entries, the date is set to the first day of that period. TBA and undated entries are NA. |
|release_date_raw              |character |Original release date string as it appeared on Wikipedia before parsing. |
|air_date_raw                  |character |Original air date string for television productions, as it appeared on Wikipedia. NA for non-television entries. |
|worldwide_box_office_currency |character |Currency symbol of the worldwide box office figure (e.g. "$", "¥"). |
|worldwide_box_office          |double    |Worldwide box office gross in the original currency units. See worldwide_box_office_currency. |
|rotten_tomatoes               |double    |Rotten Tomatoes critic score as a percentage (0–100). |
|metacritic                    |double    |Metacritic score out of 100. |
|cinema_score                  |character |CinemaScore audience grade (e.g. "A+", "B−"). |
|distributor                   |character |Film distributor(s). |
|original_game_publisher       |character |Publisher of the video game the film is based on. |
|budget_currency               |character |Currency symbol of the budget figures (e.g. "$", "¥"). |
|budget_low                    |double    |Lower bound of the reported production budget in the original currency units. Equal to budget_high for single-value budgets. |
|budget_high                   |double    |Upper bound of the reported production budget in the original currency units. Equal to budget_low for single-value budgets. |
|domestic_box_office           |character |Domestic box office gross as reported on Wikipedia (documentary sections). |
|subject                       |character |Subject or topic of the documentary (documentary sections only). |
|network                       |character |Broadcasting network for television productions. |

