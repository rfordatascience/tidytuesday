# How to Submit a Dataset

To submit a dataset there are a few steps.

* Identifying a dataset
* Setting up your github repo to submit a PR
* Submitting a dataset

### Find a dataset

Find a dataset that would be good for TidyTuesday, either that is already ready for analysis, or that you can do some data cleaning so it meets the criteria. These are the requirements for a dataset.
  * Files are .csv files
  * The whole dataset is less than 20MB
  * The metadata exists, you can describe each variable
  * The data is publicly avaialable and free for reuse, either with or with attribution

You will aslo need:
  * some sort of source for the dataset
  * an article about the dataset or using the dataset
  * at least one image

More complete instructions for this will be available elsewhere soon

### Prepare your repository

To submit datasets, we use a fork/branch approach. You're going to fork this repository, and then create a branch in your forked repository to submit the pull request. 

1. Fork the tidytuesday repository (this one). We will have instructions soon that don't involve copying the entire TidyTuesday repository (which is huge), but for now we're starting from the full thing.
2. Create a new branch in that fork, with something similar to the name of the dataset you're submitting. For instance if it's a dataset on American baseball, something like 'american baseball' or 'baseball' works. 
3. Do the next steps in this fork/branch.

### Prepare the dataset

1. Go into the 'data/curated' folder. Make a copy of the "template" folder for your dataset, inside the "curated" folder. Name it something descriptive, like "funspotr" or "ttmeta", not "my_dataset".
2. Go into that folder you just copied. That's where you're doing to do your work.
3. `cleaning.R` Get the clean data as .csv files into this folder.
  * Write the code to download and clean the data in `cleaning.R`.
  * If you're getting the data from a github repo, remember to use the 'raw' version of the URL.
5. `saving.R`: Use`saving.R` to save your datasets. This creates the .csv file, and the data dictionary template files.
6. `{dataset}.md`: Edit the `{dataset}.md` files to describe your datasets. There should be one file for each dataset saved in step 5. Most likely you only need to fill in the "description" column with a description of each variable.
7. `intro.md`: Edit the `intro.md` file to describe your dataset.
8. Find at least one image for your dataset, and ideally 2. These often come from the article about your dataset. Save the images in your folder as `png` files.
9. `meta.yaml`: Edit `meta.yaml` to provide information about the your dataset.

### Submit your pull request with the data

1. Commit the changes with this folder to your branch
2. Submit a pull request to https://github.com/rfordatascience/tidytuesday
