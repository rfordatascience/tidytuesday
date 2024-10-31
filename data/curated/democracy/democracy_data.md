|variable                    |class     |description                           |
|:---------------------------|:---------|:-------------------------------------|
|country_name                |character |Country name in the original PACL dataset. |
|country_code                |character |Three letter ISO country code. |
|year                        |integer   |Year. |
|regime_category_index       |integer   |Numeric regime category, following Cheibub, Ghandi and Vreeland (2010). |
|regime_category             |character |Regime category label, following Cheibub, Ghandi and Vreeland (2010). |
|is_monarchy                 |logical   |Is the country a hereditary monarchy? |
|is_commonwealth             |logical   |Is the country a member of the British Commonwealth? |
|monarch_name                |character |Name of the monarch. |
|monarch_accession_year      |integer   |Year of accession of the monarch. |
|monarch_birthyear           |integer   |Year of birth of the monarch. |
|is_female_monarch           |logical   |Is the monarch female. |
|is_democracy                |logical   |Is the country democratic or not? Following Cheibub, Ghandi and Vreeland (2010) Dichotomous indicator of democracy based on a minimalist definition. A country is defined as democratic, if elections were conducted, these were free and fair, and if there was a peaceful turnover of legislative and executive offices following those elections. |
|is_presidential             |logical   |Is the political system presidential? |
|president_name              |character |Name of the president. |
|president_accesion_year     |integer   |Accession year of the president. |
|president_birthyear         |integer   |Year of birth of the president. |
|is_interim_phase            |logical   |Is the president interim / preliminary? (more than 2 Presidents/year) |
|is_female_president         |logical   |Is the president female? |
|is_colony                   |logical   |Is the country a colony? |
|colony_of                   |character |If colony, which country is the colonial power? Country name of the colonial power. |
|colony_administrated_by     |character |If colony, which country is the colonial administrator? |
|is_communist                |logical   |Is the country's regime communist / socialist? |
|has_regime_change_lag       |logical   |Regime Change lag. If a coded event, such as a change in the Presidency, took place after 01.07 it is assigned to the following calendar year in the data. In this case, the lag variable will be TRUE. For all change events before that date, the lag variable is FALSE. |
|spatial_democracy           |double    |Average of geographical neighbors' Democracy score. |
|parliament_chambers         |integer   |Total number of chambers in parliament. |
|has_proportional_voting     |logical   |Is the electoral system characterized by including proportional representation? |
|election_system             |character |Electoral system. See [the package website](https://xmarquez.github.io/democracyData/reference/pacl_update.html) for a full list of options. |
|lower_house_members         |integer   |If bicameral parliament, total number of members in lower house. |
|upper_house_members         |integer   |If bicameral parliament, total number of members in upper house. |
|third_house_members         |integer   |If tricameral parliament, total number of members in third house. |
|has_new_constitution        |logical   |Whether a new constitution was implemented. |
|has_full_suffrage           |logical   |Whether electoral system attributes full suffrage. |
|suffrage_restriction        |character |If no full suffrage, kind of suffrage restriction. |
|electoral_category_index    |integer   |Alternative democracy indicator capturing degree of multi-party competition (index from 0 to 3). |
|electoral_category          |character |Alternative democracy indicator capturing degree of multi-party competition. |
|spatial_electoral           |double    |Average of geographical neighbors' electoral_category_index. |
|has_alternation             |logical   |Whether there's an alternation in power after election. Undocumented in original codebook. |
|is_multiparty               |logical   |Whether the elections are multiparty. Undocumented in original codebook. |
|has_free_and_fair_election  |logical   |Whether the elections are free and fair. Undocumented in original codebook. |
|parliamentary_election_year |integer   |Year of parliamentary election. Undocumented in original codebook. |
|election_month              |character |Month of parliamentary election. Undocumented in original codebook. |
|election_year               |integer   |Year of parliamentary election. Undocumented in original codebook. |
|has_postponed_election      |logical   |Whether the election was postponed. Undocumented in original codebook. |
