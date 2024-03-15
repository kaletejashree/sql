-- create database
create database student1;

--create database if not exist give warning
--create database student1 if not exists student1;

create database student2;
create database student3;

--drop data base
drop database student2;
drop database student3;

--also drop database if exist
drop database if exists student2;

--use database
use student1;

--create table
create table student1_info(
id int primary key,
name varchar(20),
age int not null);

--insert values into the table **string is written in single quotes
insert into student1_info values(1,'tej',22)
insert into student1_info values(2,'shree',1),(3,'vaibh',30),(4,'jo',25),(5,'rik',23);

--to display the all rows in table
select * from student1_info;

--show databases;not working in that
--show tables;

--drop the table-delete all stucture
drop table student1_info;

use student1;
create table student(
roll_no int primary key,
name varchar(50),);

--select DQL query
select * from student;
select roll_no from student;  --select particular column from the table

--insert the values into the table
insert into student values(101,'teju'),(102,'shreenu'),(103,'ritu'),(104,'praju'),(105,'vaibhu');

select * from student;

-- practice question1- create company database of xyz, create employee table to strore employee info, select and view your data
create database employee_details;
use employee_details;
create table emp_info(
id int primary key,
name varchar(50),
salary int);
insert into emp_info values(1,'adam',25000),(2,'bob',30000),(3,'casey',40000);
select * from emp_info;


--primary key is unique and not null,only one,
--foreign key -refer to the primary key-is multiple and can be null and duplicate repeated values are allowed-link table

--constraints -specific rule
--1)not null-value are not null       2)unique-all the values in col is different 3)primary key 4)foreign key 5)default- set default value to column -salary int default 25000 6)check-limit values in column

--unique value
create table temp1(
id int unique);

insert into temp1 values(101);
insert into temp1 values(101);      --due to unique key we cannot insert duplicate value

--default key constraint
create table emp(
id int,
salary int default 25000);
insert into emp(id) values(101);
select * from emp;    --by default salary is 25000 is written if value is not give it will written 25000

--check constraints
--create table newtab(age int check(age>=18));


--new database college
create database college;
use college;
create table stud(
roll_no int primary key,
name varchar(50),
marks int not null,
grade varchar(1),
city varchar(20));

insert into stud(roll_no,name,marks,grade,city) values(101,'anil',78,'c','pune'),
(102,'bhumika',93,'a','mumbai'),(103,'chetan',85,'b','mumbai'),(104,'dhruv',96,'a','delhi'),(105,'emul',12,'f','delhi'),(106,'farah',82,'b','delhi');
select * from stud;
select name,marks from stud;

--distinct keyword -show unique value not give duplicate value
select distinct city from stud;


--clauses:condition
--1)where :condition

select * from stud 
where marks>80 and city='mumbai';

select * from stud 
where city='mumbai';

select * from stud 
where marks>80 or city='mumbai';

--between:range
select * from stud 
where marks between 80 and 90;

--in:match any value in list
select * from stud 
where city in('pune','mumbai');

--not in:give the  value not in list
select * from stud 
where city not in('pune','mumbai');

/*limit
select * from stud 
where limit 2;*/


--order by -ascending or descinding
select * from stud 
order by city asc;

select * from stud 
order by roll_no desc;

--print top 3 student marks in class
select * from stud
order by marks desc
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY;

--aggregate function
--max(),count(),min(),sum(),avg()
select max(marks) from stud;
select min(marks) from stud;
select count(roll_no) from stud;
select sum(marks) from stud;
select avg(marks) from stud;


-- group by clause:generally use aggregate funnction
--1) count number of student in each city
select count(roll_no),city from stud 
group by city;


--2)find avg marks in each city in ascending order
select avg(marks),city from stud
group by city
order by city;

--3)count each grade
select grade,count(roll_no) from stud
group by grade;

--having clause:same as where applies condition on row but having applies condition on group
--1)count number of student in each city where max marks cross 90
select count(roll_no),city from stud
group by city
having max(marks)>90;

/* general order

select colunms
form table_name
where condition
group by columns
having condition
order by columns asc/desc

*/

--table related quries
--1)updte -update existing row
update stud
set grade='o'
where grade='a';
select *from stud;

