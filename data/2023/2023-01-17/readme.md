### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here’s a simple formula for writing alt text for data visualization:
> ### Chart type
> It’s helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you’re including this visual. What does it show that’s meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don’t include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Art History

The data this week comes from the [arthistory data package](https://saralemus7.github.io/arthistory/)

> This dataset contains data that was used for Holland Stam’s thesis work, titled [Quantifying art historical narratives](https://research.repository.duke.edu/concern/datasets/q811kk70n?locale=en). The data was collected to assess the demographic representation of artists through editions of Janson’s History of Art and Gardner’s Art Through the Ages, two of the most popular art history textbooks used in the American education system. In this package specifically, both artist-level and work-level data was collected along with variables regarding the artists’ demographics and numeric metrics for describing how much space they or their work took up in each edition of each textbook.

> This package contains three datasets:

> * worksjanson: Contains individual work-level data by edition of Gardner’s art history textbook from 1963 until 2011. For each work, there is information about the size of the work and text as displayed in the textbook as well as details about the work’s medium and year created. Demographic data about the artist is also included.

> * worksgardner: Contains individual work-level data by edition of Gardner’s art history textbook from 1926 until 2020. For each work, there is information about the size of the work as displayed in the textbook as well as the size of the accompanying descriptive text. Demographic data about the artist is also included.

> * artists: Contains various information about artists by edition of Gardner or Janson’s art history textbook from 1926 until 2020. Data includes demographic information, space occupied in the textbook, as well as presence in the MoMA and Whitney museums.

Acknowledging arthistory

> Citation

> Lemus S, Stam H (2022). arthistory: Art History Textbook Data. https://github.com/saralemus7/arthistory, https://saralemus7.github.io/arthistory/.

Examples of analyses are included in [Holland Stam's thesis](https://github.com/hollandstam1/thesis) in Quarto files.


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-01-17')
tuesdata <- tidytuesdayR::tt_load(2023, week = 03)

arthistory <- tuesdata$arthistory

# Or read in the data manually

artists <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-17/artists.csv')

```
### Data Dictionary


# `artists.csv`

|variable                   |class     |description                |
|:--------------------------|:---------|:--------------------------|
|artist_name                |character |The name of each artist                |
|edition_number             |double    |The edition number of the textbook from either Janson's History or Art or Gardner's Art Through the Ages.             |
|year                       |double    |The year of publication for a given edition of Janson or Gardner.                   |
|artist_nationality         |character |The nationality of a given artist.        |
|artist_nationality_other   |character |The nationality of the artist. Of the total count of artists through all editions of Janson's History of Art and Gardner's Art Through the Ages, 77.32% account for French, Spanish, British, American and German. Therefore, the categorical strings of this variable are French, Spanish, British, American, German and Other   |
|artist_gender              |character |The gender of the artist              |
|artist_race                |character |The race of the artist                |
|artist_ethnicity           |character |The ethnicity of the artist           |
|book                       |character |Which book, either Janson or Gardner the particular artist at that particular time was included.                    |
|space_ratio_per_page_total |double    |The area in centimeters squared of both the text and the figure of a particular artist in a given edition of Janson's History of Art divided by the area in centimeters squared of a single page of the respective edition. This variable is continuous. |
|artist_unique_id           |double    |	The unique identifying number assigned to artists across books is denoted in alphabetical order. This variable is discrete.        |
|moma_count_to_year         |double    |The total count of exhibitions ever held by the Museum of Modern Art (MoMA) of a particular artist at a given year of publication. This variable is discrete.         |
|whitney_count_to_year      |double    |The count of exhibitions held by The Whitney of a particular artist at a particular moment of time, as highlighted by year. This variable in discrete.   |
|artist_race_nwi            |character |The non-white indicator for artist race, meaning if an artist's race is denoted as either white or non-white.          |




### Cleaning Script

No data cleaning