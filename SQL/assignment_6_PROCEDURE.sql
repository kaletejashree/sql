CREATE DATABASE tejashree_assi6_procedure;

USE tejashree_assi6_procedure;

CREATE TABLE Customer(
          CustomerId INT PRIMARY KEY identity(1,1),
		  CustomerName VARCHAR(30),
		  CustomerAddress VARCHAR(30)
);

CREATE TABLE Products(
       ProductID INT PRIMARY KEY,
	   ProductName VARCHAR(30),
	   Price Float
);

CREATE TABLE Orders(
         OrderID INT IDENTITY(901,1) PRIMARY KEY ,
		 CustomerId INT,
		 ProductID INT,
		 Quantity INT,
		 OrderDate DATE,
		 TotalAmount DECIMAL(10,2),
		 CustomerPay DECIMAL(10,2),
		 FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
		 FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);



INSERT INTO Customer VALUES('Tejashree','Baramati'),
                           ('Pooja','Madha'),
						   ('Priti','Solapur'),
						   ('Vaibhav','Khadki'),
						   ('Jayashree','Shirur'),
						   ('Ritesh','Pune'),
						   ('Vaibhavi','Tuljapur'),
						   ('Bhakti','Akluj'),
						   ('Shreenay','Khadki'),
						   ('Prajkta','Pune');

INSERT INTO Products VALUES(101,'Tomato Chips',10),
                           (102,'Choclate',50),
						   (103,'Milk',100),
						   (104,'Book',45),
						   (105,'Notebook',100),
						   (106,'Pen',5),
						   (107,'Colors',120.50),
						   (108,'Dary Milk Cadbury',60),
						   (109,'Corns',10),
						   (110,'Onion Chips',10),
						   (111,'Shoes',300),
                           (112,'Pencil',20),
						   (113,'Bag',1000),
						   (114,'Perfume',500),
						   (115,'Snacks',170),
						   (116,'Soap',670),
						   (117,'BornVita',275),
						   (118,'Oats',98),
						   (119,'Cloths',1250),
						   (120,'Facewash',89);


INSERT INTO Orders VALUES(1, 101, 2, '2024-03-01', 20.00, 20.00),
                         (2, 102, 3, '2024-03-02', 150.00, 150.00),
                         (3, 103, 1, '2024-03-03', 100.00, 90.00),
                         (4, 104, 4, '2024-03-04', 183.16, 100.16),
                         (5, 105, 2, '2024-03-05', 200.00, 300.00),
                         (6, 106, 5, '2024-03-06', 25.00, 26.00),
                         (7, 107, 1, '2024-03-07', 120.50, 110.50),
                         (8, 108, 3, '2024-03-08', 180.00, 150.00),
                         (9, 109, 6, '2024-03-09', 60.00, 90.00),
                         (10, 110, 2, '2024-03-10', 20.00, 10.00),
                         (1, 111, 1, '2024-03-11', 300.00, 270.00),
                         (2, 112, 4, '2024-03-12', 80.00, 65.00),
                         (3, 113, 2, '2024-03-13', 2000.00, 2000.00),
                         (4, 114, 1, '2024-03-14', 500.00, 540.00),
                         (5, 115, 3, '2024-03-15', 510.00, 510.00),
                         (6, 116, 5, '2024-03-16', 3350.00, 3350.00),
                         (7, 117, 1, '2024-03-17', 275.00, 270.00),
                         (8, 118, 2, '2024-03-18', 196.00, 193.00),
                         (9, 119, 3, '2024-03-19', 3750.00, 3750.00),
                         (10, 120, 1, '2024-03-20', 89.00, 70.00);


SELECT * FROM Customer;
SELECT * FROM Products;
SELECT * FROM Orders;



--1.Create a stored procedure called "get_customers" that returns all customers from the "customers" table.

CREATE PROCEDURE get_customers
AS
BEGIN
SELECT * FROM Customer;
END;
EXEC get_customers;

--2.Create a stored procedure called "get_orders" that returns all orders from the "orders" table.
CREATE PROCEDURE get_orders
AS
BEGIN
SELECT * FROM Orders;
END;
EXEC get_orders;

--3.Create a stored procedure called "get_order_details" that accepts an order ID as a parameter and returns the details of that order (i.e., the products and quantities).
CREATE PROCEDURE get_order_details(@OID INT)
AS
BEGIN
SELECT * FROM Orders AS o 
INNER JOIN Products AS p
ON o.ProductID=p.ProductID
WHERE OrderID=@OID;
END;
EXEC get_order_details @OID=904;

--4.Create a stored procedure called "get_customer_orders" that accepts a customer ID as a parameter and returns all orders for that customer.
CREATE PROCEDURE get_customer_orders(@CustID INT)
AS
BEGIN
SELECT * FROM Orders AS o
WHERE o.CustomerId=@CustID;
END;
EXEC get_customer_orders @CustID=10;

