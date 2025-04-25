
--1. Создать таблицу для хранения отзывов пользователей о товарах.
--Требования:
--review_id – уникальный идентификатор отзыва (первичный ключ, автоинкремент).
--product_id – ссылка на товар (внешний ключ в таблицу products).
--user_id – ссылка на пользователя (внешний ключ в таблицу users).
--rating – оценка от 1 до 5 (ограничение CHECK).
--review_text – текст отзыва (может быть NULL).
--created_at – дата создания (по умолчанию текущее время).
--is_verified – флаг верификации (0 или 1, по умолчанию 0).
--Ограничение UNIQUE(product_id, user_id) – 
--один пользователь может оставить только один отзыв на товар.
--Добавить группировку цен по категориям (как с возрастом)


CREATE TABLE if not exists users_reviews (
	review_id integer primary key autoincrement,
	product_id integer not null,
	user_id integer not null,
	reting integer check (reting between 1 and 5),
	review_text text CURRENT_TIMESTAMP,
	created_at DEFAULT CURRENT_TIMESTAMP,
	is_verified DEFAULT 0 CHECK (is_verified IN (0, 1)),

	UNIQUE(product_id, user_id),

	FOREIGN KEY (product_id) REFERENCES products(id),
	FOREIGN KEY (user_id) REFERENCES user(id)
);

--2. Вставить в таблицу reviews 14 тестовых отзывов с разными оценками, статусом верификации и текстами.
--Пример данных:
    --(101, 1, 5, 'Отличный ноутбук, всем рекомендую!', 1),
    --(101, 3, 4, 'Хорошее качество, но дороговат', 0),
   -- (102, 2, 3, 'Нормальный телефон за свои деньги', 1),
    --(102, 5, 2, 'Разочарован, быстро разряжается', 0),
    -- ... остальные записи
    --(110, 3, 4, 'Стабильный сигнал, легко настраивается', 0),
    --(101, 2, 5, 'Прекрасный ноутбук для работы', 1),
    --(103, 5, 2, 'Звук хороший, но неудобно сидят', 0);

INSERT INTO users_reviews (product_id, user_id, reting, review_text, is_verified)
VALUES  (101, 1, 5, 'Отличный ноутбук, всем рекомендую!', 1),
     	(101, 3, 4, 'Хорошее качество, но дороговат', 0),
   		(102, 2, 3, 'Нормальный телефон за свои деньги', 1),
    	(102, 5, 2, 'Разочарован, быстро разряжается', 0),
    	(110, 3, 4, 'Стабильный сигнал, легко настраивается', 0),
    	(101, 2, 5, 'Прекрасный ноутбук для работы', 1),
    	(103, 5, 2, 'Звук хороший, но неудобно сидят', 0);

SELECT * FROM users_reviews 


--3. Посчитать:
-- Общее количество отзывов.
-- Средний рейтинг.
-- Количество верифицированных отзывов.

SELECT 
	COUNT(*) AS total_reviews,
	AVG(reting) AS average_reting,
	SUM(is_verified) AS verified_reviews
FROM users_reviews

--4. Сгруппировать отзывы по оценкам (rating) и для каждой группы вывести:
--- Количество отзывов.
-- Среднюю длину текста.
-- Количество верифицированных.
-- Процент верифицированных.

SELECT 
	reting,
	COUNT(*) AS reviews_count,
	AVG(LENGTH(review_text)) AS avg_review_length,
	SUM(is_verified) AS veriefied_count,
	ROUND((SUM(is_verified) * 100 / COUNT(*)), 2) AS verifiend_precent
FROM users_reviews
GROUP BY reting;

--5.  Разбить отзывы по:
-- Дням недели (strftime('%w', created_at)).
-- Времени суток (утро, день, вечер, ночь).
--И для каждой группы вывести:
--- Количество отзывов .
-- Средний рейтинг.
-- Процент 5-звёздочных отзывов.
-- Процент негативных отзывов (1-2 звезды).

SELECT 
    CASE strftime('%w', created_at) -- - Дням недели (strftime('%w', created_at)).
        WHEN '0' THEN 'Воскресенье'
        WHEN '1' THEN 'Понедельник'
        WHEN '2' THEN 'Вторник'
        WHEN '3' THEN 'Среда'
        WHEN '4' THEN 'Четверг'
        WHEN '5' THEN 'Пятница'
        WHEN '6' THEN 'Суббота'
        ELSE 'Неизвестно'
		END AS day_of_week,
    CASE -- - Времени суток (утро, день, вечер, ночь).
        WHEN strftime('%H', created_at) BETWEEN '06' AND '11' THEN 'Утро'
        WHEN strftime('%H', created_at) BETWEEN '12' AND '17' THEN 'День'
        WHEN strftime('%H', created_at) BETWEEN '18' AND '23' THEN 'Вечер'
        WHEN strftime('%H', created_at) BETWEEN '00' AND '05' THEN 'Ночь'
        ELSE 'Неизвестно'
    END AS time_of_day,
		COUNT(*) AS total_reviews, -- Количество отзывов .
		AVG(reting) AS average_rating, -- Средний рейтинг
		ROUND((SUM(CASE WHEN reting = 5 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS five_star_percent, -- - Процент 5-звёздочных отзывов.
		ROUND((SUM(CASE WHEN reting IN (1, 2) THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS negative_percent -- - Процент негативных отзывов (1-2 звезды).
		
FROM users_reviews

GROUP BY day_of_week, time_of_day
ORDER BY day_of_week, time_of_day
