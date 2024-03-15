create database tejashree_assi2_joins;

use tejashree_assi2_joins;

create table Employees(
EmployeeID int primary key identity(1,1),
LastName varchar(50),
FirstName varchar(50),
Title varchar(50),
BirthDate date,
HireDate date,
ReportsTo int,
Address varchar(50),
foreign key (ReportsTo) references Employees(EmployeeID)
);

drop table Employees;

create table Orders(
OrderID int primary key,
CustomerID int,
EmployeeID int,
OrderDate date,
foreign key (CustomerID) references Customers(CustomerID),
foreign key (EmployeeID) references Employees(EmployeeID));

drop table Orders;

create table Customers(
CustomerID int primary key identity(1,1),
CompanyName varchar(50),
ContactName varchar(50),
ContactTitle varchar(50),
Address varchar(50),
City varchar(50),
Country varchar(50));

drop table Customers;

insert into Employees values('kale','tejashree','Developer','2002-01-04','2024-02-01',1,'Mumbai'),
                            ('shinde','jyoti','.Net','2000-11-11','2024-02-01',2,'USA'),
							('jadhav','aishwarya','HR','1999-09-23','2023-05-01',3,'Pune'),
							('gade','prathmesh','Developer','2005-12-30','2020-12-12',4,'USA'),
							('dhumal','pooja','junior','2002-09-12','2024-03-01',5,'USA'),
							 ('kale', 'shree', 'Manager', '2024-02-01', NULL, 6, 'Mumbai');
    

select * from Employees;

insert into Customers values('tcs','abc','application','pune','karadi','maharashtra'),
                            ('shaligram','xyz','query','mumbai','hinjawadi','USA'),
							('tcs','pqr','application','pune','baner','ahemdabad'),
							('acdemor','xuv','query','thane','karadi','maharashtra'),
							('Digvi','stu','contact','nashik','it park','USA'),
							('infosys','vwx','application','banglore','corporate','USA'),
							('persistence','gfe','contact','thane','wagholi','Mumbai');


select * from Customers;

insert into Orders values(1,2,3,'2024-03-03'),(2,1,4,'2024-02-01'),(3,4,1,'2024-03-03'),(4,3,2,'2024-03-03');

select * from Orders;


--1)retrieve the list of all orders made by customers in the "USA".
select Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate ,Customers.Country from Orders inner join Customers
on Orders.CustomerID=Customers.CustomerID
where Customers.Country='USA';


--2)list of all customers who have placed an order.
select * from Customers 
inner join Orders
on Customers.CustomerID=Orders.CustomerID;

--3)list of all employees who have not yet placed an order.
select Employees.EmployeeID,Employees.LastName,Employees.FirstName,Employees.Title,Employees.BirthDate,Employees.HireDate,Employees.ReportsTo,Employees.Address
from Employees left join Orders 
on Employees.EmployeeID=Orders.EmployeeID
where Orders.OrderID is NULL;

--4)list of all employees who have placed an order.
select Employees.EmployeeID,Employees.LastName,Employees.FirstName,Employees.Title,Employees.BirthDate,Employees.HireDate,Employees.ReportsTo,Employees.Address
from Employees inner join Orders 
on Employees.EmployeeID=Orders.EmployeeID;

--5)list of all customers who have not yet placed an order.
select Customers.CustomerID,Customers.CompanyName,Customers.ContactName,Customers.ContactTitle,Customers.Address,Customers.City,Customers.Country 
from Customers left join Orders
on Customers.CustomerID=Orders.CustomerID
where Orders.orderID is NULL;

--6)list of all customers who have placed an order, along with the order date.
select Customers.CustomerID,Customers.CompanyName,Customers.ContactName,Customers.ContactTitle,Customers.Address,Customers.City,Customers.Country,Orders.OrderDate
from Customers inner join Orders
on Customers.CustomerID=Orders.OrderID;

--7)list of all orders placed by a particular customer.
select Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate from Orders inner join Customers
on Orders.CustomerID=Customers.CustomerID
where Customers.CustomerID=3;


--8)list of all orders placed by a particular employee.
select Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate from Orders inner join Employees
on Orders.OrderID=Employees.EmployeeID
where Employees.EmployeeID=2;


--9)all orders placed by a particular customer on a particular date.
select count(Orders.OrderID) as count,Customers.CustomerID,Orders.OrderDate
from Orders inner join Customers
on Orders.OrderID=Customers.CustomerID
group by Customers.CustomerID,Orders.OrderDate
having  Orders.OrderDate = '2024-02-01';

--10)list of all customers who have not yet placed an order, sorted by their country.
select Customers.CustomerID,Customers.CompanyName,Customers.ContactName,Customers.ContactTitle,Customers.Address,Customers.City,Customers.Country
 from Customers left join Orders on Customers.CustomerID=Orders.CustomerID
where Orders.OrderID is NULL
order by country asc;

--11)list of all orders placed by customers in the "USA", sorted by order date.
select Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate,Customers.Country
from Orders inner join Customers
on Orders.OrderID =Customers.CustomerID
where Customers.Country='USA'
order by OrderDate;


--12)list of all employees who have not yet placed an order, sorted by last name.
select Employees.EmployeeID,Employees.LastName,Employees.FirstName,Employees.Title,Employees.BirthDate,Employees.HireDate,Employees.ReportsTo,Employees.Address
from Employees inner join Orders
on Employees.EmployeeID=Orders.OrderId
where Orders.OrderID is Null
order by Employees.LastName asc;