--5.Create a stored procedure called "get_order_total" that accepts an order ID as a parameter and returns the total amount of the order.
CREATE PROCEDURE get_order_total(@OID INT)
AS
BEGIN
SELECT OrderId,TotalAmount
FROM Orders
WHERE OrderId=@OID;
END;
EXEC get_order_total @OID=909;

--6.Create a stored procedure called "get_product_list" that returns a list of all products from the "products" table.
CREATE PROCEDURE get_product_list
AS
BEGIN
SELECT * FROM Products;
END;
EXEC get_product_list;


--7.Create a stored procedure called "get_product_info" that accepts a product ID as a parameter and returns the details of that product.
CREATE PROCEDURE get_product_info(@PID INT)
AS
BEGIN
SELECT * FROM Products
WHERE ProductID=@PID;
END;
EXEC get_product_info @PID=119;


--8.Create a stored procedure called "get_customer_info" that accepts a customer ID as a parameter and returns the details of that customer.
CREATE PROCEDURE get_customer_info(@CID INT)
AS
BEGIN
SELECT * FROM Customer
WHERE CustomerId=@CID;
END;
EXEC get_customer_info @CID=10;

--9.Create a stored procedure called "update_customer_info" that accepts a customer ID and new information as parameters and updates the customer's information in the "customers" table.
CREATE PROCEDURE update_customer_info( @CID INT,
                                       @update_name VARCHAR(20),
									   @update_add VARCHAR(30))
AS
BEGIN
    UPDATE Customer
	SET CustomerName=@update_name,
	    CustomerAddress=@update_add
	WHERE CustomerId=@CID;
END;
EXEC update_customer_info @CID=7,@update_name="Jyoti",@update_add="Bhore";



--10.Create a stored procedure called "delete_customer" that accepts a customer ID as a parameter and deletes that customer from the "customers" table.
CREATE PROCEDURE delete_customer(@CID INT)
AS
BEGIN
   DELETE FROM Customer
   WHERE CustomerId=@CID
   SELECT * FROM Customer;
END;
EXEC delete_customer @CID=6;

--11.Create a stored procedure called "get_order_count" that accepts a customer ID as a parameter and returns the number of orders for that customer.
CREATE PROCEDURE get_order_count(@CID INT)
AS 
BEGIN
    SELECT DISTINCT CustomerId,count(OrderID) AS count 
	FROM Orders
	GROUP BY CustomerId
	HAVING CustomerId=@CID
END;
EXEC get_order_count @CID=4;

drop procedure get_order_count
  
--for all customer to see the order
CREATE PROCEDURE get_order_count
AS 
BEGIN
    SELECT DISTINCT CustomerId,count(OrderID) AS count 
	FROM Orders
	GROUP BY CustomerId;
	
END;
EXEC get_order_count;

--12.Create a stored procedure called "get_customer_balance" that accepts a customer ID as a parameter and returns the customer's balance (i.e., the total amount of all orders minus the total amount of all payments).
CREATE PROCEDURE get_customer_balance(@CID INT)
AS 
BEGIN
   DECLARE @Total_order DECIMAL(10,2);
   DECLARE @Total_Payment DECIMAL(10,2);

   --get the sum of total order
   SELECT @Total_order=SUM(TotalAmount)
   FROM Orders
   WHERE CustomerId=@CID;

   --get the sum of total order pay by customer
   SELECT @Total_Payment=SUM(CustomerPay)
   FROM Orders
   WHERE CustomerId=@CID;
   
   --to get balance
   SELECT DISTINCT @Total_order AS TotalAmount ,
                   @Total_Payment AS CustomerPay ,
				   @Total_order-@Total_Payment AS Balance 
   FROM Orders
   WHERE CustomerId=@CID;

END;
EXEC get_customer_balance @CID=4;

--13.Create a stored procedure called "get_customer_payments" that accepts a customer ID as a parameter and returns all payments made by that cust
CREATE PROCEDURE get_customer_payments(@CID INT)
AS 
BEGIN
    SELECT DISTINCT CustomerId,SUM(CustomerPay) AS Payment 
	FROM Orders
	GROUP BY CustomerId
	HAVING CustomerId=@CID;
END;
EXEC get_customer_payments @CID=1;

--14.Create a stored procedure called "add_customer" that accepts a name and address as parameters and adds a new customer to the "customers" table.
CREATE PROCEDURE add_customer( @Cust_Name VARCHAR(30),
                               @Cust_Add VARCHAR(30))
AS
BEGIN
    INSERT INTO Customer VALUES(@Cust_Name,@Cust_Add)
	SELECT * FROM Customer;
END;
EXEC add_customer @Cust_Name="Sanika",@Cust_Add="Daund";


--15.Create a stored procedure called "get_top_products" that returns the top 10 products based on sales volume.
CREATE PROCEDURE get_top_products
AS
BEGIN
   SELECT TOP 10 
          p.ProductID,
		  p.ProductName,
		  SUM(o.Quantity) AS SALES
   FROM Products AS p
   INNER JOIN  Orders AS o
   ON o.ProductID=p.ProductID
   GROUP BY p.ProductID,p.ProductName
   ORDER BY SALES DESC;
