# Data downloaded from https://dashboard.repairmonitor.org/?language=en, cleaning to fix variable names and data types

repairs <- readxl::read_xlsx("repairs-en.xlsx") %>%
  janitor::clean_names() %>%
  dplyr::mutate(repair_date = ymd(repair_date), 
         repair_cafe_number = as.integer(repair_cafe_number), 
         estimated_year_of_production = as.integer(estimated_year_of_production),   
         if_not_repaired_why_could_you_not_repair_it_open_answer = as.character(if_not_repaired_why_could_you_not_repair_it_open_answer),
         reparability_of_product_1_difficult_10_easy = as.integer(reparability_of_product_1_difficult_10_easy))
         
         

