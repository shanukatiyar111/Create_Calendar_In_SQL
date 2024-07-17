
-- CALENDAR CREATION FROM 2000 TO 2050 

select cast('2000-01-01' as date) as cal_date,
YEAR('2000-01-01') as cal_year ,
month('2000-01-01') as cal_month ,
day('2000-01-01') as cal_day,
DATEPART(quarter,'2000-01-01') as cal_quarter, 
datepart(MONTH , '2000-01-01') as cal_month,
DATENAME(MONTH , '2000-01-01') as cal_monthname,
DATEPART(WEEKDAY , '2000-01-01') as cal_weekday,
DATENAME(WEEKDAY , '2000-01-01') as cal_weekname


select cast('2000-01-01' as date) as cal_date
,datepart(year,'2000-01-01') as cal_year
,datepart(dayofyear, '2000-01-01') as cal_year_day
,datepart(quarter, '2000-01-01') as cal_quarter
,datepart(month, '2000-01-01') as cal_month
,datename(month, '2000-01-01') as cal_month_name
,datepart(day, '2000-01-01') as cal_month_day
,datepart(week, '2000-01-01') as cal_week
,datepart(weekday, '2000-01-01') as cal_week_day
,datename(weekday, '2000-01-01') as cal_day_name


--recursive cte 
with cte as (
select 1 as id 
union all 
select id+1 from cte 
where id<10 ) 

select * from cte 



with cte as (
select cast('2000-01-01' as date) as cal_date
,datepart(year,'2000-01-01') as cal_year
,datepart(dayofyear, '2000-01-01') as cal_year_day
,datepart(quarter, '2000-01-01') as cal_quarter
,datepart(month, '2000-01-01') as cal_month
,datename(month, '2000-01-01') as cal_month_name
,datepart(day, '2000-01-01') as cal_month_day
,datepart(week, '2000-01-01') as cal_week
,datepart(weekday, '2000-01-01') as cal_week_day
,datename(weekday, '2000-01-01') as cal_day_name

union all 

select dateadd(day, 1 , cal_date) 
,datepart(year , dateadd(day, 1 , cal_date)) 
,datepart(dayofyear, dateadd(day, 1 , cal_date)) 
,datepart(quarter, dateadd(day, 1 , cal_date)) 
,datepart(month, dateadd(day, 1 , cal_date)) 
,datename(month, dateadd(day, 1 , cal_date)) 
,datepart(day, dateadd(day, 1 , cal_date)) 
,datepart(week, dateadd(day, 1 , cal_date)) 
,datepart(weekday, dateadd(day, 1 , cal_date)) 
,datename(weekday, dateadd(day, 1 , cal_date)) 
from cte 
where cal_date < cast('2050-01-01' as date)
)

select row_number() over(order by cal_date asc ) as id , * ,
DATEFROMPARTS(YEAR(cal_date), MONTH(cal_date), 1) AS StartOfMonth ,
EOMONTH(cal_date) as end_of_month

INTO CALENDAR_DIM
from cte 
option(maxrecursion 32676) --DEFAULT RECURSION IS ALLOWED TILL 100 LOOP 

SELECT * FROM CALENDAR_DIM
