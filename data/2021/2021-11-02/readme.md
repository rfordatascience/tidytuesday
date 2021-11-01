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

# Making maps with R

November is the `#30DayMapChallenge` month! More details can be found on the [30DayMapChallenge GH page](https://github.com/tjukanovt/30DayMapChallenge).

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">🎉Categories for <a href="https://twitter.com/hashtag/30DayMapChallenge?src=hash&amp;ref_src=twsrc%5Etfw">#30DayMapChallenge</a> 2021 🎉<br><br>Join in to create maps around these themes. Use your creativity and share your results with others! Starts 01/11/2021. <br><br>More information: <a href="https://t.co/OmTLB6u2cL">https://t.co/OmTLB6u2cL</a> <a href="https://t.co/IzWAw21ns6">pic.twitter.com/IzWAw21ns6</a></p>&mdash; Topi Tjukanov (@tjukanov) <a href="https://twitter.com/tjukanov/status/1443868144905428992?ref_src=twsrc%5Etfw">October 1, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

The data this week comes from [`spData` package](https://nowosad.github.io/spData/) and the [`spDataLarge` package](https://github.com/Nowosad/spDataLarge). The files are loaded inside those packages, so rather than loading the data as typical, please install those packages and use the data from there.

Some example code from [Geocompution with R book](https://geocompr.robinlovelace.net/adv-map.html).

Rather than supplying datasets, this week we'll be exploring the excellent [Geocomputation with R book](https://geocompr.robinlovelace.net/).

### Get the data here

```{r}
# Get the Data

library(spData)

# note that spDataLarge needs to be installed via:
# install.packages("spDataLarge", 
# repos = "https://nowosad.github.io/drat/", type = "source")
library(spDataLarge) 
```

### Cleaning Script

```
library(sf)
library(raster)
library(dplyr)
library(spData)

# note that this needs to be installed like
# install.packages("spDataLarge", 
# repos = "https://nowosad.github.io/drat/", type = "source")

library(spDataLarge) 


library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2) # tidyverse data visualization package

# Add fill layer to nz shape
tm_shape(nz) +
  tm_fill() 
# Add border layer to nz shape
tm_shape(nz) +
  tm_borders() 
# Add fill and border layers to nz shape
tm_shape(nz) +
  tm_fill() +
  tm_borders() 

map_nz = tm_shape(nz) + tm_polygons()
class(map_nz)
#> [1] "tmap"
#> 
map_nz1 = map_nz +
  tm_shape(nz_elev) + tm_raster(alpha = 0.7)

nz_water = st_union(nz) %>% st_buffer(22200) %>% 
  st_cast(to = "LINESTRING")
map_nz2 = map_nz1 +
  tm_shape(nz_water) + tm_lines()

map_nz3 = map_nz2 +
  tm_shape(nz_height) + tm_dots()

tmap_arrange(map_nz1, map_nz2, map_nz3)

```