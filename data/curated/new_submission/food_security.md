|variable   |class     |description                           |
|:----------|:---------|:-------------------------------------|
|Year_Start |integer   |First year of this observation. |
|Year_End   |integer   |Final year of this observation. |
|Area       |character |Country or region in which the observation took place. |
|Item       |character |The specific indicator of food security. |
|Unit       |character |Unit of the measurement. One of "g/cap/d" (Grams per capita per day), "Int$/cap" (International Dollar per capita), "kcal/cap/d" (Kilocalories per capita per day), "km" (Kilometers), "million No" (million Number), "No" (Number), "%" (Percent), "1000 Int$/cap" (thousand International Dollar per capita), or "index". |
|Value      |double    |The numeric value of the measurement. Note: values of "0.09", "0.49", and "2.49" were "<0.1", "<0.5", and "<2.5" (respectively) in the original dataset. |
|CI_Lower   |double    |The lower bound of the confidence interval of the measurement. Note: values of "0.09" and "0.49" were "<0.1" and "<0.5" (respectively) in the original dataset. |
|CI_Upper   |double    |The upper bound of the confidence interval of the measurement. Note: values of "0.09" and "0.49" were "<0.1" and "<0.5" (respectively) in the original dataset. |
|Flag       |character |Additional information about the measurement. One of "Estimated value", "Figure from external organization", "Missing value", "Missing value; suppressed", or "Official figure" |
|Note       |character |Additional details about this measurement (mostly NA). |
