|variable           |class   |description                           |
|:------------------|:-------|:-------------------------------------|
|season             |integer |The season number in which the episode is part of the Bob's Burgers TV show. |
|episode            |integer |The episode number within the specific season of Bob's Burgers. |
|dialogue_density   |double  |The number of non-blank lines in this episode. |
|avg_length         |double  |The average number of characters (technically codepoints, see `?stringr::str_length`) per line of dialogue. |
|sentiment_variance |double  |The variance in the numeric AFINN sentiment of words in this episode. See `?textdata::lexicon_afinn` for further information. |
|unique_words       |integer |The number of unique lowercase words in this episode. |
|question_ratio     |double  |The proportion of lines of dialogue that contain at least one question mark ("?"). |
|exclamation_ratio  |double  |The proportion of lines of dialogue that contain at least one exclamation point ("!"). |
