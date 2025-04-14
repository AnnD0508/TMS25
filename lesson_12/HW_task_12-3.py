# Задача 3: Найдите все уникальные домены из столбца domain.

import pandas as pd

df = pd.read_excel('/Users/Anna_D/PycharmProjects/PythonProject-TMS DE-2025/lesson_12/hw_DE_12_domain.xlsx')

unique_domains = sorted(df['domain'].dropna().unique())
domains_df = pd.Series(unique_domains, name='domain')
unique_domains_path = 'unique_domains.xlsx'
domains_df.to_excel(unique_domains_path, index=False)
