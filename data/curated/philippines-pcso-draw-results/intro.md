This week we're exploring a fixed snapshot of historical draw results from the Philippine Charity Sweepstakes Office (PCSO). The independently compiled dataset contains 13,457 records across nine digit and jackpot games from January 2, 2022 through July 20, 2026. Each row preserves the source name and URL used during collection.

The normalized compilation and documentation are released under CC BY 4.0. The underlying draw results are public factual records and remain attributable to their original sources. LottoLens PH is an independent information project, not an official PCSO service. The data is intended for verification, education, and reproducible analysis, not for predicting future results or promising a win.

> Each historical record keeps its game, draw date, draw time, number order, publication status, and source URL in a consistent structure.

The five jackpot games usually have one draw per scheduled day, while 2D and 3D Lotto can have multiple draw windows. `jackpot_amount` is therefore populated only for jackpot-bearing games. `winning_numbers` remains a character field so that number order and leading zeroes are preserved.

- How does the number of recorded draw windows vary by game and year?
- Which calendar periods have the most or fewest published records, and do those gaps align with the expected draw schedule?
- How have advertised jackpot amounts changed over time for each jackpot game?
- How has the mix of retained source domains changed across the snapshot?
- Which visual encodings best compare high-frequency digit games with lower-frequency jackpot games without implying that past results predict future draws?

