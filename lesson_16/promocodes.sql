1. Создание таблицы promocodes
Что нужно сделать:
Создать таблицу для хранения промокодов, которые могут применять пользователи к своим заказам.

Требования:
promo_id – уникальный ID промокода (первичный ключ, автоинкремент).
code – текст промокода (уникальный, не может повторяться).
discount_percent – процент скидки (от 1 до 100).
valid_from и valid_to – срок действия.
max_uses – максимальное количество применений (NULL = без ограничений).
used_count – сколько раз уже использован (по умолчанию 0).
is_active – активен ли промокод (1 или 0, по умолчанию 1).
created_by – кто создал промокод (внешний ключ на users.id).

CREATE TABLE IF NOT EXISTS promocodes(
	promo_id INTEGER PRIMARY KEY AUTOINCREMENT,
	code TEXT UNIQUE, 
	discount_percent INTEGER CHECK (discount_percent BETWEEN 1  AND 100),
	valid_from DATETIME,
	valid_to DATETIME,
	max_uses INTEGER DEFAULT NULL CHECK (max_uses >=0 OR max_uses IS NULL),
	used_count INTEGER DEFAULT NULL, 
	is_active – INTEGER DEFAULT 1 CHECK (is_active IN (0, 1)),
	created_by – INTEGER,
	
	FOREIGN KEY (created_by) REFERENCES users(id)
	
	);


2. Заполнение таблицы тестовыми данными
- Добавить 10 тестовых промокодов с разными параметрами:
- Скидки от 5% до 50%.
- Разные даты действия (некоторые уже истекли).
- Ограниченное и неограниченное количество использований.
    ('SUMMER10', 10, '2023-06-01', '2023-08-31', 100, 1),
    ('WELCOME20', 20, '2023-01-01', '2023-12-31', NULL, 2),
    ('BLACKFRIDAY30', 30, '2023-11-24', '2023-11-27', 500, 3),
    ('NEWYEAR15', 15, '2023-12-20', '2024-01-10', 200, 4),
    ('FLASH25', 25, '2023-10-01', '2023-10-07', 50, 5),
    ('LOYALTY5', 5, '2023-01-01', '2024-01-01', NULL, 6),
    ('MEGA50', 50, '2023-09-01', '2023-09-30', 10, 7),
    ('AUTUMN20', 20, '2023-09-01', '2023-11-30', 300, 8),
    ('SPRING10', 10, '2023-03-01', '2023-05-31', 150, 9),
    ('VIP40', 40, '2023-07-01', '2023-07-31', 20, 10);

INSERT INTO promocodes (code, discount_percent, valid_from, valid_to, max_uses, used_count, is_active, created_by)
VALUES
('SPRING5', 5, '2024-01-01', '2025-05-01', 100, 30, 1, 1),
('SUMMER10', 10, '2025-04-01', '2025-06-01', NULL, 0, 1, 2),
('FALL15', 15, '2023-09-01', '2023-12-01', 50, 45, 0, 1),
('WINTER20', 20, '2025-01-01', '2025-12-31', 10, 10, 1, 3),
('HOLIDAY25', 25, '2025-04-01', '2025-05-15', NULL, 3, 1, 1),
('FLASH30', 30, '2025-04-20', '2025-04-30', 5, 2, 1, 2),
('LIMITED35', 35, '2024-12-01', '2025-01-01', 1, 1, 0, 1),
('BIG40', 40, '2025-05-01', '2025-06-01', NULL, 0, 1, 3),
('EXTRA45', 45, '2025-04-01', '2025-04-10', 20, 19, 1, 2),
('MEGA50', 50, '2025-07-01', '2025-08-01', NULL, 0, 1, 3),
('AUTUM60', 60, '2024-09-01', '2025-09-01', 1, 1, 1, 1),
('SPECIAL99', 99, '2025-08-01', '2025-08-05', 1, 0, 1, 3),
('VIP80', 80, '2025-04-01', '2025-10-10', 1, 19, 1, 2),
('MARCH70', 70, '2025-03-01', '2025-03-31', NULL, 0, 0, 3);


3. Анализ по группам скидок
Сгруппировать промокоды по диапазонам скидок и вывести:
- Количество промокодов в группе.
- Минимальную и максимальную скидку.
- Сколько из них имеют ограничение по использованию (max_uses IS NOT NULL).

SELECT * FROM promocodes 

SELECT 
	CASE
		WHEN discount_percent BETWEEN 1 AND 10 THEN "1-10%"
		WHEN discount_percent BETWEEN 11 AND 20 THEN "11-20%"
		WHEN discount_percent BETWEEN 21 AND 30 THEN "21-30%"
		WHEN discount_percent BETWEEN 31 AND 40 THEN "31-40%"
		WHEN discount_percent BETWEEN 41 AND 50 THEN "41-50%"
		WHEN discount_percent BETWEEN 51 AND 60 THEN "51-60%"
		WHEN discount_percent BETWEEN 61 AND 70 THEN "61-70%"
		WHEN discount_percent BETWEEN 71 AND 80 THEN "71-80%"
		WHEN discount_percent BETWEEN 81 AND 90 THEN "81-90%"
		WHEN discount_percent BETWEEN 91 AND 100 THEN "91-100%"
		ELSE 'another'
	END AS discount_range,
	COUNT (*) AS promo_count,
	MIN (discount_percent) AS min_discount_percent,
	MAX (discount_percent) AS max_discount_percent,
	COUNT (CASE WHEN max_uses IS NOT NULL THEN 1 END) AS limit_max_uses
	
	FROM promocodes
	GROUP BY discount_range

4. Анализ по времени действия
Что нужно сделать:
Разделить промокоды на:
- Активные (текущая дата между valid_from и valid_to).
- Истекшие (valid_to < текущая дата).
- Еще не начавшиеся (valid_from > текущая дата).
Для каждой группы вывести:
- Количество промокодов.
- Средний процент скидки.
- Сколько из них имеют лимит использований.

SELECT 
	CASE
		WHEN CURRENT_TIMESTAMP BETWEEN valid_from AND valid_to THEN 'promo code is active'
		WHEN CURRENT_TIMESTAMP > valid_to AND valid_to THEN 'promo code not is valid'
		ELSE 'promo code not is active still'
	END AS status_promocode,
	COUNT (*) AS promo_count,
	ROUND(AVG (discount_percent), 2) AS averag_discount_percent,
	COUNT(max_uses) AS limit_max_uses
	FROM promocodes
	GROUP BY status_promocode
	