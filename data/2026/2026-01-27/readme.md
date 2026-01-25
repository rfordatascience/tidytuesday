# Brazilian Companies

This week we’re exploring  **Brazilian Companies**, curated from Brazil’s open **CNPJ (Cadastro Nacional da Pessoa Jurídica)** records published by the **Brazilian Ministry of Finance / Receita Federal** on the national open-data portal ([dados.gov.br](https://dados.gov.br/dados/conjuntos-dados/cadastro-nacional-da-pessoa-juridica---cnpj)).

> The CNPJ open data is a large-scale public registry of Brazilian legal entities. For this dataset, the raw company records were cleaned and enriched with lookup tables (legal nature, owner qualification, and company size), then filtered to retain firms above a share-capital threshold so the analysis focuses on meaningful variation in capital stock.

* Which **legal nature** categories concentrate the highest total and average capital stock?
* How does **company size** relate to capital stock (and how skewed is it)?
* Do specific **owner qualification** groups dominate high-capital companies?
* What patterns emerge when comparing the **top capital-stock tail** across categories (legal nature, size, qualification)?

Thank you to [Marcelo Silva](https://github.com/MarcleoSilva) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-01-27')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 4)

companies <- tuesdata$companies
legal_nature <- tuesdata$legal_nature
qualifications <- tuesdata$qualifications
size <- tuesdata$size

# Option 2: Read directly from GitHub

companies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/companies.csv')
legal_nature <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/legal_nature.csv')
qualifications <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/qualifications.csv')
size <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/size.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-01-27')

# Option 2: Read directly from GitHub and assign to an object

companies = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/companies.csv')
legal_nature = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/legal_nature.csv')
qualifications = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/qualifications.csv')
size = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/size.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-01-27")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

companies = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/companies.csv")
legal_nature = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/legal_nature.csv")
qualifications = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/qualifications.csv")
size = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/size.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
companies = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/companies.csv", DataFrame)
legal_nature = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/legal_nature.csv", DataFrame)
qualifications = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/qualifications.csv", DataFrame)
size = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-27/size.csv", DataFrame)
```


## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.


## Data Dictionary

### `companies.csv`

| variable            | class     | description                                                                             |
| :------------------ | :-------- | :-------------------------------------------------------------------------------------- |
| company_id          | integer   | Company identifier (8-digit ID used as the primary key in this dataset).                |
| company_name        | character | Company legal name (as provided in the source registry).                                |
| legal_nature        | character | Company legal nature (e.g., “Limited Liability Business Company (LLC)”).              |
| owner_qualification | character | Owner/partner qualification label (e.g., “Managing Partner / Partner-Administrator”). |
| capital_stock       | numeric   | Declared share capital (**BRL**), numeric.                                        |
| company_size        | character | Company size category (e.g.,`micro-enterprise`, `small-enterprise`, `other`).     |

### `legal_nature.csv`

| variable     | class     | description                                 |
| :----------- | :-------- | :------------------------------------------ |
| id           | integer   | Legal nature code (source registry code).   |
| legal_nature | character | Legal nature label corresponding to `id`. |

### `qualifications.csv`

| variable            | class     | description                                        |
| :------------------ | :-------- | :------------------------------------------------- |
| id                  | integer   | Owner qualification code (source registry code).   |
| owner_qualification | character | Owner qualification label corresponding to `id`. |

### `size.csv`

| variable     | class     | description                                                                                    |
| :----------- | :-------- | :--------------------------------------------------------------------------------------------- |
| id           | integer   | Company size code (source registry code).                                                      |
| company_size | character | Company size label corresponding to `id` (e.g., `micro-enterprise`, `small-enterprise`). |

## Cleaning Script

```r
# Imports
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import csv

# Input data
companies0 = pd.read_csv("../raw_data/raw_companies.csv", sep=";", encoding="cp1252", header=None)

legal_nature = pd.read_csv('../raw_data/legal_nature.csv', sep=',')

sizes = pd.read_csv("../raw_data/size.csv", sep=",", encoding="cp1252")

qualifications = pd.read_csv("../raw_data/qualifications.csv", sep = ",", encoding="cp1252")

# Remove all private associations
def treat_companies_dataframe(dataframe):
    companies_df_column_name = ["company_id", "company_name","legal_nature", "owner_qualification","capital_stock","company_size","federal_owner"]

    dataframe.columns = companies_df_column_name

    dataframe['capital_stock'] = dataframe['capital_stock'].str.replace(',', '.')
    dataframe['capital_stock'] = pd.to_numeric(dataframe['capital_stock'], errors='coerce')
    
    dataframe_filtered = dataframe[dataframe['capital_stock'] > 150000]
    dataframe_filtered = dataframe_filtered.drop(columns=["federal_owner"])
    
    return dataframe_filtered

def mapper(dataframe, dictionary: dict, column_name: str):
    dataframe[column_name] = dataframe[column_name].map(dictionary)
    return dataframe

def replace_info(dataframe):
    legal_nature_dict = dict(zip(legal_nature['id'], legal_nature['legal_nature']))
    qualification_dict = dict(zip(qualifications['id'], qualifications['owner_qualification']))
    size_dict = dict(zip(sizes['id'], sizes['company_size']))

    dataframe = mapper(dataframe, legal_nature_dict, 'legal_nature')
    dataframe = mapper(dataframe, qualification_dict, "owner_qualification")
    dataframe = mapper(dataframe, size_dict, 'company_size')

    return dataframe

def merge_and_clean(df_top, df_bottom):

    combined_df = pd.concat([df_top, df_bottom], ignore_index=True)
    
    cleaned_df = combined_df.drop_duplicates()
    
    return cleaned_df

filtered_df0 = treat_companies_dataframe(companies0)

filtered_df0 = replace_info(filtered_df0)

with open("../data/companies.csv", mode="w", newline='') as file:
    write = csv.writer(file, delimiter=';')
    write.writerow(filtered_df0.columns) 
    write.writerows(filtered_df0.values.tolist())

```
