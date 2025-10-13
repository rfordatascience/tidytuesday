# Selected British Literary Prizes (1990-2022)

This week we are exploring data related to the Selected British Literary Prizes (1990-2022) dataset which comes from the [Post45 Data Collective](https://data.post45.org/posts/british-literary-prizes/). 

> "This dataset contains primary categories of information on individual authors comprising gender, sexuality, UK residency, ethnicity, geography and details of educational background, 
> including institutions where the authors acquired their degrees and their fields of study. Along with other similar projects, we aim to provide information to assess the cultural, 
> social and political factors determining literary prestige. Our goal is to contribute to greater transparency in discussions around diversity and equity in literary prize cultures." 

Additional metadata discussion relating to the ethnicity, gender and sexuality, and educational classification variables is [available here](https://data.post45.org/posts/british-literary-prizes/). 

Thank you to @gkaramanis for the [dataset suggestion](https://github.com/rfordatascience/tidytuesday/issues/893)!

In relation to ethical considerations, the authors note that...

> "All of the information in this dataset is publicly available. Information about a writer’s location, gender identity, race, ethnicity, or education from scholarly and public sources can be sensitive.
> The data provided here enables the study of broad patterns and is not intended as definitive."

- In which genres are women, Black, Asian and ethnically diverse writers most likely to be shortlisted and/or awarded?
- Have prizes improved their record on gender and/or ethnic representation in shortlists and awardees?
- Is there a connection between specific educational credentials and/or educational institutions and writers’ chances of being shortlisted or winning?

Thank you to [Jen Richmond](https://github.com/jenrichmond) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-10-28')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 43)

prizes <- tuesdata$prizes

# Option 2: Read directly from GitHub

prizes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-28/prizes.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-10-28')

# Option 2: Read directly from GitHub and assign to an object

prizes = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-28/prizes.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-10-28')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

prizes = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-28/prizes.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
prizes = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-28/prizes.csv", DataFrame)
```


## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.


## Data Dictionary

### `prizes.csv`

|variable              |class     |description                           |
|:---------------------|:---------|:-------------------------------------|
|prize_id              |integer    |Unique prize identifier used in the SBLP dataset. |
|prize_alias           |character |Name of the prize awarded, regularized to the most current name. |
|prize_name            |character |Name of the prize awarded, at the time of award. |
|prize_institution     |character |Institution that sponsored the prize. |
|prize_year            |integer  |Year the prize was awarded. |
|prize_genre           |character |Genre category of book that the prize was awarded to. |
|person_id             |character |Unique author identifier used in the SBLP dataset, assigned in order of entity entry to the dataset. |
|person_role           |character |Whether author was shortlisted or won the prize. |
|last_name             |character |Family name of author. |
|first_name            |character |Given name of author. |
|name                  |character |Full name author in family name, given name format. |
|gender                |character |Author’s gender, as self-declared/publicly available. |
|sexuality             |character |Author’s sexuality, as self-declared/publicly available. |
|uk_residence          |logical   |Whether the author holds residence status in the UK at the time of data gathering. |
|ethnicity_macro       |character |Ethnicity macro category, as created for this dataset. |
|ethnicity             |character |Ethnicity as self-declared/publicly available. |
|highest_degree        |character |Highest level of post-secondary education. |
|degree_institution    |character |Institution from which the highest degree was attained. |
|degree_field_category |character |Degree macro category, as created for this dataset. |
|degree_field          |character |Field of study, as self-declared/publicly available. |
|viaf                  |character |Virtual internet authority file code. |
|book_id               |character |Unique book identifier used in the SBLP dataset. |
|book_title            |character |Title of the awarded or shortlisted book. |

## Cleaning Script

```r
# Data obtained from Post45 Data Collective Github, no cleaning necessary

prizes <- readr::read_csv("https://raw.githubusercontent.com/Post45-Data-Collective/data/refs/heads/main/british_literary_prizes/british_literary_prizes-1990-2022.csv")

```
