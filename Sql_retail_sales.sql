Create table retail_sales (
	transactions_id int PRIMARY KEY,
	sale_date date,
	sale_time time,
	customer_id int,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
)

SELECT * FROM retail_sales

--Checking Null Values of Single Column
SELECT * FROM retail_sales
where sale_date is null

--Checking the Null Values of all Columns

SELECT * FROM retail_sales
where quantiy is NULL
	or
	price_per_unit is NULL
	or
	cogs is NULL;


--Deleting the Null Values
Delete FROM retail_sales
where quantiy is NULL
	or
	price_per_unit is NULL
	or
	cogs is NULL;

--
select  * from retail_sales

--Data Exploration
--Q1 How many sales we have
select count(*) as total_sale from retail_sales

--Q2 How many Customers we have

select count(DISTINCT customer_id) as CUSTOMER from retail_sales

--Q3 How many CATEGORY we have

select DISTINCT category as total_category from retail_sales



--Data Analysis (Business Problems)
--Q1: Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date = '2022-11-05'


--Q2  Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from retail_sales
where category = 'Clothing'
and to_char(sale_date, 'YYYY-MM') = '2022-11'
and quantiy >= 4;



--Q3 Write a SQL query to calculate the total sales (total_sale) for each category.
select * from retail_sales
SELECT category, 
       SUM(total_sale) AS net_sale, 
       COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;


--Q4 - Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select * from retail_sales
SELECT AVG(age) , category
FROM retail_sales
group by category


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sale > '1000'

--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category , gender, count(*) as total_transaction from retail_sales
group by category , gender
order by 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from
(select
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	avg(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
from retail_sales
group by year , month) as t1
where rank = 1



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id , sum(total_sale) from retail_sales
group by customer_id
order by sum(total_sale) desc
limit 5



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select * from retail_sales
select
	count(distinct customer_id) as unique_customer,
	category
from retail_sales
group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select * from retail_sales
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift


----End 









