|variable             |class     |description                           |
|:--------------------|:---------|:-------------------------------------|
|cip4                 |character |Four-digit CIP 2020 code for the field of study; joins to `cip4` in the ai_salary_majors table. |
|field_of_study       |character |Name of the college major from the CIP-SOC crosswalk. |
|soc                  |character |Six-digit Standard Occupational Classification (SOC) 2018 code for an occupation this major can lead to. |
|occupation           |character |Human-readable occupation title for the SOC code. |
|ai_exposure          |double    |Overall AI Occupational Exposure (AIOE) score for this occupation. Standardized (mean 0, SD 1); higher means more exposed to AI. |
|ai_exposure_language |double    |AIOE score for the language-modeling application of generative AI for this occupation. |
|ai_exposure_image    |double    |AIOE score for the image-generation application of generative AI for this occupation. |
