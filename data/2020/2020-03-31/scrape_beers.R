library(here)
library(glue)
library(tidyverse)
library(pdftools)
library(readxl)

# Helpful blog post https://www.brodrigues.co/blog/2018-06-10-scraping_pdfs/
# main thing we do differently is rather than read.csv 
# we can use enframe() to create a tibble() from the raw input

# list all the files we have downloaded so far
all_files <- list.files(here("2020", "2020-03-31"))

# get just the ttb_monthly_stats data
monthly_stats <- all_files[str_detect(all_files, "ttb_monthly_stats")]

# exclude 2018|2019 as it is different format
monthly_no_18_19 <- monthly_stats[!str_detect(monthly_stats, "2018|2019")]

# some early testing
pdftools::pdf_text(here("2020", "2020-03-31", "ttb_monthly_stats_2008-01.pdf"))

raw_text <- pdftools::pdf_text(here("2020", "2020-03-31", "ttb_monthly_stats_2008-01.pdf")) %>% 
  str_split("\n", simplify = TRUE) 

# find start of table
stringr::str_which(raw_text, "MANUFACTURE OF BEER")

# find end of table
stringr::str_which(raw_text, "Total Used")


# create a function that works for most years
get_beer_tables <- function(year, month){
  
  # read in and separate by new lines
  raw_table <- pdftools::pdf_text(here("2020", "2020-03-31", glue("ttb_monthly_stats_{year}-{month}.pdf"))) %>% 
    str_split("\n", simplify = TRUE) 
  
  # Start of table (drop all the description info)
  table_start <- stringr::str_which(raw_table, "MANUFACTURE OF BEER")
  
  # End of table (drop all the asterisks and the like)
  table_end <- stringr::str_which(raw_table, "Total Used")
  
  # Trim the table to the start/end and drop whitespace at each line
  table_trimmed <- raw_table[1, table_start:table_end] %>% 
    str_trim()
  
  # Replace long spaces with a col break symbol
  squished_table <- str_replace_all(table_trimmed, "\\s{2,}", "|")
  
  # Convert to tibble
  raw_df <- suppressWarnings(suppressMessages(enframe(squished_table) %>% 
    separate(value, 
             into = c("type", "month_current", "month_prior_year", "ytd_current", "ytd_prior_year"), 
             sep = "\\|") %>% 
    mutate_at(vars(month_current:ytd_prior_year), readr::parse_number) %>% 
    mutate(year = as.integer(year), month = as.integer(month)) %>% 
    select(year, month, type, everything()))) %>% 
    mutate(row_n = row_number())
  
  # filter additional labeling rows
  slice_num <- raw_df %>% 
    filter(str_detect(type, "MATERIALS USED|IN POUNDS")) %>%
    pull(row_n)
  
  # split data into materials vs barrels produced
  split_df <- raw_df %>% 
    mutate(data_type = dplyr::if_else(row_n >= slice_num, "Pounds of Materials Used", "Barrels Produced")) %>% 
    select(data_type, everything(), -name, -row_n) %>% 
    filter(!str_detect(type, "IN POUNDS|MATERIALS USED|MANUFACTURE OF BEER|BARRELS")) %>% 
    group_by(data_type) %>% 
    group_split()
  
  # clean up the manufacture dataset
  manufacture_df <- split_df[[1]] %>% 
    mutate(
      tax_status = case_when(
        type %in% c("In bottles and cans", "In kegs", "In barrels and kegs",
                    "Tax Determined, Premises Use") ~ "Taxable",
        type == "Sub Total Taxable" ~ "Sub Total Taxable",
        type %in% c("For export", "For vessels and aircraft", 
                    "Consumed on brewery premises") ~ "Tax Free",
        type == "Sub Total Tax-Free" ~ "Sub Total Tax-Free",
        type %in% c("Production", "Total Removals", 
                    "Stocks On Hand end-of-month:") ~ "Totals"
        ),
      tax_rate = dplyr::if_else(year <= 2017, "$7/$18 per barrel", "$3.50/$16 per barrel")
      ) %>% 
    filter(!is.na(tax_status)) %>% 
    select(data_type, tax_status, everything())
  
  # clean up the material dataset
  material_df <- split_df[[2]] %>% 
    mutate(
      material_type = case_when(
        str_detect(type, "Malt|Corn|Rice|Barley|Wheat") ~ "Grain Products",
        str_detect(type, "Sugar|Hops|Other") ~ "Non-Grain Products",
        str_detect(type, "Total") ~ type
      )
    ) %>% 
    select(data_type, material_type, everything())
  
  # output a list of both datasets
  list(manufacture_df, material_df)
}


# Create an input dataframe for purrr -------------------------------------

# Quick test of purrr

pmap(list(2008, "02"), get_beer_tables)

# add the month_num as vector
month_num <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")

# use crossing to generate all combos for the data 
# 2010 is missing, but as the data has prior year data we can theoretically
# add it back in after the fact

