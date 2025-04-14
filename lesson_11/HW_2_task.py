# Задача 2.
# Создайте программу, которая считывает список чисел из файла, проверяет каждое число на чётность
# и записывает результаты (чётное или нечётное) в другой файл.
# Используйте обработку исключений для возможных ошибок ввода-вывода.

def check_parity_number():
    try:
        with open('file_input.txt', 'r', encoding='utf-8') as infile:
            lines = infile.readlines()

            if not lines:
                print("Файл 'file_input.txt' пустой.")
                return

            with open('file_output.txt', 'w', encoding='utf-8') as outfile:

                for line in lines:
                    line = line.strip()
                    if not line:
                        continue
                    try:
                        number = int(line)
                        if number % 2 == 0:
                            outfile.write(f"{number} - чётное\n")
                        else:
                            outfile.write(f"{number} - нечётное\n")
                    except ValueError:
                        outfile.write(f"Ошибка: '{line}' - не является числом\n")
                print("Данные успешно записаны в файл 'file_output.txt'.")
    except FileNotFoundError:
        print("Ошибка: файл 'file_input.txt' не найден.")
    except IOError as e:
        print(f"Ошибка ввода-вывода: {e}")
    except Exception as e:
        print(f"Неожиданная ошибка: {e}")
