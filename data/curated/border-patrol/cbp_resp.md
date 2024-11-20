|variable               |class     |description                           |
|:----------------------|:---------|:-------------------------------------|
|fiscal_year            |double    |The fiscal year the encounter took place |
|month_grouping         |character |Allows for comparisons between completed FY months vs. those remaining |
|month_abbv             |character |The month the encounter took place (abbreviated) |
|component              |character |Who in CBP was involved in the encounter |
|land_border_region     |character |The border region in which the encounter occurred; border regions are defined by each component Nationwide numbers are calculated by adding together Northern Land Border, Southwest Land Border, and Other regions  |
|area_of_responsibility |character |The field office or sector where the encounter occurred |
|aor_abbv               |character |The field office or sector where the encounter occurred (abbreviated) |
|demographic            |character |Categories under which individuals were encountered based on factors such as age, admissibility, and relationship |
|citizenship            |character |Citizenship of the individual encountered |
|title_of_authority     |character |The authority under which the noncitizen was processed |
|encounter_type         |character |The category of encounter based on Title of Authority and component (Title 8 for USBP = Apprehensions; Title 8 for OFO = Inadmissibles; Title 42 = Expulsions) |
|encounter_count        |double    |The number of individuals encountered |
