-- Напишите запросы, которые выводят следующую информацию:
/* 1. заказы, отправленные в города, заканчивающиеся на 'burg'. 
	Вывести без повторений две колонки (город, страна) (см. таблица orders, колонки ship_city, ship_country)*/
select distinct ship_city, ship_country from orders o
where o.ship_city like '%burg'
order by ship_city, ship_country;


/* 2. из таблицы orders идентификатор заказа, идентификатор заказчика, вес и страну отгрузки. 
   Заказ отгружен в страны, начинающиеся на 'P'. Результат отсортирован по весу (по убыванию). 
   Вывести первые 10 записей.
 */
select 
	o.order_id, 
	o.customer_id, 
	o.ship_country, 
	o.freight 
from orders o 
where o.ship_country like 'P%'
order by o.freight desc 
limit 10;

/* 3. фамилию и телефон сотрудников, у которых в данных отсутствует регион (см таблицу employees) */
select 
	e.last_name,	
	e.home_phone 
from employees e
where e.region is null;

/* 4. количество поставщиков (suppliers) в каждой из стран. 
   Результат отсортировать по убыванию количества поставщиков в стране */
select s.country, count(*)  from suppliers s
group by s.country
order by count(*) desc;


/* 5. суммарный вес заказов (в которых известен регион) по странам, но вывести только те результаты, 
   где суммарный вес на страну больше 2750. 
   Отсортировать по убыванию суммарного веса (см таблицу orders, колонки ship_region, ship_country, freight) */

select ship_country, sum(freight) as total_freight
from orders o
where o.ship_region is not null
group by ship_country
having sum(freight) > 2750
order by total_freight desc;

/* 6. страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers) и работники (employees). */
select 
	distinct c.country 
from customers c
intersect
select 
	distinct s.country 
from suppliers s
intersect
select 
	distinct e.country 
from employees e;


/* 7. страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers), 
 * но не зарегистрированы работники (employees).*/
select 
	distinct c.country 
from customers c
intersect
select 
	distinct s.country 
from suppliers s
except
select 
	distinct e.country 
from employees e;