df_2008_2017 <- crossing(year = c(2008, 2009, 2011:2017), 
                         month = month_num) %>% 
  mutate(data = pmap(., get_beer_tables)) %>%
  # grab the data into respective columns
  mutate(manufacture_data = map(data, 1),
         material_data = map(data, 2))

# Grab just the manufacture data
manufacture_df <- df_2008_2017 %>% 
  select(manufacture_data) %>% 
  unnest(manufacture_data)

# Grab just the material data

material_df <- df_2008_2017 %>% 
  select(material_data) %>% 
  unnest(material_data)


# 2010 Data is missing - we can assume with "prior year" ------------------

# Grab 2011 data and use prior year as current
man_2010a <- manufacture_df %>% 
  filter(year == 2011) %>% 
  mutate(year = 2010) %>% 
  select(data_type:type, month_current = month_prior_year, ytd_current = ytd_prior_year, tax_rate)

# grab 2009 data and use current year as prior
man_2010b <- manufacture_df %>% 
  filter(year == 2009) %>% 
  mutate(year = 2010) %>% 
  select(data_type:type,  month_prior_year = month_current, ytd_prior_year = ytd_current, tax_rate)

# Combine back to the overall dataset and arrange by year
final_manufacture_df <- left_join(man_2010a, man_2010b, by = c("data_type", "tax_status", "year", "month", "type", "tax_rate")) %>% 
  select(data_type:type, starts_with("month"), starts_with("ytd"), tax_rate) %>% 
  bind_rows(manufacture_df) %>% arrange(year)

# Grab 2011 data and use prior year as current
mat_2010a <- material_df %>% 
  filter(year == 2011) %>% 
  mutate(year = 2010) %>% 
  select(data_type:type, month_current = month_prior_year, ytd_current = ytd_prior_year)

# grab 2009 data and use current year as prior
mat_2010b <- material_df %>% 
  filter(year == 2009) %>% 
  mutate(year = 2010) %>% 
  select(data_type:type,  month_prior_year = month_current, ytd_prior_year = ytd_current)

# Combine back to the overall dataset and arrange by year
final_material_df <- left_join(mat_2010a, mat_2010b, by = c("data_type", "material_type", "year", "month", "type")) %>% 
  select(data_type:type, starts_with("month"), starts_with("ytd")) %>% 
  bind_rows(material_df) %>% arrange(year)

# output final material dataset (no data for 2018/2019)
write_csv(final_material_df, here("2020", "2020-03-31", "brewing_materials.csv"))


# 2018 and 2019 had different format --------------------------------------

# Possible Types

final_manufacture_df %>% filter(year == 2008, month ==1) %>% pull(type) %>% datapasta::vector_paste_vertical()

prod_types <- c(
  "Production",
  "In bottles and cans",
  "In barrels and kegs",
  "Tax Determined, Premises Use",
  "Sub Total Taxable",
  "For export",
  "For vessels and aircraft",
  "Consumed on brewery premises",
  "Sub Total Tax-Free",
  "Total Removals",
  "Stocks On Hand end-of-month:"
  )

final_manufacture_df %>% filter(year == 2008, month ==1) %>% pull(tax_status) %>% datapasta::vector_paste_vertical()

tax_types  <- c(
  "Totals",
  "Taxable",
  "Taxable",
  "Taxable",
  "Sub Total Taxable",
  "Tax Free",
  "Tax Free",
  "Tax Free",
  "Sub Total Tax-Free",
  "Totals",
  "Totals"
  )


# We can read in the Excel files
# input is year and month, which we can do for all of 2018 and 2019

get_excel_tables <- function(year, month){
  
  test_df <- suppressMessages(
    read_excel(here("2020", "2020-03-31", glue("ttb_monthly_stats_{year}-{month}.xlsx")), skip = 5)
  )
  raw_df <- test_df %>% 
    janitor::clean_names() %>% 
    select(x4:x8) %>% 
    slice(-c(1, 2)) %>% 
    filter(!is.na(x5)) %>% 
    set_names(nm = c("type", "month_current", "month_prior_year", "ytd_current", "ytd_prior_year")) %>% 
    filter(!str_detect(month_current, "[:alpha:]+"))
  
  suppressWarnings(
    raw_df %>% 
    mutate(row_n = row_number(),
           data_type = "Barrels Produced",
           tax_status = if_else(max(row_n) == 10, list(tax_types[-7]), list(tax_types))[[1]],
           type = if_else(max(row_n) == 10, list(prod_types[-7]), list(prod_types))[[1]],
           year = as.integer(year), 
           month = as.integer(month),
           tax_rate = "$3.50/$16 per barrel") %>% 
    mutate_at(vars(month_current:ytd_prior_year), as.double) %>% 
    select(data_type, tax_status, year, month, type, everything(), -row_n)
  )
  
}

# test function
get_excel_tables(2018, "02")

# test purrr
pmap(list(year = 2019, month = "05"), .f = get_excel_tables)

month_num <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")

