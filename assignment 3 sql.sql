create database assignment;
use assignment;

#Q1. Show all the records in the Sales table. 
SELECT * FROM sales;

#Q2. Show only the Customer, Product and Price of every sale.
select customer,product,product ,price from sales;

#Q3. List the cities where sales were made, with no city repeated. 
select distinct city from sales;

#Q4. List all the different products that were sold, with no product repeated.
select distinct product 
from sales 
where status ='delivered';

#Q5. Show Customer as Buyer and Product as Item_Sold for every sale.
select customer as buyer,
       product as item_sold
from sales;       
 
#Q6. Show all sales made in Kochi.
select * from sales
where city = 'kochi'; 

#Q7. Show all sales where the Price is more than 5000.
select * from sales
where price>5000;

#Q8. Show all sales where 5 or more items were bought. 
select * from sales
where quantity>=5;

#Q9. Show all sales that were not delivered. 
select * from sales
where not status='delivered';

#Q10. Show all Electronics sales where more than 1 item was bought. 
select * from sales
where category='electronics' and quantity>1;

#Q11. Show all sales paid by UPI or by Card. 
select * from sales
where paymentmode='upi' or paymentmode='card';

#Q12. Show all sales that were not paid in Cash.
select * from sales
where not paymentmode = 'cash'; 

#Q13. Show all sales from Kochi, Calicut and Thrissur. 
select * from sales
where city in('kochi','calicut','thrissur');

#Q14. Show all sales from every city except Kochi, Calicut and Trivandrum.
 select * from sales
where city not in('kochi','calicut','trivandrum');

#Q15. Show all sales made in March 2026 (from 1 March to 31 March). 
select * from sales
where saledate between '2026-03-03' and '2026-03-31';

#Q16. Show all sales where the Price is below 1000 or above 10000. 
select * from sales
where price<1000 or price>10000;

#Q17. Show Product and the total amount (Price multiplied by Quantity) as TotalAmount for every 
select product ,price*quantity as totalprice
from sales;

#Q18. Show Customer and the discount amount as DiscountAmount. The Discount column is a percentage of the total amount. 
select customer,(price*quantity*discount/100) as discountamount
from sales;

#Q19. Show Customer, Product and the final amount after discount as FinalAmount. 
select customer ,product ,price*quantity-discount as finalamount
from sales;

#Q20. Show Product and the price with 18% GST added as PriceWithGST for Electronics products only. 
select product,(price + (price*18/100)) as pricewithgst
from sales
where category='Electronics'; 

#Q21. Show Customer, Product and TotalAmount for delivered sales where the total amount is more than 10000. 
select customer,product,price*quantity as totalamount 
from sales
where status='delivered' and price*quantity>10000; 

#Q22. Show all sales where the customer's email is missing. 
SET SQL_SAFE_UPDATES = 0;

update sales set email=null 
where email='';
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM SALES;

select * from sales
where email IS NULL;

#Q23. Show all sales where the customer's email is available. 
select * from sales
where email is not null;

#Q24. Show all sales where the Customer name starts with S. 
SELECT * FROM SALES
WHERE customer LIKE 'S%';

#Q25. Show all sales where the Customer name ends with the letter a. 
select * from sales
where customer like '%a';
#Q26. Show all sales where the Product name contains the word Desk. 
select * from sales
where product like  '%desk%';

#Q27. Show all sales where the Customer name has exactly 4 letters and ends with 'run'. 
select * from sales
where customer like '_run';

#Q28. Show all sales where the Customer name does not start with A. 
select * from sales
where customer not like 'a%';

#Q29. Show delivered sales from Kochi or Calicut where the customer has an email and got a discount of 10 or more. 
select * from sales
where status='delivered' 
and (city='kochi' or city='calicut')
and email is not null
and discount>=10;

# Q30. Show Customer, Product and TotalAmount for customers whose name starts with A or S, who bought Electronics or Accessories, and whose total amount is more than 3000. 
select customer,product,price*quantity as totalamount
from sales
where (customer like 'a%' or customer like 's%')
and category in ('electronics','accessories')
and price*quantity>3000;

#Q31. Show sales that were returned or cancelled, where the total amount is more than 2000. 
select * from sales
where status in ('returned','cancelled')
and price*quantity>2000;

#Q32. Show Customer, Product and FinalAmount for Furniture or Electronics sales paid by UPI, where 2 to 4 items were bought and the sale was delivered.
select customer, product,price*quantity as finalamount
from sales
where category in ('furniture','electronics')
and paymentmode='upi'
and quantity between 2 and 4
and status='delivered';