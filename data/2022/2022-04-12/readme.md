### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`.

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing *good* alt text for plots/graphs.

> Here’s a simple formula for writing alt text for data visualization:
>
> ### Chart type
>
> It’s helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual. Example: Line graph
>
> ### Type of data
>
> What data is included in the chart? The x and y axis labels may help you figure this out. Example: number of bananas sold per day in the last year
>
> ### Reason for including the chart
>
> Think about why you’re including this visual. What does it show that’s meaningful. There should be a point to every visual and you should tell people what to look for. Example: the winter months have more banana sales
>
> ### Link to data or source
>
> Don’t include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data. Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Indoor Air pollution

The data this week comes from [Our World in Data](https://ourworldindata.org/indoor-air-pollution).

> Indoor air pollution is caused by burning solid fuel sources – such as firewood, crop waste, and dung – for cooking and heating.
>
> The burning of such fuels, particularly in poor households, results in air pollution that leads to respiratory diseases which can result in premature death. The WHO calls indoor air pollution “the world’s largest single environmental health risk.”

-   [Indoor air pollution is a leading risk factor for premature death.](https://ourworldindata.org/indoor-air-pollution#indoor-air-pollution-is-one-of-the-leading-risk-factors-for-premature-death)

-   [**4.1%** of global deaths are attributed to indoor air pollution.](https://ourworldindata.org/indoor-air-pollution#indoor-air-pollution-is-one-of-the-leading-risk-factors-for-premature-death)

-   [Death rates from air pollution are highest in low-income countries. There’s a greater than 1000-fold difference between low- and high-income countries.](https://ourworldindata.org/indoor-air-pollution#death-rates-are-highest-across-low-income-countries)

-   [The world is making progress: global deaths from indoor air pollution have declined substantially since 1990.](https://ourworldindata.org/indoor-air-pollution#death-rates-have-declined-in-almost-all-countries-in-the-world)

-   [Death rates from indoor air pollution have declined in almost every country in the world since 1990.](https://ourworldindata.org/indoor-air-pollution#death-rates-have-declined-in-almost-all-countries-in-the-world)

-   [Indoor air pollution results from a reliance of solid fuels for cooking.](https://ourworldindata.org/indoor-air-pollution#indoor-air-pollution-results-from-poor-access-to-clean-cooking-fuels)

-   [Only 60% of the world has access to clean fuels for cooking. This share has been steadily increasing.](https://ourworldindata.org/indoor-air-pollution#only-60-of-the-world-has-access-to-clean-cooking-fuels)

-   [The use of solid fuels for cooking has been declining across world regions, but is still high.](https://ourworldindata.org/indoor-air-pollution#use-of-solid-fuels-for-cooking-is-still-high-but-it-is-falling)

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-04-12')
tuesdata <- tidytuesdayR::tt_load(2022, week = 15)

indoor_pollution <- tuesdata$indoor_pollution

# Or read in the data manually

indoor_pollution <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-04-12/indoor_pollution.csv')

```

### Data Dictionary

# `fuel_access.csv`

| variable                                                             | class     | description                                                          |
|:----------------------------------------------|:------------|:------------|
| Entity                                                               | character | Country name                                                         |
| Code                                                                 | character | Country code                                                         |
| Year                                                                 | double    | Year                                                                 |
| Access to clean fuels and technologies for cooking (% of population) | double    | Access to clean fuels and technologies for cooking (% of population) |

# `fuel_gdp.csv`

| variable                                                             | class     | description |
|:----------------------------------------------|:------------|:------------|
| Entity                                                               | character | .           |
| Code                                                                 | character | .           |
| Year                                                                 | double    | .           |
| Access to clean fuels and technologies for cooking (% of population) | double    | .           |
| GDP per capita, PPP (constant 2017 international \$)                 | double    | .           |
| Population (historical estimates)                                    | double    | .           |
| Continent                                                            | character | .           |

# `death_source.csv`

| variable                                                                                                               | class     | description |
|:--------------------------------------------------|:----------|:----------|
| Entity                                                                                                                 | character | .           |
| Code                                                                                                                   | character | .           |
| Year                                                                                                                   | double    | .           |
| Deaths - Cause: All causes - Risk: Household air pollution from solid fuels - Sex: Both - Age: Age-standardized (Rate) | double    | .           |

# `death_full.csv`

| variable                                                                                                               | class     | description |
|:--------------------------------------------------|:----------|:----------|
| Entity                                                                                                                 | character | .           |
| Code                                                                                                                   | character | .           |
| Year                                                                                                                   | double    | .           |
| Deaths - Cause: All causes - Risk: Household air pollution from solid fuels - Sex: Both - Age: Age-standardized (Rate) | double    | .           |
| Access to clean fuels and technologies for cooking (% of population)                                                   | double    | .           |
| Population (historical estimates)                                                                                      | double    | .           |
| Continent                                                                                                              | character | .           |

# `death_timeseries.csv`

| variable                                                                                                             | class     | description |
|:--------------------------------------------------|:----------|:----------|
| Entity                                                                                                               | character | .           |
| Code                                                                                                                 | character | .           |
| Year...3                                                                                                             | double    | .           |
| Deaths - Cause: All causes - Risk: Household air pollution from solid fuels - Sex: Both - Age: All Ages (Number)...4 | double    | .           |
| Deaths - Cause: All causes - Risk: Household air pollution from solid fuels - Sex: Both - Age: All Ages (Number)...5 | double    | .           |
| Year...6                                                                                                             | double    | .           |
| Continent                                                                                                            | character | .           |

# `indoor_pollution.csv`

| variable                                                                                                             | class     | description |
|:--------------------------------------------------|:----------|:----------|
| Entity                                                                                                               | character | .           |
| Code                                                                                                                 | character | .           |
| Year...3                                                                                                             | double    | .           |
| Deaths - Cause: All causes - Risk: Household air pollution from solid fuels - Sex: Both - Age: All Ages (Number)...4 | double    | .           |
| Deaths - Cause: All causes - Risk: Household air pollution from solid fuels - Sex: Both - Age: All Ages (Number)...5 | double    | .           |
| Year...6                                                                                                             | double    | .           |
| Continent                                                                                                            | character | .           |

### Cleaning Script
