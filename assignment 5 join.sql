DROP DATABASE IF EXISTS sales_db;
CREATE DATABASE sales_db;
USE sales_db;

-- ---------- Table 1: Customer ----------
CREATE TABLE Customer (
CustID INT PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(80),
City VARCHAR(50),
Age INT,
JoinDate DATE,
ReferredBy INT NULL 
);

INSERT INTO Customer VALUES
(1, 'Rahul Menon','rahul.menon@shopzone.com','Kochi', 34, '2021-02-14', NULL),
(2, 'Sneha Iyer','sneha.iyer@shopzone.com', 'Chennai', 28, '2021-06-10', 1),
(3, 'Arjun Nair', 'arjun.nair@shopzone.com', ';Kochi', 41, '2022-01-05', 1),
(4, ';Priya Das', 'priya.das@shopzone.com', 'Bengaluru', 25,'2022-08-19', 2),
(5, 'Kiran Rao', 'kiran.rao@shopzone.com', 'Hyderabad', 37, '2022-11-30', 3),
(6, 'Fathima Beevi', 'fathima.beevi@shopzone.com', 'Kochi', 30, '2023-03-12', 2),
(7,'Vishnu Raj', 'vishnu.raj@shopzone.com', 'Chennai', 45, '2023-07-25', 4),
(8, 'Ananya Pillai', 'ananya.pillai@shopzone.com', 'Bengaluru', 23, '2024-01-18', 6),
(9, 'Mohit Jain', 'mohit.jain@shopzone.com','Mumbai', 39, '2024-05-09', 5), 
(10, 'Zoya Khan','zoya.khan@shopzone.com', 'Hyderabad', 31, '2024-09-21', 8);
select * from customer;

-- ---------- Table 2: Product ----------
CREATE TABLE Product (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Category VARCHAR(30),
UnitPrice DECIMAL(10,2)
);

INSERT INTO Product VALUES
(1, 'Laptop', 'Electronics', 55000.00),
(2, 'Smartphone', 'Electronics', 28000.50),
(3, 'Headphones', 'Accessories', 2499.99),
(4, 'Office Chair', 'Furniture', 7200.00),
(5, 'Study Table', 'Furniture', 6400.75),
(6, 'Smart Watch', 'Electronics', 9999.00);

-- ---------- Table 3: Orders ----------

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustID INT NULL, 
ProductID INT,
Quantity INT,
OrderDate DATE,
DiscountPct INT
);
INSERT INTO Orders VALUES
(5001, 1, 1, 1, '2024-01-15', 5),
(5002, 2, 2, 2, '2024-02-10', 10),
(5003, 3, 3, 3, '2024-03-05', 0),
(5004, 1, 3, 1, '2024-03-22', 0),
(5005, 4, 4, 1, '2024-06-18', 15),
(5006, 5, 2, 1, '2024-06-30', 5),
(5007, 6, 5, 2, '2024-07-14', 10),
(5008, 7, 1, 1, '2024-08-02', 0),
(5009, 2, 3, 4, '2024-11-11', 20),
(5010, NULL, 2, 1, '2025-01-09', 0), -- guest order
(5011, 3, 4, 2, '2025-02-14', 10),
(5012, NULL, 3, 2, '2025-03-03', 5), -- guest order
(5013, 8, 5, 1, '2025-06-21', 0),

(5014, 4, 1, 1, '2025-06-28', 10);
-- ---------- Table 4: Discount_Slab ----------
CREATE TABLE Discount_Slab (
SlabID INT PRIMARY KEY,
SlabName VARCHAR(30),
DiscountPct INT
);
INSERT INTO Discount_Slab VALUES
(1, 'Member', 5),
(2, 'Festive', 10),
(3, 'Clearance', 25);
-- ---------- Table 5: Online_Sales ----------
CREATE TABLE Online_Sales (
SaleID INT PRIMARY KEY,
ProductName VARCHAR(50),
City VARCHAR(50),
Amount DECIMAL(10,2)
);
INSERT INTO Online_Sales VALUES
(1, 'Laptop', 'Kochi', 52250.00),
(2, 'Headphones', 'Chennai', 2499.99),
(3, 'Smartphone', 'Bengaluru', 28000.50),
(4, 'Study Table', 'Kochi', 6400.75);
-- ---------- Table 6: Store_Sales ----------
CREATE TABLE Store_Sales (
SaleID INT PRIMARY KEY,
ProductName VARCHAR(50),
City VARCHAR(50),
Amount DECIMAL(10,2)
);
INSERT INTO Store_Sales VALUES
(5, 'Laptop', 'Kochi', 52250.00), -- same as Online_Sales row (ProductName + City +Amount)
(6, 'Office Chair', 'Chennai', 7200.00),
(7, 'Smartphone', 'Bengaluru', 28000.50), -- same as Online_Sales row (ProductName + City +Amount)
(8, 'Headphones', 'Mumbai', 2499.99);
-- Check the data
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM Discount_Slab;
SELECT * FROM Online_Sales;
SELECT * FROM Store_Sales;


