# Global Student to Teacher Ratios

"The UNESCO Institute of Statistics collects country-level data on the number of teachers, teacher-to-student ratios, and related figures. You can download the data or explore it in UNESCO’s eAtlas of Teachers or their interactive visualization of teacher supply in Asia"

h/t to [Data is Plural 2019/04/03](https://docs.google.com/spreadsheets/d/1wZhPLMCHKJvwOkP4juclhjFgqIY8fQFMemwKL2c64vk/edit#gid=0)

There is even more education data at the country level available at [UNESCO Institute of Statistics](http://data.uis.unesco.org/index.aspx?queryid=180).

"Reducing class size to increase student achievement is an approach that has been tried, debated, and analyzed for several decades. The premise seems logical: with fewer students to teach, teachers can coax better performance from each of them. But what does the research show?Some researchers have not found a connection between smaller classes and higher student achievement, but most of the research shows that when class size reduction programs are well-designed and implemented in the primary grades (K-3), student achievement rises as class size drops." 
> [Center for Public Education](http://www.centerforpubliceducation.org/research/class-size-and-student-achievement)

# Get the data!

```
student_ratio <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-07/student_teacher_ratio.csv")
```

# Data Dictionary

### `student_teacher_ratio.csv`

|variable      |class     |description |
|:---|:---|:-----------|
|edulit_ind    | character | Unique ID|
|indicator     | character | Education level group ("Lower Secondary Education", "Primary Education", "Upper Secondary Education", "Pre-Primary Education", "Secondary Education", "Tertiary Education", "Post-Secondary Non-Tertiary Education")|
|country_code  | character |  Country code |
|country       | character | Country Full name|
|year          | integer (date)    | Year |
|student_ratio | double    |Student to teacher ratio (lower = fewer students/teacher)|
|flag_codes    | character | Code to indicate some metadata about exceptions |
|flags         | character | Metadata about exceptions |


# Cleaning script

```
library(tidyverse)
library(here)

raw_df <- read_csv(here("2019", "2019-05-07", "EDULIT_DS_06052019101747206.csv"))

clean_ed <- raw_df %>% 
  janitor::clean_names() %>% 
  mutate(indicator = str_remove(indicator, "Pupil-teacher ratio in"),
         indicator = str_remove(indicator, "(headcount basis)"),
         indicator = str_remove(indicator, "\\(\\)"),
         indicator = str_trim(indicator),
         indicator = stringr::str_to_title(indicator)) %>% 
  select(-time_2) %>% 
  rename("country_code" = location,
         "student_ratio" = value,
         "year" = time)

clean_ed %>% 
  write_csv(here("2019", "2019-05-07", "student_teacher_ratio.csv"))


```
