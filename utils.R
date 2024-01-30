library(tidyverse)
library(lubridate)

get_current_tt_data <- function() {

# Get today's date
today_date <- Sys.Date()
yr <- paste0(year(today_date),"/")

# Find the most recent Tuesday or today if it's Tuesday
closest_tuesday <- ifelse(lubridate::wday(today_date) >= 3,
                          today_date + (3 - lubridate::wday(today_date)),
                          today_date - (lubridate::wday(today_date) - 3))

# Extract date from `closest_tuesday`
year_str <- format(as.Date(closest_tuesday), "%Y")  # Ensure closest_tuesday is a Date object
tuesday_date_str <- format(as.Date(closest_tuesday), "%m-%d")
data_str <- paste0(year_str,"-",tuesday_date_str)
file_path <-paste0("data/",yr,data_str)

files <- list.files(path = file_path, pattern = ".csv$", full.names = TRUE)

return(files)
}

# future function work
# can expand function to read files? depending on if there are multiple .csvs?
# function to create multiple dfs of the .csv files?

get_current_tt_data()
