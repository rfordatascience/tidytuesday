![](https://images.unsplash.com/photo-1533854775446-95c4609da544?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80)

# College tuition, diversity, and pay

College tuition data is somewhat difficult to find - with many sites limiting it to online tools.

The data this week comes from many different sources but originally came from the US Department of Education. The most comprehensive and easily accessible data cames from [Tuitiontracker.org](https://www.tuitiontracker.org/) who allows for a .csv download! Unfortunately it's in a very wide format that is not ready for analysis, but `tidyr` can make quick work of that with `pivot_longer()`. It has a massive amount of data, I have filtered it down to a few tables as seen in the attached .csv files. Tuition and diversity data can be quickly joined by `dplyr::left_join(tuition_cost, diversity_school, by = c("name", "state"))`. Some of the other tables can also be joined but there may be some fuzzy matching needed.

Historical averages from the [NCES](https://nces.ed.gov/fastfacts/display.asp?id=76) - cover 1985-2016.

*Tuition and fees* by college/university for 2018-2019, along with school type, degree length, state, in-state vs out-of-state from the [Chronicle of Higher Education](https://www.chronicle.com/interactives/tuition-and-fees).

*Diversity* by college/university for 2014, along with school type, degree length, state, in-state vs out-of-state from the [Chronicle of Higher Education](https://www.chronicle.com/interactives/student-diversity-2016).

Example diversity graphics from [Priceonomics](https://priceonomics.com/ranking-the-most-and-least-diverse-colleges-in/).

Average net cost by income bracket from [TuitionTracker.org](https://www.tuitiontracker.org/).

Example price trend and graduation rates from [TuitionTracker.org](https://www.tuitiontracker.org/school.html?unitid=228778)

Salary potential data comes from [payscale.com](https://www.payscale.com/college-salary-report/best-schools-by-state/bachelors/new-hampshire).



### Get the data here

```{r}
# Get the Data

tuition_cost <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/tuition_cost.csv')

tuition_income <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/tuition_income.csv') 

salary_potential <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/salary_potential.csv')

historical_tuition <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/historical_tuition.csv')

diversity_school <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-10/diversity_school.csv')

# Or read in with tidytuesdayR package (https://github.com/dslc-io/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO USE tidytuesdayR version ? from GitHub

# Either ISO-8601 date or year/week works!

# Install via pak::pak("dslc-io/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-03-10')
tuesdata <- tidytuesdayR::tt_load(2020, week = 11)


tuition_cost <- tuesdata$tuition_cost
```
### Data Dictionary

# `tuition_cost.csv`

|variable             |class     |description |
|:--------------------|:---------|:-----------|
|name                 |character |School name |
|state                |character | State name |
|state_code           |character | State Abbreviation |
|type                 |character | Type: Public, private, for-profit|
|degree_length        |character | 4 year or 2 year degree |
|room_and_board       |double    | Room and board in USD |
|in_state_tuition     |double    | Tuition for in-state residents in USD |
|in_state_total       |double    | Total cost for in-state residents in USD (sum of room & board + in state tuition) |
|out_of_state_tuition |double    | Tuition for out-of-state residents in USD|
|out_of_state_total   |double    | Total cost for in-state residents in USD (sum of room & board + out of state tuition) |

# `tuition_income.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|name        |character | School name |
|state       |character | State Name |
|total_price |double    | Total price in USD |
|year        |double    | year |
|campus      |character | On or off-campus |
|net_cost    |double    | Net-cost - average actually paid after scholarship/award |
|income_lvl  |character | Income bracket |

# `salary_potential.csv`

|variable                  |class     |description |
|:-------------------------|:---------|:-----------|
|rank                      |double    | Potential salary rank within state |
|name                      |character | Name of school |
|state_name                |character | state name |
|early_career_pay          |double    | Estimated early career pay in USD |
|mid_career_pay            |double    | Estimated mid career pay in USD |
|make_world_better_percent |double    | Percent of alumni who think they are making the world a better place |
|stem_percent              |double    | Percent of student body in STEM |

# `historical_tuition.csv`

|variable     |class     |description |
|:------------|:---------|:-----------|
|type         |character | Type of school (All, Public, Private) |
|year         |character | Academic year |
|tuition_type |character | Tuition Type All Constant (dollar inflation adjusted), 4 year degree constant, 2 year constant, Current to year, 4 year current, 2 year current |
|tuition_cost |double    | Tuition cost in USD |

# `diversity_school.csv`
|variable         |class     |description |
|:----------------|:---------|:-----------|
|name             |character | School name |
|total_enrollment |double    | Total enrollment of students |
|state            |character | State name |
|category         |character | Group/Racial/Gender category |
|enrollment       |double    | enrollment by category |

### Cleaning Script

Please see the various .R files.
