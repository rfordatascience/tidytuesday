|variable |class |description |
|:----------------------------|:---------|:-------------------------------------|
|r_fighter |character |The name of the fighter in the Red corner. |
|b_fighter |character |The name of the fighter in the Blue corner. |
|r_odds |double |Moneyline betting odds (American format) for the Red fighter. |
|b_odds |double |Moneyline betting odds (American format) for the Blue fighter. |
|r_ev |double |Expected value for a $100 wager on the Red fighter. |
|b_ev |double |Expected value for a $100 wager on the Blue fighter. |
|date |character |The date the bout took place (YYYY-MM-DD). |
|location |character |The city, state/province, and country where the event was held. |
|country |character |The country where the event was held. |
|winner |character |The corner that won the bout ("Red" or "Blue"). |
|title_bout |logical |Logical indicator if the bout was for a championship title. |
|weight_class |character |The weight division the bout was contested in. |
|gender |character |The gender category of the bout (MALE or FEMALE). |
|no_of_rounds |double |The scheduled number of rounds for the bout (typically 3 or 5). |
|b_current_lose_streak |double |Current consecutive losing streak prior to the bout for the Blue fighter. |
|b_current_win_streak |double |Current consecutive winning streak prior to the bout for the Blue fighter. |
|b_draw |double |Total historical UFC draws strictly prior to the current bout for the Blue fighter. |
|b_avg_sig_str_landed |double |Average significant strikes landed per minute by the Blue fighter. |
|b_avg_sig_str_pct |double |Historical significant strike accuracy percentage for the Blue fighter. |
|b_avg_sub_att |double |Average submission attempts per 15 minutes by the Blue fighter. |
|b_avg_td_landed |double |Average takedowns landed per 15 minutes by the Blue fighter. |
|b_avg_td_pct |double |Historical takedown accuracy percentage for the Blue fighter. |
|b_longest_win_streak |double |Longest winning streak in the Blue fighter's UFC career. |
|b_losses |double |Total historical UFC losses strictly prior to the current bout for the Blue fighter. |
|b_total_rounds_fought |double |Total number of rounds fought in the UFC prior to the bout by the Blue fighter. |
|b_total_title_bouts |double |Total number of title bouts the Blue fighter has competed in. |
|b_win_by_decision_majority |double |Career wins by majority decision for the Blue fighter. |
|b_win_by_decision_split |double |Career wins by split decision for the Blue fighter. |
|b_win_by_decision_unanimous |double |Career wins by unanimous decision for the Blue fighter. |
|b_win_by_ko_tko |double |Career wins by knockout or technical knockout for the Blue fighter. |
|b_win_by_submission |double |Career wins by submission for the Blue fighter. |
|b_win_by_tko_doctor_stoppage |double |Career wins by doctor stoppage for the Blue fighter. |
|b_wins |double |Total historical UFC wins strictly prior to the current bout for the Blue fighter. |
|b_stance |character |The fighting stance of the Blue fighter (e.g., Orthodox, Southpaw, Switch). |
|b_height_cms |double |Blue fighter height in centimeters. |
|b_reach_cms |double |Blue fighter reach in centimeters. |
|b_weight_lbs |double |Blue fighter weigh-in weight in pounds. |
|r_current_lose_streak |double |Current consecutive losing streak prior to the bout for the Red fighter. |
|r_current_win_streak |double |Current consecutive winning streak prior to the bout for the Red fighter. |
|r_draw |double |Total historical UFC draws strictly prior to the current bout for the Red fighter. |
|r_avg_sig_str_landed |double |Average significant strikes landed per minute by the Red fighter. |
|r_avg_sig_str_pct |double |Historical significant strike accuracy percentage for the Red fighter. |
|r_avg_sub_att |double |Average submission attempts per 15 minutes by the Red fighter. |
|r_avg_td_landed |double |Average takedowns landed per 15 minutes by the Red fighter. |
|r_avg_td_pct |double |Historical takedown accuracy percentage for the Red fighter. |
|r_longest_win_streak |double |Longest winning streak in the Red fighter's UFC career. |
|r_losses |double |Total historical UFC losses strictly prior to the current bout for the Red fighter. |
|r_total_rounds_fought |double |Total number of rounds fought in the UFC prior to the bout by the Red fighter. |
|r_total_title_bouts |double |Total number of title bouts the Red fighter has competed in. |
|r_win_by_decision_majority |double |Career wins by majority decision for the Red fighter. |
|r_win_by_decision_split |double |Career wins by split decision for the Red fighter. |
|r_win_by_decision_unanimous |double |Career wins by unanimous decision for the Red fighter. |
|r_win_by_ko_tko |double |Career wins by knockout or technical knockout for the Red fighter. |
|r_win_by_submission |double |Career wins by submission for the Red fighter. |
|r_win_by_tko_doctor_stoppage |double |Career wins by doctor stoppage for the Red fighter. |
|r_wins |double |Total historical UFC wins strictly prior to the current bout for the Red fighter. |
|r_stance |character |The fighting stance of the Red fighter (e.g., Orthodox, Southpaw, Switch). |
|r_height_cms |double |Red fighter height in centimeters. |
|r_reach_cms |double |Red fighter reach in centimeters. |
|r_weight_lbs |double |Red fighter weigh-in weight in pounds. |
|r_age |double |The age of the Red fighter at the time of the bout. |
|b_age |double |The age of the Blue fighter at the time of the bout. |
|lose_streak_dif |double |Difference in losing streaks (Red minus Blue). |
|win_streak_dif |double |Difference in winning streaks (Red minus Blue). |
|longest_win_streak_dif |double |Difference in longest winning streaks (Red minus Blue). |
|win_dif |double |Difference in total wins (Red minus Blue). |
|loss_dif |double |Difference in total losses (Red minus Blue). |
|total_round_dif |double |Difference in total rounds fought (Red minus Blue). |
|total_title_bout_dif |double |Difference in total title bouts fought (Red minus Blue). |
|ko_dif |double |Difference in career KO/TKO wins (Red minus Blue). |
|sub_dif |double |Difference in career submission wins (Red minus Blue). |
|height_dif |double |Difference in height in centimeters (Red minus Blue). |
|reach_dif |double |Difference in reach in centimeters (Red minus Blue). |
|age_dif |double |Difference in age (Red minus Blue). |
|sig_str_dif |double |Difference in average significant strikes landed (Red minus Blue). |
|avg_sub_att_dif |double |Difference in average submission attempts (Red minus Blue). |
|avg_td_dif |double |Difference in average takedowns landed (Red minus Blue). |
|empty_arena |double |Numeric or logical indicator for fights that took place without an audience. |
|b_match_weightclass_rank |double |Blue fighter's rank in the division of the current bout. |
|r_match_weightclass_rank |double |Red fighter's rank in the division of the current bout. |
|r_womens_flyweight_rank |double |Red fighter's rank in the Women's Flyweight division. |
|r_womens_featherweight_rank |double |Red fighter's rank in the Women's Featherweight division. |
|r_womens_strawweight_rank |double |Red fighter's rank in the Women's Strawweight division. |
|r_womens_bantamweight_rank |double |Red fighter's rank in the Women's Bantamweight division. |
|r_heavyweight_rank |double |Red fighter's rank in the Heavyweight division. |
|r_light_heavyweight_rank |double |Red fighter's rank in the Light Heavyweight division. |
|r_middleweight_rank |double |Red fighter's rank in the Middleweight division. |
|r_welterweight_rank |double |Red fighter's rank in the Welterweight division. |
|r_lightweight_rank |double |Red fighter's rank in the Lightweight division. |
|r_featherweight_rank |double |Red fighter's rank in the Featherweight division. |
|r_bantamweight_rank |double |Red fighter's rank in the Bantamweight division. |
|r_flyweight_rank |double |Red fighter's rank in the Flyweight division. |
|r_pound_for_pound_rank |double |Red fighter's rank in the Pound-for-Pound rankings. |
|b_womens_flyweight_rank |double |Blue fighter's rank in the Women's Flyweight division. |
|b_womens_featherweight_rank |double |Blue fighter's rank in the Women's Featherweight division. |
|b_womens_strawweight_rank |double |Blue fighter's rank in the Women's Strawweight division. |
|b_womens_bantamweight_rank |double |Blue fighter's rank in the Women's Bantamweight division. |
|b_heavyweight_rank |double |Blue fighter's rank in the Heavyweight division. |
|b_light_heavyweight_rank |double |Blue fighter's rank in the Light Heavyweight division. |
|b_middleweight_rank |double |Blue fighter's rank in the Middleweight division. |
|b_welterweight_rank |double |Blue fighter's rank in the Welterweight division. |
|b_lightweight_rank |double |Blue fighter's rank in the Lightweight division. |
|b_featherweight_rank |double |Blue fighter's rank in the Featherweight division. |
|b_bantamweight_rank |double |Blue fighter's rank in the Bantamweight division. |
|b_flyweight_rank |double |Blue fighter's rank in the Flyweight division. |
|b_pound_for_pound_rank |double |Blue fighter's rank in the Pound-for-Pound rankings. |
|better_rank |character |Indicates which corner held the superior ranking ("Red", "Blue", or "neither"). |
|finish |character |The method of the bout's conclusion (e.g., KO/TKO, SUB, U-DEC). |
|finish_details |character |Specifics on the finishing sequence (e.g., "Punches", "Rear Naked Choke"). |
|finish_round |double |The round in which the bout ended. |
|finish_round_time |character |The exact time on the clock when the fight was stopped (MM:SS). |
|total_fight_time_secs |double |The cumulative duration of the bout in seconds. |
|r_dec_odds |double |Prop bet odds for the Red fighter to win by decision. |
|b_dec_odds |double |Prop bet odds for the Blue fighter to win by decision. |
|r_sub_odds |double |Prop bet odds for the Red fighter to win by submission. |
|b_sub_odds |double |Prop bet odds for the Blue fighter to win by submission. |
|r_ko_odds |double |Prop bet odds for the Red fighter to win by KO/TKO. |
|b_ko_odds |double |Prop bet odds for the Blue fighter to win by KO/TKO. |

