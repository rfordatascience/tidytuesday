![](https://3.bp.blogspot.com/-dYWcbKVsiGY/V8RFmMFnLjI/AAAAAAAAG9Y/Qr_PGmR0V8MhSXb8-rBdAsdciny-oql2ACLcB/s400/1datasaurus.png)

# Datasaurus Dozen

The data this week comes from [Alberto Cairo](http://www.thefunctionalart.com/2016/08/download-datasaurus-never-trust-summary.html) courtesy of [Steph Locke](https://twitter.com/SteffLocke) + [Lucy McGowan](https://twitter.com/LucyStats).

H/t to: [Jesus M. Castagnetto](https://github.com/rfordatascience/tidytuesday/issues/260) for sharing it with the TidyTuesday crew.

The original blogpost from [Alberto](http://www.thefunctionalart.com/2016/08/download-datasaurus-never-trust-summary.html). A quick look at the [`datasauRus` R package](https://cran.r-project.org/web/packages/datasauRus/vignettes/Datasaurus.html) from Steph and Lucy. An article on the datasets from [AutoDesk](https://www.autodesk.com/research/publications/same-stats-different-graphs).

From Steph and Lucy's [`datasauRus` Vignette](https://cran.r-project.org/web/packages/datasauRus/vignettes/Datasaurus.html):

> This package wraps the awesome Datasaurus Dozen dataset, which contains 13 sets of x-y data. Each sub-dataset has five statistics that are (almost) the same in each case. (These are the mean of x, mean of y, standard deviation of x, standard deviation of y, and Pearson correlation between x and y). However, scatter plots reveal that each sub-dataset looks very different. The dataset is intended to be used to teach students that it is important to plot their own datasets, rather than relying only on statistics.
> 
> The Datasaurus was created by Alberto Cairo in this great [blog post](http://www.thefunctionalart.com/2016/08/download-datasaurus-never-trust-summary.html).
> 
> Datasaurus shows us why visualisation is important, not just summary statistics.
> 
> He's been subsequently made even more famous in the paper [Same Stats, Different Graphs: Generating Datasets with Varied Appearance and Identical Statistics](https://www.autodeskresearch.com/publications/samestats) through Simulated Annealing by Justin Matejka and George Fitzmaurice.
> 
> In the paper, Justin and George simulate a variety of datasets that the same summary statistics to the Datasaurus but have very different distributions.
> 
> This package looks to make these datasets available for use as an advanced [Anscombe's Quartet](Anscombe's Quartet), available in R as `anscombe`.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-10-13')
tuesdata <- tidytuesdayR::tt_load(2020, week = 42)

datasaurus <- tuesdata$datasaurus

# Or read in the data manually

datasaurus <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-10-13/datasaurus.csv')

```
### Data Dictionary

# `datasaurus.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|dataset  |character | Dataset name |
|x        |double    | x-coordinate |
|y        |double    | y-coordinate |

### Cleaning Script

No data cleaning this week, but a quick vignette from Steph and Lucy:

```{r}
library(ggplot2)

ggplot(datasaurus_dozen, aes(x=x, y=y, colour=dataset))+
  geom_point()+
  theme_void()+
  theme(legend.position = "none")+
  facet_wrap(~dataset, ncol=3)
```
