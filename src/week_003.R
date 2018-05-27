# set up workspace 
library(tidyverse)  # probably could load everything individually but /shrug
library(readxl)
library(here) 

# import data
week3 <- read_excel(here("data", "global_mortality.xlsx"))
