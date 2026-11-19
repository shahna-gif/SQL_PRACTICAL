use assignment;
select * from employee1;

#Part A: ORDER BY and LIMIT
#1. Display all employees sorted by Salary from highest to lowest.
select * from employee1
order by salary desc;

#2. Display all employees sorted by Department (A to Z), then by Salary (highest first) within each department.
select * from employee1
order by department asc, salary desc;
  
#3. Display only the top 3 highest-paid employees.
select * from employee1
order by salary desc limit 3;

#4. Display the 2 lowest-paid employees.
select * from employee1
order by salary asc limit 2;

#Part B: Aggregate Functions
#5. Find the total number of employees.
select count(*) as totalemployees
from employee1;

#6. Find the total, average, minimum and maximum salary. Use aliases for each column.
select sum(salary) as total
from employee1;
select avg(salary) as average
from employee1;
select min(salary) as min_salary
from employee1;
select max(salary) as max_salary
from employee1;

#Part C: GROUP BY and HAVING
#7. Show the number of employees in each department.
select department,count(*) as num_of_employees
from employee1
group by department;

#8. Show the total salary paid in each department.
select department,sum(salary) as total_salary
from employee1
group by department;

#9. Show the average salary of each department, but only for departments with an average above 55000.
select department,avg(salary) as average_salary
from employee1
group by department
having avg(salary)>55000;

#10. Show departments that have more than 3 employees.
select department, count(*) as employee
from employee1
group by department
having count(*)>3;

#11. Write one query that uses both WHERE and HAVING. First filter out employees earning below 48000, then show only departments whose total salary is above 100000.
select department,sum(salary) as total_salary
from employee1
where salary>=48000
group by department
having sum(salary)>100000;

#Part D: Window Functions
#12. Add a column RowNum that numbers the employees from highest to lowest salary using ROW_NUMBER().
select row_number() over(order by salary desc) as rowno,
name,
department
from employee1;

#13. Rank employees by salary (highest first) using RANK() and DENSE_RANK() in the same query. Compare the two columns for the tied salaries.
select name,department,
rank() over(order by salary desc) as rankno,
dense_rank() over (order by salary desc) as dense_ranks
from employee1;

#14. Rank employees within each department by salary using PARTITION BY. Then show only the top-paid employee in each department (hint: use a subquery or CTE).
select name,department,salary,
rank() over(partition by salary order by department) as rankno
from employee1;


#15. Display each employees salary along with the previous salary (LAG) and the next salary (LEAD), ordered by salary. Add a column showing the difference between the current andprevious salary.
SELECT Name,
Salary,
LEAD(Salary) OVER(ORDER BY Salary) AS NextSalary,
lag(salary) over(order by salary) as previous_salary,
salary - LAG(salary) OVER (ORDER BY salary) AS Salary_Difference
FROM Employeeinfo;

#Part E: Short Answer Questions

#16. What is the difference between WHERE and HAVING?
#-where-filter rows before grouping,cannot use aggregate function
#-having-filter groups after grouping and can use aggregate function

#17. What is the difference between GROUP BY and a window function?
#group_by-combines rows into groups and shows summary results
#window function - performs calculations on rows without removing individuals

#18. Why does RANK() skip numbers while DENSE_RANK() does not?
#RANK(): Gives the same rank to tied values but skips the next rank.
#DENSE_RANK(): Gives the same rank to tied values without skipping numbers

#19. What does PARTITION BY do inside OVER()?
#PARTITION BY divides rows into groups based on a column. It performs calculations separately within each group without combining the rows.

#Bonus
#20. Find the second highest salary in the table using any method (DENSE_RANK(), LIMIT with OFFSET, or a subquery).
SELECT name, salary,
DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
FROM employee1
WHERE rnk = 2;