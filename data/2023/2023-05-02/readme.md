### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics
for `#TidyTuesday`.

Twitter provides
[guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions)
for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an
[article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81)
on writing *good* alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> \### Chart type It's helpful for people with partial sight to know
> what chart type it is and gives context for understanding the rest of
> the visual. Example: Line graph \### Type of data What data is
> included in the chart? The x and y axis labels may help you figure
> this out. Example: number of bananas sold per day in the last year
> \### Reason for including the chart Think about why you're including
> this visual. What does it show that's meaningful. There should be a
> point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales \### Link to data or
> source Don't include this in your alt text, but it should be included
> somewhere in the surrounding text. People should be able to click on a
> link to view the source data or dig further into the visual. This
> provides transparency about your source and lets people explore the
> data. Example: Data from the USDA

Penn State has an
[article](https://accessibility.psu.edu/images/charts/) on writing alt
text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users.
> But since they are images, these media provide serious accessibility
> issues to colorblind users and users of screen readers. See the
> [examples on this page](https://accessibility.psu.edu/images/charts/)
> for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post
tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with
alt text programatically.

Need a **reminder**? There are
[extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related)
that force you to remember to add Alt Text to Tweets with media.

# The Portal Project

The data this week comes from the [Portal
Project](https://portal.weecology.org/). This is a long-term ecological
research site studying the dynamics of desert rodents, plants, ants and
weather in Arizona.

> The Portal Project is a long-term ecological study being conducted
> near Portal, AZ. Since 1977, the site has been used to study the
> interactions among rodents, ants and plants and their respective
> responses to climate. To study the interactions among organisms, they
> experimentally manipulate access to 24 study plots. This study has
> produced over 100 scientific papers and is one of the longest running
> ecological studies in the U.S.

The [Weecology research group](https://www.weecology.org/) monitors
rodents, plants, ants, and weather. All data from the Portal Project are
made openly available in near real-time so that they can provide the
maximum benefit to scientific research and outreach. The core dataset is
managed using an automated living data workflow run using GitHub and
Continuous Analysis.

This dataset focuses on the rodent data. Full data is available through
these resources:

-   [GitHub Data Repository](https://github.com/weecology/PortalData)
-   [Live Updating Zenodo
    Archive](https://doi.org/10.5281/zenodo.1215988)
-   [Data
    Paper](https://www.biorxiv.org/content/early/2018/05/28/332783)
-   [Methods
    Documentation](https://github.com/weecology/PortalData/blob/master/SiteandMethods/Methods.md)

The Portal Project data can also be accessed through the Data Retriever,
a package manager for data.

[Data Retriever](https://www.data-retriever.org/)

A teaching focused version of the dataset is also maintained with some
of the complexities of the data removed to make it easy to use for
computational training purposes. This dataset serves as the core dataset
for the [Data Carpentry
Ecology](https://datacarpentry.org/ecology-workshop/) material and has
been downloaded almost 50,000 times.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-05-02')
tuesdata <- tidytuesdayR::tt_load(2023, week = 18)

plots <- tuesdata$plots
species <- tuesdata$species
surveys <- tuesdata$surveys


# Or read in the data manually

plots <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-02/plots.csv')
species <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-02/species.csv')
surveys <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-02/surveys.csv')


```

### Data Dictionary

# `plots.csv`

| variable  | class     | description    |
|:----------|:----------|:---------------|
| plot      | double    | Plot number    |
| treatment | character | Treatment type |

# `species.csv`

| variable       | class     | description             |
|:---------------|:----------|:------------------------|
| species        | character | Species                 |
| scientificname | character | Scientific Name         |
| taxa           | character | Taxa                    |
| commonname     | character | Common Name             |
| censustarget   | double    | Target species (0 or 1) |
| unidentified   | double    | Unidentified (0 or 1)   |
| rodent         | double    | Rodent (0 or 1)         |
| granivore      | double    | Granivore (0 or 1)      |
| minhfl         | double    | Minimum hindfoot length |
| meanhfl        | double    | Mean hindfoot length    |
| maxhfl         | double    | Maximum hindfoot length |
| minwgt         | double    | Minimum weight          |
| meanwgt        | double    | Mean weight             |
| maxwgt         | double    | Maximum weight          |
| juvwgt         | double    | Juvenile weight         |

# `surveys.csv`

| variable   | class     | description                                                    |
|:-----------------------|:---------------------|:-------------------------|
| censusdate | double    | Census date                                                    |
| month      | double    | Month                                                          |
| day        | double    | Day                                                            |
| year       | double    | Year                                                           |
| treatment  | character | Treatment type                                                 |
| plot       | double    | Plot number                                                    |
| stake      | double    | Stake number                                                   |
| species    | character | Species code                                                   |
| sex        | character | Sex                                                            |
| reprod     | character | Reproductive condition                                         |
| age        | character | Age                                                            |
| testes     | character | Testes (Scrotal, Recent, or Minor)                             |
| vagina     | character | Vagina (Swollen, Plugged, or Both)                             |
| pregnant   | character | Pregnant                                                       |
| nipples    | character | Nipples (Enlarged, Swollen, or Both)                           |
| lactation  | character | Lactating                                                      |
| hfl        | double    | Hindfoot length                                                |
| wgt        | double    | Weight                                                         |
| tag        | character | Primary individual identifier                                  |
| note2      | character | Newly tagged individual for 'tag'                              |
| ltag       | character | Secondary tag information when ear tags were used in both ears |
| note3      | character | Newly tagged individual for 'ltag'                             |

### Cleaning Script

Thanks to @ethanwhite for the data cleaning script. This script
downloads the data using the [{portalr}](https://weecology.github.io/portalr/) package. It filters for the
species and plot data, and years greater than 1977.

``` r
# All packages used in this script:
library(portalr)
library(dplyr)

download_observations(".")
data_tables <- load_rodent_data()

species_data <- data_tables[["species_table"]]
plots_data <- data_tables[["plots_table"]]

plot_treatments <- plots_data %>%
  filter(year > 1977) |>
  mutate(iso_date = as.Date(paste0(year, "-", month, "-", "01")), 
         plot = as.factor(plot)) %>%
  select(iso_date, plot, treatment)

plots_data_longterm <- plot_treatments |>
  group_by(plot) |>
  summarize(treatment = case_when(
              all(treatment == "control") ~ "control",
              all(treatment == "exclosure") ~ "exclosure")) |>
  filter(!is.na(treatment))

species_data <- species_data |>
  filter(censustarget == 1, unidentified == 0)

survey_data <- summarize_individual_rodents(
  time = "date",
  length = "Longterm") |>
  filter(year > 1977) |>
  filter(species %in% unique(species_data$species))

write.csv(survey_data, "surveys.csv", row.names = FALSE, na = "")
write.csv(plots_data_longterm, "plots.csv", row.names = FALSE, na = "")
write.csv(species_data, "species.csv", row.names = FALSE, na = "")
```
