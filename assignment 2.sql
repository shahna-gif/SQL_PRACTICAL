#Q1. Create the table Customer:
create database customer_dtls1;
use customer_dtls1;
create table customer
(CustomerID INT AUTO_INCREMENT PRIMARY KEY,
FullName VARCHAR (20) NOT NULL,
Email VARCHAR(30) UNIQUE NOT NULL,
Phone varchar(10) UNIQUE,
Age INT CHECK (Age>=18),
City VARCHAR(20) DEFAULT 'Kochi');
select * from customer;

#Q2. Create the table Product:
USE customer_dtls1;
create table Product
(ProductID INT PRIMARY KEY AUTO_INCREMENT,
ProductName VARCHAR(20) NOT NULL,
SerialNumber INT UNIQUE,
Brand VARCHAR(20) DEFAULT 'Dell', 
Price INT CHECK (Price > 0), 
StockQty INT CHECK (StockQty >= 0));
select * from product;


#Q5. Insert at least 5 customers and 5 products (for example: Laptop/HP/55000, Mouse/Logitech/1200,
#Keyboard/Dell/2500). Include one customer with no City and one product with no Brand, so the
#DEFAULT values apply. Show the result using SELECT.

INSERT INTO customer(FullName,Email,Phone,Age,City)
values
('Arun',  'arun@gmail.com', '2345678766', 23,'Kochi'),
('Anjali',  'anjali@gmail.com', '2987456231', 67, 'Calicut'),
('Rahul', 'rahul@gmail.com','4563456674', 70,'thrisur'),
('Appu', 'appu@gmail.com','6787678978' , 55, 'Kochi'),
('babitha','babitha@gmail.com','6780934525',  67, 'Calicut');

INSERT INTO Product(ProductName, SerialNumber, Brand, Price, StockQty)
VALUES
('Laptop', 101, 'HP', 55000, 10),
('Mouse', 102, 'Logitech', 1200, 20),
('Keyboard', 103, 'Dell', 2500, 15),
('Monitor', 104, 'Samsung', 15000, 8),
('Printer', 105, DEFAULT, 12000, 5);

SELEct * from product;

#QUS-3
use customer_dtls1;
create table salesorder
(orderID INT auto_increment PRIMARY KEY,
CustomerID INT NOT NULL,
OrderDate DATE NOT NULL default (current_date),
Status VARCHAR(15) NOT NULL DEFAULT 'pending'
CHECK (Status IN('Pending','Shipped','Delivered','Cancelled')),
foreign key (CustomerID) references customer(customerID)
ON DELETE cascade);
SELECT * FROM salesorder;

create table orderitem
(OrderID INT,
ProductID INT,
Quantity INT CHECK (Quantity>0),
UnitPrice DECIMAL(10,2) CHECK (UnitPRICE > 0),
PRIMARY KEY (OrderID, ProductID),
FOREIGN KEY (OrderID) REFERENCES SalesOrder(OrderID) ON DELETE CASCADE,
FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE RESTRICT);
SELECT * FROM orderitem;

#Qus-4
Alter table orderitem
ADD COLUMN DiscountPercent DECIMAL(5,2) DEFAULT 0,
ADD CONSTRAINT chk_discount CHECK (DiscountPercent BETWEEN 0 AND 50);

ALTER TABLE customer
ADD CONSTRAINT chk_phone CHECK (Phone REGEXP '^[0-9]{10}$');
ALTER TABLE Product DROP INDEX SerialNumber;


#Qus-6
INSERT INTO SalesOrder (CustomerID, OrderDate, Status)
 VALUES
 (1, '2026-10-01', 'Delivered'), 
 (1, '2026-10-15', 'Shipped'), 
 (2, '2026-10-05', 'Delivered'), 
 (3, '2026-10-20', 'Pending'), 
 (4, '2026-10-22', 'Cancelled'), 
 (2, '2026-11-01', 'Pending');
 SELECT * FROM salesorder;
 
 INSERT INTO OrderItem (OrderID, ProductID, Quantity, UnitPrice) 
 VALUES
 (1, 1, 1, 55000), (1, 2, 2, 1200),
 (2, 3, 1, 2500),
 (3, 2, 3, 1200), (3, 3, 1, 2500),
 (4, 4, 2, 12000),
 (5, 1, 1, 55000), (5, 5, 1, 3000),
 (6, 2, 1, 1200), (6, 4, 1, 12000);
 SELECT * FROM orderitem;
 
 #qus-7
 #a  A customer with a duplicate email

 INSERT INTO customer(FullName, Email, Phone, Age)
 VALUES
 ('Shahnna','arun@gmail.com','9000000001',22);
 
 #b  A product with Price = 0, and another with a negative StockQty

 INSERT INTO Product (productname,price,stockqty,serialnumber) 
 VALUES 
 ('Cable',100,-5,'SN200');
 INSERT INTO Product (ProductName, Price, StockQty, SerialNumber)
 VALUES ('Cable', 100, -5, 'SN200');
 
 #c  A duplicate (OrderID, ProductID) order item
 
 insert into OrderItem (orderid,productid,quantity,unitprice)
 values (1,1,1,55000);
 
 # An order for a CustomerID that does not exist
 insert into salesorder(customerid,orderdate)
 values (99,'2026-09-12');
 
 # An order with Status = 'Returned'
 insert into salesorder(customerid,orderdate,status)
 values (1,'2026-11-10','returned');
 
 #Q8. Write UPDATE queries to: [1.5 marks]
 # Increase the price of all products of one brand by 10%
 SET SQL_SAFE_UPDATES = 0;
 update product set price = price*1.10
 where brand = 'dell';
 SET SQL_SAFE_UPDATES = 1;

 # Change the status of one specific order to 'Shipped'
 SET SQL_SAFE_UPDATES = 0;
 update salesorder set status = 'shipped'
 where orderid = 3;
 SET SQL_SAFE_UPDATES = 1;

 # Set the city to 'Trivandrum' for all customers whose city is NULL (hint: insert one customer with an explicit NULL city first)
 #there is no null city so first insert null city
 insert into customer ( fullname,email,phone,age,city)
 values ('ajnish','aj@gmail.com','0987654321',44,null);
 SET SQL_SAFE_UPDATES = 0;
 update customer set city = 'trivandrum' 
 where city = null;
 SET SQL_SAFE_UPDATES = 1;