--13)list of all customers who have placed an order, sorted by their company name.
select Customers.CustomerID,Customers.CompanyName,Customers.ContactName,Customers.ContactTitle,Customers.Address,Customers.City,Customers.Country
 from Customers left join Orders on Customers.CustomerID=Orders.CustomerID
order by Customers.CompanyName asc;

--14)list of all employees who have placed an order, sorted by their hire date.
select Employees.EmployeeID,Employees.LastName,Employees.FirstName,Employees.Title,Employees.BirthDate,Employees.HireDate,Employees.ReportsTo,Employees.Address
from Employees inner join Orders
on Employees.EmployeeID=Orders.EmployeeID
order by Employees.HireDate asc;

--15)list of all customers who have placed an order on a particular date, sorted by their company name.
select Customers.CustomerID,Customers.CompanyName,Customers.ContactName,Customers.ContactTitle,Customers.Address,Customers.City,Customers.Country
 from Customers left join Orders on Customers.CustomerID=Orders.CustomerID
 where  Orders.OrderDate = '2024-02-01'
order by Customers.CompanyName asc;

--16)list of all customers who have placed an order, along with the employee who handled the order.
select Customers.CustomerID,Customers.CompanyName,Customers.ContactName,Customers.ContactTitle,Customers.Address,Customers.City,Customers.Country,Employees.EmployeeID,Orders.CustomerID
 from Customers inner join Orders 
 on Customers.CustomerID=Orders.CustomerID
 inner join Employees 
 on Employees.EmployeeID=Orders.EmployeeID;

--17)list of all employees who have placed an order, along with the customer who placed the order.
select Employees.EmployeeID,Employees.LastName,Employees.FirstName,Employees.Title,Employees.BirthDate,Employees.HireDate,Employees.ReportsTo,Employees.Address
from Employees inner join Orders
on Employees.EmployeeID=Orders.EmployeeID
inner join Customers
on Customers.CustomerID=Employees.EmployeeID;

--18)list of all orders placed by customers in a particular country, along with the customer name and order date.
select Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate,Customers.CompanyName,Customers.Country
from Orders inner join Customers
on Orders.CustomerID =Customers.CustomerID
where Country='USA';

--19)list of all orders placed by employees who were born in a particular year, along with the employee name and order date.
select Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate,Employees.FirstName
from Orders inner join Employees
on Orders.EmployeeID =Employees.EmployeeID
where Employees.BirthDate='2002-01-04';

--19)list of all customers who have placed an order, along with the customer name, order date, and employee who handled the order.
select Customers.CustomerID,Customers.CompanyName,Employees.EmployeeID,Orders.OrderDate
 from Customers inner join Orders 
 on Customers.CustomerID=Orders.CustomerID
 inner join Employees 
 on Employees.EmployeeID=Orders.EmployeeID;

 --20)list of all orders placed by customers who have a particular contact title, along with the customer name and order date.
 select Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate,Customers.ContactTitle,Customers.ContactTitle
 from Orders inner join Customers
 on Orders.CustomerID=Customers.CustomerID
 where Customers.ContactTitle='application';

 --21)list of all orders placed by employees who have a particular job title, along with the employee name and order date.
 select Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate,Employees.FirstName
 from Orders inner join Employees
 on Orders.EmployeeID=Employees.EmployeeID
 where Employees.Title='Developer';

 --22)list of all customers who have placed an order on a particular date, along with the customer name, order date, and employee who handled the order.
 select Customers.CustomerID,Customers.CompanyName,Customers.ContactName,Customers.ContactTitle,Customers.Address,Customers.City,Customers.Country,Employees.EmployeeID,Orders.OrderDate
 from Customers inner join Orders 
 on Customers.CustomerID=Orders.CustomerID
 inner join Employees 
 on Employees.EmployeeID=Orders.EmployeeID
 where Orders.OrderDate='2024-03-03';

 --23)list of all orders placed by customers in a particular city, along with the customer name and order date.
 select Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate,Customers.ContactName
 from Orders inner join Customers
 on Orders.CustomerID=Customers.CustomerID
 where city='karadi';

 --24)list of all orders placed by employees who were born in a particular city, along with the employee name and order date.
 select Orders.OrderID,Orders.CustomerID,Orders.EmployeeID,Orders.OrderDate,Employees.FirstName
 from Orders inner join Employees
 on Orders.EmployeeID=Employees.EmployeeID
 where Address='Mumbai';

 --25)list of all customers who have placed an order, along with the customer name, order date, and employee who handled the order, sorted by order date.
 select Orders.OrderDate,Customers.ContactTitle,Employees.EmployeeID
 from Customers inner join Orders
 on Customers.CustomerID=Orders.CustomerID
 inner join Employees
 on Employees.EmployeeID=Orders.EmployeeID
 order by Orders.OrderDate asc;
 
 --26)list of all orders placed by customers in a particular country, along with the customer name and order date, sorted by order date.
 select Orders.OrderID,Orders.OrderDate,Customers.ContactTitle
 from Orders inner join Customers
 on Orders.CustomerID=Customers.CustomerID
 where Customers.Country='USA'
 order by Orders.OrderDate asc;
