### Women in the Workforce

March is Women's History month, as such we're exploring data from the Bureau of Labor Statistics and the Census Bureau about women in the workforce. There are historical data about women's earnings and employment status, as well as detailed information about specific occupation and earnings from 2013-2016.  

According to the [AAUW](https://www.aauw.org/research/the-simple-truth-about-the-gender-pay-gap/) - "The gender pay gap is the gap between what men and women are paid. Most commonly, it refers to the median annual pay of all women who work full time and year-round, compared to the pay of a similar cohort of men." These data can be nuanced so please use your best judgement when reporting on trends in the dataset. 

The specific jobs data came from the [Census Bureau](https://www.census.gov/data/tables/time-series/demo/industry-occupation/median-earnings.html) and the historical data comes from the Bureau of Labor [here](https://www.bls.gov/opub/ted/2012/ted_20121123.htm) and [here](https://www.bls.gov/opub/ted/2017/percentage-of-employed-women-working-full-time-little-changed-over-past-5-decades.htm). The data is provided as is, and you recognize the limitations and issues in defining gender as binary.

Data Scientist and Austin #Rladies co-organizer [Caitlin Hudon](https://twitter.com/beeonaposy) has some [great recommendations](https://caitlinhudon.com/2018/05/15/better-allies/) on how to be a better ally for underepresented groups in tech. If you are interested in trying to make tech a better place for ALL please check out or support the following organizations.

[RLadies](https://rladies.org/about-us/)  
[Women Who Code](https://www.womenwhocode.com/)  
[Girls Who Code](https://girlswhocode.com/)  
[Black Girls Code](http://www.blackgirlscode.com/)  
[National Center for Women & IT](https://www.ncwit.org/)  

### Grab the clean data here

```{r}
jobs_gender <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-05/jobs_gender.csv")
earnings_female <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-05/earnings_female.csv") 
employed_gender <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-05/employed_gender.csv") 
```

The original data came primarily from .xlsx sheets - I do **NOT** recommend cleaning them as an exercise - there are some major gotchas that are less than enjoyable. However I have uploaded the raw data and how I cleaned it if you are interested in taking a look. As a summary table the major and minor categories are indicated by indent but this doesn't translate nicely to either conversion to .csv or being read in directly as a .xlsx file.  


</br>

### Data Dictionary

[**jobs_gender.csv**](jobs_gender.csv)

## Data Dictionary

|variable              |class     |description |
|:---------------------|:---------|:-----------|
|year                  |integer   | Year          |
|occupation            |character | Specific job/career           |
|major_category        |character | Broad category of occupation           |
|minor_category        |character | Fine category of occupation           |
|total_workers         |double    | Total estimated full-time workers > 16 years old           |
|workers_male          |double    |  Estimated MALE full-time workers > 16 years old         |
|workers_female        |double    | Estimated FEMALE full-time workers > 16 years old |
|percent_female        |double    | The percent of females for specific occupation |
|total_earnings        |double    | Total estimated median earnings for full-time workers > 16 years old |
|total_earnings_male   |double    | Estimated MALE median earnings for full-time workers > 16 years old |
|total_earnings_female |double    | Estimated FEMALE median earnings for full-time workers > 16 years old |
|wage_percent_of_male  |double    | Female wages as percent of male wages - NA for occupations with small sample size  |
</br>

***

</br>

[**earnings_female.csv**](earnings_female.csv)

|variable |class     |description |
|:--------|:---------|:-----------|
|Year     |integer   | Year          |
|group    |character | Age group         |
|percent  |double    | Female salary percent of male salary |

***

</br>

[**employed_gender.csv**](employed_gender.csv)

|variable         |class  |description |
|:----------------|:------|:-----------|
|year             |double | Year          |
|total_full_time  |double | Percent of total employed people usually working full time         |
|total_part_time  |double | Percent of total employed people usually working part time          |
|full_time_female |double | Percent of employed women usually working full time          |
|part_time_female |double | Percent of employed women usually working part time         |
|full_time_male   |double | Percent of employed men usually working full time          |
|part_time_male   |double |Percent of employed men usually working part time        |


### Spoilers - Cleaning Script


```{r load libraries}
library(tidyverse)
library(readxl)
library(unpivotr)
library(tidyxl)
library(rvest)
```

### Dataset 1

```{r}
col_nm <- c(
  "category", "total_estimate", "total_moe3", "men_estimate", "men_moe3",
  "women_estimate", "women_moe3", "percent_women", "percent_women_moe3",
  "total_earnings_estimate", "total_earnings_moe3", "total_earnings_men_estimate", 
  "total_earnings_men_moe3", "total_earnings_women_estimate", "total_earnings_women_moe3", 
  "wage_percent_of_mens_estimate", "wage_percent_of_mens_moe3"
)

category_names <- readr::read_rds("category_names.rds") %>% str_remove_all(., ":")

earnings_2013 <- readxl::read_excel("median-earnings-2013-final.xlsx", skip = 6) %>%
  janitor::clean_names() %>%
  set_names(nm = col_nm) %>%
  filter(!is.na(total_estimate)) %>%
  mutate(year = 2013L) %>%
  mutate(category = category_names)

earnings_2014 <- readxl::read_excel("median-earnings-2014-final.xlsx", skip = 6) %>%
  janitor::clean_names() %>%
  set_names(nm = col_nm) %>%
  filter(!is.na(total_estimate)) %>%
  mutate(year = 2014L) %>%
  mutate(category = category_names)

earnings_2015 <- readxl::read_excel("median-earnings-2015-final.xlsx", skip = 6) %>%
  janitor::clean_names() %>%
  set_names(nm = col_nm) %>%
  filter(!is.na(total_estimate)) %>%
  filter(!str_detect(category, "Transportation and Material Moving Occupations")) %>%
  mutate(year = 2015L) %>%
  mutate(category = category_names)

earnings_2016 <- readxl::read_excel("median-earnings-2016-final.xlsx", skip = 6) %>%
  janitor::clean_names() %>%
  set_names(nm = col_nm) %>%
  filter(!is.na(total_estimate)) %>%
  filter(!str_detect(category, "Transportation and Material Moving Occupations")) %>%
  mutate(year = 2016L) %>%
  mutate(category = category_names)

all_years <- bind_rows(earnings_2013, earnings_2014, earnings_2015, earnings_2016) %>%
  filter(!str_detect(category, "Total"))
```

### Create the major category

Grabbed the major categories from the table by hand and did some basic checks to make sure everything came out ok.

```{r}

cat1 <- c(
  "Management, Business, and Financial Occupations",
  "Computer, Engineering, and Science Occupations",
  "Education, Legal, Community Service, Arts, and Media Occupations",
  "Healthcare Practitioners and Technical Occupations",
  "Service Occupations",
  "Sales and Office Occupations",
  "Natural Resources, Construction, and Maintenance Occupations",
  "Production, Transportation, and Material Moving Occupations"
)

length(cat1)

tibble(category_names) %>%
  filter(category_names %in% cat1) %>%
  nrow()

all.equal(cat1, tibble(category_names) %>%
  filter(category_names %in% cat1) %>%
  pull())

```

### Create the minor category

Grabbed the minor categories from the table by hand and did some basic checks to make sure everything came out ok.

```{r}

cat2 <- c(
  "Management Occupations",
  "Business and Financial Operations Occupations",
  "Computer and mathematical occupations",
  "Architecture and Engineering Occupations",
  "Life, Physical, and Social Science Occupations",
  "Community and Social Service Occupations",
  "Legal Occupations",
  "Education, Training, and Library Occupations",
  "Arts, Design, Entertainment, Sports, and Media Occupations",
  "Healthcare Practitioners and Technical Occupations",
  "Healthcare Support Occupations",
  "Protective Service Occupations",
  "Food Preparation and Serving Related Occupations",
  "Building and Grounds Cleaning and Maintenance Occupations",
  "Personal Care and Service Occupations",
  "Sales and Related Occupations",
  "Office and Administrative Support Occupations",
  "Farming, Fishing, and Forestry Occupations",
  "Construction and Extraction Occupations",
  "Installation, Maintenance, and Repair Occupations",
  "Production Occupations",
  "Transportation Occupations",
  "Material Moving Occupations"
)

length(cat2)

tibble(category_names) %>%
  filter(category_names %in% cat2) %>%
  nrow()

all.equal(cat2, tibble(category_names) %>%
  filter(category_names %in% cat2) %>%
  pull())
```
### Add new columns

Add the new columns and remove "occupations" from the text to shorten things out.

```{r}
category_added <- all_years %>%
  mutate(
    cat1 = case_when(
      category %in% cat1 ~ category,
      TRUE ~ NA_character_
    ),
    cat2 = case_when(
      category %in% cat2 ~ category,
      TRUE ~ NA_character_
    )
  ) %>%
  mutate(
    cat1 = str_remove(cat1, " Occupations"),
    cat1 = str_remove(cat1, " occupations"),
    cat2 = str_remove(cat2, " Occupations"),
    cat2 = str_remove(cat2, " occupations"),
    category = str_remove(category, " Occupations"),
    category = str_remove(category, "occupations")
  )

clean_all <- category_added %>%
  fill(cat1) %>%
  fill(cat2)
```

### Create final dataframe

Clean up the names, filter to remove the within-table summary stats and leave only the more discrete occupations.

```{r}

nm_final <- c("year", "occupation", "major_category", "minor_category", "total_workers", "workers_male", "workers_female", "percent_female", "total_earnings", "total_earnings_male", "total_earnings_female", "wage_percent_of_male")

final_all <- clean_all %>%
  filter(!str_detect(category, cat1)) %>%
  filter(!str_detect(category, cat2)) %>%
  filter(category != "Management,  Business, Science, and Arts Occupations") %>%
  filter(category != "Management, Business, and Financial Occupations") %>%
  filter(category != "Management,  Business, Science, and Arts") %>%
  filter(!is.na(cat1)) %>%
  filter(!is.na(cat2)) %>%
  select(year, occupation = category, major_category = cat1, minor_category = cat2, everything()) %>%
  select(-contains("moe")) %>%
  mutate_at(c("total_earnings_estimate", "total_earnings_men_estimate", "total_earnings_women_estimate", "wage_percent_of_mens_estimate"), as.numeric) %>%
  set_names(nm = nm_final)

```


### Mental and code checks


```{r}
final_all %>% 
  group_by(year) %>% count()
```


```{r}

final_all %>% 
  ggplot(aes(x = year, y = total_earnings, group = occupation)) +
  geom_line() +
  facet_wrap(~major_category, scales = "free")
```

### Scrape the additional datasets

```{r}
url <- "https://www.bls.gov/opub/ted/2012/ted_20121123.htm"

raw_html <- url %>%
  read_html()

women_earnings <- raw_html %>%
  html_table(fill = TRUE) %>%
  .[[1]] %>%
  gather(group, percent, 2:9)
```


```{r}
url2 <- "https://www.bls.gov/opub/ted/2017/percentage-of-employed-women-working-full-time-little-changed-over-past-5-decades.htm"

raw_html2 <- url2 %>%
  read_html()

women_employed <- raw_html2 %>%
  html_table(fill = TRUE) %>%
  .[[1]] %>%
  janitor::clean_names() %>%
  slice(2:50) %>%
  set_names(nm = c(
    "year", "total_full_time", "total_part_time", "full_time_female", "part_time_female",
    "full_time_male", "part_time_male"
  )) %>%
  mutate_all(parse_number)
```

