This week we're looking at cholesterol and death in US adults, built from the National Health and Nutrition Examination Survey (NHANES) linked to the NCHS public-use mortality records.

A 2019 study of 12.8 million Korean adults found a U-shaped link between total cholesterol and death: people at the low and high ends died at higher rates than people in the middle. It's a striking result, but the authors said plainly that they only had total cholesterol. They could not see LDL, HDL, or triglycerides, so they could not say which part of the cholesterol picture was doing the work.

That gap is the reason for this dataset. NHANES measures the full lipid panel and the US government links those participants to the National Death Index, so we can ask the question the Korean study could not. I pooled ten NHANES cycles from 1999 to 2018, kept the adults who gave a blood sample and were eligible for mortality follow-up, and joined each person to their mortality outcome. The result is 52,678 adults, 7,643 of whom had died by the end of 2019.

Researchers have already used this same NHANES data to dig into the fractions. A 2025 study of the 1999 to 2018 cycles found a U-shaped link between HDL and death, where both low and high HDL carried higher risk. That is the kind of question you can ask here that the total-cholesterol-only studies could not.

Each row is one person. You get total cholesterol, HDL, LDL, and triglycerides, plus the two ratios doctors actually read off a lab report (total-to-HDL and LDL-to-HDL). You also get age, sex, race, the survey design columns, and the mortality outcome: whether the person died, how many months of follow-up they had, and the cause of death.

Two things to keep in mind. LDL and triglycerides come from the fasting morning exam, so they are missing for about half the sample. And NHANES is a complex survey with weights, so population estimates need the `survey_weight`, `psu`, and `strata` columns fed into a package like `survey` or `srvyr`.

> The NHANES combines interviews and physical examinations to assess the health and nutritional status of adults and children in the United States. The survey is unique in that it combines interviews and physical examinations, and it has been a major program of the National Center for Health Statistics since the early 1960s.

- Does the total-cholesterol U-curve from the Korean study show up in US adults, and does it survive adjusting for age?
- Which single lipid measure best separates who dies from who survives: total cholesterol, LDL, HDL, or one of the ratios?
- Is low LDL linked to higher death because of reverse causality, where sick people already have low cholesterol?
- Does the cause of death differ along the cholesterol range? For example, is low cholesterol tied more to cancer deaths and high cholesterol tied more to heart disease?
- How much do the answers change once you apply the NHANES survey weights?
