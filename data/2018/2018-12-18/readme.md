# Cetacean Dataset

Data for this week comes from a *The Pudding* article. 

## Dataset information

This folder contains all of the data used in The Pudding article [Free Willy and Flipper by the Numbers](https://pudding.cool/2017/07/cetaceans/) published in July 2017. 

The below metadata and descriptions were taken directly from the GitHub for *[The Pudding](https://github.com/the-pudding/data/tree/master/cetaceans)* and were prepared by [Amber Thomas](https://twitter.com/proquesasker).

## allCetaceanData.csv

- 	**What is this?**: A collection of all data that I could find on whales and dolphins that spent some period of time captive in the US between 1938 and May 7, 2017. 
-   **Source(s)**: The data used to create this aggregated set came from the US National Marine Mammal Inventory (original data requested on June 15, 2015 via FOIA available [here](https://foiaonline.regulations.gov/foia/action/public/view/request?objectId=090004d28075988d)) and from [Ceta-Base](http://www.cetabase.org/). Data from Ceta-Base were downloaded May 7, 2017. 
-   **Last Modified**: May 7, 2017
-   **Contact Information**: [Amber Thomas](mailto:amber@polygraph.cool)
-   **Spatial Applicability**: United States
-   **Temporal Applicability**: March 1, 1938 - May 7, 2017
-   **Variables (Columns)**:

| Header | Description | Data Type |
|---|---|---|
| `species` | The common name for an individual animal's species (e.g., `Bottlenose`, `Killer whale; orca` etc.) | text |
| `id` | One or more individual identification numbers assigned to an animal. **Note:** Not all individual animals have an ID number. If an animal has no number, it is denoted as `NA`. | text |
| `name` | An individual animal's name. Some animals have been known by more than one name. Where possible, the additional name(s) are noted in `Notes`. | text |
| `sex` | An individual animal's sex. <br/>&bull; `M` = male<br/>&bull; `F` = female<br/>&bull; `U` = unknown | text |
| `accuracy` | The accuracy of an animal's birth date (i.e., birth dates for wild-caught animals are estimated). <br/>&bull; `a` = actual date <br/> &bull; `e` = estimated date <br/>&bull; `u` = unknown | text |
| `birthYear` | The year that an individual animal was born (see `Accuracy` to determine if that birth year is known or estimated). If a birth year is unknown and not estimated, it is coded as `NA`. | number |
| `acquisition` | The method through which an animal was acquired and brought into the captive cetacean group. <br/> &bull; `Born` = animal was born in captivity <br/> &bull; `Capture` = animal was captured from the ocean <br/> &bull; `Rescue` = animal was rescued (e.g., had stranded or required medical intervention) and was deemed unreleasable. <br/> **Note:** If the recorder was unsure how an animal was acquired, they may have included a `?` with the above code (e.g., `born?`). | text |
| `originDate` | The year that an animal entered captivity. For a wild-caught or rescued animal, this will be the year that they were rescued/captured. For captive-born animals, this will be the same as the birth year. Unknown dates are encoded as `NA`. | date | 
| `originLocation` | The location that an animal originated from. For captured/rescued animals this is an approximate location in the ocean (e.g., `Atlantic Ocean` or `Gulf of Mexico, MS, US`), but for animals born in captivity it will list the facility where the animal was born. | text |
| `mother` | The name of an animal's biological mother (if known). **Note:** Some names contain species scientific names (e.g., `Cindy (T.t. gilli)`). Unknown names are encoded as `NA`.| text |
| `father` | The name of an animal's biological father (if known). **Note:** Some names contain species scientific names (e.g., `Jethro (T.t. gilli)`). Unknown names are encoded as `NA`.| text |
| `transfers` | A list of facilities that an animal was transferred to, with the approximate dates that they were transferred (e.g., `SeaWorld Orlando to New England Aquarium (22-Feb-1982) to Dolphin Research Center (23-Oct-1991)`). If no transfers are known, this field is encoded as `NA`. | text | 
| `currently` | The location where a living animal currently resides (as of May 7, 2017) or the last location where an animal lived before it died. If an animal's last location is unknown it is encoded as `Unknown`. | text |
| `region` | The region of the world where the animal either currently or most-recently lived. | text |
| `status` | The current status of an animal. <br/> &bull; `Alive` = animal is still alive and living in captivity (as of May 7, 2017) <br/> &bull; `Died` = animal has been confirmed as dead. <br/> &bull; `Stillbirth` = Calf that died before birth. <br/>&bull; `Miscarriage` = Calf that was miscarried before full-term gestation. <br/>&bull; `Released` = Animal had lived in captivity for some period of time but has since been released to the ocean. <br/> &bull; `Unknown` = The animal's current status is unknown. <br/> **Note:** When the recorder of an animal's status wasn't sure exactly what happened to the animal, they may have included a `?` with the above code (e.g., `stillbirth?`). | text |
| `statusDate` | The date that an animal's status changed. For living animals, the status date is `NA`, but for animals that have died or been released, this is their date of death or release. | date |
| `COD` | The animal's reported cause of death. For living animals, this is `NA`. <br/>**Note:** Use these data with caution. COD is reported differently between facilities and are not always reported by a pathologist that can properly identify the cause of death. | text |
| `transferDate` | The date an animal was transferred into the US. For animals that were born in the US, this is `NA`. | date |
| `transfer` | The types of transfers that an animal has been involved with. <br/>&bull; `US` = The animal was only transferred between facilities in the US <br/>&bull; `Foreign` = The animal was transferred from outside of the US into the US. | text |
| `entryDate` | The date that an individual animal entered the US captive population. For captive-born animals, this is their birth date *or* the day they were transferred to a facility in the US. For captured or rescued animals, this is either the date that they were captured/rescued *or* the day that they were transferred from a foreign facility to a US one. | date | 

