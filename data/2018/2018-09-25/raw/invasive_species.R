library(tidyverse)

df <- read_csv("afr_species.csv") %>% 
        janitor::clean_names() %>% 
        select(species:origin)

df %>% write_csv("africa_species.csv")

df1 <- read_csv("table1.csv") %>% janitor::clean_names()
tab_1 <- df1 %>% 
        select(rank:o_tt) %>% 
        bind_rows(df1 %>% 
                          select(rank_1:o_tt_1) %>% 
                          set_names("rank", "country", "o_tt")
        ) %>% 
        bind_rows(df1 %>% 
                          select(rank_2:o_tt_2) %>% 
                          set_names("rank", "country", "o_tt")
        ) %>% 
        filter(!is.na(rank)) %>% 
        rename("invasion_threat" = o_tt)

df2 <- read_csv("table2.csv") %>% janitor::clean_names()
tab_2 <- df2 %>% 
        select("country" = x1, "ti_ct" = ti_ct_millions) %>% 
        mutate(rank = parse_number(country),
               country = str_extract(country, "[:alpha:].*$"),
               ti_ct = parse_number(ti_ct) * 1000000) %>% 
        filter(!is.na(rank)) %>%
        bind_rows(df2 %>% 
                select("country" = x4, "ti_ct" = ti_ct_millions_1) %>% 
                        mutate(rank = parse_number(country),
                               country = str_extract(country, "[:alpha:].*$"),
                               ti_ct = parse_number(ti_ct) * 1000000) %>% 
                        filter(!is.na(rank))
        ) %>% 
        bind_rows(df2 %>% 
                          select("country" = x7, "ti_ct" = ti_ct_millions_2) %>% 
                          mutate(rank = parse_number(country),
                                 country = str_extract(country, "[:alpha:].*$"),
                                 ti_ct = parse_number(ti_ct) * 1000000) %>% 
                          filter(!is.na(rank))
                
        ) %>% 
        rename("invasion_cost" = ti_ct)

df3 <- read_csv("table3.csv") %>% janitor::clean_names()
tab_3 <- df3 %>% 
        select("country" = x1, "ti_ct" = ti_ct_millions, 
               "gdp_mean" = x4, "gdp_proportion" = proportion_of) %>% 
        mutate(rank = parse_number(country),
               country = str_extract(country, "[:alpha:].*$"),
               ti_ct = parse_number(ti_ct) * 1000000,
               gdp_mean = parse_number(gdp_mean) * 1000000,
               gdp_proportion = as.numeric(gdp_proportion)
        ) %>% 
        filter(!is.na(rank)) %>%
        bind_rows(df3 %>% 
                          select("country" = x6, "ti_ct" = ti_ct_millions_1, 
                                 "gdp_mean" = x9, "gdp_proportion" = proportion_of_1) %>% 
                          mutate(rank = parse_number(country),
                                 country = str_extract(country, "[:alpha:].*$"),
                                 ti_ct = parse_number(ti_ct) * 1000000,
                                 gdp_mean = parse_number(gdp_mean) * 1000000,
                                 gdp_proportion = as.numeric(gdp_proportion)
                          ) %>% 
                          filter(!is.na(rank))
        ) %>%
        bind_rows(df3 %>% 
                          select("country" = x11, "ti_ct" = ti_ct_millions_2, 
                                 "gdp_mean" = x14, "gdp_proportion" = proportion_of_2) %>% 
                          mutate(rank = parse_number(country),
                                 country = str_extract(country, "[:alpha:].*$"),
                                 ti_ct = parse_number(ti_ct) * 1000000,
                                 gdp_mean = parse_number(gdp_mean) * 1000000,
                                 gdp_proportion = as.numeric(gdp_proportion)
                          ) %>% 
                          filter(!is.na(rank))
        ) %>% 
        rename("invasion_cost" = ti_ct)

df4 <- read_csv("table4.csv") %>% janitor::clean_names()
tab_4 <- df4 %>% 
        select("country" = rank_country, "ti_cs" = ti_cs_millions_us) %>% 
        mutate(rank = parse_number(country),
               country = str_extract(country, "[:alpha:].*$"),
               ti_cs = parse_number(ti_cs) * 1000000
               ) %>% 
        filter(!is.na(rank)) %>%
        bind_rows(df4 %>% 
                          select("country" = rank_country_1, "ti_cs" = ti_cs_millions_us_1) %>% 
                          mutate(rank = parse_number(country),
                                 country = str_extract(country, "[:alpha:].*$"),
                                 ti_cs = parse_number(ti_cs) * 1000000
                          ) %>% 
                          filter(!is.na(rank))
                  ) %>%
        bind_rows(df4 %>% 
                          select("country" = rank_country_2, "ti_cs" = ti_cs_millions_us_2) %>% 
                          mutate(rank = parse_number(country),
                                 country = str_extract(country, "[:alpha:].*$"),
                                 ti_cs = parse_number(ti_cs) * 1000000
                          ) %>% 
                          filter(!is.na(rank))
        ) %>% 
        rename("invasion_cost" = ti_cs)

df6 <- read_csv("table6.csv") %>% janitor::clean_names()
tab_6 <- df6 %>% 
        select(species, "max_impact_percent" = maximum_reported_species) %>%
        filter(!is.na(species)) %>% 
        mutate(rank = 1:n(),
               species = species,
               max_impact_percent = parse_number(max_impact_percent)
        ) %>% 
        bind_rows(df6 %>% 
                          select("species" = maximum_reported_species, 
                                 "max_impact_percent" = maximum_reported_species_1) %>%
                          filter(species != "% impact") %>% 
                          mutate(rank = 1:n(),
                                 species = str_extract(species, "[:alpha:].*$"),
                                 max_impact_percent = parse_number(max_impact_percent)
                          )
        ) %>%
        bind_rows(df6 %>% 
                          select("species" = maximum_reported_species_1, 
                                 "max_impact_percent" = maximum_reported) %>%
                          filter(species != "% impact") %>% 
                          mutate(rank = 1:n(),
                                 species = str_extract(species, "[:alpha:].*$"),
                                 max_impact_percent = parse_number(max_impact_percent)
                          )
        ) %>% 
        filter(!is.na(species))

tab_list <- list(table_1 = tab_1, table_2 = tab_2, table_3 = tab_3, table_4 = tab_4, table_6 = tab_6)

tab_list %>% 
        names() %>% 
        walk(~ write_csv(tab_list[[.]], glue::glue("{.}.csv")))
