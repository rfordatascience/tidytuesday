# Clean data provided by @chendaniely. No cleaning was necessary.
import pandas as pd

dataset_url = "https://raw.githubusercontent.com/chendaniely/olympics-2026/refs/heads/main/data/final/olympics/olympics_events.csv"
schedule = pd.read_csv(dataset_url)

