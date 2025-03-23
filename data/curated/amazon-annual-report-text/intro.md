This week we're exploring text data from 
[Amazon's annual reports.](https://ir.aboutamazon.com/annual-reports-proxies-and-shareholder-letters/default.aspx)
The PDFs were read into R using the {pdftools} R package, and explored by TidyTuesday
participant Gregory Vander Vinne in 
[a post on his website](https://gregoryvdvinne.github.io/Text-Mining-Amazon-Budgets.html).
Note that stop words (e.g., "and", "the", "a") have been removed from the data.

> As a publicly-traded company, Amazon releases an annual report every year (with a December 31st year end). An annual report is essentially a summary of the company’s performance over the past year. It includes details on how well the company did financially, what goals were achieved, and what challenges it faced.

- How have the words used change over time? 

- Are there meaningful changes in sentiment from year to year? 

- Which words are likely to appear together in the same annual report?
