|variable                  |class     |description |
|:-------------------------|:---------|:-----------|
|slug                      |character |Id of the plugin on zoteroplugins.org; its page is https://zoteroplugins.org/p/{slug}. Joins the other three tables. |
|name                      |character |Name of the plugin, as its release file gives it. |
|repo                      |character |GitHub repository, as owner/name. |
|owner                     |character |GitHub account that owns the repository. |
|tagline                   |character |The site's own one-line summary of what the plugin does (at most 45 characters), written by AI from the plugin's README and checked by a script. NA where there is none yet. |
|main_category             |character |The main job the plugin is listed under (one of eight; see plugin_categories for all of a plugin's categories). Assigned by AI from the plugin's name and summary, not by hand. NA where none was assigned. |
|grade                     |character |The Zotero Plugins grade, from automated checks of the code of the latest release: A+ (recommended, and behaved as its card describes when installed in a live Zotero), A (recommended: every check of the code came out low), B (use with care: read why before installing), C (not recommended: serious problems found). NA means not graded yet. |
|grade_reason              |character |Why it got that grade, in the site's words (for example "it launches programs on your computer"). NA where there is none. |
|works_with_current_zotero |logical   |Whether it works with the current Zotero (10 at the time of this snapshot). |
|zotero_6                  |logical   |Whether its latest release declares support for Zotero 6. Zotero 7 (2024) changed the plugin system, so plugins built only for Zotero 6 or older don't run in later versions. To find those, use hidden_reason "legacy" (99 plugins): 43 of them declare only Zotero 5 or older, so zotero_6 is FALSE for them. |
|zotero_7                  |logical   |Whether its latest release declares support for Zotero 7. |
|zotero_8                  |logical   |Whether its latest release declares support for Zotero 8. |
|zotero_9                  |logical   |Whether its latest release declares support for Zotero 9. |
|zotero_10                 |logical   |Whether its latest release declares support for Zotero 10, the current version. |
|zotero_11                 |logical   |Whether its latest release declares support for Zotero 11, in beta at the time of this snapshot. |
|created_at                |date      |Date its GitHub repository was created. For a fork this is the date of the fork, not of the original. |
|last_release_at           |date      |Date of its latest GitHub release. |
|last_commit_at            |date      |Date of the latest commit to its repository. |
|maintenance               |character |Maintenance status from its release and commit history: active, slowing, dormant or archived (the repository is archived on GitHub). |
|stars                     |double    |GitHub stars. |
|forks                     |double    |GitHub forks. |
|contributors              |double    |People who have committed to the repository, as GitHub counts them. |
|releases                  |double    |Releases published on GitHub. |
|downloads                 |double    |All-time downloads of its .xpi release files from GitHub, all releases together. Automatic updates count as downloads too. |
|latest_release_downloads  |double    |Downloads of its latest release's .xpi files. |
|in_use_estimate           |double    |The site's estimate of how many copies of Zotero have it installed. Zotero downloads each new version once for every copy that has the plugin, so the estimate is the downloads of its most-downloaded recent release, rounded. Plugins that update from outside GitHub count low. NA without enough history. |
|license                   |character |Licence of its code, as GitHub detects it (SPDX id). NA where GitHub finds none. |
|is_fork                   |logical   |Whether the repository is a fork of another plugin's repository. |
|fork_of                   |character |The repository it was forked from, as owner/name. NA if it is not a fork. |
|hidden                    |logical   |Whether the site leaves it out of its lists (it still has a page). See hidden_reason. |
|hidden_reason             |character |Why it is hidden: fork (a fork of a plugin the site lists, unless it has overtaken the original with more downloads, or is still active while the original has stopped), legacy (built only for Zotero 6 or older), no-release (no installable release), removed (its repository is gone), retired (its developer retired it). NA if it is listed. |
|docs_language             |character |Main language of its README, as an ISO 639-1 code (en, zh, ko, ...). NA where it couldn't be told. |
|api_key                   |character |Whether it needs an API key for an outside service (usually an AI or translation service): required, optional, none, or unknown (not checked yet). |
|data_sharing              |character |Where its code sends data, in short: no-network-found (no web requests found), user-configured-only (only servers the user sets up), named-third-parties (only services the site could identify), developer-servers (the developer's own servers), unknown-endpoints (servers the site couldn't identify), bundled-library-only (network code only in bundled libraries). NA if its code wasn't analysed. |
|update_source             |character |Where Zotero's automatic updates for it come from: this-project (its own GitHub repository), other-listed-project (another plugin's project), other-repository, other-host (an address that isn't a code host), unclaimed-namespace (a template address its developer doesn't control), none (no update address). NA if its code wasn't analysed. |
|provenance                |character |Where the release file came from: plausible (uploaded by the project's automated GitHub build or carrying a build attestation, and not obfuscated; the build itself wasn't reproduced) or not-checked (uploaded from a person's account, so the file hasn't been compared with the public source code). NA if its code wasn't analysed. |
|obfuscated                |logical   |Whether the analysis found the plugin's own code deliberately obfuscated, that is made hard to read (bundled libraries are left out of this check). Encrypted code is a separate finding: capability_id "encrypted-code" in plugin_capabilities. NA if its code wasn't analysed. |
|live_test                 |character |Result of installing the release in a real Zotero and watching what it does: as-described (it behaved as its card says), unexpected (it did something the card didn't describe), not-loaded (it didn't load), incomplete. NA if not tested in a live Zotero. |
|url                       |character |Its page on zoteroplugins.org. |
