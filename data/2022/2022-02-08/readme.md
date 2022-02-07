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

# Tuskegee Airmen

The data this week comes from the [Tuskegee Airmen Challenge](https://github.com/lang1023/Tuskegee-Airman-Challenge/blob/main/Tuskegee%20Airmen%20Challenge.xlsx) as part of the [Veterans Advocacy Tableau User Group](https://usergroups.tableau.com/airmenchallegekickoff) with data sourced from the CAF (Commemorative Air Force) [CAF](https://commemorativeairforce.org/). This dataset is released in honor of Black History Month and honors the sacrifices and challenges that these African American pilots faced in WWII and beyond. 

Credit to Ethan Lang and Timothy Blaisdell of the VA-TUG for preparing the challenge and Allen Hillery for collaborating on connecting us all and getting the challenge kicked off. Credit to Anthony Starks, Sekou Tyler, and Allen Hillery for kicking off the WEB DuBois challenge in past years and this year's challenge for 2022. If you would like to participate in the dataset this week please use the `#TuskegeeAirmenChallenge` hashtag in addition to `#TidyTuesday`

The WEB DuBois challenge is live for 10 weeks, and you can use the `#DuBoisChallenge2022` hashtag to participate in this challenge. Full details available in the [DuBois data portraits repo](https://github.com/ajstarks/dubois-data-portraits/tree/master/challenge/2022). Anthony Starks has written an excellent article covering the details of last year's challenge and this year's new challenge in the [Nightingale by DVS](https://nightingaledvs.com/the-dubois-challenge/).

Lots of great detail on the [Tuskegee Airmen Wikipedia page](https://en.wikipedia.org/wiki/Tuskegee_Airmen), and see the article by the [Dr. Daniel Haulman of the Airforce](https://github.com/lang1023/Tuskegee-Airman-Challenge/blob/main/112%20Victories_%20Aerial%20Victories%20of%20hte%20Tuskegee%20Airmen%20(1).pdf).

> The Tuskegee Airmen /tʌsˈkiːɡiː/[1] were a group of primarily African American military pilots (fighter and bomber) and airmen who fought in World War II. They formed the 332d Expeditionary Operations Group and the 477th Bombardment Group of the United States Army Air Forces. 

> The Tuskegee Airmen were the first African-American military aviators in the United States Armed Forces. During World War II, black Americans in many U.S. states were still subject to the Jim Crow laws and the American military was racially segregated, as was much of the federal government. The Tuskegee Airmen were subjected to discrimination, both within and outside of the army. 

> Before the Tuskegee Airmen, no African-American had been a U.S. military pilot. In 1917, African-American men had tried to become aerial observers but were rejected.[6] African-American Eugene Bullard served in the French air service during World War I because he was not allowed to serve in an American unit. Instead, Bullard returned to infantry duty with the French.[7]
> 
> The racially motivated rejections of World War I African-American recruits sparked more than two decades of advocacy by African-Americans who wished to enlist and train as military aviators. 
>
> Because of the restrictive nature of selection policies, the situation did not seem promising for African-Americans, since in 1940 the U.S. Census Bureau reported there were only 124 African-American pilots in the nation.[10] The exclusionary policies failed dramatically when the Air Corps received an abundance of applications from men who qualified, even under the restrictive requirements. Many of the applicants had already participated in the Civilian Pilot Training Program, unveiled in late December 1938 (CPTP). Tuskegee University had participated since 1939.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-02-08')
tuesdata <- tidytuesdayR::tt_load(2022, week = 6)

airmen <- tuesdata$airmen

# Or read in the data manually

airmen <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-08/airmen.csv')

```
### Data Dictionary

# `airmen.csv`

|variable                         |class     |description |
|:--------------------------------|:---------|:-----------|
|name                             |character | Full name |
|last_name                        |character | last name |
|first_name                       |character | First name |
|graduation_date                  |datetime    | Graduation date|
|rank_at_graduation               |character | Military rank|
|class                            |character | Class ID|
|graduated_from                   |character | Graduated from  |
|pilot_type                       |character | Pilot type|
|military_hometown_of_record      |character | Hometown of record |
|state                            |character | State of record |
|aerial_victory_credits           |character | Aerial victory credit |
|number_of_aerial_victory_credits |double    | Number of aerial victory credits |
|reported_lost                    |character | Reported lost |
|reported_lost_date               |double    | Reported lost date |
|reported_lost_location           |character | Reported lost location |
|web_profile                      |character | Web profile |

### Cleaning Script

