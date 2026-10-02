# ==============================================================================
# AmphibiaWeb (Order Anura - Frogs & Toads)
#
# NOTE:
# AmphibiaWeb enforces Cloudflare Turnstile protection, which blocks automated
# HTTP script downloads. 
#
# INSTRUCTIONS:
# 1. Download 'amphib_dump.xml' manually from:
#    https://amphibiaweb.org/amphib_dump.xml
# 2. Place 'amphib_dump.xml' into your working directory.
# 3. Run this script to parse, filter, clean, and export the final dataset.
# ==============================================================================

library(tidyverse)
library(xml2)

raw_xml_file <- "amphib_dump.xml"

# 1. Check for required local XML dump
if (!file.exists(raw_xml_file)) {
  stop(
    "\n[ERROR] Missing source file: 'amphib_dump.xml'\n",
    "Please download the XML file directly from https://amphibiaweb.org/amphib_dump.xml\n",
    "and save it in your project directory before running this script."
  )
}

message("Reading local AmphibiaWeb XML dump...")

# 2. Read XML document with recovery mode enabled for minor syntax tolerance
xml_doc <- read_xml(raw_xml_file, options = "RECOVER")

# 3. Extract species nodes
species_nodes <- xml_find_all(xml_doc, "//species")
message(paste("Successfully found", length(species_nodes), "total species records in XML."))

# 4. Unnest XML nodes into a wide data frame
message("Unnesting XML nodes into tabular format...")
raw_df <- map_dfr(species_nodes, function(node) {
  children <- xml_children(node)
  keys <- xml_name(children)
  vals <- xml_text(children)
  
  tibble(key = keys, val = vals) %>% 
    group_by(key) %>% 
    summarise(val = paste(val, collapse = " | "), .groups = "drop") %>% 
    pivot_wider(names_from = key, values_from = val)
})

# 5. Clean column names and locate order field
raw_df_clean <- raw_df %>% 
  rename_with(str_to_lower)

order_col <- names(raw_df_clean)[str_detect(names(raw_df_clean), "^ordr$|^order$")][1]

if (is.na(order_col)) {
  stop("Could not locate an 'ordr' or 'order' column in the parsed XML dataset.")
}

message(paste("Filtering records on order column:", order_col))

# 6. Filter strictly for Order Anura (Frogs & Toads)
anura_df <- raw_df_clean %>% 
  filter(str_trim(str_to_lower(.data[[order_col]])) == "anura")

# 7. Clean whitespace, convert empty strings to NA, and parse column data types
message("Curating columns and parsing data types...")
anura_curated <- anura_df %>% 
  # 7.1. Strip leading/trailing whitespace and \n characters across all character columns
  mutate(across(where(is.character), str_trim)) %>% 
  
  # 7.2. Convert empty strings ("") or whitespace-only strings to true R NAs
  mutate(across(where(is.character), ~ na_if(.x, ""))) %>% 
  
  # 7.3. Explicitly parse numeric and date columns
  mutate(
    amphib_id   = as.integer(amphib_id),
    submit_date = ymd(submit_date),
    edit_date   = ymd(edit_date),
    interntnl_status = as.character(interntnl_status)
  )

# 8. Export final curated CSV file
# Target the TidyTuesday dataset sub-directory if it exists, otherwise fall back to root
target_dir <- "frogs_and_toads_amphibiaweb"
output_filename <- "frogs_and_toads_amphibiaweb.csv"

output_path <- if (dir.exists(target_dir)) {
  file.path(target_dir, output_filename)
} else {
  output_filename
}

write_csv(x = anura_curated, file = output_path)
message(paste0("Done! Successfully exported ", nrow(anura_curated), " species to '", output_path, "'."))

# 9. Print dataset dictionary summary table
message("Dataset Schema Overview:")
tibble(
  column_name  = names(anura_curated),
  data_type    = map_chr(anura_curated, ~ class(.x)[1]),
  sample_value = map_chr(anura_curated, ~ as.character(na.omit(.x))[1] %||% NA_character_)
) %>% 
  print(n = Inf)
