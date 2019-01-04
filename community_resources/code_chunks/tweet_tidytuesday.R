# Packages used in this script
library(rtweet) # For Tweeting
library(glue) # For interpretation inside strings
library(emo) # For emojis!
library(lubridate) # Working with date-times
library(here) # Easier file navigation inside projects
library(tinycc) # Programmatically generate tinycc short urls via their API
library(purrr) # for pluck - I'm lazy. :shrug:

# Auth against tinycc
# Need to provide your own secret credentials
tinycc::auth(secret_login, secret_api_key)

# Automated things (as long as you run them each Monday prior to TidyTuesday)
week_date <- as.character(lubridate::today() + 1)
week_num <- as.numeric((lubridate::today() + 1) - lubridate::ymd(20190101))/7

# Override Week Date and Num
# week_date <- "2019-01-01"
# week_num <- "1"

############# Change these things manually! ############
exploring <- "Data about data things!"
long_link <- "http://bit.ly/tidyarticle"
########################################################

# Generate the short_link
short_link <- tinycc::shorten(longURL = long_link,
                              shortURL = glue::glue("tt_2019_{week_num}")) %>% 
        purrr::pluck("results", "short_url")


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


# refactored as a function

post_tidytuesday <- function(exploring, long_link){
        
        # Authenticate each session
        tinycc::auth(secret_login, secret_api_key)
        
        # set date for files structure and names
        week_date <- as.character(lubridate::today() + 1)
        week_num <- as.numeric((lubridate::today() + 1) - lubridate::ymd(20190101))/7
        

        # Generate the short_link
        short_link <- tinycc::shorten(longURL = long_link,
                                      shortURL = glue::glue("tt_2019_{week_num}")) %>% 
                purrr::pluck("results", "short_url")
        
        # post the tweet with fill
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
}

# You can call the function as so
post_tidytuesday(
        exploring = ""
        long_link = ""
)
