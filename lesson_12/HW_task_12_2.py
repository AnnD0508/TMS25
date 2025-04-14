# Задача 2:  Создайте новый столбец domain, который будет содержать домен из электронной почты
# (например, для zsheara0@buzzfeed.com домен — buzzfeed.com).

import pandas as pd
import os

df = pd.read_csv('hw_DE_12.csv')

df['domain'] = df['email'].str.split('@').str[1]

output_path = 'hw_DE_12_domain.xlsx'

output_dir = os.path.dirname(output_path)
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

df.to_excel(output_path, index=False)
