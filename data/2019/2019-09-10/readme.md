# Texas Amusement Park injuries

This week's data is from [data.world](https://data.world/amillerbernd/texas-amusement-park-accidents/workspace/file?filename=Amusement-Park-Injuries-xlsxCleaned.xls).

A lot of free text this week, some inconsistent NAs (n/a, N/A) and dates (ymd, dmy). A good chance to do some data cleaning and then take a look at frequency, type of injury, and analyze free text.

# Get the data!

```
injuries <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-10/injuries.csv")


```

# Data Dictionary

## `injuries.csv`

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|injury_report_rec |double    | Unique Record ID |
|name_of_operation |character | Company name |
|city              |character | City |
|st                |character | State (all TX) |
|injury_date       |character | Injury date - note there are some different formats |
|ride_name         |character | Ride Name |
|serial_no         |character | Serial number of ride |
|gender            |character | Gender of the injured individual |
|age               |character | Age of the injured individual |
|body_part         |character | Body part injured |
|alleged_injury    |character | Alleged injury - type of injury |
|cause_of_injury   |character | Approximate cause of the injury (free text) |
|other             |character | Anecdotal information in addition to cause of injury |