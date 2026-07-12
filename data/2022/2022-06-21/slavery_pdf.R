library(pdftools) # reading in the PDF tables
library(tidyverse) # requires tidy 1.0 and dplyr 1.0 for below example

# black past, african names & slave routes database
# Just cleaned up the names

routes <- read_csv("2020/2020-06-16/slave_routes.csv")

# test plot
cleaned_routes %>%
  mutate(decade = 10 * (year_arrival %/% 10)) %>% 
  group_by(decade) %>% 
  summarize(n = sum(n_slaves_arrived, na.rm = TRUE)) %>% 
  ggplot(aes(x = decade, y = n)) + 
  geom_col() +
  scale_y_continuous(labels = scales::label_number())


 -----------------------------------------------------------

raw_names <- read_csv("2020/2020-06-16/african_names.csv")

raw_names %>% 
  ggplot(aes(x = age)) +
  geom_density() + facet_wrap(~gender, ncol = 1)

# Census Populations ------------------------------------------------------

# Read in the raw PDF
raw_pdf <- pdftools::pdf_text("2020/2020-06-16/POP-twps0056.pdf")

# test on one page
raw_text <- raw_pdf[[31]] %>% 
  str_split("\n")

# Some attempts at cleaning the data
mw_test <- raw_text %>%
  unlist() %>% 
  .[7:38] %>% 
  .[str_detect(., ".......")] %>% 
  .[str_which(str_sub(., 1), "1")] %>% 
  str_remove_all("\\.") %>% 
  .[c(1,3,5,9:26)] %>% 
  str_replace_all("([0-9])(\\s)([0-9])", "\\1\\3") %>% 
  str_squish() 

midwest <- mw_test %>% 
  read_table(col_names = FALSE) %>% 
  separate(X2, into = c("total", "white", "black", "native",
                        "asian", "other", "hispanic", "white_other"
  )) %>% 
  select(year = X1, total:black) %>% 
  filter(year <= 1870) %>% 
  mutate(across(c(total:black), parse_number)) %>% 
  add_column(black_free = c(273080, 69291, 48185, 30743, 15664, 6931, 3630, 500)) %>% 
  mutate(black_slaves = black - black_free, 
         region = "Midwest") %>% 
  select(region, everything())


# trying for the US Total
us_raw <- raw_pdf[[29]] %>% 
  str_split("\n") %>% 
  unlist()

str_subset(us_raw, all_years) %>% 
  str_subset("Table", negate = TRUE) %>% 
  .[c(1:9)]

all_years <- seq(1790, 1870, by = 10) %>% 
  paste0(collapse = "|")

us_raw[str_detect(us_raw, all_years)] %>% 
  .[2:10]

# Create a robust function to get tables
get_population <- function(page_number, division, free_blacks){
  
  # match regions and divisions
  regions <- case_when(
    division %in% c("New England","Middle Atlantic") ~ "Northeast",
    division %in% c("East North Central", "West North Central") ~ "Midwest",
    division %in% c("South Atlantic", "East South Central", "West South Central") ~ "South",
    division %in% c("Mountain", "Pacific") ~ "West",
    division %in% c("Northeast", "Midwest", "South", "West") ~ division,
    TRUE ~ "USA Total"
  )
  
  # years to filter down to
  all_years <- seq(1790, 1870, by = 10) %>% 
    paste0(collapse = "|")
  
  # get specific page and separate into lines
  raw_pdf_text <- raw_pdf[[page_number]] %>% 
    str_split("\n") %>% 
    unlist()
  
  # filter down to matching years and exclude table row
  raw_table <- str_subset(raw_pdf_text, all_years) %>% 
    str_subset("Table", negate = TRUE)
  
  clean_table <-  raw_table %>% 
    str_remove_all("\\.") %>% 
    # find space in between digits and drop the space
    str_replace_all("([0-9])(\\s)([0-9])", "\\1\\3") %>% 
    str_squish() %>% 
    # couldn't get this to work nicely, but this works fine w/ separate
    read_table(col_names = FALSE) %>% 
    separate(X2, into = c("total", "white", "black", "native",
                          "asian", "other", "hispanic", "white_other"
    )) %>% 
    select(year = X1, total:black) %>% 
    # parse character numbers
    mutate(across(c(total:black), parse_number)) %>% 
    # exclude percentage
    filter(total > 1000) %>% 
    # add in the free black people
    add_column(black_free = free_blacks) %>%
    # assign region/division
    mutate(black_slaves = black - black_free,
           division = division,
           region = regions,
           division = if_else(division == region, NA_character_, division)) %>%
    select(region, division, everything())
  
  # return table
  clean_table
  
}

