# Code Chunks

This section is for useful generic functions that get created, discovered or shared as `#TidyTuesday` goes on.

* You can do a pull-request using the format seen in the below example
* Give yourself credit (either w/ GitHub or Twitter handle)
* Add to this readme.md or create a new .md file (will re-visit as this folder grows).


### Create a markdown table of column names and types
- By [Thomas Mock](twitter.com/thomas_mock)
- I use this each week to get a .md table for the data dictionary

```
library(tidyverse)
library(knitr)

data_frame(variable = names(df)) %>% 
    mutate(class = map(df, typeof)) %>% 
    kable()
```

### Markdown table for summary statistics with `skimr`
- By [Philip Khor](https://twitter.com/philip_khor)

To get a more informative Markdown table with summary statistics, try the following: 

```
skimr::skim_to_wide(iris) %>% 
    knitr::kable()
```
|type    |variable     |missing |complete |n   |n_unique |top_counts                       |ordered |mean |sd   |p0  |p25 |p50  |p75 |p100 |hist     |
|:-------|:------------|:-------|:--------|:---|:--------|:--------------------------------|:-------|:----|:----|:---|:---|:----|:---|:----|:--------|
|factor  |Species      |0       |150      |150 |3        |set: 50, ver: 50, vir: 50, NA: 0 |FALSE   |NA   |NA   |NA  |NA  |NA   |NA  |NA   |NA       |
|numeric |Petal.Length |0       |150      |150 |NA       |NA                               |NA      |3.76 |1.77 |1   |1.6 |4.35 |5.1 |6.9  |▇▁▁▂▅▅▃▁ |
|numeric |Petal.Width  |0       |150      |150 |NA       |NA                               |NA      |1.2  |0.76 |0.1 |0.3 |1.3  |1.8 |2.5  |▇▁▁▅▃▃▂▂ |
|numeric |Sepal.Length |0       |150      |150 |NA       |NA                               |NA      |5.84 |0.83 |4.3 |5.1 |5.8  |6.4 |7.9  |▂▇▅▇▆▅▂▂ |
|numeric |Sepal.Width  |0       |150      |150 |NA       |NA                               |NA      |3.06 |0.44 |2   |2.8 |3    |3.3 |4.4  |▁▂▅▇▃▂▁▁ |


Have a look at the `skimr::skim_with()` function to include/exclude specific summary statistics. 

`skimr` also supports grouped data frames, which means you can do something like the following: 

```
library(dplyr)

iris %>% 
    group_by(Species) %>%   
    skimr::skim_to_wide() %>% 
    knitr::kable()
```

|type    |Species    |variable     |missing |complete |n  |mean |sd   |p0  |p25  |p50  |p75  |p100 |hist     |
|:-------|:----------|:------------|:-------|:--------|:--|:----|:----|:---|:----|:----|:----|:----|:--------|
|numeric |setosa     |Petal.Length |0       |50       |50 |1.46 |0.17 |1   |1.4  |1.5  |1.58 |1.9  |▁▁▅▇▇▅▂▁ |
|numeric |setosa     |Petal.Width  |0       |50       |50 |0.25 |0.11 |0.1 |0.2  |0.2  |0.3  |0.6  |▂▇▁▂▂▁▁▁ |
|numeric |setosa     |Sepal.Length |0       |50       |50 |5.01 |0.35 |4.3 |4.8  |5    |5.2  |5.8  |▂▃▅▇▇▃▁▂ |
|numeric |setosa     |Sepal.Width  |0       |50       |50 |3.43 |0.38 |2.3 |3.2  |3.4  |3.68 |4.4  |▁▁▃▅▇▃▂▁ |
|numeric |versicolor |Petal.Length |0       |50       |50 |4.26 |0.47 |3   |4    |4.35 |4.6  |5.1  |▁▃▂▆▆▇▇▃ |
|numeric |versicolor |Petal.Width  |0       |50       |50 |1.33 |0.2  |1   |1.2  |1.3  |1.5  |1.8  |▆▃▇▅▆▂▁▁ |
|numeric |versicolor |Sepal.Length |0       |50       |50 |5.94 |0.52 |4.9 |5.6  |5.9  |6.3  |7    |▃▂▇▇▇▃▅▂ |
|numeric |versicolor |Sepal.Width  |0       |50       |50 |2.77 |0.31 |2   |2.52 |2.8  |3    |3.4  |▁▂▃▅▃▇▃▁ |
|numeric |virginica  |Petal.Length |0       |50       |50 |5.55 |0.55 |4.5 |5.1  |5.55 |5.88 |6.9  |▂▇▃▇▅▂▁▂ |
|numeric |virginica  |Petal.Width  |0       |50       |50 |2.03 |0.27 |1.4 |1.8  |2    |2.3  |2.5  |▂▁▇▃▃▆▅▃ |
|numeric |virginica  |Sepal.Length |0       |50       |50 |6.59 |0.64 |4.9 |6.23 |6.5  |6.9  |7.9  |▁▁▃▇▅▃▂▃ |
|numeric |virginica  |Sepal.Width  |0       |50       |50 |2.97 |0.32 |2.2 |2.8  |3    |3.18 |3.8  |▁▃▇▇▅▃▁▂ |
