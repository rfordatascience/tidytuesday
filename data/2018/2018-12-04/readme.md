# Medium Data Science articles

This week's [dataset](https://github.com/rfordatascience/tidytuesday/blob/master/data/2018-12-04/medium_datasci.csv) was submitted by [Matthew Hendrickson](https://twitter.com/mjhendrickson), thanks! Also credit to [Kanishka Misra](https://twitter.com/iamasharkskin) who wanted to work with some text-based data via the [tidytext package](https://github.com/juliasilge/tidytext).

## Data

Data was originally scraped by [Harrison Jansma](https://github.com/harrisonjansma/Analyzing_Medium) and submitted as a [Kaggle dataset](https://www.kaggle.com/harrisonjansma/medium-stories).

The data-set originally consisted of 1.4 million stories from 95 of Medium’s most popular story-tags. Every story was published between August 1st, 2017 and August 1st, 2018.

For each story, Harrison collected all of the information present on a Medium story-card.

Here is the full list of the information he was able to collect for each story: Title, Sub-Title, Author, Publication, Date, Tags, Read-Time, Claps-Received, Story-URL, and Author-URL.

Given that this file was ~660 MB, I filtered the dataset to only articles with tags in: AI, Artificial Intelligience, big data, data, data science, data visualization, deep learning and machine learning. Feel free to use the original dataset if you want a deeper dive.

|column | description
|------|-----|
title| Title of the article
subtitle | Subtitle of the article
image | Header image present
author | Author's name
publication | Publication that the article was published under
year | Year
month | Month
day | Day
reading_time | Estimated reading time in minutes
claps | Number of claps (similar to likes, 1 person could clap many times)
url | url for the article
author_url | url for the author's Medium page
tag_ai | tag AI
tag_artificial_intelligience | tag artificial intelligience
tag_big_data | tag big data
tag_data |tag data
tag_data_science |tag data science
tag_data_visualization | tag data visualization
tag_deep_learning | tag deep learning
tag_machine_learning | tag machine learning
