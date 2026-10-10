|variable       |class     |description                           |
|:--------------|:---------|:-------------------------------------|
|franchise_slug |character |Id of the franchise ranking the death is recorded on. |
|killer_id      |character |entry_id of the killer in fiction_rankings. |
|killer         |character |Name of the killer. |
|victim         |character |Who or what died, as named in the record. |
|victim_id      |character |entry_id of the victim when the victim is ranked in the same franchise; NA otherwise. |
|work           |character |The work the death happens in. |
|year           |double    |Year of that work, when recorded. |
|confidence     |character |Evidence grade of the death: shown (depicted on page or screen) or stated (reported by a character or narrator). |
|undone         |logical   |Whether the death was later reversed (the character came back, or the timeline was changed). |
|verdict        |character |The site's verdict on whether the death moves the ranking, filled only where a matchup page argues it: confirms (the higher-ranked killed the lower-ranked), upset (the lower-ranked killed the higher-ranked), undone (reversed, so the ranking does not move) or off-scale (one side is unranked). NA otherwise. |
|matchup_url    |character |The citedfeats.com matchup page arguing the verdict, where there is one. |
