create database project;
use project;


-- 1. Enable local CSV loading
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

-- 2. Remove old table
DROP TABLE IF EXISTS zomato;

-- 3. Create table
CREATE TABLE zomato (
    RestaurantID INT,
    RestaurantName VARCHAR(255),
    CountryCode INT,
    City VARCHAR(100),
    Address VARCHAR(500),
    Locality VARCHAR(255),
    LocalityVerbose VARCHAR(500),
    Longitude DECIMAL(10,6),
    Latitude DECIMAL(10,6),
    Cuisines VARCHAR(500),
    Currency VARCHAR(100),
    Has_Table_booking VARCHAR(10),
    Has_Online_delivery VARCHAR(10),
    Is_delivering_now VARCHAR(10),
    Switch_to_order_menu VARCHAR(10),
    Price_range INT,
    Votes INT,
    Average_Cost_for_two INT,
    Rating DECIMAL(3,1),
    Datekey_Opening VARCHAR(20),
    `Rating Groups` VARCHAR(20),
    `Price Bucket` VARCHAR(30)
);

-- 4. Import CSV
LOAD DATA LOCAL INFILE 'D:/Downloads/zomato project/By SQL/Copy of Zomato Restaurant Data.csv'
INTO TABLE zomato
CHARACTER SET latin1
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 5. Check record count
SELECT COUNT(*) AS Total_Records
FROM zomato;

-- 6. Check data
SELECT *
FROM zomato
LIMIT 10;

-- 7. Check import warnings
SHOW WARNINGS;

select * from zomato;
select * from country_code;
select * from calender_table;


#Q1 Find the Numbers of Restaurants based on City and Country

select count(restaurantid) as restaurant_count,
city from zomato
group by city
limit 10;

select count(z.restaurantid) as restaurant_count,
	c.country
    from zomato z left join country_code c
    on z.countrycode = C.Country_Code
    group by c.country;
  ---------------------------------------------------------------------------------------------------------  
#2.Numbers of Restaurants opening based on Year , Quarter , Month
select ct.year, count(z.restaurantid) as restaurant_count from zomato z
left  join calender_table ct
on z.datekey_opening = ct.Datekey_Opening
group by ct.year
order by ct.year desc;

select ct.quarter,
count(z.restaurantid) as restaurant_count from zomato z
left  join calender_table ct
on z.datekey_opening = ct.Datekey_Opening
group by ct.quarter
order by ct.quarter;

select ct.monthno,
count(z.restaurantid) as restaurant_count from zomato z
left  join calender_table ct
on z.datekey_opening = ct.Datekey_Opening
group by ct.monthno
order by ct.monthno;
----------------------------------------------------------------------------------------------------------
#3 Restaurant Opening Trend and YoY Growth.

select year, 
 total_restaurant,
lag(Total_Restaurant) over(order by year) as PY_TotalRestaurant, 
(Total_Restaurant - LAG(Total_Restaurant) OVER(ORDER BY year))/LAG(Total_Restaurant) OVER(ORDER BY year) * 100 as YOY_Growth
 from (select year(Datekey_Opening) as year, count(RestaurantID) as Total_Restaurant
from zomato
group by year(Datekey_Opening) 
order by year(Datekey_Opening)) as yearly_data;
---------------------------------------------------------------------------------------------------------------
#4 Count of Restaurants based on Average Ratings
select `rating groups`,count(restaurantid) as restaurant_count
from zomato
group by `rating groups`
order by `rating groups` ;
-----------------------------------------------------------------------------------------------------------------
#5.  buckets based on Average Price of reasonable size and find out how many restaurants falls in each buckets
select `price bucket`,count(restaurantid) as Restaurant_count
from zomato
group by `price bucket`
order by `price bucket`;
--------------------------------------------------------------------------------------------------------
#6 restaurant offering table booking
select has_table_booking, count(restaurantid) AS restaurant_count,
round(count(*)*100/(select count(restaurantid)from zomato),2) as percentage
from zomato
group by has_table_booking;
--------------------------------------------------------------------------------------------------
#7 Restaurant offering online delivery
select has_online_delivery,count(restaurantid) as Restaurant_count,
round(count(*)*100/(select count(restaurantid) from zomato),2) as pecentage
from zomato
group by has_online_delivery;

#8 top 10 restaurants by votes
select restaurantname, votes,rating,city
from zomato
order by votes desc
limit 10;
-------------------------------------------------------------------------------------------------------------
#9 restaurants with max ratings and max votes
select 
restaurantname,votes,rating,city,
average_cost_for_two from zomato
where rating >=4 and average_cost_for_two = 1000
order by rating desc, votes desc;
----------------------------------------------------------------------------------------------------
#10 count restaunts by top 10 cusines
select Cuisines, count(restaurantid) as rest_count
from zomato
group by cuisines
order by rest_count desc
limit 10;
-------------------------------------------------------------------------------------------------------------
## adding column of age
alter table zomato add column age int;
set sql_safe_updates=0;
update zomato 
SET age=date_format(curdate(),'%Y')-date_format(datekey_opening,'%Y');

UPDATE zomato
SET opening_date =str_to_date(datekey_opening,'%Y-%d-%m');
---------------------------------------------------------------------------------------------
#11 rating and price by restaurant age
select
 age, 
count(restaurantid) as restaurant_count,
round(avg(rating),2) as avg_rating,
round(avg(average_cost_for_two),2) as avg_price_for_two from zomato
group by age
order by age desc;
-----------------------------------------------------------------------------------------------

#12 top 3 restaunts by city and rating > 4
SELECT
    city,
    restaurantname,
    rating,
    rnk
FROM (
    SELECT
        city,
        restaurantname,
        rating,
        dense_rank() OVER (
            PARTITION BY city
            ORDER BY rating DESC
        ) AS rnk
    FROM zomato
    WHERE rating > 4
) AS ranked
where rnk <=3
ORDER BY city, rnk ;
;
----------------------------------------------------------------------------------------
#13 cusines by rating >=4
select cuisines , count(restaurantid) as restaurant_count from zomato where rating >= 4
group by cuisines 
order by restaurant_count desc
limit 10;
--------------------------------------------------------------------------------------
#14 Top 10 Cuisine Combinations in India
SELECT 
    cuisines,
    COUNT(RestaurantID) AS TotalRestaurants,
    ROUND(AVG(rating), 1) AS Average_Rating,
    ROUND(AVG(votes), 1) AS Average_Votes
FROM zomato z
JOIN country_code c
    ON z.CountryCode = c.Country_Code
WHERE c.Country = 'India'
GROUP BY cuisines
ORDER BY TotalRestaurants DESC
LIMIT 10;
------------------------------------------------------------------
#15 Restaurants by Rating and price bucket Within Indian Cities
SELECT 
    city,
    `price bucket`,
    ROUND(AVG(rating), 1) AS average_rating,
    COUNT(RestaurantID) AS TotalRestaurant
FROM zomato z
JOIN country_code c
    ON z.countrycode = c.country_code
WHERE country = 'India'
GROUP BY city, `price bucket`
HAVING COUNT(RestaurantID) >= 5
ORDER BY city, average_rating DESC;

----------------------------------------------------------------------------------------
