-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select customers.company_name
, CONCAT(employees.first_name, ' ', employees.last_name) as employee
from orders
inner join customers using (customer_id)
inner join employees using (employee_id)
inner join shippers on orders.ship_via = shippers.shipper_id
where customers.city = 'London' and employees.city = 'London'
and shippers.company_name = 'United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select product_name, units_in_stock, suppliers.contact_name, suppliers.phone
from products
join suppliers using (supplier_id)
join categories using (category_id)
where discontinued = 0 and category_name in ('Dairy Products', 'Condiments') and units_in_stock < 25
order by 2 asc

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select company_name
from orders
full join customers using (customer_id)
where order_date is NULL
order by company_name asc

select company_name
from customers
where not exists (select customer_id from customers.customer_id = order.customer_id)

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT product_name
FROM products
JOIN order_details ON order_details.product_id = products.product_id
WHERE quantity IN(
	SELECT order_details.quantity FROM order_details
	WHERE quantity = 10)