-- ROLLING SUM SALARY

-- The following table shows the monthly salary for an employee for the first nine months in a given year. 
-- From this, write a query to return a table that displays, for each month in the first half of the year,
--  the rolling sum of the employee’s salary for that month and the following two months, ordered chronologically

create database if not exists practicedb;
use practicedb;

create table if not exists salaries (
month integer, 
salary integer);
/* 
insert into salaries (month, salary) 
VALUES 
(1, 2000),
(2, 3000),
(3, 5000),
(4, 4000),
(5, 2000),
(6, 1000),
(7, 2000),
(8, 4000),
(9, 5000);
*/

select s1.month, 
sum(s2.salary) as salary_3mos 
from salaries s1 
join salaries s2 
on s1.month <= s2.month 
and s1.month + 3 > s2.month 
group by s1.month
having s1.month < 7
order by s1.month
;

with t1 as (
select * , 
lead(salary,1,0) over (order by month) as salary_2,
lead(salary,2,0) over (order by month) as salary_3
from salaries)
select month, salary+salary_2+salary_3 as salary_3mos from t1 where month < 7;

