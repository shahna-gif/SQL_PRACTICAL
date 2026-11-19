# SQL ASSIGNMENT – FULL OUTER JOIN

### 1. Create Student Table


CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    CourseID INT
);

INSERT INTO Student VALUES
(1, 'Aisha', 201),
(2, 'Arjun', 202),
(3, 'Diya', 203),
(4, 'Rahul', 204),
(5, 'Sneha', NULL);

### 2. Create Course Table


CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

INSERT INTO Course VALUES
(201, 'Python'),
(202, 'Data Science'),
(203, 'SQL'),
(205, 'Power BI'),
(206, 'Machine Learning');

### 3. Display Both Tables


SELECT * FROM Student;

SELECT * FROM Course;

### 4. Assignment Questions

#Q1. Display all students and all courses, including records that do not have matching values in both tables.
SELECT s.StudentID, s.StudentName, s.CourseID, c.CourseName
FROM Student s
LEFT JOIN Course c
ON s.CourseID = c.CourseID

UNION

SELECT s.StudentID, s.StudentName, c.CourseID, c.CourseName
FROM Student s
RIGHT JOIN Course c
ON s.CourseID = c.CourseID;
 
##**Q2.** Display StudentID, StudentName, CourseID and CourseName.
SELECT s.StudentID, s.StudentName, s.CourseID, c.CourseName
FROM Student s
LEFT JOIN Course c
ON s.CourseID = c.CourseID

UNION

SELECT s.StudentID, s.StudentName, c.CourseID, c.CourseName
FROM Student s
RIGHT JOIN Course c
ON s.CourseID = c.CourseID;

#Q3.** Write a query to achieve FULL OUTER JOIN using LEFT JOIN, RIGHT JOIN and UNION.
SELECT *
FROM Student s
LEFT JOIN Course c
ON s.CourseID = c.CourseID

UNION

SELECT *
FROM Student s
RIGHT JOIN Course c
ON s.CourseID = c.CourseID;


##self join assignment

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT,
    ManagerID INT NULL
);
INSERT INTO Employee (EmpID, Name, Salary, ManagerID)
VALUES
(1, 'Arun', 90000, NULL),
(2, 'Meera', 60000, 1),
(3, 'Rahul', 50000, 1),
(4, 'Anu', 65000, 2),
(5, 'John', 40000, 2);

SELECT * FROM Employee;

#Q1. Write a query to show each employee's name along with their manager's name.
#Hint: Join the Employee table with itself using aliases e and m.
select e.name as employeename,
       m.name as managername
 from employee e
 inner join employee m
 on e.managerid = m.empid;
 
#Q2. Write a query to show all employees, including the ones who have no manager. For them, the manager's name should show as NULL.
#Hint: Which join keeps every row of the left table?

select e.name as employeename,
       m.name as managername
from employee e
left join employee m
on e.managerid = m.empid;       
 
#Q3. Write a query to find the employees who earn more than their manager.
#Hint: Compare e.Salary with m.Salary in a WHERE condition.
select e.name as employeename,
       e.salary as employeesalary,
       m.name as managername,
       m.salary as managersalary
from employee e
inner join employee m
on e.managerid = m.empid
where e.salary > m.salary;     


##cross join assignement

#Q1. List all possible color and size combinations of a T-shirt. Table queries:
 CREATE TABLE colors
 (color_id INT,
 color_name VARCHAR(20));
 
 INSERT INTO colors 
 VALUES 
 (1,'Red'),
 (2,'Blue'),
 (3,'Black'); 
 
 CREATE TABLE sizes
 (size_id INT, 
 size_name VARCHAR(5)); 
 
 INSERT INTO sizes 
 VALUES 
 (1,'S'),
 (2,'M'),
 (3,'L');
 
 select * from colors;
 select * from sizes;
  
 select c.color_name ,s.size_name
 from colors c
 cross join sizes s;
 
 #Q2. Display every student against every subject, ordered by student name. Table queries: 
 CREATE TABLE students
 (student_id INT, 
 student_name VARCHAR(30)); 
 
 INSERT INTO students 
 VALUES 
 (101,'Anu'),
 (102,'Ravi'),
 (103,'Meera'); 
 
 CREATE TABLE subjects
 (subject_id INT,
 subject_name VARCHAR(30)); 
 
 INSERT INTO subjects 
 VALUES 
 (1,'Maths'),
 (2,'Science'),
 (3,'English'); 
 
 select * from students;
 select * from subjects;
 
 SELECT s.student_name, sub.subject_name
FROM students s
CROSS JOIN subjects sub
ORDER BY s.student_name;

#Q3. Show the final price of every product under every discount offer. Table queries: 
CREATE TABLE products
(product_id INT,
 product_name VARCHAR(30), 
 price INT); 
 
 INSERT INTO products 
 VALUES
 (1,'Laptop',50000),
 (2,'Phone',20000),
 (3,'Tablet',15000); 
 
 CREATE TABLE discounts
 (discount_name VARCHAR(30), 
 percent INT); 

INSERT INTO discounts 
VALUES 
('Festival',10),
('Student',15); 

select * from products;
select * from discounts;

SELECT p.product_name,
       d.discount_name,
       d.percent,
       p.price - (p.price * d.percent / 100) AS FinalPrice
FROM products p
CROSS JOIN discounts d;