manufacture_18_19 <- crossing(year = c(2018, 2019),
         month = month_num) %>% 
  mutate(data = pmap(., get_excel_tables)) %>% 
  select(data) %>% 
  unnest(data)

# combine the 2008-2017 data with 2018/19
output_manufacture_df <- bind_rows(final_manufacture_df, manufacture_18_19) %>% arrange(year)

# Test plot - MAN CHECK OUT Oct-2012 (double-checked the data and it's real!)
output_manufacture_df %>% 
  filter(type == "Production") %>% 
  ggplot(aes(x = month, y = month_current, color = year, group = year)) +
  geom_line() +
  scale_color_viridis_c()

# output final manufacture dataset
write_csv(output_manufacture_df, here("2020", "2020-03-31", "beer_taxed.csv"))



# Prod Size Excel ---------------------------------------------------------
# Production size as the factor - counting the number of brewers and their output

get_beer_brewers <- function(year){
  
  test_df <- suppressMessages(
    read_excel(here("2020", "2020-03-31", glue("ttb_brewery_size_{year}.xlsx")), skip = 8)
  )
  raw_df <- test_df %>% 
    set_names(nm = c("brewer_size", "n_of_brewers", "total_barrels", 
                     "taxable_removals", "total_shipped")) %>% 
    filter(!is.na(taxable_removals))
  
  raw_df %>% 
    add_column(year, .before = "brewer_size") %>% 
      mutate(total_shipped = str_extract(total_shipped, "[:digit:]+")) %>% 
    mutate_at(vars(n_of_brewers:total_shipped), as.double) %>% 
    mutate(brewer_size = if_else(
      brewer_size %in% c("0 Barrels", "Zero barrels"),"Under 1 Barrel", brewer_size
      ),
      brewer_size = str_remove(brewer_size, " \\(5\\)")
      ) %>% 
    filter(!str_detect(brewer_size, "31 gallons"))

  
}

# Test function
get_beer_brewers(2010)

brewers_size <- 2009:2019 %>% 
  map_dfr(get_beer_brewers)

write_csv(brewers_size, here("2020", "2020-03-31", "brewer_size.csv"))

brewers_size %>% 
  ggplot(aes(x = year, y = total_barrels, group = brewer_size, color = brewer_size)) +
  geom_line() +
  scale_y_log10()


# State-level data --------------------------------------------------------
# Three sheets, all with similar format
# Taxed barrels for on premises, bottles/cans and kegs/barrels

raw_tax_premise <- read_excel(here("2020", "2020-03-31", "ttb_brewery_state_2008-2019.xlsx"), sheet = 1, skip = 6) %>% 
  filter(!is.na(STATE) & !str_detect(STATE, "[:digit:]"))

premise_df <- raw_tax_premise %>% 
  mutate(`2008` = as.double(`2008`)) %>% 
  rename(state = STATE) %>% 
  pivot_longer(-state, names_to = "year", values_to = "barrels") %>% 
  mutate(year = str_extract(year, "[:digit:]+"),
         year = as.integer(year),
         type = "On Premises")

# test plot
premise_df %>% 
  ggplot(aes(x = year, y = barrels, group = state)) +
  geom_line() +
  scale_y_log10()

# bottles and cans
raw_bottles <- read_excel(here("2020", "2020-03-31", "ttb_brewery_state_2008-2019.xlsx"), sheet = 2, skip = 6) %>% 
  filter(!is.na(State) & !str_detect(State, "[:digit:]"))

bottles_df <- raw_bottles %>% 
  mutate(`2008` = as.double(`2008`)) %>% 
  rename(state = State) %>% 
  pivot_longer(-state, names_to = "year", values_to = "barrels") %>% 
  mutate(year = str_extract(year, "[:digit:]+"),
         year = as.integer(year),
         type = "Bottles and Cans")

bottles_df %>% 
  ggplot(aes(x = year, y = barrels, group = state)) +
  geom_line() +
  scale_y_log10()


# Kegs and barrels
raw_kegs <- read_excel(here("2020", "2020-03-31", "ttb_brewery_state_2008-2019.xlsx"), sheet = 3, skip = 6) %>% 
  filter(!is.na(State) & !str_detect(State, "[:digit:]"))

kegs_df <- raw_kegs %>% 
  mutate(`2008` = as.double(`2008`)) %>% 
  rename(state = State) %>% 
  pivot_longer(-state, names_to = "year", values_to = "barrels") %>% 
  mutate(year = str_extract(year, "[:digit:]+"),
         year = as.integer(year),
         type = "Kegs and Barrels")

kegs_df %>% 
  ggplot(aes(x = year, y = barrels, group = state)) +
  geom_line() +
  scale_y_log10()


# combine all
all_states <- bind_rows(premise_df, bottles_df, kegs_df)

# write it out
all_states %>% 
  write_csv(here("2020", "2020-03-31","beer_states.csv"))

all_states %>% 
  ggplot(aes(x = year, y = barrels, group = state, color = type)) +
  geom_line() +
  scale_y_log10() +
  facet_grid(~type)
