|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|state        |character |The two-letter code for the state (or territory, etc) where the hospital is located. |
|condition    |character |The condition for which the patient was admitted. Six categories of conditions are included in the data. |
|measure_id   |character |The ID of the thing being measured. Note that there are 22 unique IDs but only 21 unique names. |
|measure_name |character |The name of the thing being measured. Note that there are 22 unique IDs but only 21 unique names. |
|score        |double    |The score of the measure. |
|footnote     |character |Footnotes that apply to this measure: 5 = "Results are not available for this reporting period.", 25 = "State and national averages include Veterans Health Administration (VHA) hospital data.", 26 = "State and national averages include Department of Defense (DoD) hospital data.". |
|start_date   |date      |The date on which measurement began for this measure. |
|end_date     |date      |The date on which measurement ended for this measure. |
