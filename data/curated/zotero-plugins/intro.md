This week we're exploring Zotero plugins. [Zotero](https://www.zotero.org) is a free, open-source reference manager that researchers and students use to collect, organise and cite their sources, and anyone can extend it with a plugin. There is no official list of them (Zotero's documentation says "We don't currently provide a list of available plugins"), so the data comes from [zoteroplugins.org](https://zoteroplugins.org), a site that searches GitHub every night for Zotero plugins. For each plugin it records the repository's statistics and the Zotero versions the plugin supports, reads the code of its latest release, and gives it an automated grade. The curator of this dataset runs the site.

Zotero 7, released in August 2024, changed how plugins are built. New plugins began to pick up in 2025 and took off in 2026: 1,340 new plugin repositories were created in 2026 up to 18 November, more than three times as many as in all earlier years together. The data covers who builds plugins and what for, how popular they are, which Zotero versions they work with, what their code can do on your computer, and which web services they contact.

A few things to keep in mind. `created_at` is the date the GitHub repository was created; for a fork it is the date of the fork, so leave out `is_fork` rows to count new plugins. November 2026 is a partial month. Repositories that were deleted before the census found them are missing, so earlier years may be undercounted. The grades, capability findings and `in_use_estimate` come from automated checks and estimates, not from review by hand, and the categories and taglines were written by AI. Developers' own descriptions are left out, because they stay under their authors' terms. The data is "zoteroplugins.org (Ilias Beshimov), CC BY 4.0".

> We went looking for every Zotero plugin on GitHub. Out of 32,184 repositories we found 2,001 plugins, read the code of each one, and kept the numbers.
>
> zoteroplugins.org, The state of Zotero plugins

- How fast is the ecosystem growing, and which categories drive the growth?
- Do newer plugins get different grades from older ones? Do AI plugins differ from the rest?
- Which AI services do plugins contact (`plugin_hosts` with `host_category` "llm-provider"), and how has that changed over time?
- How many plugins work with the current Zotero, and how popular were the ones left behind on Zotero 6 (`hidden_reason` "legacy")?
- Do stars, downloads or contributors go with better grades?
- How do plugins with Chinese and English documentation differ in what they do?
