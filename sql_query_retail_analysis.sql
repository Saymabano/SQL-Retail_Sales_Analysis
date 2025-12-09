-- SQL Retail_Sales_Analysis
create database retail_analysis;

-- Create a Table
drop table if exists retail_sales_analysis;

create table retail_sales_analysis
(

     transaction_id INT PRIMARY KEY,	
     sale_date DATE,	 
     sale_time TIME,	
     customer_id	INT,
     gender	VARCHAR(15),
     age	INT,
     category VARCHAR(15),	
     quantity	INT,
     price_per_unit FLOAT,	
     cogs	FLOAT,
     total_sale FLOAT
);

select * from retail_sales_analysis;

-- Data Cleaning 

SELECT * FROM retail_sales_analysis;
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- 
DELETE FROM retail_sales_analysis;
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration or EDA

-- Unique Customers
select count(distinct(customer_id)) as total_cus 
from retail_sales_analysis;

-- Total Categories
select count(distinct(category)) as total_categories
from retail_sales_analysis;

--  Name of category
select distinct category as category_name
from retail_sales_analysis;

--  sum of total sales as category wise
select distinct category , sum(total_sale)
from retail_sales_analysis
group by category;

select distinct category , count(total_sale)
from retail_sales_analysis
group by category;

-- Data Analysis & Key Problems


--  Retrive data of clothing month of Nov
select count(total_sale) from retail_sales_analysis
where sale_date = '2022-11-05';


select * from retail_sales_analysis
where sale_date = '2022-11-05';


-- Retrive data of clothing 
select * from retail_sales_analysis
where 
   category = 'Clothing'
   and 
   quantiy >=4 
   and
   TO_CHAR(sale_date,'YYYY-MM') = '2022-11';

-- Calculate total_sale of each category
   
select distinct category , 
  sum(total_sale) as net_sale,
  count(*)as total_order
from retail_sales_analysis
group by category;

select * from retail_sales_analysis;

--  avg age of female Beauty customers

select
   round(avg(age),2) as avg_age
from 
   retail_sales_analysis
where
   category = 'Beauty'
and gender = 'Female';

--  avg age of beauty customers
select
   round(avg(age),2) as avg_age
from 
   retail_sales_analysis
where
   category = 'Beauty';
   
-- Transaction of total sale more than 1000

select * from retail_sales_analysis
where 
   total_sale > 1000;

-- Transaction made by each gender on each category
select  
  count(transactions_id ) as transaction_i,
  gender,
  category
  from retail_sales_analysis
  group by gender ,category;

 --  Calculate sale of each month
select year,month ,avg_sale
from (
  select 
      Extract(Year from sale_date) as Year,
      Extract(Month from sale_date) as Month,
      avg(total_sale) as avg_sale ,
      rank() over(partition by Extract(Year from sale_date) order by avg(total_sale) desc ) as rank
   from retail_sales_analysis
   group by 1,2)
as t1
where rank = 1;
  -- order by 1,3 desc;

  
-- top 5 customers based on higest sale
 select 
   customer_id ,
 sum( total_sale)
 from retail_sales_analysis
 group by 1
 order by  2 desc
 limit 5;

 -- Unique Customer
 select 
 count(distinct customer_id)as unique_customer,
 category 
 from retail_sales_analysis
 group by category;

 -- Order based on shifts 
with hourly_sale as
(
  select *,
    case 
      when extract(hour from sale_time) <12 then 'Morning'
      when  extract(hour from sale_time) between 12 and 17 then 'Afternoon'
      else 'evening' 
     end as shift
   from retail_sales_analysis
 )
 select 
     count(* )as total_order,
	 shift 
 from hourly_sale
 group by shift;


  