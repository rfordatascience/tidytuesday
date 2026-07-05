This week we're stepping into the Octagon to explore Ultimate Fighting Championship (UFC) data! 

The data this week comes from the [`{fightr}` R package](https://github.com/benyamindsmith/fightr), which compiles a collection of datasets from UFC athlete profiles, [UFCStats](http://ufcstats.com/), [Kaggle](https://www.kaggle.com/datasets/mdabbert/ultimate-ufc-dataset), and the [Octagon API](https://www.octagon-api.com/). 

> The `fightr` package provides a comprehensive, historical dataset of Ultimate Fighting Championship (UFC) bouts and athlete-level profile information. It tracks divisional and pound-for-pound rankings over time, career records, physical attributes, fighting styles, gym affiliations, and summarized performance statistics, offering a longitudinal view of a fighter's status and performance within the promotion.

Here are a few questions you might want to try and answer with this week's data:

- How do physical attribute advantages such as height, reach, or age differences (`reach_dif`, `age_dif`) correlate with the likelihood of winning a bout?
- How has the distribution of fight finishes (KO/TKO vs. Submission vs. Decision) evolved over the history of the UFC?
- Is there a discernible relationship between a fighter's historical striking/takedown accuracy and their peak divisional ranking?
- How accurate are the betting odds (`r_ev`, `b_ev`) at predicting the actual winner of a title bout?

