use bhavya;

-- Module 4 (SQL)


--  Database Name: HR 


-- 1.	Display all information in the tables EMP and DEPT.
      select *from employees;  
      select *from departments;

-- 2.	Display only the hire date and employee name for each employee.

      SELECT hire_date,concat(first_name,"",last_name) as employee_name from employees;
  
 -- 3. Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title      
         
         select concat(first_name,last_name,job_id) as "Employee and Title" from employees;

-- 4. Display the hire date, name and department number for all clerks.         
  select hire_date,concat(first_name,"",last_name) as  clerksfull_name,department_id from employees where job_id like '___clerk%';       

-- 5. Create a query to display all the data from the EMP table. Separate each column by acomma. Name the column THE OUTPUT                        
select concat(employee_id,',',first_name,',',last_name,',',email,',',phone_number,',',hire_date,',',job_id,',',salary,',',commission_pct,',',manager_id,',',department_id)as THE_OUTPUT from employees;

-- 6. Display the names and salaries of all employees with a salary greater than 2000.
select concat(first_name,"",last_name) as full_name,salary from employees where salary>2000;

-- 7. Display the names and dates of employees with the column headers "Name" and "Start Date"
select concat(first_name,"",last_name) as 'NAME',hire_date as start_date from employees;

-- 8. Display the names and hire dates of all employees in the order they were hired.
select concat(first_name,"",last_name) as emp_name,hire_date from employees order by hire_date;

-- 9. Display the names and salaries of all employees in reverse salary order.
select concat(first_name,"",last_name) as e_name,salary from employees order by salary desc;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order.
select concat(first_name,"",last_name) as emp_name,department_id from employees where commission_pct is not null order by salary desc;

-- 11. Display the last name and job title of all employees who do not have a manager
SELECT last_name,job_id from employees where manager_id is null;

-- 12. Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000
select last_name,job_id,salary from employees where job_id in('sa_rep','st_clerk') and salary not in(2500,3500,5000);

-- 13. Display the maximum, minimum and average salary and commission earned.
select max(SALARY),min(SALARY),avg(SALARY),max(commission_pct),min(commission_pct),avg(commission_pct) from employees;

-- 14.  Display the department number, total salary payout and total commission payout for each department.
select department_id,sum(salary),sum(commission_pct) from employees group by department_id;

-- 15. Display the department number and number of employees in each department.
select department_id,count(employee_id) from employees group by department_id;

-- 16. Display the department number and total salary of employees in each department.
select department_id,sum(salary) from employees group by department_id;

-- 17. Display the employee's name who doesn't earn a commission. Order the result set without using the column name
select concat(first_name,"",last_name)as employee_name from employees where commission_pct is  null order by 1;

-- 18. Display the employees name, department id and commission. If an Employee doesn't earn the commission, then display as 'No commission'. Name the columns appropriately
SELECT employee_id, first_name, department_id, 
       CASE 
         WHEN commission_pct IS NULL THEN 'No commission' 
         ELSE commission_pct 
       END AS commission
FROM employees;

-- 19. Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn the commission, then display as 'No commission. Name the columns appropriately
SELECT first_name  AS "Name", salary, 
       CASE 
           WHEN commission_pct IS NULL THEN 'No commission_pct' 
           ELSE commission_pct * 2 
       END AS "Commission_pct x 2" 
FROM employees;

-- 20. Display the employee's name, department id who have the first name same as another employee in the same department
select 
    concat(e.first_name,"",e.last_name) as employee_name,
    e.department_id
from
    employees e
join
    employees m
on
    e.first_name=m.first_name
    and e.department_id=m.department_id
    and e.employee_id<>m.employee_id;

-- 21. Display the sum of salaries of the employees working under each Manager.
select
        sum(salary) 
    from
        employees
    group by manager_id;

-- 22. Select the Managers name, the count of employees working under and the department ID of the manager.
select
        concat(first_name,"",last_name) as manager_name,
        count(e.employee_id)as employee_count,d.department_name
    from employees e join departments d on e.manager_id=d.manager_id and e.department_id=d.department_id group by e.employee_id,d.department_name;    

-- 23. Select the employee name, department id, and the salary. Group the result with the manager name and the employee last name should have second letter 'a!
    select concat(first_name,"",last_name)as employee_name,department_id,salary from employees where last_name like '_a%';

-- 24. Display the average of sum of the salaries and group the result with the department id. Order the result with the department id.
    select department_id,avg(salary) from employees group by department_id order by department_id;

-- 25. Select the maximum salary of each department along with the department id.
    select department_id,max(salary) from employees group by department_id;

