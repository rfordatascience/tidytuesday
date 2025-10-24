This week we are exploring data about cars in Qatar!

One of the most common example datasets in R is `mtcars`, which contains data on a bunch of cars from 1974 (!). Some of the car companies in there don't even exist anymore, like Datsun. The `mpg` dataset that comes with {ggplot2} was designed to be an improvement on `mtcars` and includes vehicles from 1999 and 2008. However, both `mpg` and `mtcars` are highly US-centric---most people in the world don't think in gallons and miles and feet and inches---and neither datasets include details about electic cars, which are increasingly common today.

Qatar Cars (also available as [the {qatarcars} R package](https://profmusgrave.github.io/qatarcars/)) provides a more internationally-focused, modern cars-based demonstration dataset. It mirrors many of the columns in `mtcars`, but uses (1) non-US-centric makes and models, (2) 2025 prices, and (3) metric measurements, making it more appropriate for use as an example dataset outside the United States.

Paul Musgrave and students in his international politics course at Georgetown University in Qatar [collected this data in early 2025](https://musgrave.substack.com/p/introducing-the-qatar-cars-dataset) with the goal of creating a new toy dataset that does not suffer from ["U.S. defaultism"](https://doi.org/10.1080/15512169.2025.2572320):

> “U.S. defaultism”—the assumption that American contexts, units, and perspectives are universal—manifests in many ways in political science. In this article, I describe how toy datasets commonly employed in quantitative methods courses exemplify this problem. Using customary units, for instance, is unsuitable for an internationalized higher education system. To address these limitations, I introduce the Qatar Cars dataset, a freely available alternative toy dataset that uses International System (SI) units, reflects current global automotive market trends (such as the rise of Chinese manufacturers and electric vehicles), and avoids ethnocentric classifications such as labeling the non-U.S. world “foreign.” Created through collaborative data collection with students, the Qatar Cars dataset maintains the pedagogical advantages of earlier datasets, improves statistical instruction by removing barriers for international audiences, and provides opportunities to discuss data-generating processes and research ethics.[^musgrave2025]

[^musgrave2025]: Paul Musgrave, “Defaulting to Inclusion: Producing Sample Datasets for the Global Data Science Classroom,” *Journal of Political Science Education*, 2025, 1–11, <https://doi.org/10.1080/15512169.2025.2572320>.

The `price` column is stored as Qatari Riyals (QAR). At the time of data collection in January 2025, the exchange rates between QAR and US Dollars and Euros were:

- 1 USD = 3.64 QAR
- 1 EUR = 4.15 QAR

---

There are many possible questions to explore!

- What's the distribution of price? (there are some really expensive cars here!)
- What's the relationship between (logged) price and performance?
- Are there patterns across cars from different countries? Do some countries make more expensive cars? More electic cars?
- What's the relationship between car dimensions and seating or trunk volume?
