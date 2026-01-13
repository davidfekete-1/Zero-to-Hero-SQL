
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
DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER insert on employee_salary
	FOR EACH ROW
BEGIN
	INSERT INTO employee_demographics(employee_id, first_name, last_name)
	VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
values (14, 'Rudolf', 'McGregor', 'Film manufacture', 150000, 2);


/*EVENTS*/

SELECT * from employee_demographics;

DELIMITER $$
create event delete_retirees
on schedule every 30 SECOND
do
begin
	DELETE
    from employee_demographics
    where age > 60;
end $$
DELIMITER ;








