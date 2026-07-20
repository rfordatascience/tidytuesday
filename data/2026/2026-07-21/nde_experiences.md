|variable         |class         |description                           |
|:----------------|:-------------|:-------------------------------------|
|entry_id         |double        |Unique NDERF experience identifier (numeric page ID on search.nderf.org). |
|gender           |character     |Gender of the experiencer (M or F). |
|classification   |character     |NDERF classification of the experience (NDE, Probable NDE, Possible NDE, etc.). Multiple values separated by semicolons. |
|country          |character     |Country of the experiencer, detected by AI from the narrative text. |
|category         |character     |Experience category assigned by NDERF (e.g., NDE, FDE, STE, OBE). |
|language         |character     |Language of the submitted narrative (e.g., english, french, spanish). |
|greyson_score    |double        |Score on the Greyson NDE Scale (0–32). A score of 7 or higher indicates a validated near-death experience. |
|post_date        |datetime<UTC> |Date the experience was submitted to NDERF. |
|exp_date         |datetime<UTC> |Date the near-death experience occurred (self-reported). |
|narrative_length |double        |Character count of the narrative text (proxy for level of detail in the account). |
|ai_obe           |logical       |Whether AI detected an out-of-body experience in the narrative. |
|ai_unity         |logical       |Whether AI detected a feeling of unity or oneness in the narrative. |
|ai_hellish       |logical       |Whether AI detected distressing or hellish imagery in the narrative. |
|ai_clinical      |logical       |Whether AI detected confirmed clinical death in the narrative. |
|ai_esp           |logical       |Whether AI detected extrasensory perception or seeing distant events in the narrative. |
|ai_past_lives    |logical       |Whether AI detected past life recall in the narrative. |
|ai_world_future  |logical       |Whether AI detected visions of the world's future in the narrative. |
|ai_aliens        |logical       |Whether AI detected alien or extraterrestrial encounters in the narrative. |

