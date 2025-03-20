# Retail Sales Analysis Using SQL

## Project Overview

**Project Title**: Retail Sales Analysis   
**Database**: `retail_sales`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sales`.
- **Table Creation**: A table named `sales_tb` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database retail_sales;

create table sales_tb(
			                  transactions_id	int primary key,
                        sale_date date,
                        sale_time	time,
                        customer_id	int,
                        gender	varchar(10),
                        age	int,
                        category varchar(15),
                        quantity	int,
                        price_per_unit float,
                        cogs float,
                        total_sale float);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select * from sales_tb;
select count(*) from sales_tb;
select count(distinct customer_id) as total_sale from sales_tb;
select distinct category from sales_tb;

select * from sales_tb where transactions_id is null
or  sale_date is null
or  sale_time is null
or  customer_id is null
or  gender is null
or  age is null
or  category is null
or  quantity is null
or  price_per_unit is null
or  cogs is null
or  total_sale is null
;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select *
from sales_tb
where sale_date ='2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT * 
FROM sales_tb 
WHERE category = 'Clothing' 
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' 
  AND quantity >= 4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select 
	category,
    sum(total_sale) as net_sale,
    count(*) as total_orders 
from sales_tb
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select round(avg(age),2) as avg_age from sales_tb
where category='Beauty';
```

5. **Write a SQL query to Compare sales between male and female customers by total revenue.**:
```sql
select gender, sum(total_sale) as total_revenue
from sales_tb
group by gender;
```

6. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * from sales_tb
where total_sale>1000;
```

7. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select category,gender,count(*) as total_trans from sales_tb 
group by category,
gender
order by category;
```

8. **Write a SQL query to calculate the average sale for each month**:
```sql
select extract(year from sale_date) as year,
	extract(month from sale_date) as month,
    round(avg(total_sale),3) as avg_sale from sales_tb
    group by year , month
    order by year;
```
9. **Write a SQL query to find out best selling month in each year**:
```sql
select year,
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
group by year, month
) as t1
where ranking = 1;
```

10. **Write a SQL query to find the top 1 most frequently purchased item category.**:
```sql
select category, count(*) as total_purchases
from sales_tb
group by category
order by total_purchases desc
limit 1;

```
11. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
select 
	customer_id,
    sum(total_sale) as total_sales 
from sales_tb 
group by customer_id 
order by total_sales desc 
limit 5;
```
12. **Write a SQL query to find the number of customers who purchased multiple categories**:
```sql
SELECT customer_id, COUNT(DISTINCT category) AS category_count
FROM sales_tb
GROUP BY customer_id
HAVING category_count > 1 
order by category_count desc
limit 5;
```
13. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select 
	category ,
    count(distinct(customer_id)) as unique_cust
from sales_tb
group by category;
```

14. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
