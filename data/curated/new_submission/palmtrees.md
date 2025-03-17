|variable                |class         |description                           |
|:-----------------------|:-------------|:-------------------------------------|
|spec_name               |character     |Taxonomic name of species (binomial nomenclature) following the World Checklist of palms. |
|acc_genus               |character     |Accepted genus name from the World Checklist of palms. |
|acc_species             |character     |Accepted species name from the World Checklist of palms. |
|palm_tribe              |character     |Name of palm tribe from the World Checklist of palms. |
|palm_subfamily          |character     |Name of palm subfamily from the World Checklist of palms. |
|climbing                |factor |Whether palm species has climbing habit or not, or both if populations vary in this trait. |
|acaulescent             |factor |Whether palm species has an acaulescent growth form (leaves and inflorescence rise from the ground, i.e. lacking a visible aboveground stem) or not, or both if populations vary in this trait. |
|erect                   |factor |Whether palm species has an erect stem (rather than an acaulescent or climbing growth form) or not, or both if local populations vary in this trait. |
|stem_solitary           |factor |Whether stems are solitary (single-stemmed) or clustered (with several stems), or both if populations vary in this trait. |
|stem_armed              |factor |Whether bearing some form of spines at the stem or not, or both if populations vary in this trait. |
|leaves_armed            |factor<e522a> |Whether bearing some form of spines on the leaves or not, or both if populations vary in this trait. |
|max_stem_height_m       |double        |Maximum stem height. |
|max_stem_dia_cm         |double        |Maximum stem diameter. |
|understorey_canopy      |factor<27915> |Understory palms are defined as short-stemmed palms with a maximum stem height ≤5m or an acaulescent growth form, canopy palms with maximum stem height >5m. |
|max_leaf_number         |integer       |Maximum number of leaves. |
|max__blade__length_m    |double        |Maximum length of the blade (the flat expanded part of a leaf as distinguished from the petiole). |
|max__rachis__length_m   |double        |Maximum length of the rachis (the axis of the leaf beyond the petiole). |
|max__petiole_length_m   |double        |Maximum length of the petiole (the stalk of the leave). |
|average_fruit_length_cm |double        |Average length of the fruit as provided in a monograph or species description. |
|min_fruit_length_cm     |double        |Minimum fruit length as provided in a monograph or species description. |
|max_fruit_length_cm     |double        |Maximum fruit length as provided in a monograph or species description. |
|average_fruit_width_cm  |double        |Average width of the fruit as provided in a monograph or species description. |
|min_fruit_width_cm      |double        |Minimum fruit width as provided in a monograph or species description. |
|max_fruit_width_cm      |double        |Maximum fruit width as provided in a monograph or species description. |
|fruit_size_categorical  |factor<4ae3b> |Species classified into small-fruited palms (fruits <4cm in length) and large-fruited palms (fruits ≥4cm in length). |
|fruit_shape             |factor<3acf0> |Description of fruit shape as provided in a monograph or species description. |
|fruit_color_description |character     |Verbatim description of fruit color (e.g. red to dark purple, green to orange to red, purple-brown) as provided in a monograph or species description. |
|main_fruit_colors       |character     |Main fruit colors summarized from fruit color descriptions (black, yellow, orange, red, purple etc.). |
|conspicuousness         |factor<831ce> |Main fruit colors classified into conspicuous colors (e.g. orange, red, yellow, pink, crimson, scarlet) vs. cryptic colors (brown, black, green, blue, cream, grey, ivory, straw-coloured, white, purple). |
