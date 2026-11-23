# Data from zoteroplugins.org (https://zoteroplugins.org/api/plugins.json), licensed CC BY 4.0:
# "zoteroplugins.org (Ilias Beshimov), CC BY 4.0". The site rebuilds that file every night from
# its census of Zotero plugins on GitHub, so it changes from day to day. The CSVs saved here are
# the version of 18 November 2026, built from the site's repository
# (https://github.com/iliasbeshimov/zoteroplugins.org) at commit
# d6a1ec4e38a4065370f1f55091c58cd998e4f1ce.
#
# Cleaning: the nested JSON is split into four tidy tables, one row per plugin plus one row per
# category, capability and web address. A grade of "–" (not graded yet) becomes NA, timestamps
# become dates, and the Zotero versions a plugin declares become one logical column per major
# version. Nothing else is changed. Developers' own descriptions are left out, because they stay
# under their authors' terms; the tagline is the site's own one-line summary.

import json
from urllib.request import Request, urlopen

import pandas as pd

# The site turns away Python's default client name, so the request names itself.
request = Request(
    "https://zoteroplugins.org/api/plugins.json",
    headers={"User-Agent": "tidytuesday-cleaning"},
)
with urlopen(request) as response:
    raw = json.load(response)

CATEGORIES = {
    "reading": "Reading & PDFs",
    "citing": "Citing & writing",
    "ai": "AI & summaries",
    "translation": "Translation",
    "organising": "Organising & tags",
    "metadata": "Import & metadata",
    "interface": "Interface & look",
    "files": "Files, sync & backup",
}
ZOTERO_MAJORS = [6, 7, 8, 9, 10, 11]


def day(timestamp):
    return timestamp[:10] if timestamp else None


# One row per plugin.
zotero_plugins = pd.DataFrame(
    [
        {
            "slug": p["slug"],
            "name": p["name"],
            "repo": p["repo"],
            "owner": p["author"],
            "tagline": p["tagline"],
            "main_category": CATEGORIES[p["jobs"][0]] if p["jobs"] else None,
            "grade": None if p["grade"] == "–" else p["grade"],
            "grade_reason": p["because"] or None,
            "works_with_current_zotero": p["worksWithCurrentZotero"],
            **{f"zotero_{v}": v in p["supports"] for v in ZOTERO_MAJORS},
            "created_at": day(p["createdAt"]),
            "last_release_at": day(p["lastReleaseAt"]),
            "last_commit_at": day(p["lastCommitAt"]),
            "maintenance": p["maintenance"],
            "stars": p["stars"],
            "forks": p["forks"],
            "contributors": p["contributors"],
            "releases": p["releases"],
            "downloads": p["downloads"],
            "latest_release_downloads": p["latestDownloads"],
            "in_use_estimate": p["inUse"],
            "license": p["license"],
            "is_fork": p["forkOf"] is not None,
            "fork_of": p["forkOf"],
            "hidden": p["hidden"],
            "hidden_reason": p["hiddenReason"],
            "docs_language": p["docsLanguages"][0] if p["docsLanguages"] else None,
            "api_key": p["keyNeed"],
            "data_sharing": p["dataSharing"],
            "update_source": p["updates"],
            "provenance": p["provenance"],
            "obfuscated": p["obfuscated"],
            "live_test": p["liveTest"],
            "url": f"https://zoteroplugins.org{p['url']}",
        }
        for p in raw
    ]
)
for column in ["stars", "forks", "contributors", "releases", "downloads",
               "latest_release_downloads", "in_use_estimate"]:
    zotero_plugins[column] = zotero_plugins[column].astype("Int64")
zotero_plugins["obfuscated"] = zotero_plugins["obfuscated"].astype("boolean")

# One row per category a plugin is listed under: its main one first, plus up to two more.
plugin_categories = pd.DataFrame(
    [
        {"slug": p["slug"], "category": CATEGORIES[job], "main": i == 0}
        for p in raw
        for i, job in enumerate(p["jobs"])
    ]
)

# One row per capability finding on a plugin's card.
plugin_capabilities = pd.DataFrame(
    [
        {
            "slug": p["slug"],
            "capability_id": c["id"],
            "capability": c["label"],
            "concern": c["concern"],
        }
        for p in raw
        for c in p["capabilities"]
    ]
)

# One row per web address a plugin's code contacts or names.
plugin_hosts = pd.DataFrame(
    [
        {
            "slug": p["slug"],
            "host": h["host"],
            "host_category": h["category"],
            "confirmed": h["confirmed"],
        }
        for p in raw
        for h in p["hosts"]
    ]
)
