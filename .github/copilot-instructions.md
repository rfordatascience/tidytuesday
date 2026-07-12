# TidyTuesday Dataset Submission Review Instructions

This file contains instructions for how to review pull requests that submit new TidyTuesday datasets.

## What a Dataset Submission Looks Like

Submissions live in a new folder under `data/curated/`. There should be exactly one such folder, not counting `data/curated/template`. Any name (other than `template`) is acceptable for that folder. That folder must contain:

| File | Description |
|------|-------------|
| `cleaning.R` (or `cleaning.py` / `cleaning.jl`) | Code to download and clean the data |
| `{dataset}.csv` | One or more tidy CSV data files (each < 20 MB) |
| `{dataset}.md` | Data dictionary for each corresponding CSV |
| `intro.md` | A short introduction to the dataset (a paragraph or two) |
| `meta.yaml` | Metadata: title, article URL, data source URL, images, and submitter credit |
| `*.png` | At least one image related to the dataset |

## How Submissions Are Processed

If the dataset is approved, a maintainer will comment with `/assign`. This triggers a workflow on the PR:

1. `.github/workflows/pr-assign-command.yaml` triggers `.github/scripts/assign_week.R`.
2. `assign_week.R` reads `meta.yaml`, copies files to `data/{year}/{date}/`, and builds `readme.md` by combining:
   - A `# {title}` heading (from `meta.yaml`'s `title` field).
   - The content of `intro.md`.
   - A credit line: `"Thank you to {credit} for curating this week's dataset."` (from `meta.yaml`'s `credit.post` / `credit.github`).
   - The data dictionaries from the `{dataset}.md` files.
   - The contents of `cleaning.R` / `cleaning.py` / `cleaning.jl`.
3. The year-level `data/{year}/readme.md` and main `README.md` are updated with the new dataset entry.

## Automated Checks

Every dataset PR is checked by `.github/workflows/pr-check.yaml`, which calls `.github/scripts/check_curated.R` (sourcing `.github/scripts/check_functions.R`). Results appear in a **"TidyTuesday Submission Check"** comment on the PR. A failure does **not** automatically mean the dataset should be rejected, but each flagged item deserves a closer look.

The automated checks verify:
- Exactly one submission folder is present under `data/curated/`.
- `meta.yaml`, `cleaning.R` (or `cleaning.py`/`cleaning.jl`), and `intro.md` are present.
- At least one `*.png` image is present.
- Each `*.csv` has a matching `*.md` data dictionary.
- All CSV files are valid UTF-8.
- The `article` and `data_source` URLs in `meta.yaml` are reachable. This check is *not* an automatic ground to reject the dataset (URLs may block bots while still being reachable by humans).
- Images listed in `meta.yaml` exist, are within the Bluesky file-size limit (~976 KB), and within the Mastodon megapixel limit (8.3 MP).
- Alt text for images is 1000 characters or fewer (Mastodon limit).

## Review Checklist

When reviewing a dataset submission PR, check the following:

### `intro.md`
- [ ] **No `#` title header.** The title is added automatically from `meta.yaml` when the readme is assembled. A duplicate `# Title` in `intro.md` will produce a doubled heading.
- [ ] The text reads naturally after a `# {title}` heading (e.g. it doesn't repeat the title in the first sentence in an awkward way).

### `meta.yaml`
- [ ] `title` is descriptive and fits the sentence "This week we're exploring {title}!".
- [ ] `article.url` and `data_source.url` are present and publicly accessible. If you are not able to verify this, ask a maintainer to verify these URLs.
- [ ] The `images` section lists at least one PNG (which is also present in this submission); each entry has a `file` and an `alt` field.
- [ ] Alt text is in sentence case, and is 1000 characters or fewer, and serves as a *replacement* for the image (e.g. "A bar chart showing widgets produced per country in 1997. Peru has the largest value with 27 widgets, Kenya has the second largest value at 24, and other countries are evenly distributed down to the United States with only 3 widgets."), not simply a description of the image (e.g. "A bar chart of countries and widgets."). If you are able to evaluate the image, do so to assess the alt text. If not, still assess the alt text as described here.
- [ ] The `credit` block is filled in. The submitter will be automatically thanked with the line "Thank you to {credit} for curating this week's dataset." (where `{credit}` may be a Markdown link if `credit.github` is provided). If anyone else is thanked in `intro.md`, check that it won't produce awkward or duplicate acknowledgements alongside the auto-generated credit line.

### CSV files vs. data dictionaries (`{dataset}.md`)
- [ ] Every `*.csv` file has a matching `{dataset}.md` dictionary.
- [ ] Column names in the dictionary **exactly match** the column names in the CSV (same spelling, same case).
- [ ] Data types listed in the dictionary are consistent with the actual column types in the CSV.
- [ ] Each description is filled in (not left as the default "Describe this field in sentence case.").
- [ ] Descriptions are in sentence case and free of typos.
- [ ] Each description makes sense given the column name and a sample of its values.

### `cleaning.R` / `cleaning.py` / `cleaning.jl`
- [ ] The script can plausibly be run to reproduce the CSV files from their original source. You should *not* actually execute this code, though.
- [ ] If fetching from GitHub, the raw URL is used.
- [ ] Data frames are given descriptive names (e.g. `players`, `teams`; not `df1`, `df2`).

### Images
- [ ] At least one `*.png` is present in the submission folder.
- [ ] Each image listed in `meta.yaml` actually exists in the folder.

### Data quality (load with Python to verify)

Use Python to load the dataset(s) and spot-check the data. The runner environment has Python available:

```python
import pandas as pd

# Replace with the actual file path(s) from the PR
df = pd.read_csv("data/curated/<submission-folder>/<dataset>.csv")

print(df.shape)
print(df.dtypes)
print(df.head())
print(df.isnull().mean().round(3))  # fraction missing per column
print(df.nunique())                  # unique values per column
```

Check for:
- [ ] No unexpected all-NA columns.
- [ ] No obviously garbled text (encoding issues).
- [ ] Column names and types match the data dictionary.
- [ ] The number of rows and columns looks plausible for the described dataset.

## Helpful Files and References

- `pr_instructions.md` — submission instructions for contributors (R-focused; the same logic applies using `cleaning.py` or `cleaning.jl` for Python/Julia submissions).
- `data/curated/template/` — the template folder that submitters can copy and edit.
- `.github/scripts/check_curated.R` and `.github/scripts/check_functions.R` — automated check logic.
- `.github/scripts/assign_week.R` — the script that processes accepted submissions (sources `parse_readme.R`, `dates.R`, and `metadata.R`).
- `.github/pull_request_template.md` — the checklist contributors are asked to complete before submitting.
