![Logo for the TidyTuesday project, represented by the word TidyTuesday over a messy splash of black paint](static/tt_logo.png)

## About TidyTuesday

- `TidyTuesday` is a weekly social data project. All are welcome to participate! Please remember to share the code used to generate your results!
- `TidyTuesday` is organized by the R4DS Online Learning Community. [Join our Slack](https://r4ds.io/join) for free online help with R and other data-related topics, or to participate in a data-related book club!

## Goals

Our over-arching goal for TidyTuesday is to make learning to work with data easier, by providing real-world datasets.

Our goal for 2023-2024 is to increase usage of #TidyTuesday within classrooms.
We would like to be used in at least 10 courses by September 2024.
If you are using TidyTuesday to teach data-related skills, [please let us know](https://forms.gle/G1Y7doYqRU89m9SE8)! 

***

## How to Participate

- Data is [posted to social media](dataset_announcements.md) every Monday morning. Follow the instructions in the new post for how to download the data.
- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](sharing.md) on social media with the #TidyTuesday hashtag.

***

## DataSets

### [2018](data/2018) | [2019](data/2019) | [2020](data/2020)  | [2021](data/2021) | [2022](data/2022) | [2023](data/2023) | [2024](data/2024)

| Week | Date | Data | Source | Article
| :---: | :---: | :--- | :--- | :---|
| 1 | `2024-01-02` | Bring your own data to start 2024! | | |
| 2 | `2024-01-09` | [Canadian NHL Player Birth Dates](data/2024/2024-01-09/readme.md) | [Statistics Canada](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1310041501&pickMembers%5B0%5D=3.1&cubeTimeFrame.startYear=1991&cubeTimeFrame.endYear=2022&referencePeriods=19910101%2C20220101), [NHL team list endpoint](https://api.nhle.com/stats/rest/en/team), [NHL API](https://api-web.nhle.com/v1/) | [Are Birth Dates Still Destiny for Canadian NHL Players?](https://jlaw.netlify.app/2023/12/04/are-birth-dates-still-destiny-for-canadian-nhl-players/) |
| 3 | `2024-01-16` | [US Polling Places 2012-2020](data/2024/2024-01-16/readme.md) | [Center for Public Integrity](https://github.com/PublicI/us-polling-places) | [National data release sheds light on past polling place changes](https://publicintegrity.org/politics/elections/ballotboxbarriers/data-release-sheds-light-on-past-polling-place-changes/) |
| 4 | `2024-01-23` | [Educational attainment of young people in English towns](data/2024/2024-01-23/readme.md) | [The UK Office for National Statistics](https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/educationandchildcare/datasets/educationalattainmentofyoungpeopleinenglishtownsdata/200708201819/youngpeoplesattainmentintownsreferencetable1.xlsx) | [Why do children and young people in smaller towns do better academically than those in larger towns?](https://www.ons.gov.uk/peoplepopulationandcommunity/educationandchildcare/articles/whydochildrenandyoungpeopleinsmallertownsdobetteracademicallythanthoseinlargertowns/2023-07-25) |
| 5 | `2024-01-30` | [Groundhog predictions](data/2024/2024-01-30/readme.md) | [Groundhog-day.com API](https://groundhog-day.com/api) | [Groundhog-day.com Predictions by Year](https://groundhog-day.com/predictions) |
| 6 | `2024-02-06` | [World heritage sites](data/2024/2024-02-06/readme.md) | [UNESCO World Heritage Sites](https://whc.unesco.org/en/list) | [1 dataset 100 visualizations](https://100.datavizproject.com/) |


***  

## Citing TidyTuesday

To cite the `TidyTuesday` repo/project in publications use:

  R4DS Online Learning Community (2023). Tidy Tuesday: A weekly social data project.
  https://github.com/rfordatascience/tidytuesday.

A BibTeX entry for LaTeX users is

```
  @misc{tidytuesday, 
    title = {Tidy Tuesday: A weekly social data project}, 
    author = {R4DS Online Learning Community}, 
    url = {https://github.com/rfordatascience/tidytuesday}, 
    year = {2023} 
  }
```

Note: If you would like to cite the [tidytuesdayR](https://thebioengineer.github.io/tidytuesdayR/) package, you should use `citation("tidytuesdayR")` instead.

***

## Submitting Datasets

`TidyTuesday` is built around open datasets that are found in the "wild" or submitted as [Issues](https://github.com/rfordatascience/tidytuesday/issues) on our GitHub.

If you find a dataset that you think would be interesting, you can approach it through two ways:

### Submit the dataset as an Issue

1. Find an interesting dataset  
2. Find a report, blog post, article, etc relevant to the data   
3. Submit the dataset as an [Issue](https://github.com/rfordatascience/tidytuesday/issues) along with a link to the article (and, ideally, 2 images from the article, with alt text)

### Create an entire TidyTuesday challenge!  

1. Find an interesting dataset  
2. Find a report, blog post, article, etc relevant to the data (or create one yourself!)  
3. Let us know you've found something interesting and are working on it by filing an [Issue](https://github.com/rfordatascience/tidytuesday/issues) on our GitHub  
4. Provide a link or the raw data and a cleaning script for the data  
5. Write a basic `readme.md` file using a recent `readme.md` as a template. Make sure to give yourself credit! 
