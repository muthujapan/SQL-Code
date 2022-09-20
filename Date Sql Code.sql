truncate table DATE_DIM01;
declare @startdate date = '2017-01-01';
declare @enddate date = '2021-01-20';

with CTE_Calendar as 
(Select @startdate as DATE_DIM
UNION ALL 
Select DATEADD(dd,1,DATE_DIM)
from CTE_Calendar
WHERE DATEADD(dd,1,DATE_DIM) <= @enddate )

insert into DATE_DIM01  
Select DATE_DIM as date_clmn,
DAY(CONVERT(DATETIME,DATE_DIM,103)) as date_day,
MONTH(CONVERT(DATETIME,DATE_DIM,103)) as date_month,
YEAR(CONVERT(DATETIME,DATE_DIM,103)) as date_year,
DATENAME(month,CONVERT(DATETIME,DATE_DIM,103)) as date_month_name,
DATENAME(dw,CONVERT(DATETIME,DATE_DIM,103)) as date_weekday,
concat('Q',DATENAME(qq,CONVERT(DATETIME,DATE_DIM,103))) as date_quarter
from CTE_Calendar

OPTION (MAXRECURSION 10000);

select * from DATE_DIM01
create table DATE_DIM01(date_clmn date,date_day nvarchar(max),date_month nvarchar(max) ,date_year nvarchar(max), date_month_name nvarchar(max),
date_weekday nvarchar(max),date_quarter nvarchar(max))
