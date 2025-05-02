

# Fetch data from the CSV download link at https://grant-watch.us/nsf-data.html
raw_nsf_terminations <- readr::read_csv("https://drive.usercontent.google.com/download?id=1TFoyowiiMFZm73iU4YORniydEeHhrsVz&export=download")

# Clean the data
nsf_terminations <- raw_nsf_terminations |> 
  janitor::clean_names() |> 
  mutate(usaspending_obligated = stringi::stri_replace_first_fixed(usaspending_obligated, "$", "") |> 
           readr::parse_number()) |> 
  mutate(in_cruz_list = !is.na(in_cruz_list)) |> 
  mutate(grant_number = as.character(grant_number)) 

# Save the cleaned data to a CSV file
tt_save_dataset(nsf_terminations)

  