#self join
select c.name as custname,r.name as referal_person
from customer c
inner join customer r
on c.referredby=r.custid;

delimiter \\
create procedure getcustomerdetails()
begin
select * from customer
where city='kochi' and age > 18;
end \\

delimiter ;

call getcustomerdetails();
# creating view
create view city_customer AS
select name,email
from customer
where city='kochi';

select * from city_customer;
select * from city_customer
where name like 'r%';

#complex view
create view customer_orders as
select c.name,
       o.orderid,
       c.city
from customer c
join orders o
on c.custid = o.custid;

select * from customer_orders; 

create view productdetails as
select c.name,
       p.productname,
       p.unitprice
from customer c
join product p
on c.custid = p.productid;

select * from productdetails;      

#Section 1: INNER JOIN (Customer + Orders + Product)
#Q1. Display OrderID, Customer Name and OrderDate for all orders placed by registered customers.

select o.OrderID,c.Name,o.OrderDate
from Orders o
inner join Customer c
on o.CustID=c.CustID;

#Q2. Display Customer Name, ProductName and Quantity for every order. (Join Customer, Orders and Product)
select c.name,p.productName,o.quantity
from customer c
inner join orders o
on c.custid=o.custid
inner join product p
on o.productID = p.productID;

#Q3. Display orders of the 'Electronics' category along with the Customer Name and City.
select c.name,c.city,p.category
from customer c
inner join orders o
on c.custid=o.custid
inner join product p
on o.productid = p.productid
where p.category = 'electronics';

#Q4. Display the Customer Name and total amount spent on each order (Quantity x UnitPrice) for orders where the amount is greater than 50000.
select c.name,o.orderid,(o.quantity*p.unitprice) as totalamount
from customer c
inner join orders o
on c.custid = o.custid
inner join product p
on o.productid = p.productid
where (o.quantity * p.unitprice) > 50000;

#Section 2: LEFT JOIN (Customer + Orders)
#Q5. Display all customers with their OrderID. Customers who never ordered should show NULL.
select c.custid,c.name,o.orderid
from customer c
left join orders o
on c.custid=o.custid;

#Q6. Find the customers who have NEVER placed an order (use LEFT JOIN + IS NULL).
select c.custid,c.name,o.orderid
from customer c
left join orders o
on c.custid=o.custid
where o.orderid is null;

#Q7. Display all customers with the number of orders they have placed (0 for customers with no orders).
select c.custid,c.name,count(o.orderid) as totalorders
from customer c
left join orders o
on c.custid=o.custid
group by c.custid,c.name;

#Q8. Display all customers with OrderID. Show 'No Order' instead of NULL. (Hint: IFNULL / COALESCE)
select c.name,
Ifnull(o.orderid,'no order') as orderid
from customer c
left join orders o
on c.custid = o.custid;

#Section 3: RIGHT JOIN (Orders + Product)

#Q9. Display all products with the OrderID in which they were sold. Products that were never sold must also appear
SELECT p.ProductID, p.ProductName, o.OrderID
FROM Product p
LEFT JOIN Orders o
ON p.ProductID = o.ProductID;

#Q10. Find the products that have never been sold (use RIGHT JOIN + IS NULL).
SELECT p.ProductID, p.ProductName
FROM Orders o
RIGHT JOIN Product p
ON o.ProductID = p.ProductID
WHERE o.OrderID IS NULL;

#Q11. Display each ProductName with the total quantity sold, including products with 0 sales.
select p.productname,
ifnull(sum(o.quantity),0) as totalquantitysold
from product p
left join orders o
on p.productid = o.productid
group by p.productid,p.productname;

#Q12. Display all customers and all orders, whether or not they have a match.
select c.custid,c.name,o.orderid,o.orderdate
from customer c
left join orders o
on o.custid=c.custid

union 

select c.custid,c.name,o.orderid,o.orderdate
from customer c
right join orders o
on c.custid=o.custid;

#Q13. From the FULL JOIN result, show only the rows that have NO match on either side (customers withoutorders and orders without customers).
select c.custid,c.name,o.orderid
from customer c
left join orders o
on c.custid=o.custid
where o.orderid is null

union 

