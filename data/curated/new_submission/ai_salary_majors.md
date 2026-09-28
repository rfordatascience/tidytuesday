|variable               |class     |description                           |
|:----------------------|:---------|:-------------------------------------|
|cip4                   |character |Four-digit Classification of Instructional Programs (CIP) 2020 code identifying the field of study. |
|field_of_study         |character |Human-readable name of the college major (from the College Scorecard CIP description). |
|broad_field            |character |Broad academic area the major belongs to, derived from the two-digit CIP family (e.g. Engineering, Health Professions, Business). |
|median_starting_salary |double    |Median earnings in US dollars one year after graduation, pooled across institutions offering the major (bachelor's degree graduates). This is the starting-salary measure. |
|median_salary_4yr      |double    |Median earnings in US dollars four years after graduation, pooled across institutions. Missing for a few majors without four-year follow-up data. |
|ai_exposure            |double    |Average AI Occupational Exposure (AIOE) score across the occupations this major feeds into. The AIOE is standardized (mean 0, standard deviation 1); higher values mean more of the occupation's abilities overlap with what AI can do. |
|ai_exposure_percentile |double    |Rank of this major's AI exposure on a 0 to 100 scale relative to all 285 majors in the dataset. 0 is the least AI-exposed major, 100 the most. |
|ai_exposure_language   |double    |Average AIOE score for the language-modeling application of generative AI (text-based tasks) across the major's occupations. Standardized like ai_exposure. |
|ai_exposure_image      |double    |Average AIOE score for the image-generation application of generative AI (visual tasks) across the major's occupations. Standardized like ai_exposure. |
|n_occupations          |integer   |Number of distinct occupations (SOC codes) the major maps to in the CIP-SOC crosswalk; the exposure scores are averaged over these occupations. |
|n_institutions         |integer   |Number of institutions whose graduates contributed to the pooled starting-salary figure for this major. |
|n_graduates            |double    |Total count of graduates with measured earnings one year out, summed across institutions offering the major. |
