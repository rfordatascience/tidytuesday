# X-Men Mutant Moneyball

This week's data is [X-Men Mutant Moneyball](https://github.com/EliCash82/mutantmoneyball) from Rally's [Mutant moneyball: a data driven ultimate X-men](https://rallyrd.com/mutant-moneyball-a-data-driven-ultimate-x-men/) by [Anderson Evans](https://github.com/EliCash82). 

This is the data used in Rally's Mutant Moneyball article which visualizes X-Men value data, era by era, from the X-Men's creation in 1963 up to 1993. The idea is that the the concepts in Michael Lewis' book [Moneyball](https://www.goodreads.com/en/book/show/1301), can be applied in a number of cultural industries, not just baseball like in the book and [the movie](https://en.wikipedia.org/wiki/Moneyball_(film)).

>It’s no accident that the name of this piece is Mutant Moneyball, as the overall point is an exercise in valuing each individual character on the X-Men team in a variety of data driven ways. But buying, reading, and loving comic books should be purely for fun and the raw expression of devotion toward characters, art, and story. True: It’s a lesson we fans have failed to learn in the past. The trend of buying comics based on value speculation crippled the entire comic book industry for over a decade in the late 1990’s and early 2000’s. And the point of this isn’t to repeat those mistakes, it’s to gamify open and available financial data, giving us special insight, once unattainable, regarding our magnificent mutants. Like mature adults. 

>Why are some characters sought after more than others, what stories did some mighty mutants convey that made them sought after, while others that eek out a continued existence are unable to resonate enough with a fan base to garner the same kind of love and appreciation in the secondary market? Are there answers that a close reading of value data can offer?

Dollar signs and percentage signs are in the data for some of the columns. Which columns are they in? Do you need to address that before you work with the data in those columns?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-03-19')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 12)

mutant_moneyball <- tuesdata$mutant_moneyball


# Option 2: Read directly from GitHub

mutant_moneyball <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-19/mutant_moneyball.csv')

```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `mutant_moneyball.csv`

|variable               |class     |description            |
|:----------------------|:---------|:----------------------|
|Member                 |character |The name of the X-Men team member the data is connected to. In many cases these names are their civilian names and not their "Superhero" names (i.e. warrenWorthington is Angel, hankMcCoy is Beast, etc.              |
|TotalIssues            |double    |This shows the total number of issues each X-Men member appeared in between 1963 and 1992.      |
|TotalIssues60s         |double    |Total number of issues each X-Men member appeared between 1963 and 1969.|
|TotalIssues70s         |double    |Total number of issues each X-Men member appeared between 1970 and 1979.|
|TotalIssues80s         |double    |Total number of issues each X-Men member appeared between 1980 and 1989.|
|TotalIssues90s         |double    |Total number of issues each X-Men member appeared between 1990 and 1992.|
|totalIssueCheck        |double    |Check on the total number of issues. Should be the same as TotalIssues.    |
|TotalValue_heritage    |double    |Total value of each X-Men team member's total number of issues as reflected by Heritage highest sale.  |
|TotalValue60s_heritage |double    |Total value of each X-Men team member's total number of issues as reflected by Heritage highest sale of comics released between 1963 and 1969. |
|TotalValue70s_heritage |double    |Total value of each X-Men team member's total number of issues as reflected by Heritage highest sale of comics released between 1970 and 1979. |
|TotalValue80s_heritage |double    |Total value of each X-Men team member's total number of issues as reflected by Heritage highest sale of comics released between 1980 and 1989. |
|TotalValue90s_heritage |double    |Total value of each X-Men team member's total number of issues as reflected by Heritage highest sale of comics released between 1990 and 1992. |
|TotalValue_ebay        |double    |Total value of each X-Men team member's total number of issues as reflected by ebay sales in 2022 in which sellers tagged the issue as VG (Very Good) Condition.  |
|TotalValue60s_ebay     |double    |Total value of each X-Men team member's total number of issues released between 1963 and 1969 as reflected by ebay sales in 2022 in which sellers tagged the issue as VG (Very Good) Condition.   |
|TotalValue70s_ebay     |double    |Total value of each X-Men team member's total number of issues released between 1970 and 1979 as reflected by ebay sales in 2022 in which sellers tagged the issue as VG (Very Good) Condition.    |
|TotalValue80s_ebay     |double    |Total value of each X-Men team member's total number of issues released between 1980 and 1989 as reflected by ebay sales in 2022 in which sellers tagged the issue as VG (Very Good) Condition.   |
|TotalValue90s_ebay     |double    |Total value of each X-Men team member's total number of issues released between 1990 and 1992 as reflected by ebay sales in 2022 in which sellers tagged the issue as VG (Very Good) Condition.  |
|60s_Appearance_Percent |character |The percentage each X-Men member appeared in an issue published between 1963 and 1969 |
|70s_Appearance_Percent |character |The percentage each X-Men member appeared in an issue published between 1970 and 1979 |
|80s_Appearance_Percent |character |The percentage each X-Men member appeared in an issue published between 1980 and 1989 |
|90s_Appearance_Percent |character |	The percentage each X-Men member appeared in an issue published between 1990 and 1992 |
|PPI60s_heritage        |character |Average price per issue for each X-Men member based on highest sales on Heritage for issues published between 1963 and 1969.  |
|PPI70s_heritage        |character |Average price per issue for each X-Men member based on highest sales on Heritage for issues published between 1970 and 1979.     |
|PPI80s_heritage        |character |Average price per issue for each X-Men member based on highest sales on Heritage for issues published between 1980 and 1989.     |
|PPI90s_heritage        |character |Average price per issue for each X-Men member based on highest sales on Heritage for issues published between 1990 and 1992.  |
|PPI60s_ebay            |character |Average price per issue for each X-Men member based on VG sales on eBay for issues published between 1963 and 1969.    |
|PPI70s_ebay            |character |Average price per issue for each X-Men member based on VG sales on eBay for issues published between 1970 and 1979.   |
|PPI80s_ebay            |character |Average price per issue for each X-Men member based on VG sales on eBay for issues published between 1980 and 1989.   |
|PPI90s_ebay            |character |Average price per issue for each X-Men member based on VG sales on eBay for issues published between 1990 and 1992.   |
|TotalValue60s_wiz      |character |Total value of each X-Men team member's total number of issues released between 1963 and 1969 as they were valued in April 1993's Wizard Price Guide.  |
|TotalValue70s_wiz      |character |Total value of each X-Men team member's total number of issues released between 1970 and 1979 as they were valued in April 1993's Wizard Price Guide.  |
|TotalValue80s_wiz      |character |Total value of each X-Men team member's total number of issues released between 1980 and 1989 as they were valued in April 1993's Wizard Price Guide.   |
|TotalValue90s_wiz      |character |Total value of each X-Men team member's total number of issues released between 1990 and 1992 as they were valued in April 1993's Wizard Price Guide.  |
|TotalValue60s_oStreet  |character |Total value of each X-Men team member's total number of issues released between 1963 and 1969 as they were valued in 2015's Overstreet Price Guide.  |
|TotalValue70s_oStreet  |character |Total value of each X-Men team member's total number of issues released between 1970 and 1979 as they were valued in 2015's Overstreet Price Guide.  |
|TotalValue80s_oStreet  |character |Total value of each X-Men team member's total number of issues released between 1980 and 1989 as they were valued in 2015's Overstreet Price Guide. |
|TotalValue90s_oStreet  |character |Total value of each X-Men team member's total number of issues released between 1990 and 1992 as they were valued in 2015's Overstreet Price Guide. |
|PPI60s_wiz             |character |Average price per issue for each X-Men member based on April 1993 Wizard Price Guide for issues published between 1963 and 1969.    |
|PPI70s_wiz             |character |Average price per issue for each X-Men member based on April 1993 Wizard Price Guide for issues published between 1970 and 1979.    |
|PPI80s_wiz             |character |Average price per issue for each X-Men member based on April 1993 Wizard Price Guide for issues published between 1980 and 1989.   |
|PPI90s_wiz             |character |Average price per issue for each X-Men member based on April 1993 Wizard Price Guide for issues published between 1990 and 1992.  |
|PPI60s_oStreet         |character |Average price per issue for each X-Men member based on 2015 Overstreet Price Guide for issues published between 1963 and 1969.   |
|PPI70s_oStreet         |character |Average price per issue for each X-Men member based on 2015 Overstreet Price Guide for issues published between 1970 and 1979.   |
|PPI80s_oStreet         |character |Average price per issue for each X-Men member based on 2015 Overstreet Price Guide for issues published between 1980 and 1989.     |
|PPI90s_oStreet         |character |Average price per issue for each X-Men member based on 2015 Overstreet Price Guide for issues published between 1990 and 1992.   |


### Cleaning Script

No cleaning
