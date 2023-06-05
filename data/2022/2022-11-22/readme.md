### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> ### Chart type
> It's helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you're including this visual. What does it show that's meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don't include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Museums

The data this week comes from [Mapping Museums project](https://museweb.dcs.bbk.ac.uk/data).

> The project's research team has gathered, cleansed, and codified data relating to over 4000 UK museums - almost double the number of museums covered in any previous survey. It covers the period from 1960 to date. The challenges we faced and the processes we adopted to collect, integrate, and cleanse the data are described in our publications
>
> The following files are available for download, which capture the status of the Mapping Museums database at the formal end of the project in September 2021:
> 
> License: The above data is free to use under the terms of the Creative Commons (BY) license. This allows users to copy, distribute, remix, and build upon the research, so long the Mapping Museums team is credited with its original creation.
> 
> Please use the following citation if you do download the data: Data downloaded from the Mapping Museums website at www.mappingmuseums.org, Accessed on 2022-11-22.
> 
> Also, we would be very interested to know how you are using, or planning to use, this data. Please use the [Get in Touch](https://museweb.dcs.bbk.ac.uk/contact) link to tell us about your work.

Glossary of terms: https://museweb.dcs.bbk.ac.uk/glossary

Key findings: https://museweb.dcs.bbk.ac.uk/findings

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-11-22')
tuesdata <- tidytuesdayR::tt_load(2022, week = 47)

museums <- tuesdata$museums

# Or read in the data manually

museums <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-11-22/museums.csv')

```
### Data Dictionary

# `museums.csv`






|variable                               |class     |description                            |
|:--------------------------------------|:---------|:--------------------------------------|
|museum_id                              |character |museum_id                              |
|Name_of_museum                         |character |Name of_museum                         |
|Address_line_1                         |character |Address_line_1                         |
|Address_line_2                         |character |Address_line_2                         |
|Village,_Town_or_City                  |character |Village,_Town_or_City                  |
|Postcode                               |character |Postcode                               |
|Latitude                               |double    |Latitude                               |
|Longitude                              |double    |Longitude                              |
|Admin_area                             |character |Admin_area                             |
|Accreditation                          |character |Accreditation                          |
|Governance                             |character |Governance                             |
|Size                                   |character |Size                                   |
|Size_provenance                        |character |Size_provenance                        |
|Subject_Matter                         |character |Subject_Matter                         |
|Year_opened                            |character |Year_opened                            |
|Year_closed                            |character |Year_closed                            |
|DOMUS_Subject_Matter                   |character |DOMUS_Subject_Matter                   |
|DOMUS_identifier                       |double    |DOMUS_identifier                       |
|Primary_provenance_of_data             |character |Primary_provenance_of_data             |
|Identifier_used_in_primary_data_source |character |Identifier_used_in_primary_data_source |
|Area_Deprivation_index                 |double    |Area_Deprivation_index                 |
|Area_Deprivation_index_crime           |double    |Area_Deprivation_index_crime           |
|Area_Deprivation_index_education       |double    |Area_Deprivation_index_education       |
|Area_Deprivation_index_employment      |double    |Area_Deprivation_index_employment      |
|Area_Deprivation_index_health          |double    |Area_Deprivation_index_health          |
|Area_Deprivation_index_housing         |double    |Area_Deprivation_index_housing         |
|Area_Deprivation_index_income          |double    |Area_Deprivation_index_income          |
|Area_Deprivation_index_services        |double    |Area_Deprivation_index_services        |
|Area_Geodemographic_group              |character |Area_Geodemographic_group              |
|Area_Geodemographic_group_code         |character |Area_Geodemographic_group_code         |
|Area_Geodemographic_subgroup           |character |Area_Geodemographic_subgroup           |
|Area_Geodemographic_subgroup_code      |character |Area_Geodemographic_subgroup_code      |
|Area_Geodemographic_supergroup         |character |Area_Geodemographic_supergroup         |
|Area_Geodemographic_supergroup_code    |character |Area_Geodemographic_supergroup_code    |
|Notes                                  |character |Notes                                  |

### Cleaning Script

Clean data - no script
