# 1. Объединение данных о студентах
# Есть два файла: “students.txt” (ФИО, группа) и “grades.txt” (ФИО, оценки)
# Задача: создать файл “report.txt” с информацией о студентах и их оценках, о среднем бале для каждого студента.
# А так же в конце файла для каждой группы вывести средний бал по группе в порядке возрастания
# Пример вывода:
# Иванов Иван Иванович, Группа 101, 5 4 3 4 5, Средняя оценка: 4.20
# Петров Петр Петрович, Группа 102, 4 4 5 3 4, Средняя оценка: 4.00
# Сидоров Сидор Сидорович, Группа 101, 3 5 4 4 3, Средняя оценка: 3.80
# Козлова Анна Сергеевна, Группа 102, 5 5 4 5 4, Средняя оценка: 4.60

# Средние оценки по группам (в порядке возрастания):
# Группа 101: 3.92
# Группа 202: 4.30

students = {}
grades = {}

with open('students.txt', 'r', encoding='utf-8') as file:
    for line in file:
        fio, group = line.removesuffix('\n').rsplit(', ', 1)
        students[fio] = group

with open('grades.txt', 'r', encoding='utf-8') as file:
    for line in file:
        fio, grades_str = line.removesuffix('\n').rsplit(', ', 1)
        grades_list = list(map(int, grades_str.split()))
        grades[fio] = grades_list

group_averages = {}

with open('report.txt', 'w', encoding='utf-8') as report:

    for fio in students:
        group = students[fio]
        student_grades = grades.get(fio, [])
        if student_grades:
            average_grade = sum(student_grades) / len(student_grades)
            report.write(f"{fio}, {group}, {' '.join(map(str, student_grades))}, Средняя оценка: {average_grade:}\n")

            if group not in group_averages:
                group_averages[group] = []
            group_averages[group].append(average_grade)

    group_average_list = []
    for group, averages in group_averages.items():
        group_avg = sum(averages) / len(averages)
        group_average_list.append((group, group_avg))

    group_average_list.sort(key=lambda x: x[1])

    report.write("\nСредние оценки по группам (в порядке возрастания):\n")
    for group, avg in group_average_list:
        report.write(f"{group}: {avg:.2f}\n")
