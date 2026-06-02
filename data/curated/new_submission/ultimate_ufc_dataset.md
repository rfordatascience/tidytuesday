| variable | class | description |
| :--- | :--- | :--- |
| R_fighter | character | The name of the fighter in the Red corner. |
| B_fighter | character | The name of the fighter in the Blue corner. |
| R_odds | double | Moneyline betting odds (American format) for the Red fighter. |
| B_odds | double | Moneyline betting odds (American format) for the Blue fighter. |
| R_ev | double | Expected value for a $100 wager on the Red fighter. |
| B_ev | double | Expected value for a $100 wager on the Blue fighter. |
| date | character | The date the bout took place (YYYY-MM-DD). |
| location | character | The city, state/province, and country where the event was held. |
| country | character | The country where the event was held. |
| Winner | character | The corner that won the bout ("Red" or "Blue"). |
| title_bout | logical | Logical indicator if the bout was for a championship title. |
| weight_class | character | The weight division the bout was contested in. |
| gender | character | The gender category of the bout (MALE or FEMALE). |
| no_of_rounds | double | The scheduled number of rounds for the bout (typically 3 or 5). |
| B_current_lose_streak | double | Current consecutive losing streak prior to the bout for the Blue fighter. |
| B_current_win_streak | double | Current consecutive winning streak prior to the bout for the Blue fighter. |
| B_draw | double | Total historical UFC draws strictly prior to the current bout for the Blue fighter. |
| B_avg_SIG_STR_landed | double | Average significant strikes landed per minute by the Blue fighter. |
| B_avg_SIG_STR_pct | double | Historical significant strike accuracy percentage for the Blue fighter. |
| B_avg_SUB_ATT | double | Average submission attempts per 15 minutes by the Blue fighter. |
| B_avg_TD_landed | double | Average takedowns landed per 15 minutes by the Blue fighter. |
| B_avg_TD_pct | double | Historical takedown accuracy percentage for the Blue fighter. |
| B_longest_win_streak | double | Longest winning streak in the Blue fighter's UFC career. |
| B_losses | double | Total historical UFC losses strictly prior to the current bout for the Blue fighter. |
| B_total_rounds_fought | double | Total number of rounds fought in the UFC prior to the bout by the Blue fighter. |
| B_total_title_bouts | double | Total number of title bouts the Blue fighter has competed in. |
| B_win_by_Decision_Majority | double | Career wins by majority decision for the Blue fighter. |
| B_win_by_Decision_Split | double | Career wins by split decision for the Blue fighter. |
| B_win_by_Decision_Unanimous | double | Career wins by unanimous decision for the Blue fighter. |
| B_win_by_KO/TKO | double | Career wins by knockout or technical knockout for the Blue fighter. |
| B_win_by_Submission | double | Career wins by submission for the Blue fighter. |
| B_win_by_TKO_Doctor_Stoppage | double | Career wins by doctor stoppage for the Blue fighter. |
| B_wins | double | Total historical UFC wins strictly prior to the current bout for the Blue fighter. |
| B_Stance | character | The fighting stance of the Blue fighter (e.g., Orthodox, Southpaw, Switch). |
| B_Height_cms | double | Blue fighter height in centimeters. |
| B_Reach_cms | double | Blue fighter reach in centimeters. |
| B_Weight_lbs | double | Blue fighter weigh-in weight in pounds. |
| R_current_lose_streak | double | Current consecutive losing streak prior to the bout for the Red fighter. |
| R_current_win_streak | double | Current consecutive winning streak prior to the bout for the Red fighter. |
| R_draw | double | Total historical UFC draws strictly prior to the current bout for the Red fighter. |
| R_avg_SIG_STR_landed | double | Average significant strikes landed per minute by the Red fighter. |
| R_avg_SIG_STR_pct | double | Historical significant strike accuracy percentage for the Red fighter. |
| R_avg_SUB_ATT | double | Average submission attempts per 15 minutes by the Red fighter. |
| R_avg_TD_landed | double | Average takedowns landed per 15 minutes by the Red fighter. |
| R_avg_TD_pct | double | Historical takedown accuracy percentage for the Red fighter. |
| R_longest_win_streak | double | Longest winning streak in the Red fighter's UFC career. |
| R_losses | double | Total historical UFC losses strictly prior to the current bout for the Red fighter. |
| R_total_rounds_fought | double | Total number of rounds fought in the UFC prior to the bout by the Red fighter. |
| R_total_title_bouts | double | Total number of title bouts the Red fighter has competed in. |
| R_win_by_Decision_Majority | double | Career wins by majority decision for the Red fighter. |
| R_win_by_Decision_Split | double | Career wins by split decision for the Red fighter. |
| R_win_by_Decision_Unanimous | double | Career wins by unanimous decision for the Red fighter. |
| R_win_by_KO/TKO | double | Career wins by knockout or technical knockout for the Red fighter. |
| R_win_by_Submission | double | Career wins by submission for the Red fighter. |
| R_win_by_TKO_Doctor_Stoppage | double | Career wins by doctor stoppage for the Red fighter. |
| R_wins | double | Total historical UFC wins strictly prior to the current bout for the Red fighter. |
| R_Stance | character | The fighting stance of the Red fighter (e.g., Orthodox, Southpaw, Switch). |
| R_Height_cms | double | Red fighter height in centimeters. |
| R_Reach_cms | double | Red fighter reach in centimeters. |
| R_Weight_lbs | double | Red fighter weigh-in weight in pounds. |
| R_age | double | The age of the Red fighter at the time of the bout. |
| B_age | double | The age of the Blue fighter at the time of the bout. |
| lose_streak_dif | double | Difference in losing streaks (Red minus Blue). |
| win_streak_dif | double | Difference in winning streaks (Red minus Blue). |
| longest_win_streak_dif | double | Difference in longest winning streaks (Red minus Blue). |
| win_dif | double | Difference in total wins (Red minus Blue). |
| loss_dif | double | Difference in total losses (Red minus Blue). |
| total_round_dif | double | Difference in total rounds fought (Red minus Blue). |
| total_title_bout_dif | double | Difference in total title bouts fought (Red minus Blue). |
| ko_dif | double | Difference in career KO/TKO wins (Red minus Blue). |
| sub_dif | double | Difference in career submission wins (Red minus Blue). |
| height_dif | double | Difference in height in centimeters (Red minus Blue). |
| reach_dif | double | Difference in reach in centimeters (Red minus Blue). |
| age_dif | double | Difference in age (Red minus Blue). |
| sig_str_dif | double | Difference in average significant strikes landed (Red minus Blue). |
| avg_sub_att_dif | double | Difference in average submission attempts (Red minus Blue). |
| avg_td_dif | double | Difference in average takedowns landed (Red minus Blue). |
| empty_arena | double | Numeric or logical indicator for fights that took place without an audience. |
| B_match_weightclass_rank | double | Blue fighter's rank in the division of the current bout. |
| R_match_weightclass_rank | double | Red fighter's rank in the division of the current bout. |
| R_Women's Flyweight_rank | double | Red fighter's rank in the Women's Flyweight division. |
| R_Women's Featherweight_rank | double | Red fighter's rank in the Women's Featherweight division. |
| R_Women's Strawweight_rank | double | Red fighter's rank in the Women's Strawweight division. |
| R_Women's Bantamweight_rank | double | Red fighter's rank in the Women's Bantamweight division. |
| R_Heavyweight_rank | double | Red fighter's rank in the Heavyweight division. |
| R_Light Heavyweight_rank | double | Red fighter's rank in the Light Heavyweight division. |
| R_Middleweight_rank | double | Red fighter's rank in the Middleweight division. |
| R_Welterweight_rank | double | Red fighter's rank in the Welterweight division. |
| R_Lightweight_rank | double | Red fighter's rank in the Lightweight division. |
| R_Featherweight_rank | double | Red fighter's rank in the Featherweight division. |
| R_Bantamweight_rank | double | Red fighter's rank in the Bantamweight division. |
| R_Flyweight_rank | double | Red fighter's rank in the Flyweight division. |
| R_Pound-for-Pound_rank | double | Red fighter's rank in the Pound-for-Pound rankings. |
| B_Women's Flyweight_rank | double | Blue fighter's rank in the Women's Flyweight division. |
| B_Women's Featherweight_rank | double | Blue fighter's rank in the Women's Featherweight division. |
| B_Women's Strawweight_rank | double | Blue fighter's rank in the Women's Strawweight division. |
| B_Women's Bantamweight_rank | double | Blue fighter's rank in the Women's Bantamweight division. |
| B_Heavyweight_rank | double | Blue fighter's rank in the Heavyweight division. |
| B_Light Heavyweight_rank | double | Blue fighter's rank in the Light Heavyweight division. |
| B_Middleweight_rank | double | Blue fighter's rank in the Middleweight division. |
| B_Welterweight_rank | double | Blue fighter's rank in the Welterweight division. |
| B_Lightweight_rank | double | Blue fighter's rank in the Lightweight division. |
| B_Featherweight_rank | double | Blue fighter's rank in the Featherweight division. |
| B_Bantamweight_rank | double | Blue fighter's rank in the Bantamweight division. |
| B_Flyweight_rank | double | Blue fighter's rank in the Flyweight division. |
| B_Pound-for-Pound_rank | double | Blue fighter's rank in the Pound-for-Pound rankings. |
| better_rank | character | Indicates which corner held the superior ranking ("Red", "Blue", or "neither"). |
| finish | character | The method of the bout's conclusion (e.g., KO/TKO, SUB, U-DEC). |
| finish_details | character | Specifics on the finishing sequence (e.g., "Punches", "Rear Naked Choke"). |
| finish_round | double | The round in which the bout ended. |
| finish_round_time | character | The exact time on the clock when the fight was stopped (MM:SS). |
| total_fight_time_secs | double | The cumulative duration of the bout in seconds. |
| r_dec_odds | double | Prop bet odds for the Red fighter to win by decision. |
| b_dec_odds | double | Prop bet odds for the Blue fighter to win by decision. |
| r_sub_odds | double | Prop bet odds for the Red fighter to win by submission. |
| b_sub_odds | double | Prop bet odds for the Blue fighter to win by submission. |
| r_ko_odds | double | Prop bet odds for the Red fighter to win by KO/TKO. |
| b_ko_odds | double | Prop bet odds for the Blue fighter to win by KO/TKO. |
