| variable           | class     | description                                              |
|:-------------------|:----------|:--------------------------------------------------------|
| id                 | double    | Unique identifier for each script line. |
| episode_id         | double    | Identifier for the episode in which the line appears. |
| number             | double    | Sequential number of the line within the episode. |
| raw_text           | character | The original text of the script line. |
| timestamp_in_ms    | double    | Timestamp of the line in milliseconds. |
| speaking_line      | logical   | Indicates whether the line is spoken by a character. |
| character_id       | double    | Identifier for the character speaking the line. |
| location_id        | double    | Identifier for the location where the line is spoken. |
| raw_character_text | character | Original text of the character's name. |
| raw_location_text  | character | Original text of the location name. |
| spoken_words       | character | Words spoken by the character in the line. |
| normalized_text    | character | Lowercase version of the script line. |
| word_count         | double    | Number of words in the line. |
