# School Diversity

This week's data is from [The Washington Post](https://www.washingtonpost.com/graphics/2019/local/school-diversity-data/#methodology) courtesy of [Kate Rabinowitz](https://twitter.com/dataKateR), [Laura Meckler](https://twitter.com/laurameckler), and [Armand Emamdjomeh](https://twitter.com/emamd).

A lot of the visualizations were written in a `scrollytelling` format with `JavaScript`. If you want to play around with a similar format you could try out the experimental package [`rolldown`](https://github.com/yihui/rolldown) by Yihui. There is geospatial and shapefile data linked below in the methodology.

A methodology section taken verbatim from the article is below:

"This analysis used the [Common Core of Data](https://nces.ed.gov/ccd/pubschuniv.asp) from the National Center for Education Statistics (NCES). Charter and private schools were excluded because the government has limited control over them. Virtual schools were also excluded.

The Washington Post used data from the 1994-1995 school year, the earliest near-comprehensive data, and from 2016-2017, the latest available data. Findings were checked against interim years at a five-year interval.

Diversity was defined by the proportion of students in the dominant racial group. Diverse districts are places where fewer than 75 percent of students are of the same race. Undiverse districts are where 75 to 90 percent of students are the same race. In extremely undiverse districts one racial group constitutes more than 90 percent of students.

Black, Asian, Native American and white data excludes anyone with Hispanic ethnicity. Asian includes Asians, Native Hawaiians and other Pacific Islanders. Multiracial was not a racial category in 1995.

The Post measured integration for diverse school districts that have at least six schools, more than 1,000 students and where the sum total of black and hispanic students was at least 5 percent and no more than 95 percent of students.

The variance or [correlation ratio](https://www.census.gov/topics/housing/housing-patterns/guidance/appendix-b.html), also referred to as eta-squared, was used to measure integration. The ratio calculates how isolated a racial group or groups are while controlling for the demographics of the district. The variance ratio was computed for black and Hispanic students because of the history of exclusion and achievement gaps faced by these groups.

Integration groupings were defined by calculating Jenks breaks, a classification method for optimally determining data groupings, for the most recent data and applying it to earlier data.

The Post confirmed findings against an analysis that looked only at elementary schools, a method some researchers use to better control for differences in race across age groups and the typically smaller number of upper-level schools.

Geographic classifications are from [NCES](https://www.census.gov/cgi-bin/geo/shapefiles/index.php). [Geospatial data](https://nces.ed.gov/programs/edge/Geographic/LocaleBoundaries) is courtesy of the U.S. Census Bureau.

The code for this analysis and the output data can be found [here](https://github.com/WPMedia/student_integration_analysis)."

# Get the data!

```
school_diversity <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-24/school_diversity.csv")
```

# Data Dictionary

## `school_diversity.csv`

|variable     |class     |description |
|:------------|:---------|:-----------|
|LEAID        |character | Unique school id |
|LEA_NAME     |character | School District Name |
|ST           |character | State of school district |
|d_Locale_Txt |character | Type of school district, town, rural, city, suburban combined with distant, remote, fringe, small, midsize, large |
|SCHOOL_YEAR  | character | School year (either 1994-1995 or 2016-2017) |
|AIAN         |double    | American indian and alaskan native proportion of student population |
|Asian        |double    | Asian proportion of student population |
|Black        |double    | Black proportion of student population |
|Hispanic     |double    | Hispanic proportion of student population |
|White        |double    | White proportion of student population|
|Multi        |double    | Multi-ethnic proportion of student population|
|Total        |double    | Total student body count |
|diverse      |character | Diverse rating (Diverse, undiverse, extremely undiverse) |
|variance     |double    | the variance ratio |
|int_group    |character | the level of integration, defined as "Highly integated", "Somewhat integrated" and "Not integrated" |