-- 26. Display the commission, if not null display 10% of salary, if null display a default value 1.
    select coalesce(commission_pct,salary * 0.1,1) as "commission" from employees;

-- 27. . Write a query that displays the employee's last names only from the string's 2-5th position with the first letter capitalized and all other letters lowercase, Give each column an appropriate label.
    select substring(last_name,2,4) as "last name substring" from employees;

-- 28. Write a query that displays the employee's first name and last name along with a " in between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.
    select concat(first_name,"",last_name)as"full name",monthname(hire_date)as "join month" from employees;

-- 29. Write a query to display the employee's last name and if half of the salary is greater than ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 1500 each. Provide each column an appropriate label.
    select last_name,case when salary/2>10000 then salary * 1.10 else salary *1.115 end as "Updated Salary",1500 as "Bonus" from employees;

-- 30. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, department id, salary and the manager name all in Upper case, if the Manager name consists of 'z' replace it with '$!
SELECT 
    CONCAT(SUBSTR(employee_id, 1, 2), '00', SUBSTR(employee_id, 3), 'E') AS modified_employee_id,
    UPPER(department_id) AS department_id,
    UPPER(salary) AS salary,
    UPPER(REPLACE(CONCAT(first_name, ' ', last_name), 'z', '$!')) AS manager_name
FROM employees;

-- 31. Write a query that displays the employee's last names with the first letter capitalized and all other letters lowercase, and the length of the names, for all employees whose name starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names
SELECT LAST_NAME AS "Last Name", LENGTH(last_name) AS "Length"
FROM employees
WHERE last_name LIKE 'J%' 
   OR last_name LIKE 'A%' 
   OR last_name LIKE 'M%'
ORDER BY last_name;

-- 32. Create a query to display the last name and salary for all employees. Format the salary to be 15 characters long, left-padded with $. Label the column SALARY
SELECT last_name,lpad(salary,15,'₹') as salary from employees;

-- 33. Display the employee's name if it is a palindrome.
SELECT concat(first_name,"",last_name)as employee_name
FROM employees
WHERE first_name = REVERSE(first_name)
   OR last_name = REVERSE(last_name);

-- 34. Display First names of all employees with initcaps.
SELECT first_name
FROM employees;

-- 35. From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column.
select substr(street_address,instr(street_address,'')+1,instr(substr(street_address,instr(street_address,'')+1),'')-1) from locations;

-- 36. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end. Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name.
SELECT LOWER(CONCAT(SUBSTRING(First_Name, 1, 1), Last_Name, '@systechusa.com')) AS Email_Address, First_Name 
FROM employees;

-- 37. Display the names and job titles of all employees with the same job as Trenna.
SELECT first_name, job_id
FROM employees
WHERE job_id = (
    SELECT job_id
    FROM employees
    WHERE first_name = 'Trenna');

-- 38. Display the names and department name of all employees working in the same city as Trenna.
select e.first_name,d.department_name from employees e join departments d using(department_id) join locations l on l.location_id=d.location_id where l.city=(select l.city from employees where first_name='trenna');

-- 39. Display the name of the employee whose salary is the lowest.
select concat(first_name,"",last_name)as 'ename' from employees where salary=(select min(salary) from employees);

-- 39. Display the names of all employees except the lowest paid.
select concat(first_name,"",last_name) as 'ename',salary from employees where salary>(select min(salary) from employees);

-- 40. Write a query to display the last name, department number, department name for all employees.
select e.last_name,e.department_id,d.department_name 
from employees e
join departments d
using(department_id);

-- 41. Create a unique list of all jobs that are in department 4. Include the location of the department in the output.
select distinct e.job_id,d.location_id
from employees e
join departments d
on e.department_id=d.department_id
where d.department_id=4;

-- 42. Write a query to display the employee last name,department name,location id and city of all employees who earn commission.
SELECT 
e.last_name,
d.department_name,
d.location_id,
l.city 
FROM 
employees e
JOIN 
departments d ON e.department_id = d.department_id
JOIN 
locations l ON d.location_id = l.location_id
WHERE 
e.commission_pct IS NOT NULL;

-- 43. Display the employee last name and department name of all employees who have an 'a' in their last name.
select e.last_name,d.department_name
from employees e
join departments d
on  e.department_id=d.department_id
where e.last_name like '%a%';

-- 44. Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA.
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE location_id = (
SELECT location_id
FROM locations 
WHERE city = 'Atlanta');

-- 45. Display the employee last name and employee number along with their manager's last name and manager number.
SELECT e.last_name AS employee_last_name, 
       e.employee_id AS employee_number, 
       m.last_name AS manager_last_name, 
       m.employee_id AS manager_number
