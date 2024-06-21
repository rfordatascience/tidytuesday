## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('{{date}}')
## OR
tuesdata <- tidytuesdayR::tt_load({{year}}, week = {{week}})

{{#datasets}}
{{{dataset_name}}} <- tuesdata${{{dataset_name}}}
{{/datasets}}

# Option 2: Read directly from GitHub

{{#datasets}}
{{{dataset_name}}} <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/{{year}}/{{date}}/{{dataset_file}}')
{{/datasets}}
```