select c.custid,c.name,o.orderid
from customer c
right join orders o
on c.custid=o.custid
where c.custid is null;

#Section 5: CROSS JOIN (Product + Discount_Slab)
#Q14. Generate all possible combinations of ProductName and SlabName.
select p.productname,d.slabname
from product p
cross join discount_slab d;

#Q15. For every combination in Q14, calculate the discounted price: UnitPrice - (UnitPrice x DiscountPct /100).
SELECT p.ProductName, d.SlabName, d.DiscountPct,
       p.UnitPrice - (p.UnitPrice * d.DiscountPct / 100) AS DiscountedPrice
FROM Product p
CROSS JOIN Discount_Slab d;

#Q16. How many rows does the CROSS JOIN of Product and Discount_Slab return? Verify using COUNT(*).(Expected: number of products x number of slabs)
select count(*) as totalrows
from product
cross join discount_slab;

#Section 6: SELF JOIN (Customer)
#Q17. Display each customer&#39;s Name along with the Name of the customer who referred them.
SELECT c.Name AS CustomerName,
       r.Name AS ReferredBy
FROM Customer c
LEFT JOIN Customer r
ON c.ReferredBy = r.CustID;

#Q18. Show customers who were not referred by anyone. (Hint: LEFT SELF JOIN + IS NULL)
select c.name
from customer c
left join customer r
on c.referredby = r.custid
where r.custid is null;

#Q19. Display each referrer&#39;s Name with the number of customers they referred. (SELF JOIN + GROUP BY)
SELECT r.Name AS ReferrerName,
       COUNT(c.CustID) AS TotalReferred
FROM Customer r
LEFT JOIN Customer c
ON r.CustID = c.ReferredBy
GROUP BY r.CustID, r.Name;

#Q20. Find pairs of customers who live in the same City (avoid pairing a customer with themselves and avoid repeated pairs).
SELECT c1.Name AS Customer1,
       c2.Name AS Customer2,
       c1.City
FROM Customer c1
JOIN Customer c2
ON c1.City = c2.City
AND c1.CustID < c2.CustID;

#Section 7: UNION and UNION ALL (Online_Sales + Store_Sales)
#Q21. Display ProductName, City and Amount of all online and store sales without duplicates (UNION).
select productname,city,amount
from online_sales

union

select productname,city,amount
from store_sales;

#Q22. Display ProductName, City and Amount of all online and store sales keeping duplicates (UNION ALL).
select productname,city,amount
from online_sales

union

select productname,city,amount
from store_sales;

#Q23. Compare the row counts of Q21 and Q22. Why are they different?
SELECT COUNT(*) AS TotalRows
FROM (
    SELECT ProductName, City, Amount
    FROM Online_Sales
    UNION
    SELECT ProductName, City, Amount
    FROM Store_Sales
) AS A;

SELECT COUNT(*) AS TotalRows
FROM (
    SELECT ProductName, City, Amount
    FROM Online_Sales
    UNION ALL
    SELECT ProductName, City, Amount
    FROM Store_Sales
) AS B;

#Q24. Add an extra column 'Channel' with values 'Online' / 'Store' to the UNION ALL result.
select productname,city,amount,'online' as channel
from online_sales

union all

select productname,city,amount,'store' as channel
from store_sales;

#Q25. Find the total sales Amount of all channels combined. (Hint: UNION ALL inside a subquery)
select sum(amount) as totalsales
from (
	  select amount from online_sales
      union all
      select amount from store_sales
) as sales;

#Q26. Show the list of distinct cities where sales happened (online + store) in alphabetical order.
select city from online_sales
union 
select city from store_sales
order by city;

#Section 8: MATHEMATICAL FUNCTIONS (UnitPrice, Quantity, DiscountPct)
#Q27. Display ProductName and UnitPrice rounded to 0 decimal places. (ROUND)
select productname,round(unitprice,0) as roundedprice
from product;

#Q28. Display ProductName and UnitPrice rounded UP and DOWN to the nearest integer. (CEIL, FLOOR)
select productname,
ceil(unitprice) as roundup,
floor(unitprice) as rounddown
from product;

#Q29. Calculate the final amount of each order: Quantity x UnitPrice - discount, rounded to 2 decimals.
select o.orderid,round(p.unitprice * o.quantity *(1-o.discountpct / 100),2) as finalamount
from orders o
join product p
on o.productid = p.productid;

#Q30. Calculate the GST amount (18%) on every product&#39;s UnitPrice, rounded to 2 decimals.
select productname,round(unitprice * 18/100,2) as gstamount
from product;

