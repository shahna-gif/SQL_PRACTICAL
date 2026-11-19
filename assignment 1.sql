#QUS - 6
CREATE DATABASE sale;
USE sale;
CREATE TABLE Sales
(Sale_ID INT,Customer_Name VARCHAR(50), Product_Category VARCHAR(30), Amount INT);
SELECT * FROM Sales;

#QUS - 7
CREATE TABLE Product
(Customer_Name VARCHAR(50), Product_Category VARCHAR(30), Amount INT);
SELECT * FROM Product;

#QUS - 8
ALTER TABLE Sales ADD Customer_Email VARCHAR(100);

#QUS - 9
ALTER TABLE Sales ADD Order_Date DATE;

#QUS - 10
ALTER TABLE Sales MODIFY Customer_Name VARCHAR(100);

#QUS - 11
ALTER TABLE Sales CHANGE Product_Category Category_Name VARCHAR(30);

#QUS - 12
ALTER TABLE Sales DROP COLUMN Customer_Email; 

#QUS - 13
RENAME TABLE Sales TO Sales_Records;
SELECT * FROM Sales_Records;

#QUS - 14
RENAME TABLE Product TO Product_Details;
SELECT * FROM Product_Details;

#QUS - 15
#IT'S DML
INSERT INTO Sales_Records
    (Sale_ID, Customer_Name, Category_Name, Amount, Order_Date)
VALUES
    (1, 'Arun Kumar', 'Electronics', 25000, '2026-11-01'),
    (2, 'Meera Nair', 'Furniture', 12000, '2026-11-02'),
    (3, 'Rahul Menon', 'Grocery', 3500, '2026-11-03');
SELECT * FROM Sales_Records;
TRUNCATE TABLE Sales_Records;

#QUS - 16
#DESCRIBE TABLE NAME
DESC Sales_Records;

#QUS - 17
DROP TABLE Product_Details;

#QUS - 18
SELECT * FROM Product_Details;

#QUS - 19
USE Sale;
CREATE TABLE Invoices
(Invoice_ID INT, Customer_Name VARCHAR(10), Sales_Rep VARCHAR(10),Total_Price INT);
SELECT * FROM Invoices;
ALTER TABLE Invoices ADD Payment_mode VARCHAR(10);
ALTER TABLE Invoices MODIFY Total_Price DECIMAL(10,2);
RENAME TABLE Invoices TO Invoice_Records;
SELECT * FROM Invoice_Records;

#QUS - 20
USE Sale;
CREATE TABLE Salesperson 
(Salesperson_ID INT, Name VARCHAR(10), Age INT);
SELECT * FROM Salesperson;
ALTER TABLE Salesperson ADD Region VARCHAR(15);
ALTER TABLE Salesperson CHANGE Name Salesperson_Name varchar(15);
ALTER TABLE Salesperson DROP COLUMN Age;
TRUNCATE TABLE Salesperson;
DROP TABLE Salesperson;






 




