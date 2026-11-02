|variable       |class     |description                           |
|:--------------|:---------|:-------------------------------------|
|franchise_slug |character |Id of the franchise ranking the citation belongs to. |
|subject_id     |character |Id of the entry or armament the citation backs. Joins fiction_rankings$entry_id when subject_kind is entry. |
|subject_kind   |character |What the citation backs: entry (a ranked character or entity in fiction_rankings) or armament (an item on a franchise's separate ladder of weapons and abilities, not in fiction_rankings). |
|subject_name   |character |Display name of the subject. |
|work           |character |The work cited, named as the edition actually consulted. |
|type           |character |Kind of work: novel, film, episode, comic, game or reference (rulebooks, guidebooks, databooks and in-world documents). |
|locator        |character |Where in the work: a chapter, episode, page or game location (e.g. "Lost Izalith", "opening narration"). NA when it could not be sourced; none is invented. |
|year           |double    |Year the cited work was published or released, when recorded. |
|url            |character |A link to the source where one exists online. Almost always NA: citations point to the work and locator instead. |
|claim          |character |The part of the feat this citation backs, in the site's own words. |
|confidence     |character |Evidence grade: shown (depicted on page or screen), stated (asserted by a character, narrator or guidebook) or scaled (inferred by comparison with someone else's feat, the weakest). |
