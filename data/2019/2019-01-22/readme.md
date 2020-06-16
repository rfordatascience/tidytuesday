# Data Info

Data comes from [The Vera Institute GitHub](https://github.com/vera-institute/incarceration_trends). The raw dataset was taken from their GitHub - it is in a wide format and if you are keen on really flexing your data munging skills it is a worthy adversary! The truly raw data is seen [here](https://raw.githubusercontent.com/vera-institute/incarceration_trends/master/incarceration_trends.csv). My full code to reproduce the summary level datasets seen below can be found [here](example_code.R), you can adapt this minorly to get more data from the original wide dataset.

Alternatively, if you don't want to spend the bulk of your time tidying data - I provided summary level and a subset of some tidy county-level data for you to play around with and visualize.

# Incarceration Trends Dataset

These data are from the Vera Institute of Justice, and they wrote several deep-dive articles on the information found. At the most basic level - these data are County-level jail data (1970-2015) and prison data (1983-2015) for the USA.

I chose this dataset as there are still racial and social discrepancies prevalent throughout the world and in the USA. I thought it was fitting to dive into some "Data for Good" on Martin Luther King Jr. Day as a way to shine light on racial discrepencies in the US prison system.

Please use your best judgement, be respectful and careful when reporting on trends seen in this dataset.

## Data files

| File     | Description            |
| -------- | ---------------------- |
| [prison_summary.csv](prison_summary.csv) | Summary of population in prison by year and county-type |
| [pretrial_summary.csv](pretrial_summary.csv) | Summary of pretrial incarceration by year and county-type |
| [prison_population.csv](prison_population.csv) | County-level data for prison population |
| [pretrial_population.csv](pretrial_population.csv) | County-level data for pretrial incarceration |
| [incarceration_trends.csv](incarceration_trends.csv) | Full raw data (from Vera Institute) |

## Data Dictionary

**Incarceration Trends**

The full codebook from the Vera Institute can be found [here](https://github.com/vera-institute/incarceration_trends/blob/master/incarceration_trends-Codebook.pdf?raw=true).

**Prison Summary**

|variable        |class     | Description |
|:---------------|:---------| :---------- |
|year            |integer (date)   | Year | 
|urbanicity      |character | County-type (urban, suburban, small/mid, rural) |
|pop_category    |character | Category for population - either race, gender, or Total |
|rate_per_100000 |double    | Rate within a category for prison population per 100,000 people |

---

**Pretrial Summary**

|variable        |class     | Description |
|:---------------|:---------| :---------- |
|year            |integer (date)   | Year | 
|urbanicity      |character | County-type (urban, suburban, small/mid, rural) |
|pop_category    |character | Category for population - either race, gender, or Total |
|rate_per_100000 |double    | Rate within a category for pretrial incarceration per 100,000 people |

---

**Prison Population**

|variable          |class     | Description |
|:-----------------|:---------| :---------- |
|year              |integer (date)   | Year | 
|state             |character | State code |
|county_name       |character | County Name |
|urbanicity        |character | County-type (urban, suburban, small/mid, rural) |
|region            |character | Region of US |
|division          |character | Division of US |
|pop_category      |character | Category for population - either race, gender, or Total |
|population        |integer   | Number of total individuals in each category aged 15-64 |
|prison_population |integer   | Number of individuals in prison for each category |

---

**Pretrial Population**

|variable          |class     | Description |
|:-----------------|:---------| :---------|
|year              |integer (date)   | Year | 
|state             |character | State code |
|county_name       |character | County Name |
|urbanicity        |character | County-type (urban, suburban, small/mid, rural) |
|region            |character | Region of US |
|division          |character | Division of US |
|pop_category      |character | Category for population - either race, gender, or Total |
|population        |integer   | Number of total individuals in each category aged 15-64|
|pretrial_population |integer   | Number of individuals incarcerated for each category |

# The full details from the Vera Institute can be seen below

---

# Incarceration Trends Dataset
County-level jail data (1970-2015) and prison data (1983-2015)

![Image: Huerfano County Correctional Facility, built in 1997 and operated as a private prison by Corrections Corporation of America. Closed in 2010.](https://github.com/vera-institute/incarceration_trends/blob/master/img/iob-cfp-banner.jpg?raw=true)

## Project History
In December 2015, Vera released the Incarceration Trends data tool (http://trends.vera.org) and the companion publication [In Our Own Backyard: Confronting Growth and Disparities in American Jails](https://www.vera.org/publications/in-our-own-backyard-confronting-growth-and-disparities-in-american-jails). This work employed two Bureau of Justice Statistics (BJS) data collections: the Census of Jails (COJ), which covers all jails and is conducted every five to eight years since 1970, and the Annual Survey of Jails (ASJ), which covers about one-third of jails-and includes nearly all of the largest jails-that has been conducted in non-census years since 1982. This project was funded by the Robert W. Wilson Charitable Trust.

In 2016-2018, through a grant from the MacArthur Foundation Safety and Justice Challenge, Vera updated the data tool to include newly released data from the 2013 COJ and 2015 ASJ and developed four publications:

* [Overlooked: Women and Jails in an Era of Reform](https://www.vera.org/publications/overlooked-women-and-jails-report)
* [Out of Sight: The Growth of Jails in Rural America](https://www.vera.org/publications/out-of-sight-growth-of-jails-rural-america)
* [Divided Justice: Trends in Black and White Incarceration 1990-2013](https://www.vera.org/publications/divided-justice-black-white-jail-incarceration)
* [The New Dynamics of Mass Incarceration](https://www.vera.org/publications/the-new-dynamics-of-mass-incarceration)

In 2018, through the In Our Backyards grant from Google.org, Vera completed work on a companion county-level prison dataset, examined in The New Dynamics of Mass Incarceration, that drew on the BJS [National Corrections Reporting Program](http://ncrp.info/) (NCRP) data collection. Vera then merged this data with the original jails dataset to produce a first-in-kind national dataset that can examine both jail and prison incarceration at the county level.

Research on incarceration has traditionally centered on state-level data: specifically state prison populations or the statewide combined prison and jail population. Using the state as the unit of analysis is sufficient for understanding the broad contours of incarceration in the United States, but it does not provide the level of detail necessary to unpack its causes and consequences. This is because it is largely county officials-judges, prosecutors, people who manage jails-that decide how communities use incarceration (i.e., who is sent to jail and prison, and for how long). Therefore, county-level variability makes for more robust, theoretically-grounded studies of the high rates of incarceration seen across the United States.

For more information on In Our Backyards, see http://www.vera.org/backyards.

## Data

The data is distributed as a single file, available in  [CSV](https://github.com/vera-institute/incarceration_trends/blob/master/incarceration_trends.csv?raw=true) or [Excel](https://github.com/vera-institute/incarceration_trends/blob/master/incarceration_trends.xlsx?raw=true) format.

## Documentation
 [Codebook](https://github.com/vera-institute/incarceration_trends/blob/master/incarceration_trends-Codebook.pdf?raw=true)

## Methodology

- [Jail data methodology](https://github.com/vera-institute/incarceration_trends/blob/master/Methodology-for-Incarceration-Trends-Project-V2.pdf?raw=true).
- [Prison data methodology](https://github.com/vera-institute/incarceration_trends/blob/master/Workingpaper_Reconstructing-How-Counties-Contribute-to-State-Prisons.pdf?raw=true).

## License

By downloading the data, you hereby agree to all of the terms specified in this [license](https://github.com/vera-institute/incarceration_trends/blob/master/License.md).

## Endmatter

If you have questions, please contact Vera at <trends@vera.org> or Jacob Kang-Brown by mail at 233 Broadway, 12th Floor, New York, NY 10279.

The Vera Institute of Justice works to build and create justice systems that ensure fairness, promote safety, and strengthen communities.

The development of the public-use county-level incarceration dataset is funded through the In Our Backyards project by Google.org as part of its Inclusion and Racial Justice work. In Our Backyards is a Vera's research and communications agenda to inform the public dialogue, advance research, and guide change to justice policy and practice on mass incarceration.

Photo credit: Jack Norton. Huerfano County Correctional Facility, built in 1997 and operated as a private prison by Corrections Corporation of America. Closed in 2010. A funding request to re-open the facility by Colorado Department of Corrections was denied by the state in 2018.
