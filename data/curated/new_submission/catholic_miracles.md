|variable         |class     |description |
|:----------------|:---------|:-----------|
|event_id         |character |Unique identifier combining category prefix and sequence number (e.g., MAR_0001, EUC_1500). |
|category         |character |Type of miracle: Marian Apparition, Eucharistic Miracle, Miraculous Image, Incorrupt Body, Lourdes Healing, or Stigmata. |
|year             |double    |Year the event occurred (or death year for incorrupt bodies). |
|century          |double    |Century number derived from year (e.g., 13 = 1200s). |
|city             |character |City or locality where the event occurred. |
|country          |character |Country where the event occurred (normalized to modern names). |
|person_involved  |character |Name of the visionary, stigmatic, saint, or healed person (NA for Eucharistic miracles where no individual is named). |
|title            |character |Devotional title associated with the event (e.g., "Our Lady of Guadalupe"); primarily for Marian apparitions and miraculous images. |
|details          |character |Full description text as scraped from the source website. |
|approval_status  |character |Official Church ruling: Approved, No decision, Negative decision, Under investigation, or Approved (medically inexplicable) for Lourdes. |
|source_reference |character |Website the data was scraped from: miraclehunter.com, miracolieucaristici.org, or lourdes-france.com. |
