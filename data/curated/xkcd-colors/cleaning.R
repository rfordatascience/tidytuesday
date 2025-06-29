# Clean data provided by https://github.com/nrennie/xkcd-color-survey/. No further cleaning was necessary.
color_ranks <- readr::read_csv("https://raw.githubusercontent.com/nrennie/xkcd-color-survey/main/data/clean/color_ranks.csv")
answers <- readr::read_csv("https://raw.githubusercontent.com/nrennie/xkcd-color-survey/main/data/clean/answers.csv")
users <- readr::read_csv("https://raw.githubusercontent.com/nrennie/xkcd-color-survey/main/data/clean/users.csv")
