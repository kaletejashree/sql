
create database example;
use example;

create table Student( id int identity(1,1),
first_name varchar(20),
last_name varchar(30),
address varchar(20),
marks int);


insert into Student values('tejashree','kale','baramati',99),('shree','divekar','khadki',89),('ritz','jadhav','varvand',91),('jaya','dhumal','madha',86),('priti','ingale','shirur',97);
select * from Student;

--create view we cannot update,delete and group by ,order by clauses or crud operation perform view is created after that it is possible
create view student_Details as
select * from Student;

--not posible
--create view student_Details as
--insert into student_Details values('jaya','waghachaure','alegaon',86);

select * from student_Details;

drop view student_Details;

update student_Details 
set first_name='pooja' where first_name='jaya';

--insert into student_details
insert into student_Details values('jaya','waghachaure','alegaon',86);

--delete from view
delete from student_Details where first_name='ritz';

--alter view
alter view student_Details as
select first_name,last_name from Student;

sp_helptext student_Details ; --open the view

--nested view
create view details as
select first_name,last_name from student_Details;

select * from details;


--procedure
create procedure procedure_name
as
begin
select * from Student
end;
exec procedure_name;

create procedure procedure_name
as
begin
select * from Student
end;
exec procedure_name;


--alter produre
alter procedure procedure_name
as
begin
select first_name,last_name,address,marks from Student
insert into Student values('vaibhavi','gavali','tuljapur',66)
update Student
set first_name='ritu' where first_name='vaibhav'
delete from Student where first_name='vaibhavi'
--exec procedure_name;
end;
exec procedure_name;


--view inside the procedure
alter procedure procedure_name
as
begin
select first_name,last_name,address,marks from Student
insert into Student values('vaibhavi','gavali','tuljapur',66)
update Student
set first_name='ritu' where first_name='vaibhav'
delete from Student where first_name='vaibhavi'
--exec procedure_name;
select * from student_Details;
end;
exec procedure_name;


sp_helptext procedure_name;  --open the procedure
select * from sys.objects where type='u';
select * from sys.objects where type='v';   --give all the view in the query
select * from sys.objects where type='p';   --give all the procedure in the query



