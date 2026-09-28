This week we're asking a question every anxious student and career-changer is Googling: **which college majors are safest from AI, and do the safe ones actually pay?**

The dataset joins three public sources at the level of the college major. Starting salaries come from the U.S. Department of Education's [College Scorecard](https://collegescorecard.ed.gov/data/) field-of-study files (median earnings one year after graduation for bachelor's degrees). AI disruption risk comes from the [AI Occupational Exposure (AIOE) index](https://github.com/AIOE-Data/AIOE) of Felten, Raj & Seamans (2021), which scores how much each occupation's required abilities overlap with what AI can do — including generative-AI variants for language and image tasks. The two are bridged with the [NCES/BLS CIP-to-SOC crosswalk](https://nces.ed.gov/ipeds/cipcode/resources.aspx), which maps fields of study to the occupations their graduates enter.

The result is 285 majors, each with a starting salary and an AI-exposure score. The twist: across those majors, AI exposure and starting salary are essentially **uncorrelated** (r ≈ 0.01). Hands-on technical fields like nuclear, marine, and aerospace engineering technology sit in the low-exposure, high-pay "dream quadrant," and registered nursing lands near the 20th percentile of AI exposure while paying about $75,000 out of the gate. Meanwhile several humanities majors are both highly exposed and among the lowest paid.

A note on the exposure score: the AIOE is *standardized* (mean 0, standard deviation 1), so a value of 0 is an average-exposure occupation and negative values are below average. High exposure does not necessarily mean a job will be automated away — it can also mean AI augments the work. To make the score readable without a stats background, the main table also includes `ai_exposure_percentile`, a simple 0–100 rank across all majors.

> The AIOE links ten common AI applications with fifty-two distinct occupational abilities used by O*NET and uses the relative prevalence of these abilities within an occupation to generate an occupational measure of AI exposure. (Felten, Raj & Seamans 2021; description rephrased for compliance with licensing restrictions.)

Some questions to explore:

- Which majors land in the "safe from AI *and* well paid" quadrant, and which sit in the "exposed *and* low paid" corner?
- Does the picture change when you look at language-modeling exposure versus image-generation exposure?
- Do broad fields (Engineering, Health Professions, Business, Humanities) cluster in exposure–salary space?
- The AIOE measures *exposure*, not *automation*. How would the story differ if high exposure meant augmentation rather than replacement?
