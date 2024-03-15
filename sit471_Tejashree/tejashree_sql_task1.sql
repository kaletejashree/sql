--create database
create database tejashree_assi1;

--use database
use tejashree_assi1;

--create emp_department table
create table emp_department(
DPT_CODE int primary key ,
DPT_NAME varchar(50),
DPT_ALLOTMENT int);

--insert data into emp_department
insert into emp_department values(57,'IT',65000),
                                 (63,'Finance',15000),
								 (47,'HR',240000),
								 (27,'RD',55000),
								 (89,'QC',75000);
								 

--Display emp_details table
select * from emp_department;


--create emp_detals table
create table emp_details(
EMP_IDNO int primary key,
EMP_FNAME varchar(50),
EMP_LNAME varchar(50),
EMP_DEPT int,
foreign key (EMP_DEPT) references emp_department(DPT_CODE));
 
--insert data into emp_details table
insert into emp_details values(127323,'Michale','Robbin',57),
                              (526689,'Carlos','Snares',63),
							  (843795,'Enric','Dosio',57),
							  (328717,'Jhon','Snares',63),
							  (444527,'Joseph','Dosni',47),
							  (659831,'Zanifer','Emily',47),
							  (847674,'Kuleswar','Sitaraman',57),
							  (748681,'Henrey','Gabriel',47),
							  (555935,'Alex','Manuel',27),
							  (539569,'George','Mardy',57),
							  (733843,'Mario','Saule',63),
							  (631548,'Alan','Snappy',27),
							  (839139,'Maria','Foster',57);


--Display emp_details table
select * from emp_details;

--create table company_mast
create table company_mast( COM_ID int primary key
                          ,COM_NAME varchar(50));
drop table company_mast;
--insert into company_mast
insert into company_mast values(11,'Samsung'),
                               (12,'iBall'),
							   (13,'Epsion'),
							   (14,'Zebronics'),
							   (15,'Asus'),
							   (16,'Frontech');

--Display emp_details table
select * from company_mast;

--create item_mast table
create table item_mast(PRO_ID int primary key,
                       PRO_NAME varchar(50),
					   PRO_PRICE int,
					   PRO_COM int,
					   foreign key (PRO_COM) references company_mast(COM_ID));

--insert data into item_mast

insert into item_mast values(101,'Mother Board',3200,15),
                            (102,'Key Board',450,16),
							(103,'ZIP drive',250,14),
							(104,'Speaker',550,16),
							(105,'Monitor',5000,11),
							(106,'DVD drive',900,12),
							(107,'CD drive',800,12),
							(108,'Printer',2600,13),
							(109,'Refill cartridge',350,13),
							(110,'Mouse',250,12);


--Display item_mast table
select * from item_mast;


--create table salesman

create table salesman(salesman_id int primary key,
                      name varchar(50),
					  city varchar(50),
					  commission decimal(5,2));


 --create table customer
create table customer(customer_id int primary key,
                      cust_name varchar(50),
					  city varchar(50),
					  grade int,
					  salesman_id int,
					  foreign key (salesman_id) references salesman(salesman_id));


--create table orders
create table orders( order_no int primary key,
                     purch_amt float,
					 order_date date,
					 customer_id int,
					 salesman_id int,
					 foreign key (salesman_id) references salesman(salesman_id),
					 foreign key (customer_id) references customer(customer_id));


 --insert into salesman table
 insert into salesman values(5001,'James Hoog','New York',0.15),
                            (5002,'Nail Knite','Paris',0.13),
							(5005,'Pit Alex','London',0.11),
							(5006,'Mc Lyon','Paris',0.14),
							(5007,'Paul Adam','Rome',0.13),
							(5003,'Lauson Hen','San Jose',0.12);

--Display item_mast table
select * from salesman;

--insert into customer table
insert into customer values(3002,'Nick Rimando', 'New York',100,5001),
                            (3007 ,'Brad Davis',' New York',200,5001),
							(3005,'Graham Zusi',' California', 200,5002),
							(3008,'Julian Green','London',300 ,5002),
                           (3004 ,'Fabian Johnson',' Paris',300 ,5006),
                        (3009,'Geoff Cameron','Berlin',100,5003),
                        (3003, 'Jozy Altidor','Moscow',200 ,5007),
                         (3001,'Brad Guzan','London',null, 5005);

