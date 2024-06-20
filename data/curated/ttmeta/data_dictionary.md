### Data Dictionary

# `tt_summary.csv`

|variable      |class     |description   |
|:-------------|:---------|:-------------|
|year          |integer   |The year in which the dataset was realeased. |
|week          |integer   |The week number for this dataset within this year. |
|date          |Date      |The date of the Tuesday of this week. |
|title         |character |The overall title of this week's TidyTuesday. This is different from the individual dataset titles (although often similar). |
|source_title  |character |The title of this week's source. If there are multiple sources, there is still a single title merging them. |
|article_title |character |The title of this week's article. If there are multiple articles, there is still a single title merging them. |

# `tt_urls.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|year      |integer   |The year in which the dataset was realeased. |
|week      |integer   |The week number for this dataset within this year. |
|type      |factor    |Whether this url appeared as an "article" or as a data "source". |
|url       |character |The full url. |
|scheme    |factor    |Whether this url uses "http" or "https". |
|domain    |character |The main part of the url. For example, in www.google.com, "google" would be the domain for this column. |
|subdomain |character |The part of the url before the period (when present). For example, in www.google.com, "www" would be the subdomain for this column. |
|tld       |character |The top-level domain, the part of the url after the domain. For example, in www.google.com, "com" would be the tld for this column. |
|path      |character |The part of the url after the slash but before any "?" or "#" (when present). For example, in www.google.com/maps/place/Googleplex, "maps/place/Googleplex" would be the path for this column. |
|query     |character |The parts of the url after "?" (when present). For example, for example.com/source?a=1&b=2, this column would contain "a=1&b=2" |
|fragment  |character |The part of the url after "#" (when present). for example, for cascadiarconf.com/agenda/#craggy, this column would contain "craggy". |

# `tt_datasets.csv`

|variable     |class     |description  |
|:------------|:---------|:------------|
|year         |integer   |The year in which the dataset was realeased. |
|week         |integer   |The week number for this dataset within this year. |
|dataset_name |character |The name of this dataset. Some weeks have multiple datasets. |
|variables    |integer   |The number of columns in this dataset. |
|observations |integer   |The number of rows in this dataset. |

# `tt_variables.csv`

|variable     |class     |description  |
|:------------|:---------|:------------|
|year         |integer   |The year in which the dataset was realeased. |
|week         |integer   |The week number for this dataset within this year. |
|dataset_name |character |The name of this dataset. Some weeks have multiple datasets. |
|variable     |character |The name of this variable. |
|class        |character |The class of this variable. |
|n_unique     |integer   |The number of unique values of this variable within this dataset. |
|min          |character |The "lowest" value of this variable (lowest number, first value alphabetically, etc). |
|max          |character |The "highest" value of this variable (highest number, last value alphabetically, etc). |
|description  |character |A short description of this variable. |
