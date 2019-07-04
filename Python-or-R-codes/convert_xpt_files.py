# coding: utf-8
# In[5]:

from __future__ import print_function
from ipywidgets import interact, interactive, fixed, interact_manual
import ipywidgets as widgets
import os

out_folder = '../nhanes_output_data/'
data_folder = '../nhanes_input_data/'
diet_files = os.listdir(data_folder)
diet_files[:4]
print(diet_files)

# In[6]:
import xport

# import pandas as pd
# In[3]:

def get_columns(aFile_columns):
    f = open(aFile_columns, 'r')
    columns = ''
    for line in f:
        columns += '"' + line.strip() + '"' + ','

    columns += '\n'
    print(columns)
    f.close()
    return columns

ignore_if_output_exist = 1

# In[53]:
for aFile in diet_files:
    if aFile.find('XPT') >= 0:
        print(aFile)
        # continue

        if ignore_if_output_exist:
            if os.path.exists(out_folder + aFile + '.csv'):
                continue


        aFile_columns = aFile[0:len(aFile)-3] + 'txt'
        path = data_folder + aFile_columns
        print(aFile_columns)

        long_columns = ''
        if os.path.exists(path):
            long_columns = get_columns(path)

        data_file = data_folder + aFile

        # In[62]:
        f = open(data_file, 'rb')
        row = xport.Reader(f)
        # print(list(row))
        # print(row.fields)
        columns_set = row.fields

        columns = ''
        for field in columns_set:
            columns += '"' + field.strip() + '"' + ','

        columns += '\n'
        print(columns)

        f.close()
        # columns

        # In[63]:
        out_file = out_folder + aFile + '.csv'
        out = open(out_file, 'w')
        # out.write(columns)

        if os.path.exists(path):
            out.write(long_columns)
        else:
            out.write(columns)

        with open(data_file, 'rb') as f:
            for row in xport.Reader(f):
                row_str = ''
                for aField in row:
                    row_str += '"' + str(aField) + '"' + ','
                row_str += '\n'
                out.write(row_str)
                # break

        out.close()
        # f.close()

print('Output generation complete')

# References
# https://pypi.org/project/xport/
# Codes in the column names: https://wwwn.cdc.gov/nchs/nhanes/Search/variablelist.aspx?Component=Dietary
