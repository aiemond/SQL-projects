create TABLE Products
(	
  pruduct_id int primary key,
  low_fats varchar (20),
  recyclable varchar (20)
)

insert into Products 
VALUES
(4, 'Y', 'Y'),
(5, 'N','Y')

select * from Products

SELECT pruduct_id
from Products
where low_fats ='Y' and recyclable ='Y'

--------------------------------------------------------------------------------

create table customer
(
	id int primary key,
  	name varchar (30),
  	refree_id INT
)
insert into customer
VALUES
(1, 'emon', 1),
(2, 'ara', 2),
(3, 'ropa', 2),
(4, 'hasan', 2),
(5, 'mahmud', 1),
(6 , 'rosa', 4)

insert into customer 
VALUES
(7, 'julo', 5)

select * from customer

SELECT name
from customer
where refree_id != 2

------------------------------------------------------------------

create TABLE worldranks
(
  name varchar (30),
  continent varchar (30),
  area int,
  population int,
  gdp bigint
)

INSERT into worldranks
VALUES

('Bangladesh', 'Asia', 3000000,  25000000, 20343000000),
('Nepal', 'Asia', 300000,  250000, 20343000),
('Germany', 'Europe', 43000000,  125000000, 5620343000000),
('UK', 'Europe', 300000,  15000000, 2343000000),
('Canada', 'NorthA', 1000000,  2500000, 203000000),
('USA', 'NorthA', 123000000,  24525000000, 5620343000000)

update worldranks set population = 5000 where name = 'USA'

DELETE 
FROM worldranks 
WHERE name = 'Canada'


select * from worldranks

select name, area, population
FROM worldranks
where area >=3000000 or population >=250000

---------------------------------------------------------------------------
create table authors
(
	article_id int,
  	author_id int,
  	viewer_id int,
  	view_date date
)

INSERT into authors
VALUES
(1, 10, 20, '1.2.2025'),
(2, 13, 13, '3.3.2025'),
(2, 16, 20, '1.4.2025'),
(3, 12, 12, '7.3.2025'),
(4, 11, 11, '1.5.2025'),
(4, 19, 20, '23.1.2025')

select * from authors
update authors set author_id = 12 , viewer_id=12 where article_id=1
update authors set author_id = 17 , viewer_id=19 where article_id=2

SELECT author_id as ID
from authors
where author_id = viewer_id
order by author_id -- order by id asc

-------------------------------------------------------------------------
drop table tweets
create table tweets
(
	tweet_id int not null PRIMARY KEY,
  	content varchar (50)
)

insert into tweets
VALUES
(100, 'I love my country.'),
(101, 'I love my country and football club.'),
(102, 'I love my name.'),
(103, 'I love my country and its language.'),
(104, 'I love u.')

select * from tweets

SELECT tweet_id, content
FROM tweets
where length (content) > 15
