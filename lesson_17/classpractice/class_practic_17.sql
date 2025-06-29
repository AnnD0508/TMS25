--1. Статистика по рейсам
--Найдите минимальную, максимальную и среднюю 
--сумму бронирования (total_amount) для бронирований, сделанных в 2016 году.

select * from bookings.bookings b 
where book_date between '2016-01-01' and '2016-12-31'

select 
	min(total_amount) as min_total_amount,
	max(total_amount) as max_total_amount,
	avg(total_amount) as avg_total_amount	
from bookings.bookings 
where book_date between '2016-01-01' and '2016-12-31'

--2. Количество рейсов по статусам
--Посчитайте количество рейсов для каждого возможного статуса, отсортируйте результат по убыванию количества.

select * from bookings.flights f 

select 
	status,
	COUNT(*) as flights_count
	from bookings.flights 
	group by status
	order by flights_count desc;

--3. Популярные направления
--Найдите топ-5 аэропортов назначения (arrival_airport) с наибольшим количеством рейсов.


select 
	arrival_airport,
	count(*) as flights_count
from bookings.flights 
group by arrival_airport 
order by flights_count
limit 5