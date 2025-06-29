# Есть входной файлик по информации по людям, необходимо подготовить отчет в формате .txt в любом виде
# с информацией о том, сколько по каждой профессии у нас людей, сколько людей в каждом городе и сколько людей в стране.
#
# Вывод в файлике statistics.txt:
# Статистика по профессиям:
# программист: 10 человек
# учительница: 17 человек
# ...
#
# Статистика по городам:
# Минск: 3 человек
# Москва: 1 человек
# ...
#
# Статистика по странам:
# Беларусь: 23 человек
# Россия: 26 человек

import pandas as pd

df = pd.read_csv('filename.txt')

df.columns = ['Фамилия', 'Имя', 'Отчество', 'Пол', 'Дата рождения', 'Профессия', 'Город', 'Страна']

profession_counts = df['Профессия'].value_counts()
city_counts = df['Город'].value_counts()
country_counts = df['Страна'].value_counts()

with open("statistics.txt", "w", encoding="utf-8") as file:
    file.write("Статистика по профессиям:\n")
    for profession, count in profession_counts.items():
        file.write(f"{profession}: {count} человек\n")

    file.write("\nСтатистика по городам:\n")
    for city, count in city_counts.items():
        file.write(f"{city}: {count} человек\n")

    file.write("\nСтатистика по странам:\n")
    for country, count in country_counts.items():
        file.write(f"{country}: {count} человек\n")
