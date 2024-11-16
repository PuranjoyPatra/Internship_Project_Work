# Task 2: Ad Hoc aka Analysis

-- 1) What is the total count of distinct employee names within the dataset?
SELECT count(distinct name) FROM atliq_vi.attendance; 

-- 2) Calculate the work-from-home (WFH %) percentage in the month of May.
SELECT (COUNT(*)/(select count(*) from attendance where month = "May" and status in ("WFH", "WFO")))*100 
FROM attendance WHERE status = "WFH" AND month = "May";



-- 3) Determine which day of the week had the highest attendance percentage in the month of June.

with cte1 as(
select day, count(*) as total_working_days
from attendance where month = "Jun" and status not in ("WO")
group by day),

cte2 as(
select day, count(*) as total_present from attendance
 where month = "Jun" and status in ("WFH", "WFO")
group by day)

select cte1.day, (total_present/total_working_days)*100 as attend_pct from cte1
join cte2 on cte1.day = cte2.day 
order by attend_pct desc;



-- 4) Find out the number of employees who had a WFH percentage greater than 10% in the month of April.
with cte1 as (select name, count(*) AS tot_wfh from attendance
where status = "WFH" and month= "Apr"
group by name),

cte2 as (select name, count(*) as total_present from attendance 
where month = "Apr" and status in ("WFH", "WFO")
group by name)

select (tot_wfh/total_present)*100 as wfh_pct from cte1 
join cte2 on cte1.name = cte2.name
having wfh_pct > 10


