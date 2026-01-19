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
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('{{date}}')

# Option 2: Read directly from GitHub and assign to an object

{{#datasets}}
{{{dataset_name}}} = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/{{year}}/{{date}}/{{dataset_file}}')
{{/datasets}}
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
data = tt_load("{{date}}")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

{{#datasets}}
{{{dataset_name}}} = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/{{year}}/{{date}}/{{dataset_file}}")
{{/datasets}}

# Option 3: Read directly from Github and assign without Tidier dependencies
{{#datasets}}
{{{dataset_name}}} = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/{{year}}/{{date}}/{{dataset_file}}", DataFrame)
{{/datasets}}
```
