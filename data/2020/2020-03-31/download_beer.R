library(tidyverse)
library(rvest)

base_url <- "https://www.ttb.gov/beer/statistics"

# Get State Level aggregate stats -----------------------------------------

download.file(url = "https://www.ttb.gov/images/pdfs/statistics/aggregated/aggr-data-beer_2008-2019.xlsx",
              destfile = here::here("2020","2020-03-31", glue::glue("ttb_brewery_state_2008-2019.xlsx")))


# Download Brewery production size by year --------------------------------

# function to download by year and write out to a consistent format
download_excel <- function(year){
  url <- glue::glue("https://www.ttb.gov/images/pdfs/statistics/production_size/{year}_brew_prod_size_ttb_gov.xlsx")
  download.file(url = url, destfile = here::here("2020","2020-03-31", glue::glue("ttb_brewery_size_{year}.xlsx")))
}

# purrr::walk silently performs the function

2008:2019 %>% 
  walk(download_excel)



# Download monthly stats --------------------------------------------------

# 2008 is super weird, and they changed naming formats several times
# I decided to just scrape the url references (href)
# for each of the files as they changed each time and the logic was messy

url <- "https://www.ttb.gov/statistics/2008-beer-monthly-statistical-releases"

all_urls <- url %>% 
  read_html() %>% 
  html_nodes("a") %>% 
  html_attr("href")


href_urls <- all_urls[str_detect(all_urls, "images/pdfs/statistics")]

beer_file_names <- href_urls[!is.na(href_urls)] %>% str_remove("/images/pdfs/statistics/2008/")

# output of all the urls
urls_2008 <- as.character(glue::glue("https://www.ttb.gov/images/pdfs/statistics/2008/{beer_file_names}"))

month_num <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")

download_2008 <- function(url_in, month_num_in){
  download.file(
    url = url_in,
    destfile = here::here("2020","2020-03-31", 
                          glue::glue("ttb_monthly_stats_2008-{month_num_in}.pdf")
    )
  )
}

# Download the 2008 files in bulk
# input is the month_num for labeling and the urls for downloading
pwalk(.l = list(urls_2008, month_num), .f = download_2008)



# Generic download function for monthly stats -----------------------------


# this downloads all the stats by year
download_monthly_stats_pdf <- function(year){
  
  month_names <- tolower(month.abb)
  month_num <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
  
  month_in <- dplyr::if_else(year == 2008, list(month_names), list(month_num))[[1]]
  
  year_vec <- rep(year, 12)
  
  url_build <- function(year_vec, month_in){
    ifelse(
      year == 2008, 
      glue::glue("https://www.ttb.gov/images/pdfs/statistics/{year}/{month_in}{year}-beer.pdf"),
      glue::glue("https://www.ttb.gov/images/pdfs/statistics/{year}/{year}{month_in}beer.pdf")
    )
  }
  
  download_monthly_pdf <- function(url, year, month){
    download.file(
      url = url,
      destfile = here::here("2020","2020-03-31", 
      glue::glue("ttb_monthly_stats_{year}-{month}.pdf")
        )
      )
  }
  
  full_df <- tibble(year_vec, month_in) %>% 
    mutate(url_in = pmap_chr(.l = list(year_vec, month_in), .f = url_build)) 
  
  pwalk(.l = list(full_df$url_in, full_df$year_vec, full_df$month_in), .f = download_monthly_pdf)
  
}

# 2010 is missing
# 2015 is revised - used updated
# 2008 is funky

# Download the "good years"
# We've already downloaded 2008 and 2010 is missing
# 2015 is messy in a different way as the data was adjusted years later

c(2009, 2011:2014, 2016:2019) %>% 
  walk(download_monthly_stats_pdf)


# Download revised 2015 in bulk -------------------------------------------

# 2015 was revised so we'll need to download it separately.

download_2015 <- function(url_in, month_num_in){
  download.file(
    url = url_in,
    destfile = here::here("2020","2020-03-31", 
                          glue::glue("ttb_monthly_stats_2015-{month_num_in}.pdf")
    )
  )
}

# create the 2015 URLs data
urls_2015 <- as.character(glue::glue("https://www.ttb.gov/images/pdfs/statistics/2015/{month_num}2015_line2_rev.pdf"))

# Download all from 2015
pwalk(.l = list(urls_2015, month_num), .f = download_2015)


# Download 2018-2019 XLS Files --------------------------------------------

# 2018 and 2019 they switched to an arguably worse format for PDFs but also 
# started generating excel files, so we'll skip the PDFs for now and go for excel
# The PDFs have tables with merged cells which is very tricky and requires more 
# logic than our typical workflow

download_monthly_stats_xls <- function(year){
  
  month_in <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
  
  year_vec <- rep(year, 12)
  
  url_build <- function(year_vec, month_in){
      glue::glue("https://www.ttb.gov/images/pdfs/statistics/{year}/{year}{month_in}beer.xlsx")
  }
  
  download_monthly_pdf <- function(url, year, month){
    download.file(
      url = url,
      destfile = here::here("2020","2020-03-31", 
      glue::glue("ttb_monthly_stats_{year}-{month}.xlsx")
        )
      )
  }
  
  full_df <- tibble(year_vec, month_in) %>% 
    mutate(url_in = pmap_chr(.l = list(year_vec, month_in), .f = url_build)) 
  
  pwalk(.l = list(full_df$url_in, full_df$year_vec, full_df$month_in), .f = download_monthly_pdf)
  
}

# Get excel files from 2018-2019
download_monthly_stats_xls(2018)
download_monthly_stats_xls(2019)


# Done! data from 2008-2019 (minus 2010)
# is now downloaded

# We can kind of get the 2010 data from the 2009 and 2011 datasets, but 
# we'll do that in the scrape_beer.R file