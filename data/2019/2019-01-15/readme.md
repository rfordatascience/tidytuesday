# Data Info

Data comes from [The Economist GitHub](https://github.com/TheEconomist/graphic-detail-data/tree/master/data/2018-10-20_space-launches). The following information was taken directly from their GitHub readme.

# Space launches

These are the data behind the "space launches" article, [The space race is dominated by new contenders](https://economist.com/graphic-detail/2018/10/18/the-space-race-is-dominated-by-new-contenders).

Principal data came from the Jonathan McDowell's JSR Launch Vehicle Database, available online at http://www.planet4589.org/space/lvdb/index.html.

## Data files

| File     | Description            | Source                             |
| -------- | ---------------------- | ---------------------------------- |
| [agencies](agencies.csv) | Space launch providers | Jonathan McDowell; _The Economist_ |
| [launches](launches.csv) | Individual space launches | Jonathan McDowell; _The Economist_ |

## Codebook

### launches

| variable    | definition                               |
| ----------- | ---------------------------------------- |
| tag         | Harvard or [COSPAR][cospar] id of launch |
| JD          | [Julian Date][jd] of launch              |
| launch_date | date of launch                           |
| launch_year | year of launch                           |
| type        | type of launch vehicle                  |
| variant     | variant of launch vehicle                |
| mission     |
| agency      | launching agency                         |
| state_code  | launching agency's state                 |
| category    | success (O) or failure (F)               |
| agency_type | type of agency                           |

### agencies

| variable           | definition              |
| ------------------ | ----------------------- |
| agency             | org phase code          |
| count              | number of launches      |
| ucode              | org Ucode               |
| state_code         | responsible state       |
| type               | type of org             |
| class              | class of org            |
| tstart             | org/phase founding date |
| tstop              | org/phase ending date   |
| short_name         | short name              |
| name               | full name               |
| location           | plain english location  |
| longitude          |                         |
| latitude           |                         |
| error              | uncertainty in long/lat |
| parent             | parent org              |
| short_english_name | english short name      |
| english_name       | english full name       |
| unicode_name       | unicode full name       |
| agency_type        | type of agency          |

[cospar]: https://en.wikipedia.org/wiki/International_Designator
[jd]: https://en.wikipedia.org/wiki/Julian_day
