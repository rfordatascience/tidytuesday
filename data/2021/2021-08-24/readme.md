
### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics
for `#TidyTuesday`.

Twitter provides
[guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions)
for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an
[article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81)
on writing *good* alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> ### Chart type It's helpful for people with partial sight to know what
> chart type it is and gives context for understanding the rest of the
> visual. Example: Line graph ### Type of data What data is included in
> the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year ### Reason
> for including the chart Think about why you're including this visual.
> What does it show that's meaningful. There should be a point to every
> visual and you should tell people what to look for. Example: the
> winter months have more banana sales ### Link to data or source Don't
> include this in your alt text, but it should be included somewhere in
> the surrounding text. People should be able to click on a link to view
> the source data or dig further into the visual. This provides
> transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an
[article](https://accessibility.psu.edu/images/charts/) on writing alt
text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users.
> But since they are images, these media provide serious accessibility
> issues to colorblind users and users of screen readers. See the
> [examples on this page](https://accessibility.psu.edu/images/charts/)
> for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post
tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with
alt text programatically.

Need a **reminder**? There are
[extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related)
that force you to remember to add Alt Text to Tweets with media.

![Figure 3: Propithecus coquereli life stages. - this image shows
example images of the life stages of this species of lemur, progressing
from young to
old.](https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fsdata.2014.19/MediaObjects/41597_2014_Article_BFsdata201419_Fig3_HTML.jpg?as=webp)

# Lemurs

The data this week comes from [Duke Lemur
Center](https://lemur.duke.edu/) and was cleaned by [Jesse
Mostipak](https://github.com/rfordatascience/tidytuesday/issues/204).

> ### About Lemurs and the Duke Lemur Center

> The [Duke Lemur Center](https://lemur.duke.edu/) houses over 200
> lemurs across 14 species – the most diverse population of lemurs on
> Earth, outside their native Madagascar.
>
> Lemurs are the most threatened group of mammals on the planet, and 95%
> of lemur species are at risk of extinction. Our mission is to learn
> everything we can about lemurs – because the more we learn, the better
> we can work to save them from extinction. They are endemic only to
> Madagascar, so it's essentially a one-shot deal: once lemurs are gone
> from Madagascar, they are gone from the wild.
>
> By studying the variables that most affect their health, reproduction,
> and social dynamics, the Duke Lemur Center learns how to most
> effectively focus [their conservation
> efforts](https://lemur.duke.edu/protect/overview-madagascar-conservation-programs/).
> And the more we learn about lemurs, the better we can educate the
> public around the world about just how amazing these animals are, why
> they need to be protected, and how each and every one of us can make a
> difference in their survival.

> ### Taxonomic Code
>
> You can use the following table for the taxonomic code, or retrieve it
> by registering for the [Duke Lemur Center Database
> here](https://duke.qualtrics.com/jfe/form/SV_cZMTHoHiAljNGXX?Q_JFE=qdg).

| **Taxon** | **Latin name**               | **Common name**              |
|:----------|:-----------------------------|:-----------------------------|
| CMED      | Cheirogaleus medius           | Fat-tailed dwarf lemur       |
| DMAD      | Daubentonia madagascariensis | Aye-aye                      |
| EALB      | Eulemur albifrons            | White-fronted brown lemur    |
| ECOL      | Eulemur collaris             | Collared brown lemur         |
| ECOR      | Eulemur coronatus            | Crowned lemur                |
| EFLA      | Eulemur flavifrons           | Blue-eyed black lemur        |
| EFUL      | Eulemur fulvus               | Common brown lemur           |
| EMAC      | Eulemur macaco               | Black lemur                  |
| EMON      | Eulemur mongoz               | Mongoose lemur               |
| ERUB      | Eulemur rubriventer          | Red-bellied lemur            |
| ERUF      | Eulemur rufus                | Red-fronted brown lemur      |
| ESAN      | Eulemur sanfordi             | Sanford's brown lemur        |
| EUL       | Eulemur Eulemur              | hybrid                       |
| GMOH      | Galago moholi                | Mohol bushbaby               |
| HGG       | Hapalemur griseus griseus    | Eastern lesser bamboo lemur  |
| LCAT      | Lemur catta                  | Ring-tailed lemur            |
| LTAR      | Loris tardigradus            | Slender loris                |
| MMUR      | Mircocebus murinus           | Gray mouse lemur             |
| MZAZ      | Mirza coquereli              | Northern giant mouse lemur   |
| NCOU      | Nycticebus coucang           | Slow loris                   |
| NPYG      | Nycticebus pygmaeus          | Pygmy slow loris             |
| OGG       | Otolemur garnettii garnettii | Northern greater galago      |
| PCOQ      | Propithecus coquereli        | Coquerel's sifaka            |
| PPOT      | Perodicticus potto           | Potto                        |
| VAR       | Varecia Varecia              | hybrid                       |
| VRUB      | Varecia rubra                | Red ruffed lemur             |
| VVV       | Varecia variegata variegata  | Black-and-white ruffed lemur |

> ### Open Source article
>
> For more in-depth information on this dataset, please see: [Life
> history profiles for 27 strepsirrhine primate taxa generated using
> captive data from the Duke Lemur
> Center](http://www.nature.com/articles/sdata201419)
>
> ### Authors & Citation
>
> Zehr, SM, Roach RG, Haring D, Taylor J, Cameron FH, Yoder AD. Life
> history profiles for 27 strepsirrhine primate taxa generated using
> captive data from the Duke Lemur Center. Sci. Data 1:140019 doi:
> 10.1038/sdata.2014.19 (2014).

> Header image Photo by [Anggit
> Rizkianto](https://unsplash.com/@anggit_mr?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)
> on Unsplash

### Get the data here

``` {r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-08-24')
tuesdata <- tidytuesdayR::tt_load(2021, week = 35)

lemurs <- tuesdata$lemurs

# Or read in the data manually

lemurs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-08-24/lemur_data.csv')
```

### Data Dictionary

# `lemur_data.csv`

| ﻿variable                     | class     | description  |
|:------------------------------|:----------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| taxon                         | character | Taxonomic code: in most cases, comprised of the first letter of the genus and the first three letters of the species; if taxonomic designation is a subspecies, comprised of the first letter of genus, species, and subspecies, and hybrids are indicated by the first three letters of the genus.                                                                                                             |
| dlc_id                        | character | Specimen ID: Unique DLC number assigned at accession of animal                                                                                                                                                                                                                                                                                                                                                  |
| hybrid                        | character | Hybrid status: N=not a hybrid.  S=species hybrid.  B=subspecies hybrid. If sire is one of multiple possible and animal could be a hybrid, it is designated a hybrid.                                                                                                                                                                                                                                            |
| sex                           | character | M=male.  F=Female.  ND=Not determined                                                                                                                                                                                                                                                                                                                                                                           |
| name                          | character | House name: Animal name assigned at DLC                                                                                                                                                                                                                                                                                                                                                                         |
| current_resident              | character | Whether or not the animal currently lives in the DLC colony.                                                                                                                                                                                                                                                                                                                                                    |
| stud_book                     | character | Regional or global unique ID among captive individuals of that species; assigned by AZA studbook keeper. Not all individuals have studbook numbers in this data record.                                                                                                                                                                                                                                         |
| dob                           | double    | Date of Birth (DOB) is an exact date unless there is an entry in the 'Estimated_DOB' field.                                                                                                                                                                                                                                                                                                                     |
| birth_month                   | double    | Birth Month                                                                                                                                                                                                                                                                                                                                                                                                     |
| estimated_dob                 | character | Whether or not the date of birth is an estimate.  Y=estimated to the nearest year, M to the nearest month, and D to the nearest day.  If there is a number after the letter code, that indicates to the Nth value of the code.  U=unknown. If there is no entry in this field, DOB is not an estimate.                                                                                                          |
| birth_type                    | character | Whether the animal was captive-born (CB), wild-born (WB) or of unknown birth type (UNK)                                                                                                                                                                                                                                                                                                                         |
| birth_institution             | character | Name or ISIS abbreviation of institution where animal was born.  Duke Prim=DLC. For wild caught animals, birth institution = country of origin, if known                                                                                                                                                                                                                                                        |
| litter_size                   | double    | Number of infants in the litter the focal animal was born into (including focal animal). Only indicated where verifiable (born at DLC). A missing value indicates that the litter size is unknown                                                                                                                                                                                                               |
| expected_gestation            | double    | Values based on DLC observations and reports from the literature, in days                                                                                                                                                                                                                                                                                                                                       |
| estimated_concep              | double    | Date of estimated conception: Calculated as (DOB-Expect ed_Gestation)                                                                                                                                                                                                                                                                                                                                           |
| concep_month                  | double    | Month of estimated conception: Identified from Estimated_Concep                                                                                                                                                                                                                                                                                                                                                 |
| dam_id                        | character | Specimen ID of female parent. DLC unique ID preferred if there is one.  Local ID of another ISIS-reporting institution if known and no DLC number exists.  'Wild' indicates dam of wild-caught individual.  'Unk' or no data indicates dam is unknown                                                                                                                                                           |
| dam_name                      | character | House name of female parent (at DLC)                                                                                                                                                                                                                                                                                                                                                                            |
| dam_taxon                     | character | Taxon of female parent: Based on taxonomic code (see description)                                                                                                                                                                                                                                                                                                                                               |
| dam_dob                       | double    | Date of birth of female parent: If female parent is wild caught or of unknown origin, this date is an estimate                                                                                                                                                                                                                                                                                                  |
| dam_age_at_concep_y           | double    | Estimated age of female parent at conception of focal animal: in years ((Estimated_Concep-Dam_DOB)/365)                                                                                                                                                                                                                                                                                                         |
| sire_id                       | character | Specimen ID of male parent: DLC number preferred if there is one.  Local ID of another ISIS-reporting institution if known and no DLC number exists.  'Wild' indicates sire of wild-caught individual.  'MULT' indicates multiple possible sires. A following number indicates number of possibilities (e.g. MULT2).  'Unk' or no data indicates unknown sire and may include cases of multiple possible sires. |
| sire_name                     | character | House name of male parent (at DLC)                                                                                                                                                                                                                                                                                                                                                                              |
| sire_taxon                    | character | Taxon of male parent: Based on taxonomic code described above                                                                                                                                                                                                                                                                                                                                                   |
| sire_dob                      | double    | Date of birth of male parent: If male parent is wild caught or of unknown origin, this date is an estimate.                                                                                                                                                                                                                                                                                                     |
| sire_age_at_concep_y          | double    | Estimated age of male parent at conception of focal animal: in years ((Estimated_Concep-Dam_DOB)/365)                                                                                                                                                                                                                                                                                                           |
| dod                           | double    | Date of death: Verified date an animal died. Missing indicates animal is either alive or status is unknown                                                                                                                                                                                                                                                                                                      |
| age_at_death_y                | double    | Age of animal at verifiable date of death, in years ((DODDOD)/ 365). Missing indicates animal is either alive or status is unknown.                                                                                                                                                                                                                                                                             |
| age_of_living_y               | double    | Age if alive: Verifiable living age of DLC-owned animals and/or current residents at DLC on loan, in years as of the date the datafile was updated ((date of last upda te-DOB)/365).  Missing indicates animal is either dead or status is unknown.                                                                                                                                                             |
| age_last_verified_y           | double    | Last verifiable age: Age of animal at most recent date a non-DLC owned, non-current resident animal was verifiably alive, in years. Dates were obtained from ISIS as entered by other institutions (dates of live weight or animal transfer) or via direct communication from other animal facilities.  ((DateLastVerified-DOB)/365).  Missing indicates animal is known to be dead or alive.                   |
| age_max_live_or_dead_y        | double    | Maximum age: The animal's age from any of the three age categories (each individual must have a value in one of the three) indicating the maximum age the animal could have achieved as of the date the datafile was updated.                                                                                                                                                                                   |
| n_known_offspring             | double    | Number of offspring: Number of offspring the individual is known to have produced.  There may be additional offspring for this individual if they were born at another institution or if this individual is a possible, rather than known, parent.                                                                                                                                                              |
| dob_estimated                 | character | Whether or not the date of birth is an estimate.  Y=estimated to the nearest year, M to the nearest month, and D to the nearest day.  If there is a number after the letter code, that indicates to the Nth value of the code.  U=unknown. If there is no data in this field, DOB is not an estimate.                                                                                                           |
| weight_g                      | double    | Weight: Animal weight, in grams.  Weights under 500g generally to nearest 0.1-1g; Weights >500g generally to the nearest 1-20g.                                                                                                                                                                                                                                                                                 |
| weight_date                   | double    | Weight date: Date animal was weighed                                                                                                                                                                                                                                                                                                                                                                            |
| month_of_weight               | double    | Weight month: Month of the year the animal was weighed                                                                                                                                                                                                                                                                                                                                                          |
| age_at_wt_d                   | double    | Age in days: Age of the animal when the weight was taken, in days (Wei ght_Date-DOB)                                                                                                                                                                                                                                                                                                                            |
| age_at_wt_wk                  | double    | Age in weeks: Age of the animal when the weight was taken, in weeks ((Weight_Date-DOB)/7))                                                                                                                                                                                                                                                                                                                      |
| age_at_wt_mo                  | double    | Age in months: Age of the animal when the weight was taken, in months (((Weight_Date-DOB)/365)*12)                                                                                                                                                                                                                                                                                                              |
| age_at_wt_mo_no_dec           | double    | Age in months with no decimal: AgeAtWt_mo value rounded down to a whole number for use in computing average individual weights (FLOOR(AgeAtWt_mo))                                                                                                                                                                                                                                                              |
| age_at_wt_y                   | double    | Age in years: Age of the animal when the weight was taken, in years ((weight_date-DOB)/365                                                                                                                                                                                                                                                                                                                      |
| change_since_prev_wt_g        | double    | Weight difference: Difference, in grams, between this weight and the animal's previous weight                                                                                                                                                                                                                                                                                                                   |
| days_since_prev_wt            | double    | Days difference: Difference, in days, between the date of this weight and the date of the animal's previous weight                                                                                                                                                                                                                                                                                              |
| avg_daily_wt_change_g         | double    | Average daily change: Average daily weight change, in grams, between this weight and the animal's previous weight                                                                                                                                                                                                                                                                                               |
| days_before_death             | double    | Days before death: Number of days before the animal's death the weight was taken (DOD- Weight_Date).  Missing indicates animal is either alive or status is unknown.                                                                                                                                                                                                                                            |
| r_min_dam_age_at_concep_y     | double    | Dam minimum age at conception, in years, for the species from the life history summary table. Used to calculate 'Age_Category' as described below.                                                                                                                                                                                                                                                              |
| age_category                  | character | Age category: IJ (infant or juvenile): (AgeAtWt_yr < R_Min_Dam_Age_AtConcep_yr).  Young-adult: (Min_Dam_AgeAtConcep_yr <= AgeAtWt_yr < 2xMin_Dam_AgeAtConcep_ yr). Adult: AgeAtWt_yr >= 2xMin_Dam_A geAtConcep_yr                                                                                                                                                                                               |
| preg_status                   | character | Pregnancy status: Whether or not animal is pregnant on date weight was taken.  P=pregnant, NP=not pregnant (all males coded NP)                                                                                                                                                                                                                                                                                 |
| expected_gestation_d          | double    | Expected gestation length: Values based on DLC observations and reports from the literature, in days                                                                                                                                                                                                                                                                                                            |
| concep_date_if_preg           | double    | Conception date: Estimated date of infant conception if the weight was taken while a female was pregnant                                                                                                                                                                                                                                                                                                        |
| infant_dob_if_preg            | double    | Infant Date of Birth: Date of infant birth if the weight was taken while a female was pregnant                                                                                                                                                                                                                                                                                                                  |
| days_before_inf_birth_if_preg | double    | Days until birth: Days remaining in the pregnancy if the weight was taken while a female was pregnant                                                                                                                                                                                                                                                                                                           |
| pct_preg_remain_if_preg       | double    | % of pregnancy remaining: Percentage of pregnancy remaining when weight was taken from a pregnant female calculated as (days_BF_inf_birth/Expected_Gestation)                                                                                                                                                                                                                                                   |
| infant_lit_sz_if_preg         | double    | Infant litter size: Number of infants in the litter a female produced if she was pregnant on date weight was taken                                                                                                                                                                                                                                                                                              |                                                                                                                                                                                                                                                                                  |

### Cleaning Script
