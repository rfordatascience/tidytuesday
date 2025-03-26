read_piece <- function(filename) {
  readLines(filename, warn = FALSE) |> 
    paste(collapse = "\n") |> 
    stringr::str_remove_all("<!--[\\s\\S]*?-->") |> 
    stringr::str_trim() |> 
    stringr::str_c("\n")
}
