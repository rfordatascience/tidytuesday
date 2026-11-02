# TidyTuesday Dataset Submission Review Instructions

This file contains instructions for how to review pull requests that submit new TidyTuesday datasets.

## What a Dataset Submission Looks Like

Submissions live in a new folder under `data/curated/`. There should be exactly one such folder, not counting `data/curated/template`. Any name (other than `template`) is acceptable for that folder. That folder must contain:

| File | Description |
|------|-------------|
| `cleaning.R` (or `cleaning.py` / `cleaning.jl`) | Code to download and clean the data |
| `{dataset}.csv` | One or more tidy CSV data files, each under 20 MB |
| `{dataset}.md` | Data dictionary for each corresponding CSV |
| `intro.md` | A short introduction to the dataset (a paragraph or two) |
| `meta.yaml` | Metadata: title, article (title and URL), data source (title and URL), images with alt text, and submitter credit |
| `*.png` | At least one (and at most three) image related to the dataset, listed in `meta.yaml` |

The folder should *not* contain leftover template files (`instructions.md`, `saving.R`). Every `*.md` file in the folder is copied to the published dataset, so stray `.md` files would be published. The PR should otherwise touch nothing outside `data/curated/<submission-folder>/`.

## Dataset Eligibility

Per `pr_instructions.md`, a dataset must:
- Be saved as one or more CSV files, each under 20 MB.
- Have every variable described (in a data dictionary).
- Be publicly available and free to reuse, with or without attribution. Try to check that the source's license or terms permit this, and that the intro credits the source where the license requires it (e.g. ODbL attribution).
- Not promote a commercial business, product, or service. Such submissions are not accepted via PR (the submitter should email tidytuesday@dslc.io instead).
- Have an identifiable source, an article about or using the data, and at least one image.

Also consider whether the dataset has already been used in TidyTuesday (see the table in the main `README.md`), and whether it is sensitive or controversial.

## How Submissions Are Processed

If the dataset is approved, a maintainer will comment with `/assign`. This triggers a workflow on the PR:

1. `.github/workflows/pr-assign-command.yaml` triggers `.github/scripts/assign_week.R`.
2. `assign_week.R` reads `meta.yaml`, copies files to `data/{year}/{date}/`, and builds `readme.md`. Notes on the script's behavior:
   - It aborts if `title`, `data_source.title`, `data_source.url`, `article.title`, or `article.url` is missing, so all five are effectively required.
   - Only images listed under `images` in `meta.yaml` are copied (unlisted PNGs are dropped). Images over the Bluesky size limit are automatically downsized.
   - HTML comments (`<!-- -->`) in `.md` files and the cleaning script are stripped.
