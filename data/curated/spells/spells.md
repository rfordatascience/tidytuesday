|variable                   |class     |description                           |
|:--------------------------|:---------|:-------------------------------------|
|name                       |character |The name of the spell. |
|level                      |integer   |The level of the spell, from 0 ("cantrip") to 9. This number represents the power and difficulty of the spell within the game. |
|school                     |character |The school (broad category) of magic to which the spell belongs. One of "abjuration", "conjuration", "divination", "enchantment", "evocation", "illusion", "necromancy", or "transmutation". |
|bard                       |logical   |Whether the spell can be cast by bards. |
|cleric                     |logical   |Whether the spell can be cast by clerics. |
|druid                      |logical   |Whether the spell can be cast by druids. |
|paladin                    |logical   |Whether the spell can be cast by paladins. |
|ranger                     |logical   |Whether the spell can be cast by rangers. |
|sorcerer                   |logical   |Whether the spell can be cast by sorcerers. |
|warlock                    |logical   |Whether the spell can be cast by warlocks. |
|wizard                     |logical   |Whether the spell can be cast by wizards. |
|casting_time               |character |How long it takes to cast the spell. Can be an in-game unit ("action", "bonus action", "reaction", "ritual"), or a longer, descriptive unit. These times are broken down in the next 6 columns. |
|action                     |logical   |Whether the spell can be cast as an "action," the basic thing a character can do on their turn. |
|bonus_action               |logical   |Whether the spell can be cast as a "bonus action", a faster, "extra" thing a character can do on their turn. |
|reaction                   |logical   |Whether the spell can be cast as a "reaction", a thing a character can do on someone else's turn. |
|ritual                     |logical   |Whether the spell can be cast as a ritual. Casting a spell as a ritual adds 10 minutes to the casting time, is usually easier for characters to perform. |
|casting_time_long          |character |Other casting times, usually in minutes or hours. |
|trigger                    |character |Whether the spell requires a trigger to cast. Most common for reaction spells. |
|range                      |character |How far away the spell can appear from the caster. |
|range_type                 |character |The general category of range for the spell. One of "feet" (the most common category of ranges), "self" (the spell can be cast on the caster), "touch" (the spell can be cast on someone the caster can touch), "sight" (the spell can be cast on anyone the caster can see), or "other" (the spell has some other range, such as miles). |
|verbal_component           |logical   |Whether the spell requires a verbal component (the casting character must be able to speak). |
|somatic_component          |logical   |Whether the spell requires a somatic component (a movement or gesture by the casting character). |
|material_component         |logical   |Whether the spell requires a material component (a physical object that the casting character must possess, which might be consumed in the casting of the spell). |
|material_component_details |character |More details about any material components of the spell. |
|duration                   |character |How long the spell lasts, in rounds (sets of turns in combat, equivalent to about 6 seconds), minutes, hours, days, or other measurements. An "instantaneous" duration means the spell does whatever it does, potentially enacting a permanent change. "Concentration" is described in the next column. |
|concentration              |logical   |Whether the spell requires "concentration" -- the casting character must continue to focus on the spell to keep it active. Concentration can be interrupted by the caster taking damage in combat, for example. |
|description                |character |The full text description of the spell. |
