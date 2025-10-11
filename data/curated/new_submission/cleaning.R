# data downloaded from https://onlinelibrary.wiley.com/doi/10.1111/test.12187 
# notes variable added to flint_mdeq to explain why samples were removed


load(here::here("tt_submission", "test12187-supp-0001-flint.rdata"))

# add notes

flint_mdeq <- flint_mdeq %>% 
  mutate(notes = case_when(lead == 104 & is.na(lead2) ~ "sample removed: house had a filter",
                           lead == 20 & is.na(lead2) ~ "sample removed: business not residence"))  

