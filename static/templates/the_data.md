## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('{{date}}')
## OR
tuesdata <- tidytuesdayR::tt_load({{year}}, week = {{week}})

{{#datasets}}
{{{dataset_name}}} <- tuesdata${{{dataset_name}}}
{{/datasets}}

# Option 2: Read directly from GitHub

{{#datasets}}
{{{dataset_name}}} <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/{{year}}/{{date}}/{{dataset_file}}')
{{/datasets}}
```

```python
# Using Python
# Option 1: PyDyTuesday python library
## pip install PyDyTuesday

import PyDyTuesday

# Download files from the week, which you can then read in locally
PyDyTuesday.get_date('{{date}}')

# Option 2: Read directly from GitHub and assign to an object

{{#datasets}}
{{{dataset_name}}} = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/{{year}}/{{date}}/{{dataset_file}}')
{{/datasets}}
```
