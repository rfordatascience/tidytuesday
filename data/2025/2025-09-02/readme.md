# Australian Frogs

This week we're exploring 2023 data from the sixth annual release of [FrogID data](https://www.frogid.net.au/explore). 

FrogID is an Australian frog call identification initiative. The FrogID mobile app allows citizen scientists to record and submit frog calls for museum experts to identify. Since 2017, FrogID data has contributed to over 30 scientific papers exploring frog ecology, taxonomy, and conservation.

> Australia is home to a unique and diverse array of frog species found almost nowhere else on Earth, with 257 native species distributed throughout the continent. But Australia’s frogs are in peril – almost one in five species are threatened with extinction due to threats such as climate change, urbanisation, disease, and the spread of invasive species.

Some questions you might explore: 
- Are there species that are endemic to certain regions?
- Do different frog species have distinct calling seasons?
- Which species has the widest geographic range? Which is the rarest?

Primary citation for FrogID data:
Rowley JJL, & Callaghan CT (2020) The FrogID dataset: expert-validated occurrence records of Australia’s frogs collected by citizen scientists. ZooKeys 912: 139-151

Official frog name data:
Australian Society of Herpetologists Official List of Australian Species. 2025. http://www.australiansocietyofherpetologists.org/ash-official-list-of-australian-species.

Thank you to [Jessica Moore](https://github.com/jessjep) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-09-02')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 35)

frogID_data <- tuesdata$frogID_data
frog_names <- tuesdata$frog_names

# Option 2: Read directly from GitHub

frogID_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-02/frogID_data.csv')
frog_names <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-02/frog_names.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-09-02')

# Option 2: Read directly from GitHub and assign to an object

frogID_data = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-02/frogID_data.csv')
frog_names = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-02/frog_names.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-09-02')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

frogID_data = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-02/frogID_data.csv")
frog_names = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-02/frog_names.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
frogID_data = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-02/frogID_data.csv", DataFrame)
frog_names = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-02/frog_names.csv", DataFrame)
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

### `frogID_data.csv`

|variable                      |class     |description                           |
|:-----------------------------|:---------|:-------------------------------------|
|occurrenceID                  |double    |Occurrence ID. |
|eventID                       |double    |Event ID. |
|decimalLatitude               |double    |Latitude of frog recording. |
|decimalLongitude              |double    |Longitude of frog recording. |
|scientificName                |character |Scientific frog name. |
|eventDate                     |date      |Date of recording. |
|eventTime                     |character |Time of recording in 24-hour format. |
|timezone                      |character |Time zone of recording. |
|coordinateUncertaintyInMeters |double    |Uncertainty of coordinates. Exact locality is buffered for sensitive or endangered species. |
|recordedBy                    |double    |User ID. |
|stateProvince                 |character |State or territory. |

### `frog_names.csv`

|variable              |class     |description                           |
|:---------------------|:---------|:-------------------------------------|
|subfamily             |character |Name of frog subfamily. |
|tribe                 |character |Name of frog tribe. |
|scientificName        |character |Scientific frog name. |
|commonName            |character |Common frog name. |
|secondary_commonNames |character |Secondary frog name/s. |

## Cleaning Script

```r
library(tidyverse)
library(here)

# download and clean frogID data
frogID <- here("frog_data.csv")

download.file("https://d2pifd398unoeq.cloudfront.net/FrogID6_final_dataset.csv",
              destfile = frogID, mode = "wb")

frogID_data <- read_csv("frog_data.csv") %>%
  # remove columns containing only one unique value and other unnecessary columns
  select(-c(datasetName, basisOfRecord, dataGeneralizations,
            sex, lifestage, behavior, samplingProtocol, country,
            machineObservation, geoprivacy,
            modified)) %>%
  # restrict to 2023 data only to reduce file size
  filter(format(eventDate, "%Y") == "2023") %>%
  # split time column into time and timezone
  separate_wider_regex(eventTime,
    patterns = c(eventTime = "^\\d{2}:\\d{2}:\\d{2}", timezone   = ".*$")) %>%
  mutate(timezone = ifelse(grepl("^[+-]", timezone), paste0("GMT", timezone), timezone))


# read and tidy frog name and common name data
download.file("https://raw.githubusercontent.com/jessjep/Frogs/main/frog_names.xlsx",
              destfile = "frog_names.xlsx", mode = "wb")

frog_names <- readxl::read_xlsx("frog_names.xlsx") %>%
  select(1:4) %>%
  separate_wider_delim(`GROUP, FAMILY, SUBFAMILY, TRIBE`, delim = ",",
                       names = c("family", "subfamily", "tribe")) %>%
  rename(scientificName = `GENUS SPECIES SUBSPECIES`,
         commonName = `COMMON NAME`,
         secondary_commonNames = `SECONDARY COMMON NAMES`) %>%
  select(-1)

frog_names[frog_names == "—"] <- NA

```
