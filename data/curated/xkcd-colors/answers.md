|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|user_id  |double    |The id of the user who gave the answer. |
|hex      |character |Hex code of the color shown to a user. |
|rank     |double    |The rank of the color that the user gave as the name of the color they were shown (join with `color_ranks`to get the color name answer given by the user). Note that this table is a subset of the full answers data where the `color_name_answer` was one of the names of the 5 top ranked colors in the `color_ranks` data. |
