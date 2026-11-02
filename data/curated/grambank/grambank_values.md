|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|language_id  |character |Identifier for the language variety, joining to `grambank_languages`. |
|parameter_id |character |Identifier for the Grambank feature, joining to `grambank_parameters`. |
|value        |integer   |Coded state for the feature. For binary features, 0 = absent and 1 = present. For multi-state features (e.g., GB024), the integer codes are feature-specific categories (e.g., 1 = numeral before noun, 2 = numeral after noun, 3 = both orders), so 1 does not mean "present"; see `feature_description` in `grambank_parameters` for each feature's definitions. |
|code_id      |character |Specific categorical code identifier (`parameter_id` and `value` joined by a hyphen, e.g., GB024-2) linking the value state to CLDF parameter definitions. |