update stud
set marks=83
where marks=12;
select *from stud;

update stud
set grade='b'
where marks between 80 and 90;
select *from stud;

update stud
set grade='a'
where marks between 90 and 100;
select *from stud;


update stud 
set marks=12
where roll_no=106;


--delete existing row
delete from stud where marks=12;

--forign key
create table dept(
id int primary key,
name varchar(50),
);

insert into dept values(101,'tej'),(102,'rits');
select * from dept;
update dept
set id=104
where id=101;

create table teacher(
id int primary key,
name varchar(30),
dept_id int,
foreign key (dept_id) references dept(id)
on delete cascade
on update cascade);

drop table teacher;
select * from teacher;
insert into teacher values(101,'comp',101),(102,'civil',102);

--cascad if we change name,value in one table it reflect another table in foreign key


--alter
create table stud1(
roll_no int primary key,
name varchar(50),
marks int not null,
grade varchar(1),
city varchar(20));


insert into stud1(roll_no,name,marks,grade,city) values(101,'anil',78,'c','pune'),
(102,'bhumika',93,'a','mumbai'),(103,'chetan',85,'b','mumbai'),(104,'dhruv',96,'a','delhi'),(105,'emul',12,'f','delhi'),(106,'farah',82,'b','delhi');
select * from stud1;
select name,marks from stud1;

--add column
alter table stud1
add address varchar(50);

--drop column
alter table stud1
drop column address;

alter table stud1
add age int not null default 19;

--modify age into varchar
/*alter table stud1
modify column age varchar(2);*/

--change datatype of column
/*alter table stud1
change age stud_age int;*/

--truncate :delete the data inside the table
truncate table stud1;

--joins-combine the rows from two or more tables,based on related column between them

--inner join:intersection -matching values in both the table
create table subject(
id int primary key,
sub_name varchar(50));

insert into subject values(101,'dbms'),(102,'cns');

select * from subject;

create table course(
id int primary key,
course_name varchar(50),
price int
);

insert into course values(101,'comp',40000),(102,'entc',5000);
select * from course;

select * from 
subject inner join course
on subject.id=course.id;

/*select * from 
subject as s inner join course as c
on s.id=c.id;*/

--left join-all records from left table and match record from right table

insert into subject values(103,'dbms'),(104,'cns');
insert into course values(103,'comp',40000),(105,'entc',5000),(106,'entc',5000);
select * from 
subject left join course
on subject.id=course.id;


--right join-all records from right table and match record from left table
select * from 
subject right join course
on subject.id=course.id;

--full join-combine left and right table union
select * from 
subject left join course
on subject.id=course.id
union
select * from 
subject right join course
on subject.id=course.id;

--right exclusive join- records from right table except matching   same for left exclusive join
select * from 
subject right join course
on subject.id=course.id
where subject.id is null;

---self join :join the table with itself
select * from 
subject as a join subject as b
on a.id=b.id;

--subquery :query inside another query
/*
syntax 
select col
from table_name 
where col_name operator
(subqury);
*/

create table stud2(
roll_no int primary key,
name varchar(50),
marks int not null,
grade varchar(1),
city varchar(20));


insert into stud2(roll_no,name,marks,grade,city) values(101,'anil',78,'c','pune'),
(102,'bhumika',93,'a','mumbai'),(103,'chetan',85,'b','mumbai'),(104,'dhruv',96,'a','delhi'),(105,'emul',12,'f','delhi'),(106,'farah',82,'b','delhi');
select * from stud2;
select name,marks from stud2;

select avg(marks)
from stud2;

select name,marks
from stud2
where marks>80;

--combine both query to get subquery
select name,marks
from stud2
where marks >(select avg(marks)
from stud2);

--select student of even roll no
select roll_no
from stud2
where roll_no%2=0;

select roll_no,name 
from stud2
where roll_no in(102,104,106);

--combine
select roll_no,name 
from stud2
where roll_no in(
select roll_no
from stud2
where roll_no%2=0);


/* --------------------------------------------------------------------practice---------------------------------------------------------------*/

use employee_details;
create table stud1(
id int primary key,
name varchar(50),
age int,
marks float,
address varchar(50));

