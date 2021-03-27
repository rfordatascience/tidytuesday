![Photo of makeup compact of various shades on marble table, photo credit to Element5 Digital by way of Unsplash](https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1365&q=80)

# Makeup Shades

The data this week comes from [The Pudding](https://github.com/the-pudding/data/tree/master/foundation-names). They have a corresponding [article](https://pudding.cool/2021/03/foundation-names/) related to this data.

> First Place. Lead Role. Number One. When things are arranged in a sequence, we have a mild obsession with being the “first.” You want the blue ribbon. To be on the first page of search results. To have your story above the fold. Afterall, we prioritize the things that come first.
> 
> When beauty brands label their foundation shades with sequential numbers, they are implicitly prioritizing those at the beginning of the sequence. These products become more accessible to customers because they are often higher on store shelves and are not hidden behind the “See More” button on websites..
> 
> We found 130 products on Sephora’s and Ulta’s websites that use a sequential number system to label their shades. Of those, 97% put their lighter shades, and thus the customers that use those shades, first.

This is an interesting dataset, and many thanks to [Ofunne Amaka](https://pudding.cool/author/ofunne-amaka) and [Amber Thomas](https://pudding.cool/author/amber-thomas) for sharing the article, the data, and the code behind the article. There's a lot to the actual data collection itself, as there's a lot of regex, data cleaning, web scraping, etc.

You can work with the text data here, counts, or try and recreate some of the plots from the Pudding.

Another note is that Offune and Amber have optionally allowed for the ["scrollytelling" to be turned off](https://twitter.com/ProQuesAsker/status/1375159092684058626?s=20). This is in an effort to have better accessibility of the article. 


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-03-30')
tuesdata <- tidytuesdayR::tt_load(2021, week = 14)

sephora <- tuesdata$sephora

# Or read in the data manually

sephora <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/sephora.csv')
ulta <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/ulta.csv')
allCategories <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/allCategories.csv')
allShades <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/allShades.csv')
allNumbers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/allNumbers.csv')

```
### Data Dictionary

# `sephora.csv`

| Header      | Description                                                                                                                                                                        | Data Type |
| :---------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------- |
| brand       | The brand of foundation                                                                                                                                                            | character |
| product     | The product name                                                                                                                                                                   | character |
| url         | URL to the product page                                                                                                                                                            | character |
| description | The description associated with a particular swatch (e.g., “Shade 1 (fair cool)”) as displayed on the product page                                                                 | character |
| imgSrc      | The incomplete url to the image displaying a swatch of this particular foundation shade (*note*: to complete the url, `https://sephora.com` needs to be appended to the beginning) | character |
| imgAlt      | The alt text attribute for a particular swatch, as is made available to assistive technology                                                                                       | character |
| name        | The programmatically extracted word-based name of this particular shade                                                                                                            | character |
| specific    | The number or number/letter combination (e.g., “12CN”) used to label a particular shade                                                                                            | character |

# `ulta.csv`

| Header      | Description                                                                                                        | Data Type |
| :---------- | :----------------------------------------------------------------------------------------------------------------- | :-------- |
| brand       | The brand of foundation                                                                                            | character |
| product     | The product name                                                                                                   | character |
| url         | URL to the product page                                                                                            | character |
| description | The description associated with a particular swatch (e.g., “Shade 1 (fair cool)”) as displayed on the product page | character |
| imgSrc      | The complete url to the image displaying a swatch of this particular foundation shade                              | character |
| imgAlt      | The alt text attribute for a particular swatch, as is made available to assistive technology                       | character |
| name        | The programmatically extracted word-based name of this particular shade                                            | character |
| specific    | The number or number/letter combination (e.g., “12CN”) used to label a particular shade                            | character |

# `allShades.csv`

| Header      | Description                                                                                                                                                                      | Data Type |
| :---------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------- |
| brand       | The brand of foundation                                                                                                                                                          | character |
| product     | The product name                                                                                                                                                                 | character |
| url         | URL to the product page                                                                                                                                                          | character |
| description | The description associated with a particular swatch (e.g., “Shade 1 (fair cool)”) as displayed on the product page                                                               | character |
| imgSrc      | The url to the image displaying a swatch of this particular foundation shade                                                                                                     | character |
| imgAlt      | The alt text attribute for a particular swatch, as is made available to assistive technology                                                                                     | character |
| name        | The programmatically extracted word-based name of this particular shade                                                                                                          | character |
| specific    | The number or number/letter combination (e.g., “12CN”) used to label this particular shade                                                                                       | character |
| colorspace  | The colorspace used to analyze the shade (e.g., “RGB”)                                                                                                                           | character |
| hex         | The hexadecimal color code for the most prevalent color in the `imgSrc` swatch image (e.g., `#4F322C`)                                                                           | character |
| hue         | The `hue` value from the HSL color space. This is represented as a number from 0 to 360 degrees around the color wheel                                                           | numeric   |
| sat         | The `saturuation` value from the HSL color space. This represents the amount of gray in a color from 0 to 100 percent (*Note*: here, it is represented as a decimal from 0 to 1) | numeric   |
| lightness   | The `lightness` value from the HSL color space. This is represented as a decimal from 0 to 1 where 0 is pure black and 1 is pure white                                           | numeric   |

# `allCategories.csv`

| Header     | Description                                                                                                                            | Data Type |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------------- | :-------- |
| brand      | The brand of foundation                                                                                                                | character |
| product    | The product name                                                                                                                       | character |
| url        | URL to the product page                                                                                                                | character |
| imgSrc     | The url to the image displaying a swatch of this particular foundation shade                                                           | character |
| name       | The programmatically extracted word-based name of this particular shade                                                                | character |
| categories | Comma separated categories that were assigned to a given label (e.g., `food, color`)                                                   | character |
| specific   | The number or number/letter combination (e.g., “12CN”) used to label this particular shade                                             | character |
| hex        | The hexadecimal color code for the most prevalent color in the `imgSrc` swatch image (e.g., `#4F322C`)                                 | character |
| lightness  | The `lightness` value from the HSL color space. This is represented as a decimal from 0 to 1 where 0 is pure black and 1 is pure white | numeric   |

# `allNumbers.csv`

| Header      | Description                                                                                                                                                                                         | Data Type |
| :---------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------- |
| brand       | The brand of foundation                                                                                                                                                                             | character |
| product     | The product name                                                                                                                                                                                    | character |
| name        | The programmatically extracted word-based name of this particular shade                                                                                                                             | character |
| specific    | The number or number/letter combination (e.g., “12CN”) used to label a particular shade                                                                                                             | character |
| lightness   | The `lightness` value from the HSL color space. This is represented as a decimal from 0 to 1                                                                                                        | numeric   |
| hex         | The hexadecimal color code for the most prevalent color in the `imgSrc` swatch image (e.g., `#4F322C`)                                                                                              | character |
| lightToDark | Whether this product line organizes their colors from light to dark (*Note*: a value of `NA` indicates that a product uses a number-based naming system, but **not** a sequential numbering system) | logical   |
| numbers     | The numbers associated with a particular shade                                                                                                                                                      | numeric   |
| id          | A generated ID number assigned to each individual product                                                                                                                                           | numeric   |

### Cleaning Script

The actual cleaning script from Amber Thomas is available on [The Pudding's Github](https://github.com/the-pudding/data/tree/master/foundation-names#allshadescsv--allshadesr).