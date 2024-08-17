## Prepare the dataset

These instructions are for preparing a dataset using the R programming language.
We hope to provide instructions for other programming languages eventually.

If you have not yet set up your computer for submitting a dataset, please see the full instructions at <https://github.com/rfordatascience/tidytuesday/blob/master/.github/pr_instructions.md>.

1. `cleaning.R`: Modify the `cleaning.R` file to get and clean the data. 
  - Write the code to download and clean the data in `cleaning.R`.
  - If you're getting the data from a github repo, remember to use the 'raw' version of the URL.
  - This script should result in one or more data.frames, with descriptive variable names (eg `players` and `teams`, not `df1` and `df2`).
2. `saving.R`: Use`saving.R` to save your datasets. This process creates both the `.csv` file(s) and the data dictionary template file(s) for your datasets. **It is not enough to simply save the CSV files using a separate process. We also need the data dictionaries.**
  - Run the first line of `saving.R` to create the functions we'll use to save your dataset.
  - Provide the name of your directory as `dir_name`.
  - Use `ttsave()` for each dataset you created in `cleaning.R`, substituting the name fo the dataset for `YOUR_DATASET_DF`.
3. `{dataset}.md`: Edit the `{dataset}.md` files to describe your datasets. There should be one file for each of your datasets. You most likely only need to edit the "description" column to provide a description of each variable.
4. `intro.md`: Edit the `intro.md` file to describe your dataset. You don't need to add a `# Title` at the top; this is just a paragraph or two to introduce the week.
5. Find at least one image for your dataset, and ideally two. These often come from the article about your dataset. If you can't find an image, create an example data visualization, and save that. Save the images in your folder as `png` files.
6. `meta.yaml`: Edit `meta.yaml` to provide information about your dataset. Also provide information about how we can credit you in the `credit` block, and delete lines from this block that do not apply to you.

### Submit your pull request with the data

1. Commit the changes in this folder to your branch. In RStudio, you can do this on the "Git" tab (the "Commit" button).
2. Submit a pull request to https://github.com/rfordatascience/tidytuesday. In R, you can do this with `usethis::pr_push()`, and then follow the instructions in your browser.