FROM employees e
 JOIN employees m ON e.manager_id = m.employee_id;

-- 46. Display the employee last name and employee number along with their manager's last name and manager number (including the employees who have no manager).
SELECT 
  e.last_name AS employee_last_name, 
  e.employee_id AS employee_number, 
  m.last_name AS manager_last_name, 
  m.employee_id AS manager_number
FROM
  employees e
 JOIN 
  employees m ON e.manager_id = m.employee_id;

-- 47. Create a query that displays employees last name,department number,and all the employees who work in the same department as a given employee.
SELECT e.last_name, e.department_id
FROM employees e
WHERE e.department_id = (
    SELECT department_id 
    FROM employees 
    WHERE employee_id = given_employee_id
);

-- 48. Create a query that displays the name,job,department name,salary,grade for all employees. Derive grade based on salary(>=50000=A, >=30000=B.
select first_name,job_id,department_name,salary,
      case
      when salary>=50000 then 'A'
       when salary>=30000 then 'B'
   else'c'
      end as 'grade'from employees join departments using(department_id);
      
-- 49. Display the names and hire date for all employees who were hired before their managers along withe their manager names and hire date. Label the columns as Employee name, emp_hire_date,manager name,man_hire_date.
  SELECT concat(e.first_name,"",e.last_name) AS "Employee name",
       e.hire_date AS "emp_hire_date",
       concat(m.first_name,"",m.last_name) AS "manager name",
       m.hire_date AS "man_hire_date"
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;

-- 50. Write a query to display the last name and hire date of any employee in the same department as SALES.
select last_name,hire_date
from employees
where department_id=(
select department_id
from departments
where department_name='Sales');

-- 51. Create a query to display the employee numbers and last names of all employees who earn more than the average salary. Sort the results in ascending order of salary.
select employee_id,last_name
from employees
where salary>(select avg(salary) from employees)
order by salary asc;

-- 52. Write a query that displays the employee numbers and last names of all employees who work in a department with any employee whose last name contains a' u.
select employee_id,last_name
from employees
where department_id in(
select department_id from employees
where last_name like '%U%');

-- 53. Display the last name, department number, and job ID of all employees whose department location is ATLANTA.
SELECT last_name, department_id, job_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location_id = (
        SELECT location_id
        FROM locations
        WHERE city = 'ATLANTA'));

-- 54. Display the last name and salary of every employee who reports to FILLMORE.
select last_name,salary
from employees
where manager_id=(
select manager_id from employees
where last_name='FILLMORE');

-- 55. Display the department number, last name, and job ID for every employee in the OPERATIONS department.
select department_id,last_name,job_id
from employees
where department_id=(
select department_id from departments where department_name='OPERATIONS');

-- 56. Modify the above query to display the employee numbers, last names, and salaries of all employees who earn more than the average salary and who work in a department with any employee with a 'u'in their name.
SELECT employee_id,last_name,salary
from employees
where salary in(select avg(salary)from employees
where department_id in(select department_id from employees 
where first_name like '%U%'));

-- 57. Display the names of all employees whose job title is the same as anyone in the sales dept.
select e.first_name,e.last_name
from employees e
where job_id in( select job_id from employees
where department_id=(select department_id from departments
where department_name='sales'));

-- 58. Write a compound query to produce a list of employees showing raise percentages, employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, employees in department 2 are given a 10% raise, employees in departments 4 and 5 are given a 15% raise, and employees in department 6 are not given a raise.
SELECT 
    Employee_ID,
    Salary,
    CASE
        WHEN Department_ID IN (1, 3) THEN 0.05
        WHEN Department_ID = 2 THEN 0.10
        WHEN Department_ID IN (4, 5) THEN 0.15
        WHEN Department_ID = 6 THEN 0
        ELSE 0 
    END AS Raise_Percentage
FROM employees;

-- 59. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries.
select last_name,salary 
from employees
order by salary desc
LIMIT 3;

-- 60. Display the names of all employees with their salary and commission earned. Employees with a null commission should have O in the commission column.
SELECT concat(first_name,"",last_name)as employee_name, salary, COALESCE(commission_pct, 0) AS commission
FROM employees;

-- 61. Display the Managers (name) with top three salaries along with their salaries and department information.
SELECT 
    m.first_name,
    m.last_name,
    m.salary,
    d.department_name
FROM 
    employees m
JOIN 
    departments d ON m.department_id = d.department_id
WHERE 
    m.employee_id IN (
        SELECT manager_id
        FROM employees
        GROUP BY manager_id
    )
ORDER BY 
    m.salary DESC
LIMIT 3;






		
    


