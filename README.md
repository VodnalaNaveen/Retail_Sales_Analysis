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
	
 **SQL Query:**
```sql
select *
from sales_tb
where sale_date ='2022-11-05';
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/d317cbc5-b178-480f-9047-2e1d1aa5d57c)


2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:

**SQL Query:**
```sql
SELECT * 
FROM sales_tb 
WHERE category = 'Clothing' 
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' 
  AND quantity >= 4;
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/840b78ce-4fdf-4182-9330-3e621bc6c5dc)


3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

**SQL Query:**
```sql
select 
	category,
    sum(total_sale) as net_sale,
    count(*) as total_orders 
from sales_tb
group by category;
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/e5604d5c-0149-4ad8-8210-ace38a57dc22)

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

**SQL Query:**
```sql
select round(avg(age),2) as avg_age from sales_tb
where category='Beauty';
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/f8e5cf06-0886-460e-b0c2-98ab9cd7269f)

5. **Write a SQL query to Compare sales between male and female customers by total revenue.**:

**SQL Query:**
```sql
select gender, sum(total_sale) as total_revenue
from sales_tb
group by gender;
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/22a8fdfc-02ab-4711-9957-dc114bb482e5)

6. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

**SQL Query:**
```sql
select * from sales_tb
where total_sale>1000;
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/327c74b4-8c33-45a4-a97d-b166222e1fb7)

7. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

**SQL Query:**
```sql
select category,gender,count(*) as total_trans from sales_tb 
group by category,
gender
order by category;
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/7e2eb5e8-0e93-4097-a241-6a89dde0f361)

8. **Write a SQL query to calculate the average sale for each month**:

**SQL Query:**
```sql
select extract(year from sale_date) as year,
	extract(month from sale_date) as month,
    round(avg(total_sale),3) as avg_sale from sales_tb
    group by year , month
    order by year;
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/df0c89c9-2c3b-4863-9259-1132886587a0)

9. **Write a SQL query to find out best selling month in each year**:

**SQL Query:**
```sql
select year,
       month,
     round(avg_sale, 2) as avg_sale
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

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/4c80cf75-aee1-4a1f-be35-b70bd4a41c7e)

10. **Write a SQL query to find the top 1 most frequently purchased item category.**:

**SQL Query:**
```sql
select category, count(*) as total_purchases
from sales_tb
group by category
order by total_purchases desc
limit 1;

```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/31f70888-5bae-471e-af27-3c8dc0c0c1cc)

11. **Write a SQL query to find the top 5 customers based on the highest total sales**:

**SQL Query:**
```sql
select 
	customer_id,
    sum(total_sale) as total_sales 
from sales_tb 
group by customer_id 
order by total_sales desc 
limit 5;
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/fcf465b9-1e45-453e-a60d-7e4e4ff9f372)

12. **Write a SQL query to find the number of customers who purchased multiple categories**:

**SQL Query:**
```sql
SELECT customer_id, COUNT(DISTINCT category) AS category_count
FROM sales_tb
GROUP BY customer_id
HAVING category_count > 1 
order by category_count desc
limit 5;
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/9bad13e9-37ef-472d-a2bd-8e87b415acfe)

13. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

**SQL Query:**
```sql
select 
	category ,
    count(distinct(customer_id)) as unique_cust
from sales_tb
group by category;
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/b1374196-56a7-4c1a-abbb-4978b674349c)

14. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

**SQL Query:**
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

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/829475c8-0965-464a-9297-18432e78eb09)

15. **Segment customers into age groups and determine which group spends the most.**:

**SQL Query:**
```sql
select 
    case 
        when age < 20 then 'below 20'
        when age between 20 and 29 then '20s'
        when age between 30 and 39 then '30s'
        when age between 40 and 49 then '40s'
        else '50 and above'
    end as age_group,
    sum(total_sale) as total_spent
from sales_tb
group by age_group
order by total_spent desc;
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/ca9a018b-76ef-40b4-8abd-086f724a5bf2)

16. **Determine the profitability of each category by calculating the profit margin.**:

**SQL Query:**
```sql
select 
    category,
    round((sum(total_sale) - sum(cogs)) * 100.0 / sum(total_sale), 2) as profit_margin_pct
from sales_tb
group by category
order by profit_margin_pct desc;
```

**Output / Result Table:**

![image](https://github.com/user-attachments/assets/933696f4-7b45-4130-abfb-b5eca95a463d)


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
