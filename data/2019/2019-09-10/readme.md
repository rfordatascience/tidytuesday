# Amusement Park injuries

This week's data is from [data.world](https://data.world/amillerbernd/texas-amusement-park-accidents/workspace/file?filename=Amusement-Park-Injuries-xlsxCleaned.xls) and the Safer Parks database.

A lot of free text this week, some inconsistent NAs (n/a, N/A) and dates (ymd, dmy). A good chance to do some data cleaning and then take a look at frequency, type of injury, and analyze free text.

Additional data can be found at [SaferParks Database](https://saferparksdata.org/downloads)

# Get the data!

```
tx_injuries <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-10/tx_injuries.csv")

safer_parks <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-10/saferparks.csv")

```

# Data Dictionary

## `tx_injuries.csv`

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

## `safer_parks.csv`

|variable             |class     |description |
|:--------------------|:---------|:-----------|
|acc_id               |double    | Unique ID |
|acc_date             |character | Accident Date |
|acc_state            |character | Accident State |
|acc_city             |character | Accident City |
|fix_port             |character |.           |
|source               |character | Source of injury report |
|bus_type             |character | Business type |
|industry_sector      |character | Industry sector |
|device_category      |character | Device category |
|device_type          |character | Device type |
|tradename_or_generic |character | Common name of the device |
|manufacturer         |character | Manufacturer of device |
|num_injured          |double    | Num injured |
|age_youngest         |double    | Youngest individual injured |
|gender               |character | Gender of individual injured |
|acc_desc             |character | Description of accident |
|injury_desc          |character | Injury description |
|report               |character | Report URL |
|category             |character | Category of accident |
|mechanical           |double    | Mechanical failure (binary NA/1) |
|op_error             |double    | Operator error (binary NA/1)|
|employee             |double    | Employee error (binary NA/1)|
|notes                |character | Additional notes| 
