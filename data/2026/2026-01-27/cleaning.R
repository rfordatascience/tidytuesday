# Imports
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import csv

# Input data
companies0 = pd.read_csv("../raw_data/raw_companies.csv", sep=";", encoding="cp1252", header=None)

legal_nature = pd.read_csv('../raw_data/legal_nature.csv', sep=',')

sizes = pd.read_csv("../raw_data/size.csv", sep=",", encoding="cp1252")

qualifications = pd.read_csv("../raw_data/qualifications.csv", sep = ",", encoding="cp1252")

# Remove all private associations
def treat_companies_dataframe(dataframe):
    companies_df_column_name = ["company_id", "company_name","legal_nature", "owner_qualification","capital_stock","company_size","federal_owner"]

    dataframe.columns = companies_df_column_name

    dataframe['capital_stock'] = dataframe['capital_stock'].str.replace(',', '.')
    dataframe['capital_stock'] = pd.to_numeric(dataframe['capital_stock'], errors='coerce')
    
    dataframe_filtered = dataframe[dataframe['capital_stock'] > 150000]
    dataframe_filtered = dataframe_filtered.drop(columns=["federal_owner"])
    
    return dataframe_filtered

def mapper(dataframe, dictionary: dict, column_name: str):
    dataframe[column_name] = dataframe[column_name].map(dictionary)
    return dataframe

def replace_info(dataframe):
    legal_nature_dict = dict(zip(legal_nature['id'], legal_nature['legal_nature']))
    qualification_dict = dict(zip(qualifications['id'], qualifications['owner_qualification']))
    size_dict = dict(zip(sizes['id'], sizes['company_size']))

    dataframe = mapper(dataframe, legal_nature_dict, 'legal_nature')
    dataframe = mapper(dataframe, qualification_dict, "owner_qualification")
    dataframe = mapper(dataframe, size_dict, 'company_size')

    return dataframe

def merge_and_clean(df_top, df_bottom):

    combined_df = pd.concat([df_top, df_bottom], ignore_index=True)
    
    cleaned_df = combined_df.drop_duplicates()
    
    return cleaned_df

filtered_df0 = treat_companies_dataframe(companies0)

filtered_df0 = replace_info(filtered_df0)

with open("../data/companies.csv", mode="w", newline='') as file:
    write = csv.writer(file, delimiter=';')
    write.writerow(filtered_df0.columns) 
    write.writerows(filtered_df0.values.tolist())

