|variable         |class     |description                           |
|:----------------|:---------|:-------------------------------------|
|manuscript_id    |character |Unique catalog identifier assigned by the Israel Antiquities Authority (e.g., "4Q51", "1Q1", "Mas 1h"). The prefix indicates the site and cave number. |
|short_name       |character |Short name assigned by the IAA (e.g., "1Q Gen", "4Q Sam"). May be empty for unidentified fragments. |
|composition      |character |Name of the composition or biblical book identified in the manuscript (e.g., "Genesis", "Tobit", "Community Rule"). "Unidentified" if the content has not been determined. |
|composition_type |character |IAA classification of the composition type (e.g., "Scripture", "Pesher", "Parabiblical Texts", "Poetical/Liturgical Texts", "Sectarian Texts", "Unidentified Text"). |
|language         |character |Primary language of the manuscript: Hebrew, Aramaic, Greek, or Nabataean. |
|script_type      |character |Type of script used: "Square" (standard Jewish script), "Paleo-Hebrew" (ancient First Temple period script), "Greek", or "Nabatean". |
|material         |character |Physical writing material: Parchment (leather), Papyrus, Copper, or Stone. |
|period           |character |Paleographic dating period assigned by the IAA: "Early Hellenistic" (~300-200 BCE), "Hellenistic-Roman" (~200 BCE-68 CE), "Hasmonean" (~150-37 BCE), "Herodian" (~37 BCE-68 CE), or "Roman" (~68-135 CE). |
|site             |character |Full discovery site description (e.g., "Qumran, Cave 4", "Masada"). |
|site_parent      |character |Broad site name: "Qumran", "Masada", "Wadi Murabba'at", or "Nahal Hever". |
|cave             |integer   |Cave number (1-11) for Qumran manuscripts. NA for non-Qumran sites. |
|num_images       |integer   |Number of high-resolution photographic plates of this manuscript in the IAA digital archive. Serves as a proxy for manuscript size and preservation state. |
|keywords         |character |Thematic keywords assigned by IAA curators (e.g., "Garden of Eden, Abraham"). NA for most manuscripts. |
|biblical_book    |character |Identified biblical book or composition name, standardized for analysis (e.g., "Genesis", "Tobit", "Jubilees", "Pesher (Commentary)"). NA if unidentified. |
|canon_status     |character |Canonical status in modern Christian traditions: "Protocanonical" (accepted by both Catholics and Protestants), "Deuterocanonical" (Catholic canon only, rejected by Protestants), "Non-canonical" (not in any modern Christian canon), or "Unidentified". |
|bible_section    |character |Section of the Bible or literature type: "Torah", "Nevi'im" (Prophets), "Ketuvim" (Writings), "Deuterocanonical", "Pseudepigrapha", "Sectarian", "Liturgical", "Wisdom", "Documentary", "Biblical Translation", "Other", or "Unidentified". |
|testament        |character |Whether the manuscript is from the Old Testament ("OT"), "Non-biblical", or "Unknown" (if unidentified). |
|content_category |character |Broad content classification: "Biblical", "Biblical (Deuterocanonical)", "Parabiblical", "Sectarian", "Liturgical", "Wisdom Literature", "Documentary", "Biblical Translation", "Other Non-biblical", or "Unidentified". |
