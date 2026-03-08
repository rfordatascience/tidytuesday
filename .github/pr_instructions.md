# How to Submit a Dataset

Thank you for helping us help learners!

> [!NOTE]
> This article talks about submitting datasets "from scratch," but there's an easier way!
> The {[tidytuesdayR](https://DSLC.io/tidytuesdayR)} R package has a [set of functions for curating TidyTuesday datasets in R](https://dslc-io.github.io/tidytuesdayR/articles/curating.html)!
> The functions currently only work in Rstudio, but [we hope to also support Positron soon!](https://github.com/dslc-io/tidytuesdayR/issues/139)

There are 4 main steps to submit a dataset:

1.  [Find a dataset.](#find-a-dataset)
2.  [Prepare your repositry.](#prepare-your-repository)
3.  [Create a branch.](#create-a-branch)
4.  [Prepare the dataset.](#prepare-the-dataset)

## Find a dataset

Find a dataset that would be good for TidyTuesday: either one that is already ready for analysis, or one that you can clean so that it meets the criteria. These are the requirements for a dataset:

-   Data can be saved as one or more CSV files.

-   The whole dataset (all files) is less than 20MB.

-   You can describe each variable (either using an existing data dictionary or by creating your own dictionary).

-   The data is publicly available and free for reuse, either with or without attribution.

You will also need:

-   The source of the dataset

-   An article about the dataset or that uses the dataset

-   At least one image related to or using the dataset

## Prepare your repository

You'll need to perform this step the first time you submit a pull request to this repository. 
A "pull request" is a submission of code to a git repository. If you have never worked with git before, that's fine! We'll help you get set up.

1.  Set up git, github, and your IDE (such as RStudio). We have step-by-step [instructions for setting up things to work with the Data Science Learning Community](https://github.com/r4ds/bookclub-setup?tab=readme-ov-file#setting-up-for-data-science-learning-community-book-clubs).
2.  Fork the tidytuesday repository. In R, you can use `usethis::create_from_github("rfordatascience/tidytuesday")` to create your personal fork on GitHub and copy it to your computer. Note: This requires about **8 GB** of space on disk.

## Create a branch

We use a fork/branch approach to pull requests, meaning you'll create a version of the repo specifically for your changes, and then ask us to merge those changes into the main tidytuesday repository.

1.  If you are on anything other than the `main` branch of your local repository, switch back to main. In R, you can use `usethis::pr_pause()` (if your previous submission is still pending), or `usethis::pr_finish()` (if we've accepted your submission).

2.  Pull the latest version of the repository to your computer. In R, use `usethis::pr_merge_main()`

3.  Create a new branch, with something similar to the name of the dataset you're submitting. In R, you can create this branch using `usethis::pr_init(BRANCHNAME)`. For instance if it's a dataset on American baseball, something like "american-baseball" using `usethis::pr_init("american-baseball")`.

4.  Navigate to the `data/curated` folder in your branch of the repository.

5.  Make a copy of the `template` folder for your dataset, inside the `curated` folder. Name it something descriptive -- the same name as your branch would work, so "american-baseball" not "my_dataset".

6.  Inside the folder you just created is where you're going to do your work.

## Prepare the dataset

A copy the following instructions is also available in the folder you've created, as `instructions.md`. 
These instructions are for preparing a dataset using the R programming language, but we hope to provide instructions for other programming languages eventually.

1.  `cleaning.R`: Modify the `cleaning.R` file to get and clean the data.
    -   Write the code to download and clean the data in `cleaning.R`.
    -   If you're getting the data from a github repo, remember to use the 'raw' version of the URL.
    -   This script should result in one or more data.frames, with descriptive variable names (eg `players` and `teams`, not `df1` and `df2`).

2.  `saving.R`: Use`saving.R` to save your datasets. This process creates both the `.csv` file(s) and the data dictionary template file(s) for your datasets. **Don't save the CSV files using a separate process because we also need the data dictionaries.**
    -   Run the first line of `saving.R` to create the functions we'll use to save your dataset.
    -   Provide the name of your directory as `dir_name`.
    -   Use `ttsave()` for each dataset you created in `cleaning.R`, substituting the name for the dataset for `YOUR_DATASET_DF`.

3.  `{dataset}.md`: Edit the `{dataset}.md` files to describe your datasets (where `{dataset}` is the name of the dataset). These files are created by `saving.R`. There should be one file for each of your datasets. You most likely only need to edit the "description" column to provide a description of each variable.

4.  `intro.md`: Edit the `intro.md` file to describe your dataset. You don't need to add a `# Title` at the top; this is just a paragraph or two to introduce the week.

5.  Find at least one image for your dataset. These often come from the article about your dataset. If you can't find an image, create an example data visualization, and save the images in your folder as `png` files.

6.  `meta.yaml`: Edit `meta.yaml` to provide information about your dataset and how we can credit you. You can delete lines from the `credit` block that do not apply to you.

### Submit your pull request with the data

1.  Commit the changes with this folder to your branch. In RStudio, you can do this on the "Git" tab (the "Commit" button).

2.  Submit a pull request to <https://github.com/rfordatascience/tidytuesday>. In R, you can do this with `usethis::pr_push()`, and then follow the instructions in your browser.