3. The readme combines:
   - A `# {title}` heading (from `meta.yaml`'s `title` field).
   - The content of `intro.md`.
   - A credit line: `"Thank you to {credit} for curating this week's dataset."` (from `meta.yaml`'s `credit.post` / `credit.github`). It is appended directly after `intro.md`, so it appears after any quote or list of questions in the intro.
   - A "The Data" section with R, Python, and Julia loading code generated from the CSV file names, and a "How to Participate" section, both from static templates.
   - The data dictionaries from the `{dataset}.md` files, each under an automatically added `### {dataset}.csv` heading.
   - The contents of `cleaning.R` / `cleaning.py` / `cleaning.jl`.
4. The year-level `data/{year}/readme.md` and main `README.md` are updated with a new row built from `title`, `data_source.title`/`url`, and `article.title`/`url`. `static/tt_data_type.csv` is also updated, and the `data/curated/` submission folder is deleted.

## Automated Checks

Every dataset PR is checked by `.github/workflows/pr-check.yaml`, which calls `.github/scripts/check_curated.R` (sourcing `.github/scripts/check_functions.R`). A failure does **not** automatically mean the dataset should be rejected, but each flagged item deserves a closer look.

The automated checks verify:
- Exactly one submission folder is present under `data/curated/`.
- `meta.yaml`, `intro.md`, and a cleaning script (`cleaning.R`, `cleaning.py`, or `cleaning.jl`) are present. `cleaning.jl` is an accepted cleaning script, but the check may not recognize it (see issue #1098), in which case a Julia submission is wrongly flagged as missing one. The automated check is guidance only and never blocks acceptance, so don't treat such a flag as a reason to reject.
- At least one `*.png` image is present.
- At least one `*.csv` is present, and each `*.csv` has a matching `*.md` data dictionary.
- All CSV files are valid UTF-8.
- The `article` and `data_source` URLs in `meta.yaml` are reachable. This check is *not* an automatic ground to reject the dataset (URLs may block bots while still being reachable by humans).
- `meta.yaml` has an `images` section, and the images listed in it exist, are within the Bluesky file-size limit (~976 KB), and are within the Mastodon megapixel limit (8.3 MP).
- Alt text for images is 1000 characters or fewer (Mastodon limit).

The automated checks do **not** verify: CSV file sizes, dictionary contents or agreement with CSV columns, leftover template placeholders, `intro.md` content, presence of `article.title` / `data_source.title` / `credit.post`, the maximum of three images, or dataset eligibility. Reviewers must check these.

The report also includes a "Manual controversy check" link (a Google search for the title plus "controversy") and a per-column summary of each CSV (class, percent missing, number of unique values). Follow up on both: use the summary to inform the data quality review below.

## Review Checklist

When reviewing a dataset submission PR, check the following:

### Leftover template text
- [ ] No template placeholders remain anywhere: `PasteQuoteHere` in `intro.md`; `DESCRIPTIVE TITLE...`, `YOUR NAME...`, `YOURNAME`, `FILENAME.png`, `ALT TEXT FOR THIS IMAGE`, etc. in `meta.yaml`; "Describe this field in sentence case." in a dictionary. (HTML comments are stripped from the readme, so leftover template comments are harmless.)

### `intro.md`
- [ ] Introduces the dataset in a paragraph or two. The template suggests a quote from the source (lines starting with `>`) and optional questions for participants. The quote is customary, so a missing quote is a minor suggestion, not a blocker; questions are optional.
- [ ] The source is named, with attribution if its license requires it.
- [ ] **No `#` title header.** The title is added automatically from `meta.yaml` when the readme is assembled. A duplicate `# Title` in `intro.md` will produce a doubled heading.
- [ ] The text reads naturally after a `# {title}` heading (e.g. it doesn't repeat the title in the first sentence in an awkward way).

### `meta.yaml`
- [ ] `title` is descriptive and fits the sentence "This week we're exploring {title}!".
- [ ] `article.title`, `article.url`, `data_source.title`, and `data_source.url` are all present, since the assign script fails without them. The article should describe or use the dataset. The URLs should be publicly accessible; if you are not able to verify this, ask a maintainer to verify them.
- [ ] The `images` section lists between one and three PNGs (each also present in this submission); each entry has a `file` and an `alt` field. PNGs in the folder that are not listed in `meta.yaml` are not published.
- [ ] Alt text is in sentence case, and is 1000 characters or fewer, and serves as a *replacement* for the image (e.g. "A bar chart showing widgets produced per country in 1997. Peru has the largest value with 27 widgets, Kenya has the second largest value at 24, and other countries are evenly distributed down to the United States with only 3 widgets."), not simply a description of the image (e.g. "A bar chart of countries and widgets."). If you are able to evaluate the image, do so to assess the alt text. If not, still assess the alt text as described here.
- [ ] The `credit` block is filled in, and in particular `credit.post` (name and optional affiliation) is present. If only `credit.github` is given, `assign_week.R` produces a broken credit line (a literal "@credit_handle"). Unused credit fields (`bluesky`, `linkedin`, `mastodon`, `github`) should be deleted rather than left as placeholders. The submitter will be automatically thanked with the line "Thank you to {credit} for curating this week's dataset." (where `{credit}` is a Markdown link to their GitHub profile if `credit.github` is provided). If anyone else is thanked in `intro.md`, check that it won't produce awkward or duplicate acknowledgements alongside the auto-generated credit line.

### CSV files vs. data dictionaries (`{dataset}.md`)
- [ ] Every `*.csv` file has a matching `{dataset}.md` dictionary (same file stem).
- [ ] The dictionary is a markdown table with `variable`, `class`, and `description` columns, and has no heading of its own (a `### {dataset}.csv` heading is added automatically).
- [ ] The data is tidy: one observation per row, one variable per column, no summary rows or stray header/footer lines.
- [ ] Column names in the dictionary **exactly match** the column names in the CSV (same spelling, same case).
- [ ] Data types listed in the dictionary are consistent with the actual column types in the CSV.
- [ ] Each description is filled in (not left as the default "Describe this field in sentence case.").
- [ ] Descriptions are in sentence case and free of typos.
- [ ] Each description makes sense given the column name and a sample of its values.
- [ ] If there are multiple CSVs, join keys exist in each file and are described in the dictionaries.

### `cleaning.R` / `cleaning.py` / `cleaning.jl`
- [ ] The script can plausibly be run to reproduce the CSV files from their original source. You should *not* actually execute this code, though.
- [ ] There is exactly one cleaning script, with `library()` calls (or imports) at the top, and it produces data frames matching the submitted CSVs.
- [ ] It does not depend on local absolute paths or private credentials. If the data cannot be re-downloaded (e.g. it was hand-compiled), the script or intro explains where it came from.
- [ ] If fetching from GitHub, the raw URL is used.
- [ ] Data frames are given descriptive names (e.g. `players`, `teams`; not `df1`, `df2`). The CSV and dictionary file names follow these object names.

### Images
- [ ] At least one `*.png` is present in the submission folder, and no more than three are listed in `meta.yaml`.
- [ ] Each image listed in `meta.yaml` actually exists in the folder.
- [ ] Images relate to the dataset, and nothing in them is inappropriate to post publicly or likely to be a rights problem (e.g. a copyrighted figure from the article, unless permitted).

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
- [ ] Each CSV file is under 20 MB.
- [ ] No personal or sensitive information about private individuals (e.g. contact details) that is inappropriate for public release.

## Helpful Files and References

- `pr_instructions.md` — submission instructions for contributors (R-focused; the same logic applies using `cleaning.py` or `cleaning.jl` for Python/Julia submissions). Contributors may instead use the {tidytuesdayR} curation functions (`tt_clean()`, `tt_save_dataset()`, `tt_intro()`, `tt_meta()`, `tt_submit()`), which generate the same files in a `tt_submission` folder.
- `data/curated/template/` — the template folder that submitters can copy and edit.
- `.github/scripts/check_curated.R` and `.github/scripts/check_functions.R` — automated check logic.
- `.github/scripts/assign_week.R` — the script that processes accepted submissions (sources `parse_readme.R`, `dates.R`, and `metadata.R`).
- `data/2026/` — examples of processed submissions (e.g. `data/2026/2026-10-20/`).
- `.github/pull_request_template.md` — the checklist contributors are asked to complete before submitting.
