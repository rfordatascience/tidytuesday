# Cars in Qatar

This week we are exploring data about cars in Qatar!

One of the most common example datasets in R is `mtcars`, which contains data on a bunch of cars from 1974 (!). Some of the car companies in there don't even exist anymore, like Datsun. The `mpg` dataset that comes with {ggplot2} was designed to be an improvement on `mtcars` and includes vehicles from 1999 and 2008. However, both `mpg` and `mtcars` are highly US-centric---most people in the world don't think in gallons and miles and feet and inches---and neither dataset includes details about electric cars, which are increasingly common today.

Qatar Cars (also available as [the {qatarcars} R package](https://profmusgrave.github.io/qatarcars/)) provides a more internationally focused, modern-cars-based demonstration dataset. It mirrors many of the columns in `mtcars`, but uses (1) non-US-centric makes and models, (2) 2025 prices, and (3) metric measurements, making it more appropriate for use as an example dataset outside the United States.

Paul Musgrave and students in his international politics course at Georgetown University in Qatar [collected this data in early 2025](https://musgrave.substack.com/p/introducing-the-qatar-cars-dataset) with the goal of creating a new toy dataset that does not suffer from ["U.S. defaultism"](https://doi.org/10.1080/15512169.2025.2572320):

> "U.S. defaultism"---the assumption that American contexts, units, and perspectives are universal---manifests in many ways in political science. In this article, I describe how toy datasets commonly employed in quantitative methods courses exemplify this problem. Using customary units, for instance, is unsuitable for an internationalized higher education system. To address these limitations, I introduce the Qatar Cars dataset, a freely available alternative toy dataset that uses International System (SI) units, reflects current global automotive market trends (such as the rise of Chinese manufacturers and electric vehicles), and avoids ethnocentric classifications such as labeling the non-U.S. world "foreign." Created through collaborative data collection with students, the Qatar Cars dataset maintains the pedagogical advantages of earlier datasets, improves statistical instruction by removing barriers for international audiences, and provides opportunities to discuss data-generating processes and research ethics.[^musgrave2025]

[^musgrave2025]: Paul Musgrave, "Defaulting to Inclusion: Producing Sample Datasets for the Global Data Science Classroom," *Journal of Political Science Education*, 2025, 1–11, <https://doi.org/10.1080/15512169.2025.2572320>.

The `price` column is stored as Qatari Riyals (QAR). At the time of data collection in January 2025, the exchange rates between QAR and US Dollars and Euros were:

- 1 USD = 3.64 QAR
- 1 EUR = 4.15 QAR

---

There are many possible questions to explore!

- What's the distribution of price? (there are some really expensive cars here!)
- What's the relationship between (logged) price and performance?
- Are there patterns across cars from different countries? Do some countries make more expensive cars? More electic cars?
- What's the relationship between car dimensions and seating or trunk volume?

Thank you to [Andrew Heiss, Georgia State University](https://github.com/andrewheiss) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-12-09')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 49)

qatarcars <- tuesdata$qatarcars

# Option 2: Read directly from GitHub

qatarcars <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-09/qatarcars.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-12-09')

# Option 2: Read directly from GitHub and assign to an object

qatarcars = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-09/qatarcars.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-12-09')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

qatarcars = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-09/qatarcars.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
qatarcars = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-09/qatarcars.csv", DataFrame)
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

### `qatarcars.csv`

|variable    |class     |description                                                 |
|:-----------|:---------|:-----------------------------------------------------------|
|origin      |character |The country associated with the car brand.                  |
|make        |character |The brand of the car, such as Toyota or Land Rover.         |
|model       |character |The specific type of car, such as Land Cruiser or Defender. |
|length      |double    |Length of the car (in meters).                              |
|width       |double    |Width of the car (in meters).                               |
|height      |double    |Height of the car (in meters).                              |
|seating     |double    |Number of seats in the car.                                 |
|trunk       |double    |Capacity or volume of the trunk (in liters).                |
|economy     |double    |Fuel economy of the car (in liters per 100 km).             |
|horsepower  |double    |Car horsepower.                                             |
|price       |double    |Price of the car in 2025 Qatari riyals.                     |
|mass        |double    |Mass of the car (in kg).                                    |
|performance |double    |Time to accelerate from 0 to 100 km/h (in seconds).         |
|type        |character |The type of the car, such as coupe, sedan, or SUV.          |
|enginetype  |character |The type of engine: electric, hybrid, or petrol.            |

## Cleaning Script

```r
# Clean data provided by {qatarcars}. No cleaning was necessary.
qatarcars <- readr::read_csv("https://raw.githubusercontent.com/profmusgrave/qatarcars/refs/heads/main/inst/extdata/qatarcars.csv")

# Or alternatively, using the {qatarcars} package:
#
# install.packages("qatarcars")
# library(qatarcars)
# data(qatarcars, package = "qatarcars")

```
