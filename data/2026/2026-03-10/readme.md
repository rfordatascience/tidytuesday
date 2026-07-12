# How likely is 'likely'?

In an [online quiz](https://probability.kucharski.io/), created as an independent project by Adam Kucharski, over 5,000 participants compared pairs of probability phrases (e.g. “Which conveys a higher probability: Likely or Probable?”) and assigned numerical values (0–100%) to each of 19 phrases. The resulting data can be used to analyse how people interpret common probability phrases.

* Which phrases do people most disagree on, in relation to the probability they represent?
* Which demographic background is the most optimistic?
* Does the order people are shown phrases in change their interpretation?

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-03-10')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 10)

absolute_judgements <- tuesdata$absolute_judgements
pairwise_comparisons <- tuesdata$pairwise_comparisons
respondent_metadata <- tuesdata$respondent_metadata

# Option 2: Read directly from GitHub

absolute_judgements <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/absolute_judgements.csv')
pairwise_comparisons <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/pairwise_comparisons.csv')
respondent_metadata <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/respondent_metadata.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-03-10')

# Option 2: Read directly from GitHub and assign to an object

absolute_judgements = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/absolute_judgements.csv')
pairwise_comparisons = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/pairwise_comparisons.csv')
respondent_metadata = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/respondent_metadata.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-03-10")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

absolute_judgements = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/absolute_judgements.csv")
pairwise_comparisons = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/pairwise_comparisons.csv")
respondent_metadata = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/respondent_metadata.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
absolute_judgements = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/absolute_judgements.csv", DataFrame)
pairwise_comparisons = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/pairwise_comparisons.csv", DataFrame)
respondent_metadata = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/respondent_metadata.csv", DataFrame)
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

### `absolute_judgements.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|response_id |integer   |Unique respondent identifier. |
|term        |character |Probability phrase. |
|probability |integer   |Numerical estimate (0--100). |
|order       |integer   |Presentation order of this term for the respondent. |

### `pairwise_comparisons.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|response_id |integer   |Unique respondent identifier. |
|pair_id     |integer   |Pair sequence number within the respondent's session (1--10). |
|term1       |character |First term shown. |
|term2       |character |Second term shown. |
|selected    |character |The term the respondent chose as higher probability. |

### `respondent_metadata.csv`

|variable             |class     |description                           |
|:--------------------|:---------|:-------------------------------------|
|response_id          |integer   |Unique respondent identifier. |
|timestamp            |character |Submission month (YYYY-MM). |
|age_band             |character |Self-reported age band (e.g. "25-34"). |
|english_background   |character |English language background. |
|education_level      |character |Highest education level. |
|country_of_residence |character |Country of residence. |

## Cleaning Script

```r
# Clean data provided by <https://github.com/adamkucharski/CAPphrase/>. No cleaning was necessary.
absolute_judgements <- readr::read_csv(
  "https://raw.githubusercontent.com/adamkucharski/CAPphrase/refs/heads/main/data/absolute_judgements.csv"
)
pairwise_comparisons <- readr::read_csv(
  "https://raw.githubusercontent.com/adamkucharski/CAPphrase/refs/heads/main/data/pairwise_comparisons.csv"
)
respondent_metadata <- readr::read_csv(
  "https://raw.githubusercontent.com/adamkucharski/CAPphrase/refs/heads/main/data/respondent_metadata.csv"
)

```
