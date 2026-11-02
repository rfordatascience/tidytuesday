|variable       |class     |description                           |
|:--------------|:---------|:-------------------------------------|
|franchise_slug |character |Id of the franchise ranking the entry belongs to (e.g. marvel, westeros, one-piece); also its URL path on citedfeats.com. |
|franchise      |character |Display name of the franchise. |
|entry_id       |character |Id of the character or entity, unique within its franchise. Joins fiction_citations$subject_id and fiction_deaths$killer_id / victim_id, always together with franchise_slug. |
|name           |character |Name of the character or entity. |
|rank           |double    |Editorial power rank within the franchise, 1 = strongest. NA for an off-scale entry that is listed and argued but deliberately not ranked. |
|tier           |character |Id of the tier the entry is placed in. |
|tier_label     |character |Printed label of the tier, e.g. "Tier 01 · apex". |
|eligible       |logical   |Whether visitors can vote on the entry on the site. Always FALSE for off-scale entries. |
|continuity     |character |The franchise's own continuities the entry appears in (e.g. a game, the manga, canon or legends). Several are separated by ";". |
|media          |character |Media the entry appears in, separated by ";": film, animation, novel, comic, game or television. |
|citations      |double    |Number of citations behind the entry. Equals shown + stated + scaled. |
|shown          |double    |Number of the entry's citations graded shown: depicted on page or screen. |
|stated         |double    |Number of the entry's citations graded stated: asserted by a character, narrator or guidebook. |
|scaled         |double    |Number of the entry's citations graded scaled: inferred by comparison, the weakest grade. |
|url            |character |The entry's page on citedfeats.com. |
