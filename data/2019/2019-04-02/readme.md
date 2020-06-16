# Seattle Bike Counters

"Seattle Department of Transportation has 12 bike counters (four of which also count pedestrians) located on neighborhood greenways, multi-use trails, at the Fremont  Bridge and on SW Spokane Street. The counters are helping us create a ridership baseline in 2014 that can be used to assess future years and make sure our investments are helping us to reach our goal of quadrupling ridership by 2030. Read our [Bicycle Master Plan](http://www.seattle.gov/transportation/document-library/citywide-plans/modal-plans/bicycle-master-plan) to learn more about what Seattle is doing to create a citywide bicycle network."

The Seattle Times recently covered [What we can learn from Seattle's bike-counter data](https://www.seattletimes.com/seattle-news/transportation/what-we-can-learn-from-seattles-bike-counter-data/). They have some elegant data-visualizations there!


# Get the Data!

```
bike_traffic <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-02/bike_traffic.csv")
```

### Data Dictionary

|variable   |class     |description |
|:----------|:---------|:-----------|
|date       | date (mdy hms am/pm) | Date of data upload |
|crossing   |character | The Street crossing/intersection  |
|direction  |character | North/South/East/West - varies by crossing        |
|bike_count |double    | Number of bikes counted for each hour window  |
|ped_count  |double    | Number of pedestrians counted for each hour window        |
