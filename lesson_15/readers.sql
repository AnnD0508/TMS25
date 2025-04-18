
CREATE TABLE IF NOT EXISTS readers (
    id_reader integer,
    full_name text,
    library_card_number text,
    registration_date date,
    phone_number text,
    email text
);


INSERT INTO readers (full_name, library_card_number, registration_date, phone_number, email)  
VALUES  
    ('Иван Петров', 'R001', '2023-01-10', '+79161234567', 'ivan.petrov@example.com'),  
    ('Мария Сидорова', 'R002', '2022-05-15', '+79261239876', 'maria.sidorova@example.com'),  
    ('Алексей Смирнов', 'R003', '2023-06-20', '+79371234568', 'alexey.smirnov@example.com'),  
    ('Екатерина Иванова', 'R004', '2021-11-05', '+79551234569', 'ekaterina.ivanova@example.com'),  
    ('Павел Кузнецов', 'R005', '2020-09-25', '+79661234560', 'pavel.kuznetsov@example.com'),  
    ('Анна Белова', 'R006', '2019-03-18', '+79771234561', 'anna.belova@example.com'),  
    ('Сергей Орлов', 'R007', '2022-12-12', '+79881234562', 'sergey.orlov@example.com'),  
    ('Ольга Васильева', 'R008', '2023-08-22', '+79991234563', 'olga.vasileva@example.com'),  
    ('Дмитрий Морозов', 'R009', '2021-07-30', '+79101234564', 'dmitry.morozov@example.com'),  
    ('Елена Павлова', 'R010', '2020-02-14', '+79201234565', 'elena.pavlova@example.com');

SELECT * FROM readers

SELECT *  FROM readers WHERE registration_date BETWEEN '2019-01-01' AND '2025-04-01';
