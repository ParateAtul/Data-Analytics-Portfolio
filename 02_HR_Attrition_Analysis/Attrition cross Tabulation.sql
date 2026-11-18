use project;
### Attrition by Age group vs gender
select agegroup as Age_group , gender,  count(employeeid) as total_employee ,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage
from hr_master where Attrition = 'yes'
group by Age_group , gender, attrition
order by Total_employee desc;


#### Attrition by Marital status vs Gender
Select Maritalstatus as marital_status, gender , count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage 
from hr_master
where attrition = 'yes'
group by marital_status, gender
order by total_employee desc;

### Attrition by Business travel VS  Marital Status
select BusinessTravel as Bussiness_travel,maritalstatus as marital_status, count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage
 from hr_master where attrition = 'yes'
group by BusinessTravel,MaritalStatus
order by total_employee desc;

### Attrition by Business travel VS  gender
select BusinessTravel as Bussiness_travel,gender, count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage
 from hr_master
where attrition = 'yes'
group by BusinessTravel,gender
order by total_employee desc;

### attrition by Department VS Marital status vs gender
select Department, maritalstatus as marital_status,gender, count(employeeid) as total_employee ,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage
from hr_master
where attrition = 'yes'
group by department, marital_status,gender
order by total_employee desc;


### attrition by deparment vs Salary salb vs Enviroment Satisfaction
select Department, Salaryslab as salary_slab, environmentsatisfaction as Environment_satisfaction,count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage
 from hr_master
where attrition = 'yes' 
group by Department,salaryslab,EnvironmentSatisfaction
order by total_employee desc;

#### attrition by department vs current role
select department, yearsoncurrentrole as current_role, count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage 
from hr_master
where attrition = 'yes'
group by Department,current_role
order by total_employee desc;

#### attrition by department vs last promoted
select department, YearsSinceLastPromotion2 as last_promoted , count(employeeid) as total_employee,
concat(round(count(employeeid) * 100.0 / (select count(employeeid) from hr_master where attrition = 'yes'),2),'%') as Attrition_Percentage 
from hr_master
where attrition = 'yes'
group by department,YearsSinceLastPromotion2
order by total_employee desc;