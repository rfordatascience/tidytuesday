# Week 31 - R and Package download stats

Anonymized package and R language downloads from the RStudio CRAN mirror.

* [`r-downloads.csv`](https://github.com/rfordatascience/tidytuesday/blob/master/data/2018-10-30/r-downloads.csv) - R language downloads from RStudio CRAN mirror on last TidyTuesday for October 23, 2018. 
* [`r_downloads_year.csv`](https://github.com/rfordatascience/tidytuesday/blob/master/data/2018-10-30/r_downloads_year.csv) - A year's worth of R language downloads from RStudio CRAN mirror between October 20, 2017 and October 20, 2018.

## Data Dictionary
Header | Description
---|---------
`date` | date of download (y-m-d)
`time` | time of download (in UTC)
`size` | size (in bytes)
`version` | R release version
`os` | Operating System
`country` | Two letter ISO country code.
`ip_id` | Anonymized daily ip code (unique identifier)

## Package-level downloads
Package downloads end up with MUCH larger metadata files and are a bit unwieldy to work with, but if you want to play around with them you can use a few ways to easily check!

### [cran-logs.rstudio.com](http://cran-logs.rstudio.com/)
* .csv.gz files (can be read directly into R via `readr::read_csv()`
* Data back to Oct 2012
* Package and R-language downloads (anonymized)

#### Here's an easy example/way to get all the URLs in R
```{r} 
# Set your range of dates
start <- as.Date('2012-10-01')
today <- as.Date('2018-10-27')

all_days <- seq(start, today, by = 'day')

year <- as.POSIXlt(all_days)$year + 1900

# combine dates into a character vector of dates
urls <- paste0('http://cran-logs.rstudio.com/', year, '/', all_days, '.csv.gz')

# Read directly into memory as dataframe
urls %>%
  map_dfr(read_csv)
  
# Can use download.file to download instead of read into memory
```

[`cranlogs`](https://github.com/metacran/cranlogs)
* Extremely easy to use and small data files
* Let's you download by specific packages or look over small time-frames to see what were the most popular packages.
* Con: Aggregated data for the most part

[`installr::download_RStudio_CRAN_data`](https://cran.r-project.org/web/packages/installr/installr.pdf)
* Downloads data from RStudio CRAN anonymized logs via API call
* Has download and read function built in for working with CRAN log data


