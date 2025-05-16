--- Replace Employee ID With The Unique Identifier

create table enployee
(
	id INT,
  	name varchar
)

create table enployeeS
(
	id INT,
  	unique_id int
)

INSERT INTO enployee
VALUES
(1, 'ashik'),
(2, 'emon'),
(3, 'ropa'),
(4, 'shuvro'),
(5, 'montaha')

SELECT * FROM enployeeS

INSERT INTO enployeeS
VALUES
(1, 3),
(2, 1),
(3, 9),
(4, 5),
(5, 11)

UPDATE enployeeS SET unique_id = 4 WHERE id = 4


SELECT 
enployeeS.unique_id , enployee.name
FROM
enployee
LEFT join enployeeS on enployee.id = enployeeS.unique_id

---------------------------------------
-- Product Sales Analysis
create TABLE sales
(
	sales_id int,
  	product_id int,
  	year int,
  	quantity int,
  	price int
)
SELECT * FROM sales
DROP TABLE enployeeS

INSERT into sales
VALUES 
(1, 101, 2015, 10, 10000),
(2, 101, 2016, 12, 10000),
(3, 102, 2017, 18, 15000)

CREATE TABLE product
(
	product_id int,
  	product_name varchar (40)
)

INSERT INTO product
VALUES
(101, 'barcelona'),
(102, 'man city'),
(103, 'liverpool')

SELECT
product.product_name, sales.price, sales.year
FROM
sales
LEFT JOIN product on sales.product_id = product.product_id

------------------------------------------------
-----Customer Who Visited but Did Not Make Any Transactions

CREATE table visits

(
	visit_id int PRIMARY KEY,
  	customer_id int

)

INSERT into visits
VALUES
(1, 23),
(2, 9),
(3, 30),
(4, 54),
(5, 96),
(6, 96),
(7, 54),
(8, 54)

SELECT * FROM transactions

CREATE table transactions

(
	transacstion_id int PRIMARY KEY,
  	visit_id int,
  	amount int
)

INSERT into transactions
VALUES
(2, 5, 1000),
(3, 5,  500),
(9, 5, 800),
(12, 6, 1500),
(13, 3, 2000)

SELECT 
	visits.customer_id, 
	count(visits.visit_id) as number_of_no_transaction
from 
visits
LEFT JOIN transactions on visits.visit_id = transactions.visit_id
where transactions.transacstion_id is NULL
GROUP BY visits.customer_id

-------------------------------------------
--Finding Warmer Weather Days, rising temperature



CREATE TABLE weather
(
	id int ,
  	recordDate date,
  	temperature int
)

SELECT * FROM weather
insert into weather
VALUES

(1, '15.05.2025', 10),
(2, '16.05.2025', 12),
(3, '17.05.2025', 8),
(4, '18.05.2025', 16),
(5, '20.05.2025', 12),
(6, '20.05.2025', 12)


SELECT w1.id
FROM weather as w1
join weather as w2 on (w1.recordDate - w2.recordDate) = 1
WHERE w1.temperature > w2.temperature

--------------------------------------------------------------

-- Average Time of Process per Machinetransactions
from enum import Enum
drop TABLE activity
CREATE TABLE activity

(
	machine_id int NOT NULL,
  	process_id int NOT NULL,
  	activity_type varchar (50) not null,
  	timestamp float NOT NULL,
  	check (activity_type IN ('start','end')),
  	PRIMARY KEY (machine_id, process_id, activity_type)
)

select * from activity

INSERT into activity
VALUES

(0, 0, 'start', 0.712),
(0, 0, 'end', 1.520),
(0, 1, 'start', 3.140),
(0, 1, 'end', 4.120),
(1, 0, 'start',0.550),
(1, 0, 'end', 1.550),
(1, 1, 'start', 0.140),
(1, 1, 'end', 1.120),
(2, 0, 'start', 1.712),
(2, 0, 'end', 3.520),
(2, 1, 'start', 3.140),
(2, 1, 'end', 6.120)

SELECT a1.machine_id, a1.timestamp as start_time, a2.timestamp as end_time
from activity as a1
join activity as a2 
on a1.process_id=a2.process_id
AND a1.machine_id = a2.machine_id
and a1.timestamp < a2.timestamp


SELECT a1.machine_id,
	ROUND(AVG(a2.timestamp - a1.timestamp), 3) as processing_time
from activity as a1
join activity as a2 
on a1.process_id=a2.process_id
AND a1.machine_id = a2.machine_id
and a1.timestamp < a2.timestamp
GROUP by a1.machine_id
