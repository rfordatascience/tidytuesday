library(rvest)

# url to scrape:
root <- "https://www.ianvisits.co.uk/articles/a-list-of-monarchs-by-marriage-6857/"

# get table
tables <- read_html(root) |> html_nodes("table")
df <- tables[1] |> html_table() |> as.data.frame()

df <- df[, -6]      # remove spoiler 
df <- df[-c(1,2), ] # remove double-header effect

cols <- c("king_name", "king_age", "consort_name", "consort_age", "year_of_marriage")
colnames(df) <- cols
