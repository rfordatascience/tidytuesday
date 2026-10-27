|variable        |class         |description                           |
|:---------------|:-------------|:-------------------------------------|
|seqn            |integer       |NHANES respondent sequence number, the unique participant ID that links the survey and mortality records. |
|cycle           |character     |The two-year NHANES survey cycle the participant was enrolled in, from 1999-2000 through 2017-2018. |
|age             |double        |Age in years at the time of the exam. Ages 80 and older are top-coded at 80 in 1999-2006 and at 85 from 2007 on, per NHANES disclosure rules. |
|sex             |factor        |Sex recorded at the exam: Male or Female. |
|race            |factor        |Race and Hispanic origin: Mexican American, Other Hispanic, Non-Hispanic White, Non-Hispanic Black, or Other/Multi. |
|total_chol      |double        |Total cholesterol in mg/dL. Measured for all participants who gave a blood sample. |
|hdl             |double        |HDL (high-density lipoprotein, the "good" cholesterol) in mg/dL. |
|ldl             |double        |LDL (low-density lipoprotein, the "bad" cholesterol) in mg/dL, calculated by the Friedewald equation. Only measured on the fasting morning subsample, so it is missing for about half of participants. |
|triglycerides   |double        |Triglycerides in mg/dL. Like LDL, only measured on the fasting morning subsample. |
|non_hdl         |double        |Non-HDL cholesterol in mg/dL, total cholesterol minus HDL. |
|tc_hdl_ratio    |double        |Ratio of total cholesterol to HDL. A common clinical risk measure where lower is generally considered better. |
|ldl_hdl_ratio   |double        |Ratio of LDL to HDL. Available only when LDL is present (the fasting subsample). |
|died            |integer       |All-cause mortality status at the end of follow-up: 1 if the participant had died, 0 if assumed alive. |
|followup_months |integer       |Months from the exam date to death or to the censoring date of December 31, 2019, whichever came first. |
|cause_of_death  |factor        |Underlying cause of death for those who died, using the ten NCHS leading-cause categories: Heart disease, Cancer, Chronic respiratory disease, Accidents, Cerebrovascular (stroke), Alzheimer's disease, Diabetes, Influenza and pneumonia, Kidney disease, and All other causes. Missing for participants who were still alive. |
|survey_weight   |double        |NHANES two-year MEC exam sampling weight. Divide by the number of pooled cycles when combining cycles. Use with psu and strata for survey-weighted estimates. |
|psu             |double        |Masked variance pseudo-PSU (primary sampling unit) for the complex survey design. |
|strata          |double        |Masked variance pseudo-stratum for the complex survey design. |
