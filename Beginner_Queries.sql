/*Listing the employee_demographics*/
SELECT * from parks_and_recreation.employee_demographics;

select * from parks_and_recreation.employee_demographics where first_name = 'Tom';
select * from parks_and_recreation.employee_demographics where birth_date > '1980-01-01';
/*----------------------------------------------------------------*/

/*Next Table*/

/*Listing the employee_salary table */
SELECT * from parks_and_recreation.employee_salary;

/*List the Highes salary for Office Manager position*/
select * from parks_and_recreation.employee_salary where occupation = 'Office Manager' and salary >= '50000' order by salary desc limit 1;

/*Listing the higher salary people as 50000 or 1 Department workers*/
select * from parks_and_recreation.employee_salary where salary >= '57000' or dept_id = '1';

/*Listing the Entrepreneur or Assistant to the Director of Parks and Recreation department */
select * from parks_and_recreation.employee_salary where occupation IN ('Entrepreneur','Assistant to the Director of Parks and Recreation');

/* Listing the Salary and Department where the salary is min 57000 */
select distinct salary, dept_id from parks_and_recreation.employee_salary where salary >=57000;

/*Top salary in the Department*/
select max(salary), dept_id from parks_and_recreation.employee_salary group by dept_id limit 1;

/*Lowest salary in  the Department */
select min(salary), dept_id from parks_and_recreation.employee_salary group by dept_id limit 1;

/*Average salary by the company*/
select avg(salary) from parks_and_recreation.employee_salary;




