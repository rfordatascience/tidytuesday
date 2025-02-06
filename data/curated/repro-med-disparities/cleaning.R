# Clean data provided by Kat Correia. Student interns extracted this information
# from reproductive medicine journals using duplicate data entry. 
# After duplicate data entry discrepancies were resolved, their 
# individual files were combined, and posted for public access 
# as Google sheets, e.g.,:
# https://docs.google.com/spreadsheets/d/1UuWGQxRU0wxVuOZGYnvkwKn-GdmLIj8kzmUm4KLRHQY/edit?gid=1719021104#gid=1719021104
# No additional cleaning was necessary.

article_dat <- readr::read_csv("https://kcorreia.people.amherst.edu/repro_med_disparities-article-level-data.csv")

model_dat <- readr::read_csv("https://kcorreia.people.amherst.edu/repro_med_disparities-model-level-data.csv")


