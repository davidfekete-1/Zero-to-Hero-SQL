/*Join*/
 
/*Based on the employee_id the Name, Age, Salary and Occupation will match*/
select dem.first_name, dem.last_name, dem.age, dep.occupation, dep.salary from employee_demographics as dem join employee_salary as dep on dem.employee_id = dep.employee_id;


/*Unions*/
/*Filter out the highly paid man and woman, giving them a label with the salary of min 70.000 */
select first_name, last_name , 'Elder man' as label
 from employee_demographics where age > 40 and gender ='Male'
Union
select first_name, last_name , 'Elder Lady' as label
 from employee_demographics where age > 40 and gender ='Female'
 Union
select first_name, last_name , 'Highly paid' as label
from employee_salary where salary > 70000 order by first_name, last_name;

/*---------------------------------------------------*/

/*String*/
/*Lenght*/
select first_name, length(first_name) from employee_demographics order by length(first_name) desc;

/*Upper, Lower*/
select first_name, upper(first_name) from employee_demographics order by length(first_name) desc;
select first_name, lower(first_name) from employee_demographics order by length(first_name) desc;

/*Left, Right, Substring*/
select left(first_name, 4) from employee_demographics;
select right(first_name, 4) from employee_demographics;
select left(first_name, 4), right(first_name, 2), substring(first_name,3,4), birth_date, substring(birth_date, 6,2) as Birht_month  from employee_demographics;

/*Case statement*/
/*Salary raise calculation and if the Employee works at Finance then 10% bonus */
select first_name, last_name, salary, 
case
	when salary <=50000 then salary*1.05
	when salary between 51000 and 100000 then salary*1.07
end as Yearly_raise,
case
	when dept_id = 6 then salary*0.1
end as Bonus
from employee_salary;


/*IF the age is less than 40 and its a Male give a bonus, plus write out the salary*/
/*I used here Join, Case statement*/
select dem.first_name, dem.last_name, sal.salary, dem.age, sal.dept_id,
case
 when age < 40 and gender ='Male' then 'Give 10% Bonus'
end as EOY_Bonus
from employee_demographics as dem
join employee_salary as sal on dem.employee_id = sal.employee_id;

/*----------------------------------------------------------------*/

/*Subquery*/
/*Giving back all the name from Employee_demograph table by filtering in Salary table*/
select first_name, last_name from employee_demographics where employee_id IN
(select employee_id from employee_salary where salary >= 60000);

/*Listing only the Office Manager position. The position is stored in employee_salary table but the name comes from employee_demographics table  */
select first_name, last_name from employee_demographics where employee_id in
(select employee_id from employee_salary where occupation = 'Office Manager');

/*-------------------------------------------------------------------------*/

/* Window function*/

select dem.first_name, dem.last_name, gender,  salary, sum(salary) over(Partition by gender order by dem.employee_id) as Rolling
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;













