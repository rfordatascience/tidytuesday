|variable        |class     |description |
|:---------------|:---------|:-----------|
|lottery_slug    |character |Normalized identifier for one of nine Philippine digit or jackpot games. |
|draw_date       |date      |Calendar date of the draw in Philippine time. |
|draw_time       |character |Published draw window: 2PM, 5PM, or 9PM. |
|winning_numbers |character |Winning numbers in published order, retained as text to preserve leading zeroes. |
|jackpot_amount  |double    |Advertised jackpot amount in Philippine pesos for jackpot-bearing games; NA for digit games or unavailable values. |
|status          |character |Publication status in the fixed snapshot; all included rows are published records. |
|published_at    |character |RFC 3339 timestamp recording when the result was published in the source archive. |
|source_name     |character |Human-readable name of the source retained for the row. |
|source_url      |character |URL retained for record-level provenance and later verification. |

