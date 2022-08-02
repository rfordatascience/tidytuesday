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

# Oregon Spotted Frog

Data this week come from [USGS](https://www.sciencebase.gov/catalog/item/60ba5a00d34e86b9388d86bc). Read more about them at [USGS.gov](https://www.usgs.gov/centers/forest-and-rangeland-ecosystem-science-center/science/oregon-spotted-frog)

Oregon spotted frog (Rana pretiosa) telemetry and habitat use at Crane Prairie Reservoir in Oregon, USA.

Radio-telemetry has been used to study late-season movement and habitat use by Oregon spotted frogs (Rana pretiosa) at Crane Prairie Reservoir in Oregon. This dataset includes individual frog location data and habitat use during each tracking event that occurred roughly weekly between September and late November of 2018.

"...study adds to the limited data on late-season activity and habitat use in R. pretiosa. Information on seasonal habitat use, movement between seasonal habitat types, and habitats that are particularly valuable for maintaining populations is important to conservation and management. We tracked frogs within the main reservoir and in surrounding pond and river habitats, allowing for comparisons of movement relative to different habitat types and predatory threats."

Citation
Pearl, C.A., Rowe, J.C., McCreary, B., and Adams, M.J., 2022, Oregon spotted frog (Rana pretiosa) telemetry and habitat use at Crane Prairie Reservoir in Oregon, USA: U.S. Geological Survey data release, https://doi.org/10.5066/P9DACPCV.

More resources:
- https://en.wikipedia.org/wiki/Oregon_spotted_frog
- https://wdfw.wa.gov/species-habitats/species/rana-pretiosa
- https://amphibiaweb.org/species/5131


Keywords: #Aquatic Biology, #Ecology, #Wildlife Biology

Raw data available at: <https://www.sciencebase.gov/catalog/item/60ba5a00d34e86b9388d86bc>

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-08-02')
tuesdata <- tidytuesdayR::tt_load(2022, week = 31)

frogs <- tuesdata$frogs

# Or read in the data manually

frogs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-08-02/frogs.csv')

```

### Data Dictionary

|variable        |class     |description |
|:---------------|:---------|:-----------|
|Site      |character|location |
|Subsite   |character | location second level (Cow Camp Pond,Cow Camp River,N Res,NE Res,SE Pond,W Res) |
|HabType   | character | location third level (Pond,Reservoir,River)|
|SurveyDate| character | date |
|Ordinal   | character | Ordinal day from January 1, 2018 on which telemetry data were collected |
|Frequency | character | Unique transmitter frequency associated with each individual frog |
|UTME_83   | character | UTM coordinates (1,000-meter grid squares into tenths or hundredths)|
|UTMN_83   | character | UTM coordinates (1,000-meter grid squares into tenths or hundredths) |
|Interval  | character | integer (0 to 12)|
|Female    | character | gender - binary (0,1)|
|Water     | character | water (Deep water,No water,Shallow water,Unknown water) |
|Type      | character | water type (Marsh/Pond,Non-aquatic,Reservoir,Stream/Canal)|
|Structure | character | structure (Herbaceous veg,Leaf litter,Open,Woody debris,Woody veg)|
|Substrate | character | substrate (Flocc,Mineral soil,Organic soil,Unknown substrate)|
|Beaver    | character | beaver (Burrow,Channel/runway,Lodge,No beaver) |
|Detection | character | detection type (Captured,No visual,Visual)|

### Cleaning script
```{r}
library(tidyverse)
frog <- read_csv("2022/2022-08-02/Oregon_spotted_frog_telemetry_at_Crane_Prairie_OR.csv",
  col_names = TRUE,
  trim_ws = FALSE,
  skip = 2
)

```

