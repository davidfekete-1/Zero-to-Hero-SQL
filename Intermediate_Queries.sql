/*Join training*/
 
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
from employee_salary where salary > 70000 order by first_name, last_name limit 2;

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










