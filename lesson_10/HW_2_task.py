# Проверьте, являются ли две строки анаграммами друг друга.
# Вход: марш, шрам
# Выход: Да, это “Анаграмма”

phrasis = (input("Введите слово: ").strip().lower().replace(",", "").replace(" ", ""))
phrasis_2 = (input("Введите слово: ").strip().lower().replace(",", "").replace(" ", ""))

if sorted(phrasis) == sorted(phrasis_2):
    print("Да, это Анаграмма")
else:
    print("Нет, это не Анаграмма")
