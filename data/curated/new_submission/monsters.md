|variable          |class     |description                           |
|:-----------------|:---------|:-------------------------------------|
|name              |character |The name of the monster. |
|category          |character |The category to which this monster belongs. Often the same as the name, but, for example, all "Animated Objects" share a category. |
|cr                |double    |The challenge rating of the monster. |
|size              |character |Tiny, Small, Medium, Large, Huge or Gargantuan. If size options are presented, you choose the creature's size from those options. |
|type              |character |Each monster has a tag that identifies the type of creature it is. Certain spells, magic items, class features, and other effects in the game interact in special ways with creatures of a particular type. |
|descriptive_tags  |character |Optional additional tags. Such tags provide additional categorization and have no rules of their own, but certain game effects might refer to them. |
|alignment         |character |One of Lawful Good, Neutral Good, Chaotic Good, Lawful Neutral, Neutral, Chaotic Neutral, Lawful Evil, Neutral Evil, Chaotic Evil, or Unaligned. The alignment specified in a monster's stat block is a default suggestion of how to roleplay the monster, inspired by its traditional role in the game or real-world folklore. Change a monster's alignment to suit your storytelling needs. The Neutral alignment, in particular, is an invitation for you to consider whether an individual leans toward one of the other alignments. |
|ac                |character |The monster's Armor Class (AC) includes its natural armor, Dexterity, gear, and other defenses. |
|initiative        |integer   |The monster's Initiative modifier. Use the modifier when you roll to determine a monster's Initiative. A monster's Initiative modifier is typically equal to its Dexterity modifier, but some monsters have additional modifiers, such as Proficiency Bonus, applied to that number. |
|hp                |character |The monster's Hit Points are presented as a number followed by parentheses, where the monster's Hit Point Dice are provided, along with any contribution from its Constitution. Either use the number for the monster's Hit Points (also available in "hp_number") or roll the die expression in parentheses to determine the monster's Hit Points randomly; don't use both. |
|hp_number         |integer   |The average Hit Points for the monster. |
|speed             |character |The monster's Speed. Some monsters have one or more of the following speeds: Burrow, Climb, Fly, Swim. |
|speed_base_number |integer   |The first numeric speed for the monster, which is usually the walking speed. |
|str               |integer   |The monster's strength score. |
|dex               |integer   |The monster's dexterity score. |
|con               |integer   |The monster's constitution score. |
|int               |integer   |The monster's intelligence score. |
|wis               |integer   |The monster's wisdom score. |
|cha               |integer   |The monster's charisma score. |
|str_save          |integer   |The monster's strength saving throw bonus. |
|dex_save          |integer   |The monster's dexterity saving throw bonus. |
|con_save          |integer   |The monster's constitution saving throw bonus. |
|int_save          |integer   |The monster's intelligence saving throw bonus. |
|wis_save          |integer   |The monster's wisdom saving throw bonus. |
|cha_save          |integer   |The monster's charisma saving throw bonus. |
|skills            |character |The monster's Skill proficiencies, if any. For example, a monster that is very perceptive and stealthy might have bonuses to Wisdom (Perception) and Dexterity (Stealth) checks. A skill bonus is the sum of a monster's relevant ability modifier and its Proficiency Bonus. Other modifiers might apply. |
|resistances       |character |The monster's Resistances, if any. |
|vulnerabilities   |character |The monster's Vulnerabilities, if any. |
|immunities        |character |The monster's Immunities, if any. If the monster has damage and condition Immunities, the damage types are listed before the conditions. |
|gear              |character |Monsters have proficiency with their equipment. If the monster has equipment that can be given away or retrieved, the items are listed in the Gear entry. The monster's stat block might include special flourishes that happen when the monster uses an item, and the stat block might ignore the rules in "Equipment" for that item. When used by someone else, a retrievable item uses its "Equipment" rules, ignoring any special flourishes in the stat block. The Gear entry doesn't necessarily list all of a monster's equipment. For example, a monster that wears clothes is assumed to be dressed appropriately, and those clothes aren't in this entry. Equipment mentioned outside the Gear entry is considered to be supernatural or highly specialized, and it is unusable when the monster is defeated. |
|senses            |character |The monster's Passive Perception score, as well as any special senses the monster possesses. |
|languages         |character |Languages that the monster can use to communicate. Sometimes the monster can understand a language but can't communicate with it, which is noted in its entry. "None" indicates that the creature doesn't comprehend any language. Telepathy is a magical ability that allows a creature to communicate mentally with another creature within a specified range. |
|full_text         |character |The full text of the monster description, including the information above as well as monster Traits and Actions. |
