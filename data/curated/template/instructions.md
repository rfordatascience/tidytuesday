# How to Submit a Dataset

To submit a dataset there are a few steps:

1. Find a dataset.
2. Prepare your repository.
3. Prepare the dataset.

## Find a dataset

Find a dataset that would be good for TidyTuesday: either one that is already ready for analysis, or one that you can clean so that it meets the criteria. 
These are the requirements for a dataset:
* Files are `.csv` files.
* The whole dataset (all files) is less than 20MB.
* You can describe each variable (either using an existing data dictionary or by creating your own).
* The data is publicly available and free for reuse, either with or without attribution.

You will also need:
* The source of the dataset
* An article about the dataset or that uses the dataset
* At least one image related to or using the dataset

## Prepare your repository

To submit datasets, we use a fork/branch approach. 
You're going to fork this repository, and then create a branch in your forked repository to submit the pull request. 

1. Fork the tidytuesday repository (this one).
2. Create a new branch in that fork, with something similar to the name of the dataset you're submitting. For instance if it's a dataset on American baseball, something like "american-baseball"" or "baseball" works. 
3. Do the next steps in this fork/branch.

## Prepare the dataset

These instructions are for preparing a dataset using the R programming language.
We hope to provide instructions for other programming languages soon.

1. Navigate to the `data/curated` folder in your branch of the repository. 
2. Make a copy of the `template` folder for your dataset, inside the `curated` folder. Name it something descriptive, like "funspotr" or "ttmeta", not "my_dataset".
3. Navigate to the folder you just created. That's where you're going to do your work.
4. `cleaning.R`: Modify the `cleaning.R` file to get and clean the data. 
  * Write the code to download and clean the data in `cleaning.R`.
  * If you're getting the data from a github repo, remember to use the 'raw' version of the URL.
5. `saving.R`: Use`saving.R` to save your datasets. This creates the `.csv` file(s), and the data dictionary template file(s).
6. `{dataset}.md`: Edit the `{dataset}.md` files to describe your datasets. There should be one file for each dataset saved in step 5. Most likely you only need to fill in the "description" column with a description of each variable.
7. `intro.md`: Edit the `intro.md` file to describe your dataset.
8. Find at least one image for your dataset, and ideally 2. These often come from the article about your dataset. Save the images in your folder as `png` files.
9. `meta.yaml`: Edit `meta.yaml` to provide information about your dataset.

### Submit your pull request with the data

1. Commit the changes with this folder to your branch.
2. Submit a pull request to https://github.com/rfordatascience/tidytuesday.
