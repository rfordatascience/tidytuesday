# US Wind Turbine Data

Wind turbine location and characteristic data across the USA can be found [here](https://github.com/rfordatascience/tidytuesday/blob/master/data/2018-11-06/us_wind.csv). 

Some potential questions: 
- How do newer installations compare to older turbines? 
- Which states/regions have the most wind farms?
- Spread of wind-turbines over time?
- Where is the most missing data?

DISCLAIMER: There is quite a bit of missing data, but still an interesting dataset!

Interactive map from [usgs.gov](https://eerscmap.usgs.gov/uswtdb/viewer/#3.07/37.44/-96.38).

[GIS shapefile](https://eerscmap.usgs.gov/uswtdb/data/)

## Interested in even more wind-power data? 

Check out [OpenEI](https://openei.org/datasets/dataset) for >1600 datasets on energy production and use.

## [Data Dictionary](https://emp.lbl.gov/publications/us-wind-turbine-database-files)

I intentionally left some of the "missing" data qualifiers as it is accurate for lots of government-level open data. They often use things like "-9999" means missing data. Take a look, dig through the data, and we can't wait to see what you make!

| field      | category                      | description                                                                                     | type   | non-missing | Labels         | Missing | Min       | Median    | Max      |
|------------|-------------------------------|-------------------------------------------------------------------------------------------------|--------|-------------|----------------|---------|-----------|-----------|----------|
| case_id    | id                            | unique uswtdb id                                                                                | long   | 58185       | n/a            | n/a     | 3000001   | 3038762   | 3087216  |
| faa_ors    | id                            | faa digital obstacle file (dof) for obstacle repository system (ors)                            | str9   | 49780       | n/a            | missing | n/a       | n/a       | n/a      |
| faa_asn    | id                            | faa obstruction evaluation - airport airspace analysis (oe-aaa) aeronautical study number (asn) | str17  | 50090       | n/a            | missing | n/a       | n/a       | n/a      |
| usgs_pr_id | id                            | usgs id from prior turbine dataset                                                              | long   | 42854       | n/a            | -9999   | 1         | 27334     | 49135    |
| t_state    | location                      | state where turbine is located                                                                  | str2   | 58185       | n/a            | missing | n/a       | n/a       | n/a      |
| t_county   | location                      | county where turbine is located                                                                 | str31  | 58185       | n/a            | missing | n/a       | n/a       | n/a      |
| t_fips     | location                      | state and county fips where turbine is located                                                  | str5   | 58185       | n/a            | missing | n/a       | n/a       | n/a      |
| p_name     | project characteristic        | project name                                                                                    | str42  | 58185       | n/a            | missing | n/a       | n/a       | n/a      |
| p_year     | project characteristic        | year project became operational                                                                 | int    | 58123       | n/a            | -9999   | 1981      | 2010      | 2018     |
| p_tnum     | project characteristic        | number of turbines in project                                                                   | int    | 58185       | n/a            | -9999   | 1         | 83        | 1831     |
| p_cap      | project characteristic        | project capacity (MW)                                                                           | double | 54493       | n/a            | -9999   | 0.05      | 129       | 495.01   |
| t_manu     | turbine characteristic        | turbine original equipment manufacturer                                                         | str31  | 54309       | n/a            | missing | n/a       | n/a       | n/a      |
| t_model    | turbine characteristic        | turbine model                                                                                   | str18  | 53716       | n/a            | missing | n/a       | n/a       | n/a      |
| t_cap      | turbine characteristic        | turbine capacity (kW)                                                                           | int    | 54491       | n/a            | -9999   | 40        | 1650      | 6000     |
| t_hh       | turbine characteristic        | turbine hub height (meters)                                                                     | double | 51560       | n/a            | -9999   | 18.2      | 80        | 130      |
| t_rd       | turbine characteristic        | turbine rotor diameter (meters)                                                                 | double | 53236       | n/a            | -9999   | 11.0      | 87.0      | 150      |
| t_rsa      | turbine characteristic        | turbine rotor swept area (meters^2)                                                             | double | 53236       | n/a            | -9999   | 95.03     | 5944.68   | 17671.46 |
| t_ttlh     | turbine characteristic        | turbine total height - calculated (meters)                                                      | double | 53123       | n/a            | -9999   | 9.1       | 123.4     | 200.3    |
| t_conf_atr | turbine characteristics qa/qc | turbine characteristic confidence (0-3)                                                         | byte   | 58185       | see labels tab | n/a     | 1         | 3         | 3        |
| t_conf_loc | visual inspection qa/qc       | location confidence (0 -3)                                                                      | byte   | 58185       | see labels tab | n/a     | 1         | 3         | 3        |
| t_img_date | visual inspection info        | date of image used to visually verify turbine location                                          | int    | 34011       | n/a            | missing | n/a       | n/a       | n/a      |
| t_img_srce | visual inspection info        | source of image used to visually verify turbine location                                        | str16  | 58185       | n/a            | missing | n/a       | n/a       | n/a      |
| xlong      | location                      | longitude (decimal degrees - NAD 83 datum)                                                      | double | 58185       | n/a            | n/a     | -171.7131 | -100.2475 | 144.7227 |
| ylat       | location                      | latitude (decimal degrees - NAD 83 datum)                                                       | double | 58185       | n/a            | n/a     | 13.3894   | 37.8747   | 66.8399  |

