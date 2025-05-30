|variable            |class         |description                           |
|:-------------------|:-------------|:-------------------------------------|
|gutenberg_id        |integer       |Numeric ID, used to retrieve works from Project Gutenberg. |
|title               |character     |Title. |
|author              |character     |Author, if a single one given. Given as last name first (e.g. "Doyle, Arthur Conan"). |
|gutenberg_author_id |integer       |Project Gutenberg author ID. |
|language            |factor        |Language ISO 639 code, separated by / if multiple. Two letter code if one exists, otherwise three letter. See https://en.wikipedia.org/wiki/List_of_ISO_639-2_codes. |
|gutenberg_bookshelf |character     |Which collection or collections this is found in, separated by / if multiple. |
|rights              |factor        |Generally one of three options: "Public domain in the USA." (the most common by far), "Copyrighted. Read the copyright notice inside this book for details.", or "None". |
|has_text            |logical       |Whether there is a file containing digits followed by `.txt` in Project Gutenberg for this record (as opposed to, for example, audiobooks). |
