/*CTE*/
with bigbrother as 
(
select first_name, last_name, avg(age) 
from employee_demographics
where gender = 'Male'
)
select first_name, last_name from bigbrother;

/*Temp Table*/

CREATE temporary table salarytable
select * from employee_salary where salary >= 50000;

select * from salarytable

/*Stored Procedures*/
DELIMITER $$
create procedure large_salary2()
BEGIN
select * from employee_salary where salary >= 50000;
select * from employee_salary where salary < 100000;
END $$

call large_salary();


/*Triggers and Events*/


