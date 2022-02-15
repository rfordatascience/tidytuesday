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

# DuBois Challenge

The data this week comes from [Anthony Starks](https://github.com/ajstarks/dubois-data-portraits/tree/master/challenge/2022) as part of the `#DuBoisChallenge2022`. Credit to [Anthony Starks](https://twitter.com/ajstarks), [Allen Hillery](https://twitter.com/AlDatavizguy) and [Sekou Tyler](https://twitter.com/sqlsekou) for creating and executing this challenge!

The WEB DuBois challenge is live for 10 weeks, and you can use the `#DuBoisChallenge2022` hashtag to participate in this challenge. Full details available in the [DuBois data portraits repo](https://github.com/ajstarks/dubois-data-portraits/tree/master/challenge/2022). Anthony Starks has written an excellent article covering the details of last year's challenge and this year's new challenge in the [Nightingale by DVS](https://nightingaledvs.com/the-dubois-challenge/).

While there are several datasets in that repo, there is also the option to BYOD (Bring your own data)! Details below from the repo. The primary request is to try and recreate the ["Duboisian" style](https://github.com/ajstarks/dubois-data-portraits/blob/master/dubois-style.pdf). 

> # Du Bois Visualization Challenge: 2022

![A screenshot of the 10 visualizations from the DuBois Challenge. Each has a color scheme of bright yellow, blue, black, or green. A unique aspect is the use of curves/circles to indicate the number.](cat2022.png)

> The goal of the challenge is to celebrate the data visualization legacy of W.E.B Du Bois by recreating the visualizations from the 1900 Paris Exposition using modern tools.

> This directory contains the data and original plates from the exposition; your goal is to re-create the visualizations using modern tools of your choice (Tableau, R, ggplot, Stata, PowerBI, decksh, etc)

> There is a folder for each challenge, which includes the images of the 1900 original plates along with the corresponding data. You may submit your re-creations to twitter using the hash tag `#DuBoisChallenge2022`

> ## The Challenges

> -   challenge01: The Georgia Negro (plate 1)
> -   challenge02: Assessed Valuation of all Taxable Property Owned by Georgia Negroes  (plate 22)
> -   challenge03: Relative Negro Population of the States of the United States (plate 2)
> -   challenge04: Valuation of Town and City Property Owned by Georgia Negroes (plate 21)
> -   challenge05: Slave and Free Negroes (plate 12)
> -   challenge06: Illiteracy (plate 14)
> -   challenge07: Conjugal condition of American Negroes according to age periods (plate 53)
> -   challenge08: Assessed Value of Household and Kitchen Furniture Owned by Georgia  Negroes. (plate 25)
> -   challenge09: Number Of Negro Students Taking The Various Courses Of Study Offered In Georgia Schools (plate 17)
> -   challenge10: Proportion Of Total Negro Children Of School Age Who Are Enrolled In The Public Schools (plate 49)
>
> ## References

> To learn about how I re-created the visualizations using [decksh](https://speakerdeck.com/ajstarks/decksh-a-little-language-for-decks), see: [Recreating the Dubois Data Portraits](https://speakerdeck.com/ajstarks/recreating-the-dubois-data-portraits). This presentation contains the full catalog of re-creations at the end.

> Also, here is a quick guide to the ["Duboisian" style](https://github.com/ajstarks/dubois-data-portraits/blob/master/dubois-style.pdf).

Data available in the [GitHub repo](https://github.com/ajstarks/dubois-data-portraits/tree/master/challenge/2022).

### Cleaning Script
