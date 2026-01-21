create database Attrition;
use Attrition;

#1.How many total employees are there?
select count(EmployeeCount) as Total_Employees
from attrition_dataset;

#2.How many employees have left the company?
select count(Employeecount) as Current_Total_Employees
from attrition_dataset
where Attrition='Yes';

#3.What is the attrition rate (percentage)?
create view view1 as
select count(Attrition)
where attrition='Yes';


#4.How many employees are older than 40.
alter table attrition_dataset
change column ï»¿Age Age int;
select count(Age)
from attrition_dataset
where Age>40;


#5.Show the list of employees who have worked for more than 10 years.
select EmployeeNumber, TotalWorkingYears 
from Attrition_dataset
where TotalWorkingYears>10;


#6.Show attrition count by department.
select count(Attrition) as Total_Attrition,Department
from Attrition_dataset
where Attrition='Yes'
group by Department
order by Total_Attrition desc;

#7.Show attrition count by job role.
select count(Attrition) as Total_Attrition,JobRole
from Attrition_dataset
where Attrition='Yes'
group by JobRole
order by Total_Attrition desc;

#8.Show average monthly income by department.
select avg(MonthlyIncome) as avg_income,Department
from attrition_dataset
group by Department
order by avg_income;

#9.Show average total working years by education field.
select avg(TotalWorkingYears) avg_years,EducationField
from attrition_dataset
group by EducationField
order by avg_years;

#10.Show number of employees by marital status.
select count(EmployeeNumber)
from attrition_dataset
where Maritalstatus='Married';


#11.Count how many employees with overtime left the company.
select * from attrition_dataset;
select count(attrition)
from attrition_dataset
where overtime='Yes';

#12.Find the average income of employees who left vs. who stayed.
select Attrition,avg(MonthlyIncome) as Avg_Income
from attrition_dataset
group by Attrition;

 #13.Classify employees into salary bands (low, medium, high) based on MonthlyIncome.
 select EmployeeNumber,MonthlyIncome,
 Case
 when MonthlyIncome<5000 then 'Low'
 when MonthlyIncome Between 5000 and 15000 then 'Medium'
 else 'High'
 end as Salary_Band
 from attrition_dataset;

#14.Classify employees into Age Group (Young,Adult,Senior) based on Age.
Select EmployeeNumber,Age,
Case
When Age Between 18 and 30 then 'Young'
when Age Between 31 and 50 then 'Adult'
else 'Senior'
end as 'Age Group'
from attrition_dataset;

#15.Create a flag for "high risk" employees (low satisfaction + overtime + short tenure).
select EmployeeNumber,JobSatisfaction,Overtime,YearsAtCompany,
case
when Jobsatisfaction<=2 and overtime='Yes'and YearsAtCompany<=2 then 'High_Risk'
else 'Normal'
End as 'Flags'
from attrition_dataset;


#16.Classify work-life balance as 'Poor', 'Average', 'Good', 'Excellent' using CASE.
select EmployeeNumber,
Case
When WorkLifeBalance=1 then 'Poor'
when WorkLifeBalance Between 2 and 3 then 'Average'
else 'Excellent'
end as 'WLB_Rating'
from attrition_dataset;

#17.Is attrition higher for employees with no stock options?
SELECT StockOptionLevel,COUNT(EmployeeCount) AS total_employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attritions,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(EmployeeCount)  AS attrition_rate_percent
FROM attrition_dataset
GROUP BY StockOptionLevel;


#18.Is attrition more common in employees with fewer training sessions?
SELECT TrainingTimesLastYear,COUNT(EmployeeCount) AS total_employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attritions,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(EmployeeCount)  AS attrition_rate_percent
FROM attrition_dataset
GROUP BY TrainingTimesLastYear
ORDER BY TrainingTimesLastYear;

#19.Which job role has the highest attrition rate?
select JobRole,count(EmployeeCount) as TotalEmployee,
Sum(case when Attrition='yes' then 1 else 0 end) as Attrition,
Round(sum(case when Attrition='yes' then 1 else 0 end)*100/ count(EmployeeCount),2) as Atttrition_rate_percent
from attrition_dataset
group by JobRole
order by Jobrole;


#20.Which age group has the most attrition?
select count(EmployeeCount) as Total_Employee,
case when Age between 18 and 30 then 'Young' 
when age between 31 and 50 then 'Adult'
else 'Senior'
end as Age_Group,
sum(case when Attrition='Yes' then 1 else 0 end) as Attritions,
Round(sum(case when Attrition='yes' then 1 else 0 end)*100/Count(Employeecount),2) as Attrition_Percent
from Attrition_dataset
group by Age_Group
order by attrition_Percent;


#21.Is attrition rate different by gender?
select Gender,count(EmployeeCount) as TotalEmployee,
Sum(case when Attrition='yes' then 1 else 0 end) as Attrition,
Round(sum(case when Attrition='yes' then 1 else 0 end)*100/ count(EmployeeCount),2) as Atttrition_rate_percent
from attrition_dataset
group by Gender;


#22.Rank employees by monthly income within each department.
select EmployeeNumber,Department,MonthlyIncome,
dense_rank() over (Partition by department order by MonthlyIncome desc) as Income_rank
from attrition_dataset;


#23.Rank employees by Age within each department.
select * from attrition_dataset;
select EmployeeNumber,Department,Age,
dense_rank() over(partition by Department order by Age) as Age_rank
from attrition_dataset;

#24.Rank employees by DailyRate within each department.
select EmployeeNumber,Department,Daily_Rate,
dense_rank() over (partition by Department order by Daily_Rate) as Dailyrate_rank
from attrition_dataset;


alter table attrition_dataset
change column `DailyRate (in Rupees)`Daily_Rate int;


#25.Is attrition more common in employees with fewer Salary Hike?
select count(EmployeeCount) as Total_Employee,
case when PercentSalaryHike between 11 and 15 then 'Low' 
when PercentSalaryHike between 16 and 21 then 'Average'
else 'High'
end as Hike_Range,
sum(case when Attrition='Yes' then 1 else 0 end) as Attritions,
Round(sum(case when Attrition='yes' then 1 else 0 end)*100/Count(Employeecount),2) as Attrition_Percent
from Attrition_dataset
group by Hike_Range
order by attrition_Percent;


























