END;
EXEC get_top_products;


--16.Create a stored procedure called "get_product_sales" that accepts a product ID as a parameter and returns the total sales volume for that product.
CREATE PROCEDURE get_product_sales(@PID INT)
AS
BEGIN
   SELECT p.ProductID,
		  p.ProductName,
		  SUM(o.Quantity) AS SALES
   FROM Products AS p
   INNER JOIN  Orders AS o
   ON o.ProductID=p.ProductID
   GROUP BY p.ProductID,p.ProductName
   HAVING p.ProductID=@PID;
END;
EXEC get_product_sales @PID=112;

--17.Create a stored procedure called "get_customer_orders_by_date" that accepts a customer ID and date range as parameters and returns all orders for that customer within the specified date range.
CREATE PROCEDURE get_customer_orders_by_date(@CID INT,
                                             @Start_Date DATE,
											 @End_Date DATE)
AS
BEGIN
    SELECT * FROM Orders
	WHERE CustomerId=@CID
	AND OrderDate BETWEEN @Start_Date AND @End_Date
END;

EXEC get_customer_orders_by_date @CID=7,@Start_Date="2024-03-01",@End_Date="2024-03-20" ;



--18.Create a stored procedure called "get_order_details_by_date" that accepts an order ID and date range as parameters and returns the details of that order within the specified date range.
CREATE PROCEDURE get_order_details_by_date(@OID INT,
                                             @Start_Date DATE,
											 @End_Date DATE)
AS
BEGIN
    SELECT * FROM Orders
	WHERE OrderID=@OID
	AND OrderDate BETWEEN @Start_Date AND @End_Date
END;

EXEC get_order_details_by_date @OID=917,@Start_Date="2024-03-01",@End_Date="2024-03-20" ;


--19.Create a stored procedure called "get_product_sales_by_date" that accepts a product ID and date range as parameters and returns the total sales volume for that product within the specified date range.
CREATE PROCEDURE get_product_sales_by_date(  @PID INT,
                                             @Start_Date DATE,
											 @End_Date DATE)
AS
BEGIN
   SELECT
		  SUM(o.Quantity) AS SALES
   FROM  Orders AS o
   WHERE o.ProductID=@PID
   AND o.OrderDate BETWEEN @Start_Date AND @End_Date;
END;

EXEC get_product_sales_by_date @PID=118,@Start_Date="2024-03-01",@End_Date="2024-03-20" ;


--20.Create a stored procedure called "get_customer_balance_by_date" that accepts a customer ID and date range as parameters and returns the customer's balance within the specified date range.
CREATE PROCEDURE get_customer_balance_by_date (@CID INT,
                                               @Start_Date DATE,
											   @End_Date DATE)
AS 
BEGIN
   DECLARE @Total_order DECIMAL(10,2);
   DECLARE @Total_Payment DECIMAL(10,2);

   --get the sum of total order
   SELECT @Total_order=SUM(TotalAmount)
   FROM Orders
   WHERE CustomerId=@CID;

   --get the sum of total order pay by customer
   SELECT @Total_Payment=SUM(CustomerPay)
   FROM Orders
   WHERE CustomerId=@CID;
   
   --to get balance
   SELECT DISTINCT @Total_order AS TotalAmount ,
                   @Total_Payment AS CustomerPay ,
				   @Total_order-@Total_Payment AS Balance 
   FROM Orders
   WHERE CustomerId=@CID
   AND OrderDate BETWEEN @Start_Date AND @End_Date;;
END;
EXEC get_customer_balance_by_date @CID=8,@Start_Date="2024-03-01",@End_Date="2024-03-20";

--21.Create a stored procedure called "add_order" that accepts a customer ID, order date, and total amount as parameters and adds a new order to the "orders" table
CREATE PROCEDURE add_order(@CID INT,
                           @Orderdate DATE,
						   @Totalamount DECIMAL(10, 2))
AS
BEGIN
     INSERT INTO Orders (CustomerId, OrderDate, TotalAmount)
    VALUES (@CID, @Orderdate, @Totalamount)
	SELECT * FROM Orders;
END;
EXEC add_order @CID=2,@Orderdate="2024-03-02",@Totalamount=150;



--22.Create a stored procedure called "update_order_total" that accepts an order ID and a new total amount as parameters and updates the total amount of the order in the "orders" table.
CREATE PROCEDURE update_order_total(@OID INT,
                                    @Totalamount DECIMAL(10, 2))
AS 
BEGIN
     UPDATE Orders
	 SET 
	     TotalAmount=@Totalamount
	WHERE  OrderID=@OID
	SELECT * FROM Orders;
	 
END;
EXEC update_order_total @OID=920,@Totalamount=300;



--23.Create a stored procedure called "delete_order" that accepts an order ID as a parameter and deletes that order from the "orders" table.
CREATE PROCEDURE delete_order(@OID INT)
AS 
BEGIN
    DELETE FROM Orders
	WHERE OrderID=@OID
	SELECT * FROM Orders;
	 
END;
EXEC delete_order @OID=921;


