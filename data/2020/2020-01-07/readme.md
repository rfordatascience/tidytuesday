# Australia Fires

This week's data is all about Australia, including it's climate over time and recent fires. A good article currently is from the [New York Times](https://www.nytimes.com/interactive/2020/01/02/climate/australia-fires-map.html). The BBC also has an [article](https://www.bbc.com/news/world-australia-50951043) with maps and news, but I am not 100% convinced their use of scale for fire points is 100% appropriate. It is using the NASA FIRMS data.

A group of `#rstats` contributors have put together a list of resources for community help for those affected, please take a look at it [here](https://github.com/AusNZOpenRes/AusFires).

## Fire Data

This is an ongoing situation, and the goal of sharing data here is to spread awareness of the Australian fires. PLEASE be cautious when plotting maps of ongoing fires - there are many considerations when using the NASA "Active Fires Dataset" via FIRMS - potential pitfalls are outlined [here](https://mobile.twitter.com/maartenzam/status/1214150089117224960?s=12) and at the source from [NASA](https://earthdata.nasa.gov/earth-observation-data/near-real-time/firms/active-fire-data). It is nuanced in interpretation and plotting (1 km estimations). There is a very long [user guide](http://modis-fire.umd.edu/files/MODIS_C6_Fire_User_Guide_A.pdf) if you want to look further. 

A live update of the fires from NASA can be seen [here](https://firms.modaps.eosdis.nasa.gov/map/#z:6;c:146.8,-32.3;t:adv-points;d:2019-12-29..2020-01-05;l:firms_viirs,firms_modis_a,firms_modis_t)

A safer dataset to use is from the New South Wales Rural Fire Service - this JSON file can be rapidly turned into a map, courtesy of [Dean Marchiori](https://twitter.com/deanmarchiori/status/1212899902465822720).

`url <- "http://www.rfs.nsw.gov.au/feeds/majorIncidents.json"` contains the newest updated data, I downloaded it for today (2020-01-06).

I also found some [The Guardian](https://github.com/guardian/aus-fires-maps-2019/tree/master/processing) fire data, but it has not been updated. Some shapefiles/json/geojson though.

### Climate Data

[Nicholas Tierney](https://twitter.com/nj_tierney) has a good overview of plotting Australian climate data on [GitHub](https://github.com/njtierney/ozviridis). THe original heatmap is [here](http://www.bom.gov.au/jsp/awap/temp/index.jsp).

The overall climate of Australia can be found on [Wikipedia](https://en.wikipedia.org/wiki/Climate_of_Australia). The list of cities by population is [here](https://en.wikipedia.org/wiki/List_of_cities_in_Australia_by_population).

For climate data, temperature and rainfall was gathered from the Australian [Bureau of Meterology (BoM)](http://www.bom.gov.au/?ref=logo). A number of weather stations were chosen, based on their proximity to major Australian cities such as Sydney, Perth, Brisbane, Canberra, and Adelaide. The South East region of Australia appears to be the most affected.

Rainfall data was sourced from:  
[Subiaco](http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_nccObsCode=136&p_display_type=dailyDataFile&p_stn_num=009151&p_startYear=),  [Sydney](http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_nccObsCode=136&p_display_type=dailyDataFile&p_stn_num=066062&p_startYear=),  [Melbourne](http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_nccObsCode=136&p_display_type=dailyDataFile&p_stn_num=086232&p_startYear=), [Brisbane](http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_nccObsCode=136&p_display_type=dailyDataFile&p_stn_num=040383&p_startYear=), [Canberra](http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_nccObsCode=136&p_display_type=dailyDataFile&p_stn_num=070351&p_startYear=), [Adelaide](http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_nccObsCode=136&p_display_type=dailyDataFile&p_stn_num=023011&p_startYear=)  

Temp min/max data was sourced from:  
* [BoM Climate Data Online](http://www.bom.gov.au/climate/data/index.shtml??zoom=1&lat=-26.9635&lon=133.4635&layers=B0000TFFFFFFFFFTFFFFFFFFFFFFFFFFTTT&dp=IDC10001&p_nccObsCode=201&p_display_type=dailyDataFile)