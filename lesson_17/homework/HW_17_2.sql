--Задача 2: Анализ стоимости билетов по рейсам
--Для каждого рейса рассчитать:
-- Минимальную, максимальную и среднюю стоимость билета
-- Разницу между самым дорогим и самым дешевым билетом
-- Медианную стоимость билета
-- Массив всех цен на билеты

--select * from bookings.ticket_flights tf 

select 
	flight_id,
	min(amount) as min_amount_tickets,
	max(amount) as max_amount_tickets,
	round(avg(amount), 1) as avg_amount_tickets,
	max(amount) - min(amount) as delta_price,
	percentile_cont(0.5) within group (order by amount) as median_price,
	array_agg(amount) as array_age_amount
	from bookings.ticket_flights
	group by flight_id
	order by flight_id desc