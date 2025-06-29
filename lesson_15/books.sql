
CREATE TABLE IF NOT EXISTS books (
	id integer PRIMARY KEY,
	book_name text,
	year_publication integer,
	id_author integer,
	quantity_stock integer,
	status text,
	FOREIGN KEY (id_author) REFERENCES authors(id)
);

INSERT INTO books (book_name, year_publication, id_author, quantity_stock, status)
VALUES 
	('1984', 1949, 1, 12, 'доступна'),  
    ('Мастер и Маргарита', 1967, 2, 8, 'на руках'),  
    ('Убийство в "Восточном экспрессе"', 1934, 3, 15, 'доступна'),  
    ('Гарри Поттер и философский камень', 1997, 4, 20, 'в ремонте'),  
    ('Война и мир', 1869, 5, 5, 'доступна'),  
    ('Преступление и наказание', 1866, 6, 10, 'на руках'),  
    ('Отцы и дети', 1862, 7, 7, 'доступна'),  
    ('Три товарища', 1936, 8, 9, 'в ремонте'),  
    ('Алиса в Стране чудес', 1865, 9, 14, 'доступна'),  
    ('Скотный двор', 1945, 1, 6, 'на руках');


SELECT * FROM books

SELECT book_name
FROM books
JOIN authors 
ON books.id_author = authors.id
WHERE authors.full_name_author = 'Джордж Оруэлл'

SELECT * FROM books 
WHERE status is 'доступна'




