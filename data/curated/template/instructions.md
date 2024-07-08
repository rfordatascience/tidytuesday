# How to Submit a Dataset

1. Fork the repository. We will have instructions soon that don't involve copying the entire TidyTuesday repository (which is huge), but for now we're starting from the full thing.
2. Find a dataset. More complete instructions for this will be available elsewhere soon. You will need some sort of source for the dataset, an article about the dataset or using the dataset, and at least one image.
3. Make a copy of this "template" folder for your dataset, inside the "curated" folder. Name it something descriptive, like "funspotr" or "ttmeta", not "my_dataset".
4. Write code to download and clean the data in `cleaning.R`.
5. Use `saving.R` to save your datasets, and to create data dictionary template files.
6. Edit the `{dataset}.md` files to describe your datasets. There should be one file for each dataset saved in step 4. Most likely you only need to fill in the "description" column with a description of each variable.
7. Edit the `intro.md` file to describe your dataset.
8. Find at least one image for your dataset, and ideally 2. These often come from the article about your dataset. Save the images in your folder as `png` files.
9. Edit `meta.yaml` to provide information about the your dataset.
10. Submit a pull request with your dataset.
