# Packages used in this script

library(rtweet)
library(glue)
library(emo)
library(lubridate)
library(here)

# Automated things (as long as you run them each Monday prior to TidyTuesday)
week_date <- as.character(lubridate::today() + 1)
week_num <- as.numeric((lubridate::today() + 1) - lubridate::ymd(20190101))/7

# Override Week Date and Num if necessary
# week_date <- "2019-01-01"
# week_num <- "1"

# Change these things manually!
exploring <- "Data about data things!"
short_link <- "http://bit.ly/tidyarticle"

rtweet::post_tweet(status = glue::glue(
"The @R4DScommunity welcomes you to week {week_num} of #TidyTuesday!  We're exploring {exploring}!
 
",
        emo::ji("folder"),
        " http://bit.ly/tidyreadme
",
        emo::ji("news"),
        " {short_link}

#r4ds #tidyverse #rstats #dataviz"),
# The below code is relative to my project
# You need to specify path to the images for tweeting
        media = c(here::here("static_img", "tt_logo.png"),
                  here::here("static_img", "tt_rules.png"),
                  here::here("2019", week_date, "pic1.png"),
                  here::here("2019", week_date, "pic1.png")
        ))


           
