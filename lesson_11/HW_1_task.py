# Задача 1.
# Напишите функцию, которая принимает список чисел и возвращает их среднее значение.
# Обработайте исключения, связанные с пустым списком и некорректными типами данных.

def average_val(numbers):
    try:
        if not numbers:
            raise ValueError("Список пуст.")
        total = sum(numbers)
        count = len(numbers)
        return total / count
    except TypeError:
        raise TypeError ("Список должен содержать только числа.")

print ("Среднее значение:", (average_val([1, 'a', 9])))
