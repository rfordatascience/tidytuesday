# The Stanford Open Policing Project

The Stanford Open Policing Project Summary Video can be seen below.
<br>

[![The Stanford Open Policing Project Summary Video](https://img.youtube.com/vi/iwOWcuFjNfw/0.jpg)](https://www.youtube.com/watch?v=iwOWcuFjNfw)
<br>

Quotes below from the Stanford Open Policing Project [website](https://openpolicing.stanford.edu/):

"On a typical day in the United States, police officers make more than 50,000 traffic stops. Our team is gathering, analyzing, and releasing records from millions of traffic stops by law enforcement agencies across the country. Our goal is to help researchers, journalists, and policymakers investigate and improve interactions between police and the public.

Currently, a comprehensive, national repository detailing interactions between police and the public doesn’t exist. That’s why the Stanford Open Policing Project is collecting and standardizing data on vehicle and pedestrian stops from law enforcement departments across the country — and we’re making that information freely available. We’ve already gathered over 200 million records from dozens of state and local police departments across the country.

We, the Stanford Open Policing Project, are an interdisciplinary team of researchers and journalists at Stanford University. We are committed to combining the academic rigor of statistical analysis with the explanatory power of data journalism."

NBC News recently covered this dataset (March 13, 2019) [here](https://www.nbcnews.com/news/us-news/inside-100-million-police-traffic-stops-new-evidence-racial-bias-n980556).

H/T to both [DJ Patil](https://twitter.com/dpatil/status/1106177431671582721) and [
Alex Chohlas-Wood `@LX_CW`](https://twitter.com/LX_CW/status/1105995928740098048) for making us aware of the dataset, and credit to the [15 people](https://openpolicing.stanford.edu/) who helped contribute to collecting/cleaning/etc this data.

# Important Notes

This Stanford Open Policing project data will not all be duplicated on our GitHub as there is an abundance of datasets, many of which are larger than the 100 MB upload size allowed by GitHub. If you put together ALL of the datasets there are over 200 MILLION stops. The data is presented as is, and some datasets are missing large chunks of data while many are close to complete. Datasets are separated by state and/or city, in both `.csv` and `.rds` format.

There are a LOT of [datasets](https://openpolicing.stanford.edu/data/) there and each one has a corresponding data dictionary [here](https://github.com/stanford-policylab/opp/blob/master/data_readme.md).

## Summary level datasets

If that is a bit too much data to dig into, consider checking out the summary-level datasets [here](https://github.com/5harad/openpolicing/tree/master/results/data_for_figures) and the included [figures](https://github.com/5harad/openpolicing/tree/master/results/figures) from the group's recent arXiv paper. If you do use the summary data - please cite their working paper ( [arXiv:1706.05678](https://arxiv.org/abs/1706.05678) ). They have been kind enough to include all the code, data, figures, and even a [tutorial](https://github.com/5harad/openpolicing/blob/master/tutorial/Rtutorial.Rmd)!

These are datasets from the [working paper](https://arxiv.org/pdf/1706.05678.pdf) mentioned above - the parent folder with the full details can be found [here](https://github.com/5harad/openpolicing). Go [here](https://github.com/5harad/openpolicing/tree/master/results/data_for_figures) to skip straight to the results folder to get all the specific `.csv` files.

### Get the summary data

There are additional [data files](https://github.com/5harad/openpolicing/tree/master/results/data_for_figures) on their github, but a file was "created for convenience which combines data from all the main analyses in the paper".

```{r}
combined_data <- readr::read_csv("https://raw.githubusercontent.com/5harad/openpolicing/master/results/data_for_figures/combined_data.csv")
```

No cleaning scripts this week, the summary level data is in great shape!

### Data Dictionary

For the Summary-level datasets - there are a few data-dictionaries, you can find them [here](https://github.com/5harad/openpolicing/tree/master/resources/dictionaries). These can help with conversion of county or district codes to more meaningful data.

|variable                     |class     |description |
|:----------------------------|:---------|:-----------|
|location                     |character | County/District location for each incidence |
|state                        |character | State for each incidence           |
|driver_race                  |character | Driver's race           |
|stops_per_year               |double    | Number of stops per year          |
|stop_rate                    |double    | Stop rate (stop = police stop of a vehicle) (%)           |
|search_rate                  |double    | Search rate (%)           |
|consent_search_rate          |double    | Consent to search rate (%)           |
|arrest_rate                  |double    | Arrest rate (%)           |
|citation_rate_speeding_stops |double    | Citation rate for speeding stops (%)           |
|hit_rate                     |double    | Hit rate (%): the proportion of searches that successfully turn up contraband |
|inferred_threshold           |double    | Inferred threshold - based off the threshold test - please see section 4.2 of the paper. |