#Q9. Write DELETE queries to delete one order item, and then delete all orders with Status 'Cancelled'.
#Check what happened to the items of those orders. [1 mark]
delete from orderitem
where orderid = 5 and productid = 2;
SET SQL_SAFE_UPDATES = 0;
delete from salesorder
where status = 'cancelled';
SET SQL_SAFE_UPDATES = 1;
select * from orderitem 
where orderid = 5;

#Q10. Delete a customer who has orders. Show SalesOrder and OrderItem before and after, and
#explain what happened to the related rows (CASCADE). [1.5 marks]
select * from salesorder;
select * from orderitem;
delete from customer where customerid = 1;
select * from salesorder;
select * from orderitem;

#Q11. Try deleting a product that has already been sold. Write the error you get and explain how ON
#DELETE RESTRICT caused it. Then write the steps to remove that product successfully. [1 mark]
delete from product 
where productid = 2;

delete from orderitem
where productid = 2;
delete from product 
where productid = 2;

#PART 4: DELETE vs TRUNCATE vs DROP (Practical)
#Q12. Run TRUNCATE TABLE Customer; and DROP TABLE Customer; while SalesOrder still
#references it. Write the error for each and explain why. [1 mark]

truncate table customer;
drop table customer;
#both are not possible

#Q13. Create a copy table Product_Backup (using CREATE TABLE ... LIKE and INSERT ...
#SELECT). Then check how AUTO_INCREMENT behaves: [2 marks]

CREATE TABLE Product_Backup LIKE Product;
INSERT INTO Product_Backup SELECT * FROM Product;

# Run DELETE (without WHERE) on the copy and insert a new row. Does the counter continue or reset?
 SET SQL_SAFE_UPDATES = 0;

DELETE FROM Product_Backup;
INSERT INTO Product_Backup (ProductName, Price, StockQty, SerialNumber)
VALUES ('Test', 100, 1, '1');
SELECT ProductID FROM Product_Backup; 

# Refill the copy, run TRUNCATE, and insert a new row. Does the counter continue or reset?

INSERT INTO Product_Backup SELECT * FROM Product;
TRUNCATE TABLE Product_Backup;
INSERT INTO Product_Backup (ProductName, Price, StockQty, SerialNumber)
VALUES ('Test', 100, 1, '1');
SELECT ProductID FROM Product_Backup;

# Explain the difference you observed.


#Q14. Write the correct order of commands to completely remove all tables (including the backup)
#without errors, and explain why the order matters. [1 mark]

DROP TABLE OrderItem; 
DROP TABLE SalesOrder; 
DROP TABLE Customer;
DROP TABLE Product;
DROP TABLE Product_Backup;

#Q15. Scenario: A sales manager accidentally ran DELETE FROM SalesOrder; and another
#employee ran TRUNCATE TABLE SalesOrder;, both inside open transactions. Which one can be
#recovered using ROLLBACK, and why? Which is faster? Which would you use to remove only cancelled
#orders? What extra danger does the first command carry in this database? [1.5 marks]


#PART 5: Keys & Theory
#Q16. Given Customer(CustomerID, Email, Phone, FullName, Age, City), where
#CustomerID, Email and Phone are each unique: [1.5 marks]
#• List at least 5 super keys
#• Identify all candidate keys and choose the primary key with a reason
#• List all non-prime attributes

#Super keys (any set containing a candidate key; any 5 correct ones): {CustomerID}, {Email}, {Phone},
#{CustomerID, FullName}, {Email, Age}, {Phone, City}, {CustomerID, Email}, {Email, Phone}, {CustomerID,
#Email, Phone}, {CustomerID, FullName, Age, City}.
#Candidate keys (minimal super keys): {CustomerID}, {Email}, {Phone}.
#Primary key: CustomerID. It is short, numeric, auto-generated, never NULL and never changes. Email
#and Phone can change over time, and Phone is nullable, so they are better kept as alternate keys with
#UNIQUE.
#Non-prime attributes (not part of any candidate key): FullName, Age, City.



#Q17. In OrderItem, explain with an example why neither OrderID alone nor ProductID alone can
#be the primary key. Why is a composite key the right choice here? [1.5 marks]

#OrderID alone fails because one order can contain several products: order 1 has two rows (1,1) and (1,2),
#so OrderID repeats. ProductID alone fails because one product is sold in many orders: product 2 appears
#in orders 1, 3 and 6, so ProductID repeats. Only the pair (OrderID, ProductID) is unique, and it also stops
#the same product being added twice to one order, so a composite key is the right choice.

#Q18. Answer Yes or No with a short example: Can a table have 
#(a) more than one candidate key, 
#yes

#(b)more than one primary key, 
#no

#(c) more than one foreign key (hint: look at OrderItem),
#yes
 
#(d) a foreign keyreferencing a UNIQUE (non-primary) column?
#yes
#Q19. Can a foreign key contain NULL or duplicate values? Can a primary key? Explain the difference
#between PRIMARY KEY and UNIQUE in your answer. [1 mark]
#foreign key - can contain null values
#primary key - connot contain null value

