create database retail_sales;
use  retail_sales;


create table sales_tb(
						transactions_id	int primary key,
                        sale_date date,
                        sale_time	time,
                        customer_id	int,
                        gender	varchar(10),
                        age	int,
                        category varchar(15),
                        quantiy	int,
                        price_per_unit float,
                        cogs float,
                        total_sale float);
ALTER TABLE sales_tb 
CHANGE COLUMN quantiy quantity INT;

select * from sales_tb;

select count(*) from sales_tb;

select * from sales_tb where transactions_id is null
or  sale_date is null
or  sale_time is null
or  customer_id is null
or  gender is null
or  age is null
or  category is null
or  quantiy is null
or  price_per_unit is null
or  cogs is null
or  total_sale is null
;

select count(*) as total_sale from sales_tb;

select count(distinct customer_id) as total_sale from sales_tb;

select distinct category from sales_tb;

#1

select * from sales_tb where sale_date ='2022-11-05';

#2

SELECT * 
FROM sales_tb 
WHERE category = 'Clothing' 
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' 
  AND quantity >= 4;
  
#3
select 
	category,
    sum(total_sale) as net_sale,
    count(*) as total_orders 
from sales_tb
group by category;

#4
select round(avg(age),2) as avg_age from sales_tb
where category='Beauty';


#5
SELECT gender, SUM(total_sale) AS total_revenue
FROM sales_tb
GROUP BY gender;

#6
select * from sales_tb where total_sale>1000;

#7
select category,gender,count(*) as total_trans from sales_tb 
group by category,
gender
order by category;

#8 
select 
       year,
       month,
    avg_sale
from 
(    
select 
    EXTRACT(year from sale_date) as year,
    EXTRACT(month from sale_date) as month,
    avg(total_sale) as avg_sale,
    rank() over(partition by EXTRACT(year from sale_date) order by avg(total_sale) desc) as ranking
from sales_tb
group by year, 2
) as t1
where ranking = 1;

#9
select extract(year from sale_date) as year,
	extract(month from sale_date) as month,
    avg(total_sale) as avg_sale from sales_tb
    group by year , month
    order by year;
    
#10
select category, count(*) as total_purchases
from sales_tb
group by category
order by total_purchases desc
limit 3;

#11
select 
	customer_id,
    sum(total_sale) as total_sales 
from sales_tb 
group by customer_id 
order by total_sales desc 
limit 5;

#12
SELECT customer_id, COUNT(DISTINCT category) AS category_count
FROM sales_tb
GROUP BY customer_id
HAVING category_count > 1 
order by category_count desc
limit 5;

#13
select 
	category ,
    count(distinct(customer_id)) as unique_cust
from sales_tb
group by category;

#14
with hourly_sale as
	(select *,
		case
			when extract(hour from sale_time)<12 then 'Morning'
			when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
			else 'Evening'
		end
		as shift from sales_tb)

select shift,
		count(*) as total_orders
from hourly_sale
group by shift;