# Testing for Midwest
get_population(31, "Midwest", c(273080, 69291, 48185, 30743, 15664, 6931, 3630, 500))

# Testing for US
get_population(29, "USA", c(273080, 69291, 48185, 30743, 15664, 6931, 3630, 500, 0))

# Apply the function at scale
total_census <- tibble(
  page_number = c(29:42),
  division = c("USA Total", "Northeast", "Midwest", "South", "West", 
             "New England", "Middle Atlantic", "East North Central",
             "West North Central", "South Atlantic", 
             "East South Central", "West South Central",
             "Mountain", "Pacific"
             ),
  # manually aggregated
  free_blacks = list(
    c(4880009, 488070, 434495,386293,619599,233634,186446,108435,59527),
    c(179738,155983,149526,141559,122434,92723,75156,46696,27070),
    c(273080, 69291, 48185, 30743, 15664, 6931, 3630, 500),
    c(4420811, 258346,235569,213991,181501,133980,107660,61239,32457),
    c(6380,4450,1215),
    c(31705, 24711,23021,22634,21331,20782,19488,17313,13117),
    c(148033,131272,126505,118925,101103,71941,55668,29383,13953),
    c(130497,63699,45195,28997,15095,6584,3025,500),
    c(142583,5592,2990,1746,569,347,605),
    c(2216705, 217753,197474,171778,153087,116920,96803,60009,31982),
    c(1464252, 21447,19628,16246,11563,6525,3270,1230,475),
    c(739854, 19146,18467,25967,16851,10535,7587),
    c(1555,206,46),
    c(4825,4244,1169)
  )
) %>% 
  mutate(data = pmap(., get_population)) %>% 
  select(data) %>% 
  unnest(data) %>% 
  mutate(region)

# test plot
total_census %>% 
  mutate(percent_slaves = black_slaves/black * 100) %>% 
  filter(is.na(division), region != "USA Total")%>% 
  ggplot(aes(x = year, y = percent_slaves, color = region)) +
  geom_line() +
  facet_wrap(~region)

total_census %>% 
  mutate(percent_slaves = black_slaves/black * 100) %>% 
  filter(is.na(division), region != "USA Total") %>% 
  group_by(region) %>% 
  filter(year != 1870) %>% 
  summarize(mean_slavery = mean(percent_slaves),
            sd = sd(percent_slaves)) %>% 
  arrange(desc(mean_slavery))

total_census %>% 
  mutate(percent_slaves = black_slaves/black * 100) %>% 
  filter(is.na(division), region != "USA Total") %>% 
  filter(year != 1870) %>% 
  arrange(desc(percent_slaves)) %>% 
  ggplot(aes(x = fct_inorder(region), y = percent_slaves, color = year)) +
  viridis::scale_color_viridis() +
  geom_jitter(size = 3, width = 0.1) +
  geom_boxplot(width = 0.75, alpha = 0.5) +
  labs(x = "", y = "Blacks enslaved as a percentage of the region's total black population  (%)",
       
       subtitle = "Years between 1790 and 1860") +
  scale_y_continuous(breaks = c(0, 25, 50, 75, 90, 100)) +
  geom_hline(yintercept = 90)

total_census %>% write_csv("2020/2020-06-16/census.csv")
