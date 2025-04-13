# У вас есть список чисел. Напишите программу, которая находит минимальное значение в списке через цикл for

numbers = [10, 20, 5, 30, 15]

min_numbers = numbers[0]

for number in numbers:
    if number < min_numbers:
        min_numbers = number
print("Найдено минимальное число в списке: ", min_numbers)
