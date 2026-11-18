show databases;
SELECT VERSION(), CURRENT_USER();
show databases;

use project;
select count(*) from Hr_master;
show tables;
truncate table hr_master;
drop table hr_master;

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

USE Project;

CREATE TABLE Hr_master (
    EmployeeID varchar(15),
    Age INT,
    agegroup varchar(10),
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeCount INT,
    EmployeeNumber int,
    EnvironmentSatisfaction INT,
    Gender varchar(20),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(30),
    MonthlyIncome DECIMAL(10,2),
    salaryslab varchar(10),
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(10),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    tenureband varchar(10),
    YearsInCurrentRole INT,
    yearsoncurrentrole varchar(10),
    YearsSinceLastPromotion INT,
    YearsSinceLastPromotion2 varchar(10),
    YearsWithCurrManager INT
);

LOAD DATA LOCAL INFILE "D:/Downloads/HR Analytics-Neha Tadam/By SQL/HR_master.csv"
INTO TABLE Hr_master
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from hr_master 
limit 10;
set sql_safe_updates=0;
alter table hr_master add column Age_group varchar(10);

describe hr_master;

select count(EmployeeID) as Total_Employee from hr_master;

select  gender,Attrition, count(employeeid) as total_emoloyee,
concat(round(count(employeeid)*100.0/
(select count(employeeid) from hr_master where attrition = 'yes'),2),"%")as Attrition_percentage
from hr_master where attrition = 'yes'
group by gender;

select count(employeeid) as total_employee, attrition
from hr_master where attrition = "yes"
group by gender,attrition;

select agegroup as age_group,count(employeeid) as total_employees, 
concat(round(count(employeeid)*100.0/(select count(employeeid) from hr_master where attrition = 'yes'),2),'%')
as Attrition_percentage
from hr_master where attrition = "yes"
group by agegroup
order by total_employees desc;

select BusinessTravel as Bussiness_travel, count(employeeid) as total_employees,
concat(round(count(employeeid) * 100.0 /(select count(employeeid) from hr_master
 where attrition = 'yes'),2),'%') as attrition_percentage
from hr_master where attrition = "yes"
group by bussiness_travel
order by total_employees desc;

select Department, count(employeeid) as total_employees 
,concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_percentage
from hr_master where attrition = "yes"
group by Department
order by total_employees desc;

select distancefromhome as Distance_in_km,count(employeeid) as total_employees,
concat(round(count(employeeid) *100.0 / (select count(employeeid) from hr_master 
where attrition = 'yes'),2),'%') as Attrition_percentage
from hr_master where attrition ="yes"
group by Distance_in_KM
order by total_employees desc;

select education  ,count(employeeid) as total_employee ,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master
 where attrition = 'yes'),2),'%') as Attrition_percentage
from hr_master where attrition = 'yes'
group by Education
order by total_employee desc;

Select Educationfield as Education ,count(employeeid) as total_employee,
concat(round(count(employeeid) *100.0 /(select count(employeeid) from hr_master
 where attrition = 'yes'),2),'%') As attrition_percentage 
from hr_master where attrition = 'yes'
group by Educationfield
order by total_employee desc;

select environmentsatisfaction as Environment, count(employeeid) as total_employee,
concat(round(count(employeeid) *100.0 / (select count(employeeid) from hr_master 
where attrition = 'yes'),2),'%') as attrition_percentage
from hr_master where attrition = 'yes'
group by Environment
order by total_employee desc;

select jobinvolvement as Involvement , count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 /(select count(employeeid) from hr_master
 where attrition = 'yes'),2),'%') as attrition_percentage
from hr_master where attrition = 'yes'
group by involvement
order by total_employee desc;

select joblevel as Job_Level, count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 /(select count(employeeid) from hr_master
 where attrition = 'yes'),2),'%') as attrition_percentage
from hr_master where attrition = 'yes'
group by job_level
order by total_employee desc;

select jobrole as Job_Role, count(employeeid) as total_employee
from hr_master where attrition = 'yes'
group by Job_Role 
order by total_employee desc;

select jobSatisfaction as Job_satisfaction, count(employeeid) as Total_Employee,
concat(round(count(employeeid) * 100.0 /(select count(employeeid) from hr_master
 where attrition = 'yes'),2),'%') as attrition_percentage
from hr_master where attrition = 'yes'
group by Job_Satisfaction
order by total_employee desc;

select maritalstatus as Marrital_status, count(employeeid) as Total_employee,
concat(round(count(employeeid) * 100.0 /(select count(employeeid) from hr_master
 where attrition = 'yes'),2),'%') as attrition_percentage
from hr_master where attrition = 'yes'
group by Marrital_status
order by total_employee desc;

select salaryslab as salary_slab ,count(employeeid) as Total_Employee,
concat(round(count(employeeid) * 100.0 /(select count(employeeid) from hr_master
 where attrition = 'yes'),2),'%') as attrition_percentage
from hr_master where attrition = 'yes'
group by Salary_slab
order by total_employee desc;

select percentsalaryhike as Salary_hike , count(employeeid) as total_employee,
concat(round(count(employeeid) *100.0 /(select count(employeeid) from hr_master 
where attrition = 'yes'),2),'%') as attrition_percentage
 from hr_master where attrition = 'yes'
group by percentsalaryhike 
order by total_employee desc;

select RelationshipSatisfaction as Relationship_satisfaction, count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage
from hr_master where attrition = 'yes'
group by Relationship_satisfaction
order by total_employee desc;

select stockoptionlevel as Stock_options, count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage 
from hr_master where attrition = 'yes'
group by stock_options
order by total_employee desc;

select worklifeBalance as Life_Balance, count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage
from hr_master where attrition = 'yes'
group by Life_balance
order by total_employee desc;

select Tenureband as Tenure_band, count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage
from hr_master where attrition = 'yes'
group by Tenure_band
order by total_employee desc;

select yearsoncurrentrole as years_on_current_role, count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage
from hr_master where attrition = 'yes'
group by years_on_current_role
order by total_employee desc;

select Yearssincelastpromotion2 as Last_promoted, count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage
from hr_master where attrition = 'yes'
group by last_promoted
order by total_employee desc;

