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

# Wastewater Plants

The data this week comes from [Macedo et al, 2022](https://figshare.com/articles/dataset/HydroWASTE_version_1_0/14847786/1) by way of [Data is Plural](https://www.data-is-plural.com/archive/2022-05-04-edition/).

See the [Distribution and characteristics of wastewater treatment plants within the global river network](https://essd.copernicus.org/articles/14/559/2022/#section4)

> How to cite. 

```code
Ehalt Macedo, H., Lehner, B., Nicell, J., Grill, G., Li, J., Limtong, A., and Shakya, R.: Distribution and characteristics of wastewater treatment plants within the global river network, Earth Syst. Sci. Data, 14, 559–577, https://doi.org/10.5194/essd-14-559-2022, 2022.
```

> The main objective of wastewater treatment plants (WWTPs) is to remove pathogens, nutrients, organics, and other pollutants from wastewater. After these contaminants are partially or fully removed through physical, biological, and/or chemical processes, the treated effluents are discharged into receiving waterbodies. However, since WWTPs cannot remove all contaminants, especially those of emerging concern, they inevitably represent concentrated point sources of residual contaminant loads into surface waters. To understand the severity and extent of the impact of treated-wastewater discharges from such facilities into rivers and lakes, as well as to identify opportunities of improved management, detailed information about WWTPs is required, including (1) their explicit geospatial locations to identify the waterbodies affected and (2) individual plant characteristics such as the population served, flow rate of effluents, and level of treatment of processed wastewater. These characteristics are especially important for contaminant fate models that are designed to assess the distribution of substances that are not typically included in environmental monitoring programs. Although there are several regional datasets that provide information on WWTP locations and characteristics, data are still lacking at a global scale, especially in developing countries. Here we introduce a spatially explicit global database, termed HydroWASTE, containing 58,502 WWTPs and their characteristics. This database was developed by combining national and regional datasets with auxiliary information to derive or complete missing WWTP characteristics, including the number of people served. A high-resolution river network with streamflow estimates was used to georeference WWTP outfall locations and calculate each plant's dilution factor (i.e., the ratio of the natural discharge of the receiving waterbody to the WWTP effluent discharge). The utility of this information was demonstrated in an assessment of the distribution of treated wastewater at a global scale. Results show that 1,200,000 km of the global river network receives wastewater input from upstream WWTPs, of which more than 90 000 km is downstream of WWTPs that offer only primary treatment. Wastewater ratios originating from WWTPs exceed 10 % in over 72,000 km of rivers, mostly in areas of high population densities in Europe, the USA, China, India, and South Africa. In addition, 2533 plants show a dilution factor of less than 10, which represents a common threshold for environmental concern. HydroWASTE can be accessed at https://doi.org/10.6084/m9.figshare.14847786.v1 (Ehalt Macedo et al., 2021).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-09-20')
tuesdata <- tidytuesdayR::tt_load(2022, week = 38)

HydroWASTE_v10 <- tuesdata$HydroWASTE_v10

# Or read in the data manually

HydroWASTE_v10 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-09-20/HydroWASTE_v10.csv')

```
### Data Dictionary

# `HydroWASTE_v10.csv`

Column description:

|col        |description                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|:----------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|WASTE_ID   |ID of WWTP in HydroWASTE                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|SOURCE     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|ORG_ID     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|WWTP_NAME  |Name of the WWTP from national/regional dataset (empty if not reported)                                                                                                                                                                                                                                                                                                                                                                                                   |
|COUNTRY    |                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|CNTRY_ISO  |Country ISO                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|LAT_WWTP   |Latitude of reported WWTP location                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|LON_WWTP   |Longitude of reported WWTP location                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|QUAL_LOC   |Quality indicator related to reported WWTP location (see SI of reference paper for more information): 1 = high (tests indicated >80% of reported WWTP locations in country/region to be accurate); 2 = medium (tests indicated between 50% and 80% of reported WWTP locations in country/region to be accurate); 3 = low (tests indicated <50% of reported WWTP locations in country/region to be accurate); 4 = Quality of WWTP locations in country/region not analysed |
|LAT_OUT    |                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|LON_OUT    |                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|STATUS     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|POP_SERVED |Population served by the WWTP                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|QUAL_POP   |Quality indicator related to the attribute "population served" (see reference paper for more information): 1 = Reported as ‘population served’ by national/regional dataset; 2 = Reported as ‘population equivalent’ by national/regional dataset; 3 = Estimated (with wastewater discharge available); 4 = Estimated (without wastewater discharge available)                                                                                                            |
|WASTE_DIS  |Treated wastewater discharged by the WWTP in m3 d-1                                                                                                                                                                                                                                                                                                                                                                                                                       |
|QUAL_WASTE |Quality indicator related to the attribute "Treated wastewater discharged" (see reference paper for more information): 1 = Reported as ‘treated’ by national/regional dataset; 2 = Reported as ‘design capacity’ by national/regional dataset; 3 = Reported but type not identified; 4 = Estimated                                                                                                                                                                        |
|LEVEL      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|QUAL_LEVEL |Quality indicator related to the attribute "level of treatment" (see reference paper for more information): 1 = Reported by national/regional dataset; 2 = Estimated                                                                                                                                                                                                                                                                                                      |
|DF         |                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|HYRIV_ID   |ID of associated river reach in RiverATLAS at estimated outfall location (link to HydroATLAS database; empty if estimated outfall location is the ocean or an endorheic sink)                                                                                                                                                                                                                                                                                             |
|RIVER_DIS  |Estimated river discharge at the WWTP outfall location in m3 s-1 (derived from HydroATLAS database; empty if estimated outfall location is the ocean)                                                                                                                                                                                                                                                                                                                     |
|COAST_10KM |1 = Estimated outfall location within 10 km of the ocean or a large lake (surface area larger than 500 km2); 0 = Estimated outfall location further than 10 km of the ocean or a large lake (surface area larger than 500 km2)                                                                                                                                                                                                                                            |
|COAST_50KM |1 = Estimated outfall location within 50 km of the ocean or a large lake (surface area larger than 500 km2); 0 = Estimated outfall location further than 50 km of the ocean or a large lake (surface area larger than 500 km2)                                                                                                                                                                                                                                            |
|DESIGN_CAP |Design capacity of WWTP as reported in national/regional dataset (empty if not reported)                                                                                                                                                                                                                                                                                                                                                                                  |
|QUAL_CAP   |Quality indicator related to the attribute "design capacity": 1 = Reported as design capacity in m3 d-1; 2 = Reported as design capacity in 'population equivalent'; 3 = Not reported                                                                                                                                                                                                                                                                                     |
### Cleaning Script

