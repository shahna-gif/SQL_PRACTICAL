DROP DATABASE IF EXISTS sales_db;
CREATE DATABASE sales_db;
USE sales_db;

CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category    VARCHAR(30),
    Price       INT
);

CREATE TABLE Sales (
    SaleID       INT PRIMARY KEY,
    SaleDate     DATE,
    CustomerName VARCHAR(50),
    City         VARCHAR(30),
    ProductID    INT,
    Quantity     INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
    (1, 'Laptop', 'Electronics', 55000),
    (2, 'Smartphone', 'Electronics', 18000),
    (3, 'Tablet', 'Electronics', 22000),
    (4, 'Headphones', 'Accessories', 1500),
    (5, 'Keyboard', 'Accessories', 800),
    (6, 'Mouse', 'Accessories', 500),
    (7, 'Notebook', 'Stationery', 60),
    (8, 'Pen Pack', 'Stationery', 120);

INSERT INTO Sales (SaleID, SaleDate, CustomerName, City, ProductID, Quantity) VALUES
    (1, '2026-10-01', 'Arjun Nair', 'Kochi', 2, 1),
    (2, '2026-10-01', 'Sneha Menon', 'Thrissur', 4, 2),
    (3, '2026-10-02', 'Rahul Varma', 'Kozhikode', 1, 1),
    (4, '2026-10-03', 'Fathima Noor', 'Kannur', 5, 1),
    (5, '2026-10-04', 'Divya Raj', 'Kochi', 7, 10),
    (6, '2026-10-05', 'Mohammed Ashraf', 'Kozhikode', 6, 3),
    (7, '2026-10-07', 'Anjali Krishnan', 'Thrissur', 3, 1),
    (8, '2026-10-08', 'Suresh Kumar', 'Kochi', 8, 5),
    (9, '2026-10-10', 'Remya Thomas', 'Kannur', 4, 1),
    (10, '2026-10-12', 'Nikhil George', 'Kochi', 2, 2),
    (11, '2026-10-15', 'Aisha Beegum', 'Kozhikode', 7, 20),
    (12, '2026-10-18', 'Joseph Mathew', 'Thrissur', 5, 2),
    (13, '2026-10-20', 'Meera Nambiar', 'Kochi', 1, 1),
    (14, '2026-10-22', 'Hari Krishnan', 'Kannur', 6, 4),
    (15, '2026-10-25', 'Neha Sharma', 'Kozhikode', 2, 1),
    (16, '2026-10-28', 'Adil Rahman', 'Kochi', 8, 3),
    (17, '2026-11-02', 'Priya Das', 'Thrissur', 4, 3),
    (18, '2026-11-05', 'Kiran Babu', 'Kochi', 3, 1),
    (19, '2026-11-08', 'Arjun Nair', 'Kochi', 6, 2),
    (20, '2026-11-10', 'Sneha Menon', 'Thrissur', 2, 1);

SELECT * FROM Products;
SELECT * FROM Sales;

# simple view

#Q1. Create a view named Electronics_Products that shows ProductID, ProductName and Price of all products in the 'Electronics' category. Then display all rows from the view.
#Hint: Syntax: CREATE VIEW view_name AS SELECT ... FROM ... WHERE ...;

CREATE VIEW Electronics_products as
select productid,productname,price 
from products
where category = 'electronics';
select * from electronics_products;

#Q2. Create a view named Kochi_Sales that shows SaleID, CustomerName, ProductID and Quantity for all sales made in the city 'Kochi'. Then display the view.
create  view kochi_sales as
select saleid,customername,productid,quantity
from sales
where city = 'kochi';
select * from kochi_sales;

#Q3. Create a view named Bulk_Sales that shows SaleID, CustomerName, City and Quantity for sales where the Quantity is 3 or more. Then display the view.
create view bulk_sales as
select saleid,customername,city,quantity
from sales
where quantity >= 3;
select * from bulk_sales;

#Q4. Use the view Electronics_Products to display only the products whose Price is greater than 20000.
#Hint: You can write WHERE on a view just like on a normal table.

select * from electronics_products
where price >20000;

#Q5. Delete the view Bulk_Sales. Then try to display it again. What happens?
drop view bulk_sales;
select * from bulk_sales; #table bulk_sales doesn't exixt

# Complex Views (JOIN and GROUP BY)
#Q6. Create a view named Sales_Details that shows SaleID, CustomerName, ProductName, Quantity, Price and a calculated column TotalAmount (Quantity × Price). Use a JOIN between Sales and Products. Then display the view.
#Hint: Join the two tables using ProductID. Give the calculation an alias: Quantity * Price AS TotalAmount.

create view sales_details as
select 
       s.saleID,
	   s.customername,
       p.productname,
       s.quantity,
       p.price, 
       (s.quantity * p.price) as totalamount
from sales s
join products p
on s.productid = p.productid; 

select * from sales_details;

#Q7. Using the view Sales_Details, find the total sales amount of all sales. Name the column TotalSales.
select sum(totalamount) as total_sales
from sales_details;

#Q8. Create a view named Category_Sales that shows each Category and its total sales amount (TotalSales). Then display the view.
#Hint: Join Sales and Products, then GROUP BY Category and use SUM(Quantity * Price).

create view category_sales as
select p.category,
       (p.price *  s.quantity) as totalsales
from products p
join sales s
on p.productid = s.productid;  

select * from category_sales;
     
#Q9. Create a view named City_Sales that shows each City with the number of sales (TotalOrders) and the total quantity sold (TotalQuantity). Then display the view.
create view cityy_sales as
select s.city,
       count(saleid) as totalorders,
       sum(quantity) as totalquantity
from sales s
group by city;
select * from cityy_sales;       
       
#Q10. Create a table sales_log with the columns SaleID (INT), CustomerName (VARCHAR(50)) and Action (VARCHAR(50)). 
#Then create an AFTER INSERT trigger named after_sale_insert on the Sales table that adds a row to sales_log with the text 
#'Sale Added' every time a new sale is inserted.
#Hint: Use DELIMITER // before the trigger and DELIMITER ; after it. 
#Inside the trigger, NEW.SaleID and NEW.CustomerName give the values of the new row.

CREATE TABLE sales_log (
    SaleID INT,
    CustomerName VARCHAR(50),
    Action VARCHAR(50)
);

DELIMITER //
CREATE TRIGGER after_sale_insert
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    INSERT INTO sales_log (SaleID, CustomerName, Action)
    VALUES (NEW.SaleID, NEW.CustomerName, 'Sale Added');
END //
DELIMITER ;

#Q11. Test the trigger: insert a new sale with SaleID 21, date '2026-11-12',
#3 customer 'Aisha Beegum', city 'Kozhikode', ProductID 4 and Quantity 2. Then display sales_log.
# You did not insert anything into sales_log yourself. Who did?

INSERT INTO Sales (SaleID, SaleDate, CustomerName, City, ProductID, Quantity)
VALUES (21, '2026-11-12', 'Aisha Beegum', 'Kozhikode', 4, 2);

SELECT * FROM sales_log;

#Q12. Create a BEFORE INSERT trigger named check_quantity on the Sales table. If the Quantity of a new sale is less than 0, 
#the trigger must change it to 0 before the row is saved. 
#Test it by inserting SaleID 22, date '2026-11-13', customer 'Test Customer', city 'Kochi', 
#ProductID 6 and Quantity -5, and then display that row from the Sales table (SaleID, CustomerName, Quantity).

delimiter //
create trigger check_quantity
before insert on sales
for each row
begin
    if new.quantity < 0 then
        set new.quantity = 0;
     end if;
     end //
delimiter ;

INSERT INTO Sales (SaleID, SaleDate, CustomerName, City, ProductID, Quantity)
VALUES (22, '2026-11-13', 'Test Customer', 'Kochi', 6, -5);

SELECT SaleID, CustomerName, Quantity 
FROM Sales 
WHERE SaleID = 22;     

#Q13. Create a table price_log with the columns ProductID (INT), 
#Old_Price (INT) and New_Price (INT). Then create an AFTER UPDATE trigger 
#named price_update_log on the Products table that records OLD.Price and 
#NEW.Price whenever a product is updated. Test it by changing the price of the Keyboard 
#(ProductID 5) to 900, and then display price_log.
#Hint: OLD.Price is the price before the update. NEW.Price is the price after the update.

create table price_log(
productid int,
old_price int,
new_price int);

delimiter \\
create trigger price_update_log
after update on products
for each row
begin
    insert into price_log( productid,old_price,new_price)
    values(old.productid,old.price,new.price);
end //
delimiter ;

update products 
set price = 900
where productid = 5;

select * from price_log;
    
#Q14. Answer in 2 to 3 lines each: 
#(a) What is the difference between a BEFORE trigger and an AFTER trigger? 

#BEFORE trigger: Runs before data is saved, allowing you to check or change values first
#Runs after data is saved, making it useful for logging actions into another table.alter

#(b) What do OLD and NEW mean inside a trigger?

# LD: Refers to the existing row values before an UPDATE or DELETE happens.
# NEW: Refers to the incoming row values being saved during an INSERT or UPDATE.


#Q15. Delete the trigger check_quantity. Then run SHOW TRIGGERS and check that it is no longer in the list.

DROP TRIGGER check_quantity;
SHOW TRIGGERS;

#index

#Q16. Create an index named idx_customer_name on the CustomerName column of the Sales table.

create index idx_customer_name 
on sales(customername);

#Q17. Write a normal SELECT query to display all sales of the customer 'Arjun Nair'. Do not write the index name in the query.

select * from sales
where customername = 'arjun nair';

#Q18. Create a composite index named idx_city_product 
#on the City and ProductID columns of the Sales table. Then display the sales made in 'Kochi' for ProductID 2.

create index idx_city_product
on sales(city,productid);
select * from sales
where city = 'kochi' and productid = 2;

#Q19. Run EXPLAIN on the query from Question 17 (sales of 'Arjun Nair'). Which index is shown in the key column? 
#Then delete the index idx_customer_name using DROP INDEX and run EXPLAIN again. What changes in the key column?
#Hint: Write EXPLAIN in front of the SELECT query. To delete an index: DROP INDEX index_name ON table_name;

EXPLAIN SELECT * FROM Sales WHERE CustomerName = 'Arjun Nair';
DROP INDEX idx_customer_name ON Sales;
EXPLAIN SELECT * FROM Sales WHERE CustomerName = 'Arjun Nair';

#Q20. Answer in 2 to 3 lines: 
#What is an index, and why should we not create an index on every column of a table?

#An index is a separate data structure that allows the database to locate 
#rows quickly without scanning the entire table. Indexing every column slows 
#down INSERT, UPDATE, and DELETE operations because every index must be updated
# whenever data changes, and it consumes extra disk space.