--Display customer table
select * from customer;
                      
 --insert into order table
 insert into orders values(70001 ,150.5,' 2012-10-05',3005, 5002),
                          (70009 , 270.65 ,' 2012-09-10' ,3001, 5005),
                          (70002 , 65.26 ,'2012-10-05', 3002, 5001),
                          (70004 , 110.5 ,' 2012-08-17',3009, 5003),
                          (70007 , 948.5  ,' 2012-09-10',3005 ,5002),
                          (70005 , 2400.6 ,'2012-07-27',3007 ,5001),
                          (70008 , 5760 ,' 2012-09-10 ',3002 ,5001),
                          (70010 , 1983.43 ,'2012-10-10',3004 ,5006),
                          (70003 , 2480.4 ,' 2012-10-10',3009 ,5003),
                          (70012 , 250.45 ,' 2012-06-27',3008, 5002),
                          (70011  , 75.29 ,' 2012-08-17',3003, 5007),
                          (70013 , 3045.6 ,' 2012-04-25',3002 ,5001);

--Display orders table
select * from orders;


--1)find the total purchase amount of all orders.
select sum(purch_amt) as total_purchase_amount
from orders;

--2) find the average purchase amount of all orders.
select avg(purch_amt) as average_purchase_amount 
from orders;

--3)find the number of salesmen currently listing for all of their customers
select count(distinct salesman_id) 
from customer;

--4)how many customer have listed their names.
select count(*) as count from customer;

--5)find the number of customers who gets at least a gradation for his/her performance
select count(all grade) as count 
from customer;


--6)get the maximum purchase amount of all the orders
select max(purch_amt) as max_amount
from orders;

--7)get the minimum purchase amount of all the orders
select min(purch_amt) as min_amount 
from orders;

--8)selects the highest grade for each of the cities of the customers. 
select city,max(grade)
from customer
group by city;

--9)find the highest purchase amount ordered by the each customer with their ID and highest purchase amount.  
select max(purch_amt) as amount,customer_id
from orders
group by customer_id
order by max(purch_amt) desc;

--10)find the highest purchase amount ordered by the each customer on a particular date with their ID, order date and highest purchase amount. 
select customer_id,max(purch_amt),order_date
from orders
group by customer_id,order_date;

--11)find the highest purchase amount on a date '2012-08-17' for each salesman with their ID.
select max(purch_amt) as purch_amount,salesman_id
from orders
where order_date='2012-08-17'
group by salesman_id;

--12)find the highest purchase amount with their ID and order date, for only those customers who have highest purchase amount in a day is more than 2000.
select max(purch_amt) as purch_amount,customer_id,order_date
from orders
group by customer_id,order_date
having max(purch_amt)>2000;

--13)find the highest purchase amount with their ID and order date, for those customers who have a higher purchase amount in a day is within the range 2000 and 6000
select max(purch_amt) as purch_amount,customer_id,order_date
from orders
group by customer_id,order_date
having max(purch_amt) between 2000 and 6000;

--14)find the highest purchase amount with their ID and order date, for only those customers who have a higher purchase amount in a day is within the list 2000, 3000, 5760 and 6000.
select max(purch_amt) as purch_amount,customer_id,order_date
from orders
group by customer_id,order_date
having max(purch_amt) in (2000, 3000, 5760,6000);

--15)find the highest purchase amount with their ID, for only those customers whose ID is within the range 3002 and 3007.
select max(purch_amt) as purch_amount,customer_id
from orders
group by customer_id
having customer_id between 3002 and 3007;

--16)display customer details (ID and purchase amount) whose IDs are within the range 3002 and 3007 and highest purchase amount is more than 1000.
select customer_id,max(purch_amt) as purch_amount
from orders 
group by customer_id
having max(purch_amt)>1000 and customer_id between 3002 and 3007;

--17)find the highest purchase amount with their ID, for only those salesmen whose ID is within the range 5003 and 5008.
select max(purch_amt) as purch_amount,salesman_id
from orders
group by salesman_id
having salesman_id between 5003 and 5008;

--18)counts all orders for a date August 17th, 2012.
select count(*) as count
from orders
where order_date='2012-8-17';

--19)count the number of salesmen for whom a city is specified. Note that there may be spaces or no spaces in the city column if no city is specified.
select count(*) as count
from salesman
where city is not null;

--20)counts the number of salesmen with their order date and ID registering orders for each day.
select salesman_id,count(salesman_id) as count,order_date
from orders
group by salesman_id,order_date;

--21)calculate the average price of all the products.
select avg(PRO_PRICE) as avg_price 
from item_mast;

--22)find the number of products with a price more than or equal to Rs.350.
select PRO_ID,PRO_PRICE
from item_mast
where PRO_PRICE>=350;

--23)display the average price of each company's products, along with their code.
select avg(PRO_PRICE) as avg,PRO_COM
from item_mast
group by PRO_COM;

--24)find the sum of the allotment amount of all departments.
select sum(DPT_ALLOTMENT) as sum
from emp_department;

--25)find the number of employees in each department along with the department code.
select count(*) as count,EMP_DEPT
from emp_details
group by EMP_DEPT;