#Q31. Display Customer Name and the absolute difference between the customer&#39;s Age and 35. (ABS)
select name,abs(age - 35) as agedifference
from customer;

#Q32. Display Quantity and the square of Quantity for every order using POWER().
select quantity,power(quantity,2) as square
from orders;

#Q33. Display the average UnitPrice of all products rounded to 2 decimals.
select round(avg(unitprice),2) as average
from product;

#Section 9: STRING FUNCTIONS (Name, Email, City, ProductName)
#Q34. Display Customer Name in UPPERCASE and City in lowercase.
select upper(name) as customername,
lower(city) as city
from customer;

#Q35. Display Customer Name and the number of characters in the Name. (LENGTH)
select name, length(name) as namelength
from customer;

#Q36. Display the customer with the longest name.
select name
from customer
order by length(name) desc
limit 1;

#Q37. Combine Name and City into one column in the format: Rahul Menon - Kochi (CONCAT)
select concat(name,'-',city) as customerdetails
from customer;

#Q38. Display the first 3 characters of each ProductName. (SUBSTRING / LEFT)
select productname,left(productname,3) as firstthreecharacters
from product;

#Q39. Extract the username part of the customer Email (the text before '@'). (Hint: SUBSTRING_INDEX)
select email,substring_index(email,'@',1) as username
from customer;

#Q40. Display customers whose Email ends with 'shopzone.' and whose Name starts with 'A' or &#39;P&#39;.
select * from customer
where email like '%shopzone.com'
and (name like 'a%' or name like 'p%');

#Section 10: DATE &amp; TIME FUNCTIONS (OrderDate, JoinDate)
#Q41. Display today&#39;s date, current time and current timestamp in one query.
SELECT CURDATE() AS TodayDate,
       CURTIME() AS CurrentTime,
       NOW() AS CurrentTimestamp;

#Q42. Display OrderID, OrderDate, and the YEAR, MONTH and DAY of the order in separate columns.
select orderid,orderdate,
      year(orderdate) as orderyear,
      month(orderdate) as ordermonth,
      day(orderdate) as orderday
from orders;  
    
#Q43. Display all orders placed in the year 2024.
select * from orders
where year(orderdate)=2024;

#Q44. Display all orders placed in the month of June (any year).
select * from orders
where month(orderdate)=6;

#Q45. Count how many orders were placed in each year. (GROUP BY YEAR)
select year(orderdate) as orderyear,
count(*) as totalorders
from orders
group by year(orderdate);

#Q46. Display Customer Name and number of years since the customer joined (current year minus joining year).
select name,year(curdate())-year(joindate) as yearssincejoined
from customer;

#Section 11: MIXED / INTERVIEW-LEVEL QUESTIONS
#Q47. Display OrderID, Customer Name (UPPERCASE), ProductName, final amount (rounded) and Order Year for all registered-customer orders, sorted by final amount in descending order.
SELECT o.OrderID,
       UPPER(c.Name) AS CustomerName,
       p.ProductName,
       ROUND(p.UnitPrice * o.Quantity *
       (1 - o.DiscountPct / 100), 2) AS FinalAmount,
       YEAR(o.OrderDate) AS OrderYear
FROM Orders o
INNER JOIN Customer c
ON o.CustID = c.CustID
INNER JOIN Product p
ON o.ProductID = p.ProductID
ORDER BY FinalAmount DESC;

#Q48. Display each Category with total sales revenue (Quantity x UnitPrice) rounded to 2 decimals.
SELECT p.Category,
       ROUND(SUM(p.UnitPrice * o.Quantity), 2) AS TotalRevenue
FROM Product p
INNER JOIN Orders o
ON p.ProductID = o.ProductID
GROUP BY p.Category;

#Q49. Display each customer City with the total number of orders placed from that city, highest first.
SELECT c.City,
       COUNT(o.OrderID) AS TotalOrders
FROM Customer c
LEFT JOIN Orders o
ON c.CustID = o.CustID
GROUP BY c.City
ORDER BY TotalOrders DESC;

#Q50. Write the difference between JOIN and UNION with one example query for each.
#join-combine columns from table
SELECT c.Name, o.OrderID
FROM Customer c
JOIN Orders o
ON c.CustID = o.CustID;

#union-combines rows from tables
SELECT City FROM Customer
UNION
SELECT City FROM Online_Sales;
#Q51. Why is UNION ALL faster than UNION? When would you choose UNION instead?
#UNION ALL is faster because it does not check and remove duplicate rows.
#UNION checks for duplicates and removes them.
#Use UNION when you need only unique records.
#Use UNION ALL when you want to keep all records, including duplicates.


