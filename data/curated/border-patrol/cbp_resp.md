|variable               |class     |description                           |
|:----------------------|:---------|:-------------------------------------|
|fiscal_year            |integer   |The fiscal year the encounter took place |
|month_grouping         |character |Allows for comparisons between completed FY months vs. those remaining |
|month_abbv             |character |The month the encounter took place (abbreviated, eg "APR") |
|component              |character |Which part of CBP was involved in the encounter ("Office of Field Operations" or "U.S. Border Patrol") |
|land_border_region     |character |The border region in which the encounter occurred ("Northern Land Border", "Southwest Land Border", or "Other"); border regions are defined by each component. Nationwide numbers are calculated by adding together Northern Land Border, Southwest Land Border, and Other regions |
|area_of_responsibility |character |The field office or sector where the encounter occurred |
|aor_abbv               |character |The field office or sector where the encounter occurred (abbreviated) |
|demographic            |character |Categories under which individuals were encountered based on factors such as age, admissibility, and relationship (FMUA = Individuals in a Family Unit; UC = Unaccompanied Children) |
|citizenship            |character |Citizenship of the individual encountered |
|title_of_authority     |character |The authority under which the noncitizen was processed (Title 8: The standard U.S. immigration law governing the processing of migrants, including deportations, asylum procedures, and penalties for unauthorized border crossings. Title 42: A public health order used during the COVID-19 pandemic to rapidly expel migrants at the border without standard immigration processing, citing health concerns.) |
|encounter_type         |character |The category of encounter based on Title of Authority and component (Title 8 for USBP = Apprehensions; Title 8 for OFO = Inadmissibles; Title 42 = Expulsions) |
|encounter_count        |integer   |The number of individuals encountered |