drop table stud1;

insert into stud1 values(1,'tejashree',22,99,'mumbai'),(2,'shreenay',1,100,'mumbai'),(3,'vaibhav',30,88,'pune'),(4,'praju',29,80,'delhi'),(5,'pranay',50,12,'pune');
select * from stud1;
select id,marks from stud1;

-- aggregate function

select sum(marks) as sum from stud1;
select avg(marks) as avg from stud1;
select max(marks) as max from stud1;
select min(marks) as min from stud1;
select count(id) as count from stud1;

--alter
--drop column
alter table stud1
drop column address;

--add the column
alter table stud1
add address varchar(50);

--update the function
update stud1
set address='pune';

--clauses
--1) where

select * from stud1 where marks>90;
select * from stud1 where address in('pune','delhi');
select * from stud1 where address not in('pune','delhi');
select * from stud1 where age between 30 and 60;
select * from stud1 where age>30 and age<60;

--distinct
select  distinct address,name from stud1;

--order by
select * from stud1
order by marks desc;

--select top three marks student
select *from stud1
order by marks desc
offset 0 rows fetch first 3 rows only;

select * from stud1
order by id asc;

--group by clause-group the rows based on columns
select count(id) as count,address
from stud1 
group by address;

select avg(marks) as avg_marks,
address from stud1
group by address
order by avg(marks) desc;

-- having clauses

select count(id),address from stud1
group by address
having avg(marks)>90 and count(id)>=2;

--like
select * from stud1
where name like 'p_%';

--select the student names ends with shree
select * from stud1
where name like '%[shree]';

select * from stud1
where address like '_umbai';

--joins

create table A_table(
roll_no int primary key,
name varchar(50));

insert into A_table values(101,'tej'),(102,'teja'),(103,'teju'),(106,'shree');

select * from A_table;

create table B_table(
roll_no int primary key,
address varchar(50),
age  int);

insert into B_table values(101,'delhi',22),(103,'delhi',24),(104,'pune',18),(105,'hydrabad',12),(107,'mumbai',55);

select * from B_table;

--inner join-intersection of both the table
select * from 
A_table as a
inner join B_table as b
on a.roll_no=b.roll_no;

--left join
select * from
A_table as a
left join B_table as b
on a.roll_no=b.roll_no;

--right join
select * from
A_table as a
right join B_table as b
on a.roll_no=b.roll_no;

--self join
select * from
A_table as a join A_table as b
on a.roll_no=b.roll_no;

--autoincrement-automatically incremented id no need to insert the values
create table st(id int identity(1,1) primary key,age int);
insert into st values(22),(23);
select * from st;


--view-contain virtual table
/*syntax-
create view view_name as
select col from table
where condition*/

create table st1(id int primary key,name varchar(20),age int);

insert into st1 values(1,'teju',22),(2,'tej',12),(3,'teja',32);

select * from st1;

create view st1_view as
select id,name from st1 where age>12;

select * from st1_view;
drop view st1_view;
--insert values into view
insert into st1_view(id,name,age) values(4,'rits',18),(5,'shree',1);

--index fastest retrival of data
create index idx
on st1(id);

--drop index
drop index idx on st1;
select * from st1 where id=2;


---------------------------------------------------
create table Atable(
roll_no int primary key,
name varchar(50));

insert into Atable values(101,'tej'),(102,'teja'),(103,'teju'),(106,'shree');

select * from Atable;

create table Btable(
roll_no int primary key,
address varchar(50),
age  int);

insert into Btable values(101,'delhi',22),(103,'delhi',24),(104,'pune',18),(105,'hydrabad',12),(107,'mumbai',55);

select * from Btable;

select * from Atable as a inner join Btable as b
on a.roll_no=b.roll_no;

select * from Atable as a left join Btable as b
on  a.roll_no=b.roll_no;


select * from Atable as a right join Btable as b
on  a.roll_no=b.roll_no;

create index id_index
on Atable(roll_no);

select * from Atable where roll_no=101;

drop index id_index on Atable;

create view Atable_Btable_view as
select name,address from Atable,Btable;

select * from Atable_Btable_view;