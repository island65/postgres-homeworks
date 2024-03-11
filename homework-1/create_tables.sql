-- SQL-команды для создания таблиц


--employees
create table employees
(
employee_id int primary key,
first_name varchar (30),
last_name varchar (30),
title varchar (30),
birth_date date,
notes text
)

--customers
create table customers
(
customer_id varchar (10) primary key,
company_name varchar(50),
contact_name varchar (50)
)


--orders
create table orders_data
(
order_id int primary key,
customer_id varchar(10) REFERENCES customers(customer_id) NOT NULL,
employee_id int REFERENCES employees(employee_id) NOT NULL,
order_date date,
ship_city varchar (30)
)
