|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|language_id  |character |Identifier for the language variety, joining to `grambank_languages`. |
|parameter_id |character |Identifier for the Grambank feature, joining to `grambank_parameters`. |
|value        |integer   |Coded numerical state for the feature (e.g., 0 = absent, 1 = present, 2+ = multi-state). |
|code_id      |character |Specific categorical code identifier linking the value state to CLDF parameter definitions. |
