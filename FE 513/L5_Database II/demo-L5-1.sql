/*********
author: Xingjia Zhang
content:
1. constraints- primary key, foreign key
2. joining multple tables - inner join, left join, outer join, cross join
3. performing set operations - intersect, except, union
4. subquery
5. import from csv, export to csv
*********/


/******* constraints ********/
-- 1. primary key
-- 1.1 Define primary key when creating the table
drop table if exists employees cascade;
CREATE TABLE employees (
 employee_id int PRIMARY KEY,
 department_name VARCHAR (255)
);


INSERT INTO employees VALUES(1, 'Sales'),(2,'Marketing'),(3, 'HR'),(4, 'IT'),(5, 'Production');
INSERT INTO employees VALUES(1, 'Sales'),(1,'Marketing'),(3, 'HR'),(4, 'IT'),(5, 'Production');--  gets error when exists duplicate value in primary key column: duplicate key value violates unique constraint "employees_pkey"

INSERT INTO employees VALUES(null, 'Sales'),(2,'Marketing'),(3, 'HR'),(4, 'IT'),(5, 'Production');--  gets error when put null for primary key: null value in column "employee_id" violates not-null constraint
INSERT INTO employees VALUES(1, null),(2,'Marketing'),(3, 'HR'),(4, 'IT'),(5, 'Production');--  no error when put null for department_name

-- 1.2 Define primary key when changing the existing table structure
drop table  if exists employees cascade;
CREATE TABLE employees (
 employee_id int,
 department_name VARCHAR (255)
);
INSERT INTO employees VALUES(1, 'Sales'),(2,'Marketing'),(3, 'HR'),(4, 'IT'),(5, 'Production');


ALTER TABLE employees ADD PRIMARY KEY (employee_id); -- add primary key
ALTER TABLE employees drop constraint employees_pkey; -- drop primary key. Because we didn’t specify a name for the foreign key constraint explicitly, PostgreSQL assigned a name with the pattern: table_column_pkey


-- 2. foreign key
-- 2.1 Define simple PostgreSQL foreign key constraint
CREATE TABLE employees (
 employee_id serial PRIMARY KEY,
 employee_name VARCHAR (255) NOT NULL
);


drop table if exists keys;
CREATE TABLE keys (
 employee_id INT PRIMARY KEY,
 age INT  NOT NULL,
 FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
); 

-- 2.2 Add foreign key constraint to existing table
drop table if exists keys;
CREATE TABLE keys (
 employee_id INT PRIMARY KEY,
 age INT  NOT NULL); 

ALTER TABLE keys ADD FOREIGN KEY (employee_id) REFERENCES employees (employee_id);

-- 2.3 Drop existing foreign key constraint
ALTER TABLE keys DROP CONSTRAINT keys_employee_id_fkey;

/********** create examples for joining ***********/
drop table if exists departments;
CREATE TABLE
IF NOT EXISTS departments (
 department_id serial PRIMARY KEY,
 department_name VARCHAR (255) NOT NULL
);

drop table if exists employees;
CREATE TABLE
IF NOT EXISTS employees (
 employee_id serial PRIMARY KEY,employee_name VARCHAR (255),
 department_id INTEGER
);

INSERT INTO departments (department_name, updateTime)VALUES('Sales'),('Marketing'),('HR'),('IT'),('Production');
INSERT INTO employees ( employee_name,department_id,updateTime)VALUES('Bette Nicholson', 1),('Christian Gable', 1),('Joe Swank', 2),('Fred Costner', 3),('Sandra Kilmer', 4),('Julia Mcqueen', NULL);


/***** select from multiple tables *****/
select * from employees;
select * from departments;
select employee_name, department_name from employees e, departments d where d.department_id = e.department_id; 
select employee_name, department_id, department_name from employees e, departments d where d.department_id = e.department_id;-- wrong: column reference "department_id" is ambiguous
select employee_name, d.department_id, department_name from employees e, departments d where d.department_id = e.department_id; -- when select value from common columns, specify which table it comes from


/********** Joining multiple tables ***********/
-- 1. natural join
SELECT employee_name, department_name FROM employees e NATURAL JOIN departments d; -- by default, it's natural inner join
SELECT employee_name, department_name FROM employees e NATURAL LEFT JOIN departments d;
-- 2. full outer join
SELECT employee_name, department_name FROM employees e FULL OUTER JOIN departments d ON d.department_id = e.department_id;
SELECT employee_name, department_name FROM employees e FULL OUTER JOIN departments d USING (department_id);-- -- equivalent to above clause
-- 3. inner join
SELECT employee_name, department_name FROM employees e INNER JOIN departments d ON d.department_id = e.department_id; -- shouldn't see any empty value in columns
-- 4. left/right join
 SELECT employee_name, department_name FROM employees e RIGHT JOIN departments d ON d.department_id = e.department_id;-- shouldn't see any empty value in columns from right table(in this case, it's "departments")
-- 5. cross join
 SELECT employee_name, department_name FROM employees e CROSS JOIN departments d;-- there are 5 rows in employees and 6 rows in departments, so we get 30 rows after doing cross join
 --EXISTS (SELECT 1 FROM tbl WHERE condition);



/******** create tables *********************/
drop table if exists employees;
CREATE TABLE employees (
 employee_id serial PRIMARY KEY,
 employee_name VARCHAR (255) NOT NULL
);
drop table if exists keys; 

CREATE TABLE keys (
 employee_id INT PRIMARY KEY,
 age INT  NOT NULL,
 FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
); -- key employees

drop table if exists hipos;
CREATE TABLE hipos (
 employee_id INT PRIMARY KEY,
 age INT NOT NULL,
 FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
); --  high potential employees
INSERT INTO employees (employee_name) VALUES ('Joyce Edwards'),('Diane Collins'),('Alice Stewart'),('Julie Sanchez'),('Heather Morris'),('Teresa Rogers'),('Doris Reed'),('Gloria Cook'),('Evelyn Morgan'),('Jean Bell');
INSERT INTO keys VALUES(1, 22),(2, 31),(5, 25),(7, 54);
INSERT INTO hipos VALUES(9, 21),(2, 31),(5, 25),(10, 36);


/********* performing set operations **********/
select employee_id from keys UNION select employee_id from hipos -- select employees who are either key, or high potential
select employee_id from keys INTERSECT select employee_id from hipos; -- select employees who are both key, and high potential
select employee_id from keys EXCEPT select employee_id from hipos; -- select employees who are key, but not high potential

/******** subquery ************/
select age from hipos where age>(select avg(age) from hipos) -- select  high potential employees whose age is above all high potential employees' average age
select age from hipos where age>(select avg(age) from (select age from hipos union select age from keys) as unite) -- select high potential employees whose age is above all the employees' average age
select avg(age) from (select age from hipos union select age from keys) as unite -- subquery in FROM must have an alias; average age of all people is 31.5

/******** Import & Export **************/
-- export
copy employees to 'c:/users/xingjia zhang/desktop/employees.csv' delimiter ',' csv header;
-- if see error " Permission denied": open sql shell, and use \copy employees to 'c:/users/xingjia zhang/desktop/employees.csv' delimiter ',' csv header;
-- import
-- step1: create empty table
 CREATE TABLE employees_copy (
 id serial PRIMARY KEY,
 name VARCHAR (255) NOT NULL
);
-- step2: import data
copy employees_copy (id, name)from 'c:/users/xingjia zhang/desktop/employees.csv' delimiter ',' csv header;
-- if see error " Permission denied": open sql shell, and use \copy employees_copy ...




