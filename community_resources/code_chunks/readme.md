# Code Chunks

This section is for useful generic functions that get created, discovered or shared as `#TidyTuesday` goes on.

* You can do a pull-request using the format seen in the below example
* Give yourself credit (either w/ GitHub or Twitter handle)


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
