# Week 30 - Horror Movies and Profit

[raw data](https://github.com/rfordatascience/tidytuesday/blob/master/data/2018-10-23/movie_profit.csv)

## [Scary Movies Are The Best Investment In Hollywood](https://fivethirtyeight.com/features/scary-movies-are-the-best-investment-in-hollywood/) - FiveThirtyEight

"Horror movies get nowhere near as much draw at the box office as the big-time summer blockbusters or action/adventure movies — the horror genre accounts for only 3.7 percent of the total box-office haul this year — but there’s a huge incentive for studios to continue pushing them out.

The return-on-investment potential for horror movies is absurd.

For example, “Paranormal Activity” was made for $450,000 and pulled in $194 million — 431 times the original budget. That’s an extreme, I-invested-in-Microsoft-when-Bill-Gates-was-working-in-a-garage case, but it’s not rare. And that’s what makes horror such a compelling genre to produce."

Quote from [Walt Hickey](https://twitter.com/WaltHickey) for fivethirtyeight article.

## Data Dictionary
Data from [the-numbers.com](https://www.the-numbers.com/)

Header | Description
---|---------
`release_date` | month-day-year
`movie` | Movie title
`production_budget` | Money spent to create the film
`domestic_gross` | Gross revenue from USA
`worldwide_gross` | Gross worldwide revenue
`distributor` | The distribution company
`mpaa_rating` | Appropriate age rating by the US-based rating agency
`genre` | Film category

## Want to dive further?

Check out the [`boxoffice`](https://cran.r-project.org/web/packages/boxoffice/vignettes/Using-boxoffice.html) package!

`boxoffice()` is a simple package to get information about daily box office results of movies. It scrapes the webpages of either http://www.boxofficemojo.com or https://www.the-numbers.com/ for this information. The data it returns are the following:

1. Movie name
2. The studio that produced that movie
3. The daily gross
4. Daily percent change in gross
5. Number of theaters it is playing in
6. Average gross per theater (result of 4 / result of 5)
7. Gross-to-date
8. How many days the movie has been playing
9. The date of the data
