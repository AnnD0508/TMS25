# Задача 1: Найти женщин с IP, начинающимся на "1"
import pandas as pd

df = pd.read_csv("hw_DE_12.csv")
women_with_ip1 = df[(df["gender"] == "Female") & (df["ip_address"].str.startswith("1"))]
print("Женщины с IP-адрес, начинающимся на '1':")
print(women_with_ip1[["first_name", "last_name"]])
