# The cleaning for this dataset was done in Python. See cleaning.py.
# Data from the WHO Global Health Expenditure Database (GHED)
# To regenerate the CSVs: pip install -r requirements.txt && python cleaning.py

health_spending <- readr::read_csv("health_spending.csv")
financing_schemes <- readr::read_csv("financing_schemes.csv")
spending_purpose <- readr::read_csv("spending_purpose.csv")
