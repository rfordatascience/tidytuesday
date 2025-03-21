<!-- 
1. Describe the dataset. See previous weeks for the general format of the
DESCRIPTION. The description is the part of the readme.md file above "The Data";
everything else will be filled in from the other md files in this directory +
automatic scripts. We usually include brief introduction along the lines of
"This week we're exploring DATASET" or "The dataset this week comes from 
SOURCE", then a quote starting with ">", then a few questions participants might
seek to answer using the data. 
2. Delete this comment block.
-->
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
