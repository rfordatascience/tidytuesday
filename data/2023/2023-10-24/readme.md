# Patient Risk Profiles

The virtual [R/Pharma Conference](https://rinpharma.com/) is happening this week!
To celebrate, we're exploring Patient Risk Profiles. 
Thank you to [Jenna Reps](https://github.com/jreps) for preparing this week's data!

> This dataset contains 100 simulated patient's medical history features and the predicted 1-year risk of 14 outcomes based on each patient's medical history features. The predictions used real logistic regression models developed on a large real world healthcare dataset.

Note: We did *not* clean the column names this week. 
This data looks more like the sort of data you're likely to encounter in the wild, so we thought it would be good practice to work with it as-is.

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-10-24')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 43)

patient_risk_profiles <- tuesdata$patient_risk_profiles

# Option 2: Read directly from GitHub

patient_risk_profiles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-24/patient_risk_profiles.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.


### Data Dictionary

# `patient_risk_profiles.csv`

|variable |class |description |
|:-------------------|:---------|:-------------------|
|personId | integer | A unique identifier for the simulated patient |
|age group:  10 -  14 | integer | A binary column where 1 means the patient is aged between 10-14 (inclusive) and 0 means the patient is not in that age group |
|age group:  15 -  19 | integer | A binary column where 1 means the patient is aged between 15-19 (inclusive) and 0 means the patient is not in that age group |
|age group:  20 -  24 | integer | A binary column where 1 means the patient is aged between 20-24 (inclusive) and 0 means the patient is not in that age group |
|age group:  65 -  69 | integer | A binary column where 1 means the patient is aged between 65-69 (inclusive) and 0 means the patient is not in that age group |
|age group:  40 -  44 | integer | A binary column where 1 means the patient is aged between 40-44 (inclusive) and 0 means the patient is not in that age group | 
|age group:  45 -  49 | integer | A binary column where 1 means the patient is aged between 45-49 (inclusive) and 0 means the patient is not in that age group |
|age group:  55 -  59 | integer | A binary column where 1 means the patient is aged between 55-59 (inclusive) and 0 means the patient is not in that age group | 
|age group:  85 -  89 | integer | A binary column where 1 means the patient is aged between 85-89 (inclusive) and 0 means the patient is not in that age group | 
|age group:  75 -  79 | integer | A binary column where 1 means the patient is aged between 75-79 (inclusive) and 0 means the patient is not in that age group | 
|age group:   5 -   9 | integer | A binary column where 1 means the patient is aged between 5-9 (inclusive) and 0 means the patient is not in that age group |
|age group:  25 -  29 | integer | A binary column where 1 means the patient is aged between 25-29 (inclusive) and 0 means the patient is not in that age group | 
|age group:   0 -   4 | integer | A binary column where 1 means the patient is aged between 0-4 (inclusive) and 0 means the patient is not in that age group | 
|age group:  70 -  74 | integer | A binary column where 1 means the patient is aged between 70-74 (inclusive) and 0 means the patient is not in that age group | 
|age group:  50 -  54 | integer | A binary column where 1 means the patient is aged between 50-54 (inclusive) and 0 means the patient is not in that age group | 
|age group:  60 -  64 | integer | A binary column where 1 means the patient is aged between 60-64 (inclusive) and 0 means the patient is not in that age group | 
|age group:  35 -  39 | integer | A binary column where 1 means the patient is aged between 35-39 (inclusive) and 0 means the patient is not in that age group | 
|age group:  30 -  34 | integer | A binary column where 1 means the patient is aged between 30-34 (inclusive) and 0 means the patient is not in that age group | 
|age group:  80 -  84 | integer | A binary column where 1 means the patient is aged between 80-84 (inclusive) and 0 means the patient is not in that age group | 
|age group:  90 -  94 | integer | A binary column where 1 means the patient is aged between 90-94 (inclusive) and 0 means the patient is not in that age group |
|Sex = FEMALE | integer | A binary column where 1 means the patient has a female sex | 
|sex = MALE | integer | A binary column where 1 means the patient has a male sex | 
|Acetaminophen exposures in prior year | integer | A binary column where 1 means the patient had a record for acetaminophen in the prior year and 0 means they did not | 
|Occurrence of Alcoholism in prior year | integer | A binary column where 1 means the patient had a record for alcoholism in the prior year and 0 means they did not | 
|Anemia in prior year | integer | A binary column where 1 means the patient had a record for anemia in the prior year and 0 means they did not | 
|Angina events in prior year | integer | A binary column where 1 means the patient had a record for angina in the prior year and 0 means they did not | 
|ANTIEPILEPTICS in prior year | integer | A binary column where 1 means the patient had a record for a drug in the category ANTIEPILEPTICS in the prior year and 0 means they did not | 
|Occurrence of Anxiety in prior year | integer | A binary column where 1 means the patient had a record for anxiety in the prior year and 0 means they did not | 
|Osteoarthritis in prior year | integer | A binary column where 1 means the patient had a record for osteoarthritis in the prior year and 0 means they did not | 
|Aspirin exposures in prior year | integer | A binary column where 1 means the patient had a record for aspirin in the prior year and 0 means they did not | 
|Occurrence of Asthma in prior year | integer | A binary column where 1 means the patient had a record for asthma in the prior year and 0 means they did not | 
|Atrial Fibrillation, incident in prior year | integer | A binary column where 1 means the patient had a record for atrial fibrillation in the prior year and 0 means they did not | 
|HORMONAL CONTRACEPTIVES in prior year | integer | A binary column where 1 means the patient had a record for a drug in the category hormonal contraceptives in the prior year and 0 means they did not | 
|Any cancer (excl. prostate cancer and benign cancer) in prior year | integer | A binary column where 1 means the patient had a record for cancer excluding prostate and benign cancers in the prior year and 0 means they did not | 
|Acute Kidney Injury (AKI) in prior year | integer | A binary column where 1 means the patient had a record for acute kidney injury in the prior year and 0 means they did not | 
|Chronic kidney disease or end stage renal disease in prior year | integer | A binary column where 1 means the patient had a record for chronic kidney disease in the prior year and 0 means they did not | 
|Heart failure in prior year | integer | A binary column where 1 means the patient had a record for heart failure in the prior year and 0 means they did not | 
|Chronic obstructive pulmonary disease (COPD) in prior year | integer | A binary column where 1 means the patient had a record for chronic obstructive pulmonary disease in the prior year and 0 means they did not | 
|Coronary artery disease (CAD) in prior year | integer | A binary column where 1 means the patient had a record for coronary artery disease in the prior year and 0 means they did not | 
|Major depressive disorder, with NO occurrence of certain psychiatric disorder in prior year | integer | A binary column where 1 means the patient had a record for major depressive disorder and no certain psychiatric disorders in the prior year and 0 means they did not | 
|Type 1 diabetes and no prior specific non-T1DM diabetes in prior year | integer | A binary column where 1 means the patient had a record for type 1 diabetes in the prior year and 0 means they did not | 
|Type 2 Diabetes Mellitus (DM), with no type 1 or secondary DM in prior year | integer | A binary column where 1 means the patient had a record for type 2 diabetes in the prior year and 0 means they did not | 
|Deep Vein Thrombosis (DVT) in prior year | integer | A binary column where 1 means the patient had a record for deep vein thrombosis in the prior year and 0 means they did not | 
|Dyspnea in prior year | integer | A binary column where 1 means the patient had a record for dyspnea in the prior year and 0 means they did not | 
|Edema in prior year | integer | A binary column where 1 means the patient had a record for edema in the prior year and 0 means they did not | 
|Gastroesophageal reflux disease in prior year | integer | A binary column where 1 means the patient had a record for gastroesophageal reflux in the prior year and 0 means they did not | 
|Acute gastrointestinal (GI) bleeding in prior year | integer | A binary column where 1 means the patient had a record for acute gastrointestinal bleeding in the prior year and 0 means they did not | 
|Heart valve disorder in prior year | integer | A binary column where 1 means the patient had a record for heart valve disorder in the prior year and 0 means they did not | 
|Chronic hepatitis in prior year | integer | A binary column where 1 means the patient had a record for chronic hepatitis in the prior year and 0 means they did not | 
|Hyperlipidemia in prior year | integer | A binary column where 1 means the patient had a record for hyperlipidemia in the prior year and 0 means they did not | 
|Hypertension in prior year | integer | A binary column where 1 means the patient had a record for hypertension in the prior year and 0 means they did not | 
|Hypothyroidism in prior year | integer | A binary column where 1 means the patient had a record for hypothyroidism in the prior year and 0 means they did not | 
|Inflammatory Bowel Disease in prior year | integer | A binary column where 1 means the patient had a record for inflammatory bowel disease in the prior year and 0 means they did not | 
|Low back pain in prior year | integer | A binary column where 1 means the patient had a record for low back pain in the prior year and 0 means they did not | 
|Occurrence of neuropathy in prior year | integer | A binary column where 1 means the patient had a record for neuropathy in the prior year and 0 means they did not | 
|Obesity in prior year | integer | A binary column where 1 means the patient had a record for obesity in the prior year and 0 means they did not | 
|Opioids in prior year | integer | A binary column where 1 means the patient had a record for an opioid in the prior year and 0 means they did not | 
|Osteoporosis in prior year | integer | A binary column where 1 means the patient had a record for osteoporosis in the prior year and 0 means they did not | 
|Peripheral vascular disease in prior year | integer | A binary column where 1 means the patient had a record for peripheral vascular disease in the prior year and 0 means they did not | 
|Pneumonia in prior year | integer | A binary column where 1 means the patient had a record for pneumonia in the prior year and 0 means they did not |
|Psychotic disorder in prior year | integer | A binary column where 1 means the patient had a record for a psychotic disorder in the prior year and 0 means they did not | 
|Acute Respiratory failure in prior year | integer | A binary column where 1 means the patient had a record for acute respiratory failure in the prior year and 0 means they did not | 
|Rheumatoid Arthritis in prior year | integer | A binary column where 1 means the patient had a record for rheumatoid arthritis in the prior year and 0 means they did not | 
|Seizure in prior year | integer | A binary column where 1 means the patient had a record for a seizure in the prior year and 0 means they did not | 
|Sepsis in prior year | integer | A binary column where 1 means the patient had a record for sepsis in the prior year and 0 means they did not |
|Skin ulcer in prior year | integer | A binary column where 1 means the patient had a record for a skin ulcer in the prior year and 0 means they did not |
|Sleep apnea in prior year | integer | A binary column where 1 means the patient had a record for sleep apnea in the prior year and 0 means they did not |
|Smoking in prior year | integer | A binary column where 1 means the patient had a record for smoking in the prior year and 0 means they did not | 
|STEROIDS in prior year | integer | A binary column where 1 means the patient had a record for any steroid in the prior year and 0 means they did not | 
|Hemorrhagic stroke in an inpatient setting in prior year | integer | A binary column where 1 means the patient had a record for hemorrhagic stroke in the prior year and 0 means they did not | 
|Non-hemorrhagic Stroke in an inpatient setting in prior year | integer | A binary column where 1 means the patient had a record for non-hemorrhagic stroke in the prior year and 0 means they did not | 
|Urinary tract infectious disease in prior year | integer | A binary column where 1 means the patient had a record for urinary tract infection in the prior year and 0 means they did not | 
|Antibiotics Carbapenems in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class carbapenems in the prior year and 0 means they did not | 
|Antibiotics Aminoglycosides in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class aminoglycosides in the prior year and 0 means they did not | 
|Antibiotics Cephalosporins in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class cephalosporins in the prior year and 0 means they did not | 
|Antibiotics Fluoroquinolones in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class Fluoroquinolones in the prior year and 0 means they did not | 
|Antibiotics Glycopeptides and lipoglycopeptides in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class glycopeptides and lipoglycopeptides in the prior year and 0 means they did not | 
|Antibiotics Macrolides in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class macrolides in the prior year and 0 means they did not | 
|Antibiotics Monobactams in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class monobactams in the prior year and 0 means they did not | 
|Antibiotics Oxazolidinones in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class oxazolidinones in the prior year and 0 means they did not | 
|Antibiotics Penicillins in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class penicillins in the prior year and 0 means they did not | 
|Antibiotics Polypeptides in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class polypeptides in the prior year and 0 means they did not | 
|Antibiotics Rifamycins in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class carbapenems in the prior year and 0 means they did not | 
|Antibiotics Sulfonamides in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class sulfonamides in the prior year and 0 means they did not | 
|Antibiotics Streptogramins in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class streptogramins in the prior year and 0 means they did not | 
|Antibiotics Tetracyclines in prior year | integer | A binary column where 1 means the patient had a record for an antibiotic in the class tetracyclines in the prior year and 0 means they did not | 
|predicted risk of Pulmonary Embolism | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having pulmonary embolism given their features (0 = 0% and 1= 100%) | 
|predicted risk of Sudden Hearing Loss, No congenital anomaly or middle or inner ear conditions | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having sudden hearing loss given their features (0 = 0% and 1= 100%) | 
|predicted risk of Restless Leg Syndrome | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having restless leg syndrome given their features (0 = 0% and 1= 100%) | 
|predicted risk of Sudden Vision Loss, with no eye pathology causes | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having sudden vision loss given their features (0 = 0% and 1= 100%) | 
|predicted risk of Muscle weakness or injury | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having muscle weakness or injury given their features (0 = 0% and 1= 100%) | 
|predicted risk of Ankylosing Spondylitis | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having ankylosing spondylitis given their features (0 = 0% and 1= 100%) | 
|predicted risk of Autoimmune hepatitis | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having autoimmune hepatitis given their features (0 = 0% and 1= 100%) | 
|predicted risk of Multiple Sclerosis | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having multiple sclerosis given their features (0 = 0% and 1= 100%) | 
|predicted risk of Acute pancreatitis, with No chronic or hereditary or common causes of pancreatitis | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having acute pancreatitis given their features (0 = 0% and 1= 100%) | 
|predicted risk of Ulcerative colitis | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having ulcerative colitis given their features (0 = 0% and 1= 100%) | 
|predicted risk of Migraine | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having a migraine given their features (0 = 0% and 1= 100%) | 
|predicted risk of Dementia | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having dementia given their features (0 = 0% and 1= 100%) | 
|predicted risk of  Treatment resistant depression (TRD) | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having treatment resistant depression given their features (0 = 0% and 1= 100%) | 
|predicted risk of Parkinson's disease, inpatient or with 2nd diagnosis | numeric | A value between 0 and 1 corresponding to the patient's predicted 1-year risk of having Parkinson's disease given their features (0 = 0% and 1= 100%) | 


### Cleaning Script

Clean data provided by the R/Pharma team!
