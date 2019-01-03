# Packages used in this script

library(rtweet)
library(glue)
library(emo)
library(lubridate)

# Automated things (as long as you run them each Monday prior to TidyTuesday)
week_date <- as.character(lubridate::today() + 1)
week_num <- as.numeric((lubridate::today() + 1) - lubridate::ymd(20190101))/7

# Change these things manually!
exploring <- "Data about data things!"
short_link <- "http://bit.ly/tidyarticle"

rtweet::post_tweet(status = glue::glue(
"The @R4DScommunity welcomes you back to week {week_num} of #TidyTuesday!  We're exploring {exploring}!
 
",
        emo::ji("folder"),
        " http://bit.ly/tidyreadme
",
        emo::ji("news"),
        " {short_link}

#r4ds #tidyverse #rstats #dataviz"),
        media = c("./static_img/tt_logo.png", 
                  "./static_img/tt_rules.png", 
                  paste0("./2019/", week_date, "/pic1.png"),
                  paste0("./2019/", week_date, "/pic2.png")
        ))
