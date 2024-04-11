CREATE DATABASE TK

USE TK

CREATE TABLE Category_Master(
      CatrgoryId INT IDENTITY(1,1) PRIMARY KEY,
	  CategoryName VARCHAR(40) NOT NULL,
	  CategoryDesc VARCHAR(50) NOT NULL,
	  IsActive VARCHAR(20) NOT NULL,
	  CreatedDate DATE NOT NULL
)

CREATE TABLE ItemMaster(
     ItemId INT IDENTITY(101,1) PRIMARY KEY,
	 CatrgoryId INT,
	 Itemname VARCHAR(30) NOT NULL,
	 ItemDescription VARCHAR(40) NOT NULL,
	 Price INT NOT NULL,
	 GST DECIMAL(10,2) NOT NULL,
	 IsActive VARCHAR(20) NOT NULL,
	 CreatedDate DATE NOT NULL,
	 FOREIGN KEY(CatrgoryId) REFERENCES Category_Master(CatrgoryId)
)

CREATE TABLE CouponMaster(
      CouponId INT IDENTITY(201,1) PRIMARY KEY,
      CouponText VARCHAR(40) NOT NULL,
      DiscountPercentage DECIMAL(10,2) NOT NULL,
      ExpiryDate DATE NOT NULL
)

CREATE TABLE OrderMaster(
      OrderId INT IDENTITY(301,1) PRIMARY KEY,
      Deliverycharge DECIMAL(10,2) NOT NULL,
      CouponAmount DECIMAL(10,2) NOT NULL,
      Subtotal DECIMAL(10,2) NOT NULL,
      Total DECIMAL(10,2) NOT NULL,
      Orderdate DATE NOT NULL

)

CREATE TABLE Orderdetails(
     OrderDetailsId INT IDENTITY(401,1) PRIMARY KEY,
     OrderId INT,
     ItemId INT,
     Quantity INT NOT NULL,
     Total INT NOT NULL,
	 FOREIGN KEY(OrderId) REFERENCES OrderMaster(OrderId),
	 FOREIGN KEY(ItemId) REFERENCES ItemMaster(ItemId),
)

CREATE PROCEDURE InsertCategory
AS
BEGIN
    INSERT INTO Category_Master VALUES('Study','Education','active','2024-12-11'),
	                                  ('Sport','Playing','not active','2023-05-09'),
									  ('Vegetable','Cooking','active','2022-04-03');
	SELECT TOP 3 CategoryName,CategoryDesc,IsActive,CreatedDate FROM Category_Master;
END

EXEC InsertCategory;

CREATE PROCEDURE InsertItemMaster
AS 
BEGIN
    INSERT INTO ItemMaster VALUES(1,'pen','writing',1000,120.2,'active','2024-12-11'),
	                      (2,'Bat','Game',6000,220.99,'not active','2023-05-09'),
						  (3,'Palak','Food',8000,590.10,'active','2022-04-03');
	SELECT TOP 3 ItemId,CatrgoryId,Itemname,ItemDescription,Price,Gst,IsActive,CreatedDate FROM ItemMaster;
END
EXEC InsertItemMaster;

ALTER PROCEDURE InsertCouponMaster
AS
BEGIN
    INSERT INTO CouponMaster VALUES('Discount',10.2,'2024-05-15'),
	                                ('Profit',20.2,'2026-12-15'),
									('Scratch',50.00,'2028-01-04');
	SELECT TOP 3 CouponId ,CouponText,DiscountPercentage ,ExpiryDate FROM CouponMaster;
END

EXEC InsertCouponMaster;


ALTER PROCEDURE ProcessOrder( @ItemId INT,
                               @Quantity INT,
							   @CuponId INT)
AS
BEGIN
  DECLARE @isactive VARCHAR(30)
   DECLARE @Cateisactive VARCHAR(20)

  --FOR ITEM ACTIVE OR NOT
  SELECT @isactive=IsActive 
  FROM ItemMaster
  WHERE ItemId=@ItemId;

 IF @isactive!='active'
    BEGIN
	  PRINT 'Item is not available'
	END
 ELSE
    BEGIN
      
        PRINT 'Order processed successfully'
    END

 --FOR CATEGORY ACTIVE OR NOT

  SELECT @Cateisactive=IsActive 
  FROM Category_Master;

 IF @Cateisactive!='active'
    BEGIN
	  PRINT 'category is not avaiable'
	END
 ELSE
    BEGIN
      
        PRINT 'Category Order processed successfully'
    END

--create total amount based on quantity
   DECLARE @TotalItemAmount DECIMAL(10, 2)
    DECLARE @DeliveryCharge DECIMAL(10, 2)
    DECLARE @Discount DECIMAL(10, 2)

--calculate the total item amount based on the quantity.
	SELECT @TotalItemAmount=CalculateTotal( @ItemId,@Quantity);

--total item amount add delivery charges to that amount
	IF @TotalItemAmount>1000
	   SET @DeliveryCharge=0
	ELSE IF @TotalItemAmount BETWEEN 500 AND 1000
	   SET @DeliveryCharge=50
	ELSE 
	   SET @DeliveryCharge=80

 -- Check for coupon and calculate discount
    IF @CouponId IS NOT NULL
    BEGIN
        IF EXISTS (SELECT 1 FROM CouponMaster WHERE CouponId = @CouponId AND ExpiryDate >= GETDATE())
        BEGIN
            SELECT @Discount = DiscountPercentage FROM CouponMaster WHERE CouponId = @CouponId
            SET @TotalItemAmount = @TotalItemAmount - (@TotalItemAmount * @Discount / 100)
        END
    END

    -- Calculate total order amount
    DECLARE @Total DECIMAL(10, 2)
    SET @Total = @TotalItemAmount + @DeliveryCharge

    -- Insert into OrderMaster
    INSERT INTO OrderMaster (Deliverycharge, CouponAmount, Subtotal, Total, Orderdate)
    VALUES (@DeliveryCharge, @Discount, @TotalItemAmount, @Total, GETDATE())

    -- Insert into OrderDetails
    DECLARE @OrderId INT
    SET @OrderId = SCOPE_IDENTITY()

    INSERT INTO Orderdetails (OrderId, ItemId, Quantity, Total)
    VALUES (@OrderId, @ItemId, @Quantity, @TotalItemAmount)

    -- Select order and order details
    SELECT * FROM OrderMaster WHERE OrderId = @OrderId
    SELECT * FROM Orderdetails WHERE OrderId = @OrderId
END




CREATE FUNCTION CalculateTotal(
              @ItemId INT,
              @Quantity INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
   DECLARE @Price INT
   DECLARE @TOTAL DECIMAL(10,2)

   SELECT @Price=Price 
   FROM ItemMaster
   WHERE ItemId=@ItemId;

   SET @TOTAL=Price*Quantity;
   RETURN @TOTAL;
END


EXEC ProcessOrder @ItemId=101,@Quantity=2,@CuponId=301;
SELECT *FROM OrderMaster














