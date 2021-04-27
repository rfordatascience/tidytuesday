![Image of blurred moving people walking through an office lobby](https://images.unsplash.com/photo-1454923634634-bd1614719a7b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80)

# CEO Departures

The data this week comes from [Gentry et al.](https://onlinelibrary.wiley.com/doi/abs/10.1002/smj.3278) by way of [DataIsPlural](https://www.data-is-plural.com/archive/2021-04-21-edition/).

> We introduce an open‐source dataset documenting the reasons for CEO departure in S&P 1500 firms from 2000 through 2018. In our dataset, we code for various forms of voluntary and involuntary departure. We compare our dataset to three published datasets in the CEO succession literature to assess both the qualitative and quantitative differences among them and to explore how these differences impact empirical findings associated with the performance‐CEO dismissal relationship. The dataset includes eight different classifications for CEO turnover, a narrative description of each departure event, and links to sources used in constructing the narrative so that future researchers can validate or adapt the coding. The resulting data are available at (https://doi.org/10.5281/zenodo.4543893).
>
> This revision includes potentially relevant 8k filings from 270 days before and after the CEO's departure date. These filings were not all useful for understanding the departure, but might be useful in general.

Another article from [investors.com](https://www.investors.com/news/ceo-turnover-bailing-out-droves/).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-04-27')
tuesdata <- tidytuesdayR::tt_load(2021, week = 18)

departures.csv <- tuesdata$departures.csv

# Or read in the data manually

departures <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-27/departures.csv')

```
### Data Dictionary

# `departures.csv`

|variable             |class     |description |
|:--------------------|:---------|:-----------|
|dismissal_dataset_id |double    |The primary key. This will change from one version to the next. gvkey-year is also a unique identifier|
|coname               |character |The Compustat Company Name |
|gvkey                |double    | The Compustat Company identifier |
|fyear                |double    | The fiscal year in which the event occured  |
|co_per_rol           |double    | The executive/company identifier from Execucomp |
|exec_fullname        |character | The executive full name as listed in Execucomp  |
|departure_code       |double    | The departure reason coded from criteria abov |
|ceo_dismissal        |double    | A dummy code for involuntary, non-health related turnover (Codes 3 & 4). |
|interim_coceo        |character | A descriptor of whether the CEO was listed as co-CEO or as an interim CEO (sometimes interim positions last a couple years) |
|tenure_no_ceodb      |double    | For CEOs who return, this value should capture whether this is the first or second time in office |
|max_tenure_ceodb     |double    | For this CEO, how many times did s/he serve as CEO |
|fyear_gone           |double    | An attempt to determine the fiscal year of the CEO’s effective departure date. Occasionally, looking at departures on Execucomp does not agree with the leftofc date that we have. They apparently try to balance between the CEO serving one month in the fiscal year against documenting who was CEO on the date of record. I would stick to the Execucomp’s fiscal year, departure indication for consistency with prior work |
|leftofc              |double    | Left office of CEO, modified occasionally from execucomp but same interpretation. The date of effective departure from the office of CEO |
|still_there          |character | A date that indicates the last time we checked to see if the CEO was in office. If no date, then it looks like the CEO is still in office but we are in the process of checking |
|notes                |character | Long-form description and justification for the coding scheme assignment.  |
|sources              |character | URL(s) of relevant sources from internet or library sources. |
|eight_ks             |character | URL(s) of 8k filing from the Securities and Exchange Commission from 270 days before through 270 days after the CEO’s leftofc date which might relate to the turnover. Included here are any 8k filing 5.02 (departure of directors or principal executives) or simply item 5 if it is an older filing. These were collected without examining their content. |
|cik                  |double    | The company’s Central Index Key |
|_merge               |character | Merge details |

### CEO Departure Code

| Code Number             | Type     | description |
|:--------------------|:---------|:-----------|
| 1 | Involuntary - CEO death | The CEO died while in office and did not have an opportunity to resign before health failed. |
|2|Involuntary - CEO illness|Required announcement that the CEO was leaving for health concerns rather than removed during a health crisis.|
|3| Involuntary – CEO dismissed for job performance | The CEO stepped down for reasons related to job performance. This included situations where the CEO was immediately terminated as well as when the CEO was given some transition period, but the media coverage was negative. Often the media cited financial performance or some other failing of CEO job performance (e.g., leadership deficiencies, innovation weaknesses, etc.).|
|4|Involuntary - CEO dismissed for legal violations or concerns|The CEO was terminated for behavioral or policy-related problems. The CEO's departure was almost always immediate, and the announcement cited an instance where the CEO violated company HR policy, expense account cheating, etc.|
|5|Voluntary - CEO retired|Voluntary retirement based on how the turnover was reported in the media. Here the departure did not sound forced, and the CEO often had a voice or comment in the succession announcement. Media coverage of voluntary turnover was more valedictory than critical. Firms use different mandatory retirement ages, so we could not use 65 or older and facing mandatory retirement as a cut off. We examined coverage around the event and subsequent coverage of the CEO’s career when it sounded unclear. |
|6|Voluntary - new opportunity (new career driven succession)|The CEO left to pursue a new venture or to work at another company. This frequently occurred in startup firms and for founders.|
|7|Other|Interim CEOs, CEO departure following a merger or acquisition, company ceased to exist, company changed key identifiers so it is not an actual turnover, and CEO may or may not have taken over the new company.|
|8|Missing|Despite attempts to collect information, there was not sufficient data to assign a code to the turnover event. These will remain the subject of further investigation and expansion.|
|9|Execucomp error|If a researcher were to create a dataset of all potential turnovers using execucomp (co_per_rol != l.co_per_rol), several instances will appear of what looks like a turnover when there was no actual event. This code captures those.|

### Cleaning Script

No cleaning script, although see details at: [CEO Dismissal Database](https://docs.google.com/document/d/1VtY-_7es3JE9ymnTNYUTp9nwJW4VPpduOY0L-z1Yh9s/edit).