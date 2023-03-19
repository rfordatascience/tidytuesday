### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here’s a simple formula for writing alt text for data visualization:
> ### Chart type
> It’s helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you’re including this visual. What does it show that’s meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don’t include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Programming Languages

The data this week comes from the [Programming Language DataBase](https://pldb.com/index.html). Thanks to [Jesus M. Castagnetto](https://github.com/rfordatascience/tidytuesday/issues/530) for the suggestion!

The PLDB has a [blog](https://pldb.com/posts/index.html) with numerous articles exploring the data, such as [Does every programming language have line comments?](https://pldb.com/posts/does-every-programming-language-support-line-comments.html).

The data is user-submitted, so you might want to confirm the accuracy of anything particularly surprising that you find before stating it with certainty!

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-03-21')
tuesdata <- tidytuesdayR::tt_load(2023, week = 12)

languages <- languages

# Or read in the data manually

languages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-03-21/languages.csv')
```

### Data Dictionary

# `languages.csv`

The [full data dictionary](https://pldb.com/csv.html) is available from PLDB.com.

|variable                          |class     |description |
|:---------------------------------|:---------|:-----------|
|pldb_id                           |character |A standardized, uniquified version of the language name, used as an ID on the PLDB site.|
|title                             |character |The official title of the language.|
|description                       |character |Description of the repo on GitHub.|
|type                              |character |Which category in PLDB's subjective ontology does this entity fit into.|
|appeared                          |double    |What year was the language publicly released and/or announced?|
|creators                          |character |Name(s) of the original creators of the language delimited by " and "|
|website                           |character |URL of the official homepage for the language project.|
|domain_name                       |character |If the project website is on its own domain.|
|domain_name_registered            |double    |When was this domain first registered?|
|reference                         |character |A link to more info about this entity.|
|isbndb                            |double    |Books about this language from [ISBNdb](https://isbndb.com/).|
|book_count                        |double    |Computed; the number of books found for this language at isbndb.com|
|semantic_scholar                  |integer   |Papers about this language from Semantic Scholar.|
|language_rank                     |double    |Computed; A rank for the language, taking into account various online rankings. The computation for this column is not currently clear.|
|github_repo                       |character |URL of the official GitHub repo for the project if it hosted there.|
|github_repo_stars                 |double    |How many stars of the repo?|
|github_repo_forks                 |double    |How many forks of the repo?|
|github_repo_updated               |double    |What year was the last commit made?|
|github_repo_subscribers           |double    |How many subscribers to the repo?|
|github_repo_created               |double    |When was the *Github repo* for this entity created?|
|github_repo_description           |character |Description of the repo on GitHub.|
|github_repo_issues                |double    |How many isses on the repo?|
|github_repo_first_commit          |double    |What year the first commit made in this git repo?|
|github_language                   |character |GitHub has a set of supported languages as defined [here](https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml)|
|github_language_tm_scope          |character |The TextMate scope that represents this programming language.|
|github_language_type              |character |Either data, programming, markup, prose, or nil.|
|github_language_ace_mode          |character |A String name of the Ace Mode used for highlighting whenever a file is edited. This must match one of the filenames in http://git.io/3XO_Cg. Use "text" if a mode does not exist.|
|github_language_file_extensions   |character |An Array of associated extensions (the first one is considered the primary extension, the others should be listed alphabetically).|
|github_language_repos             |double    |How many repos for this language does GitHub report?|
|wikipedia                         |character |URL of the entity on Wikipedia, if and only if it has a page dedicated to it.|
|wikipedia_daily_page_views        |double    |How many page views per day does this Wikipedia page get? Useful as a signal for rankings. Available via WP api.|
|wikipedia_backlinks_count         |double    |How many pages on WP link to this page?|
|wikipedia_summary                 |character |What is the text summary of the language from the Wikipedia page?|
|wikipedia_page_id                 |double    |Waht is the internal ID for this entity on WP?|
|wikipedia_appeared                |double    |When does Wikipedia claim this entity first appeared?|
|wikipedia_created                 |double    |When was the *Wikipedia page* for this entity created?|
|wikipedia_revision_count          |double    |How many revisions does this page have?|
|wikipedia_related                 |character |What languages does Wikipedia have as related?|
|features_has_comments             |logical   |Does this language have a comment character?|
|features_has_semantic_indentation |logical   |Does indentation have semantic meaning in this language?|
|features_has_line_comments        |logical   |Does this language support inline comments (as opposed to comments that must span an entire line)?|
|line_comment_token                |character |Defined as a token that can be placed anywhere on a line and starts a comment that cannot be stopped except by a line break character or end of file.|
|last_activity                     |double    |Computed; The most recent of any year field in the PLDB for this language.|
|number_of_users                   |double    |Computed; "Crude user estimate from a linear model.|
|number_of_jobs                    |double    |Computed; The estimated number of job openings for programmers in this language.|
|origin_community                  |character |In what community(ies) did the language first originate?|
|central_package_repository_count  |double    |Number of packages in a central repository. If this value is not known, it is set to 0 (so "0" can mean "no repository exists", "the repository exists but is empty" (unlikely), or "we do not know if a repository exists". This value is definitely incorrect for R.|
|file_type                         |character |What is the file encoding for programs in this language?|
|is_open_source                    |logical   |Is it an open source project?|


### Cleaning Script

```r
library(tidyverse)
library(janitor)
library(knitr)

languages_url <- "https://pldb.com/languages.csv"

languages_raw <- read_csv(
  languages_url, 
  # Some of the columns are very sparse, so have readr use everything for
  # guessing.
  guess_max = 4303
) |> 
  clean_names() |>
  # The semantic_scholar column is misformed for a handful of languages. It's ok
  # to introduce NAs here.
  mutate(
    semantic_scholar = as.integer(semantic_scholar)
  )
  

# Almost all columns are almost completely empty. Keep the columns that have
# more than 10% coverage.
good_lang_cols <- languages_raw |> 
  summarize(
    across(everything(), ~sum(!is.na(.x)))
  ) |>
  tidyr::pivot_longer(
    everything(),
    names_to = "column",
    values_to = "non_empty"
  ) |> 
  mutate(
    coverage = non_empty/nrow(languages_raw)
  ) |> 
  filter(coverage > 0.1) |> 
  pull(column)

languages <- languages_raw |> 
  select(!!!good_lang_cols) |> 
  # This column references a site that doesn't want to be used in projects.
  select(-hopl) |> 
  # A couple columns are only relevant in the context of the mixed table with
  # non-languages included.
  select(-number_of_repos, -rank, -paper_count) |> 
  # Some columns are internal metadata that is no longer true with this subset.
  select(-fact_count, -example_count) |> 
  # I looked at R specifically, and the "country" column was inaccurate. Let's
  # not confuse people with known bad data.
  select(-country) |> 
  # Organize the columns.
  select(
    pldb_id,
    title,
    description,
    type,
    appeared,
    creators,
    website,
    starts_with("domain_name"),
    reference,
    isbndb,
    book_count,
    semantic_scholar,
    language_rank,
    starts_with("github_"),
    starts_with("wikipedia"),
    starts_with("features_"),
    line_comment_token,
    everything()
  )

write_csv(
  languages, 
  file = here::here(
    "data",
    "2023",
    "2023-03-21",
    "languages.csv"
  )
)

# Use the online dictionary to help with the dictionary in the post.
dictionary_url <- "https://pldb.com/columns.csv"
dictionary <- read_csv(dictionary_url) |> 
  clean_names() |> 
  # I only need the column name and description for our dictionary.
  select(column, description) |> 
  # I cleaned the column names, so let's do the same here.
  mutate(
    column = make_clean_names(column)
  ) |> 
  # We don't need the extras.
  filter(
    column %in% colnames(languages)
  )
# Arrange dictionary to match the order of colnames(languages).
dictionary <- dictionary[match(colnames(languages), dictionary$column), ]

dictionary |> 
  mutate(
    class = map_chr(languages, typeof)
  ) |> 
  select(
    variable = column,
    class,
    description
  ) |> 
  knitr::kable()
```
