--created table
create table retail_sale ( transactions_id	int primary key ,
							sale_date date ,
							sale_time time ,
							customer_id	int ,
							gender varchar(10) ,
							age	int ,
							category varchar(20) ,
							quantiy	int ,
							price_per_unit int ,
							cogs float ,
							total_sale float
);

--imported csv file
copy
retail_sale(transactions_id,sale_date ,sale_time,customer_id,gender,age	, category,	quantiy	,price_per_unit,cogs,total_sale)
from 'D:\datasets\SQL - Retail Sales Analysis_utf .csv'
delimiter ','
csv header;

select * from retail_sale ;

--data cleaning :
select * from retail_sale
where transactions_id is null
or sale_date is null
or sale_time is null 
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

--replacing null value with 0
update retail_sale
set age =0
where age is null;

update retail_sale
set quantiy =0
where quantiy is null;

update retail_sale
set price_per_unit =0
where price_per_unit is null;

update retail_sale
set cogs =0
where cogs is null;

update retail_sale
set total_sale =0
where total_sale is null;


- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than and equal to 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sale 
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than and equal to 4 in the month of Nov-2022
select * from retail_sale 
where category ='Clothing'
and quantiy >= 4
and sale_date > '2022-11-01' ;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category ,sum(total_sale) as total_sale from retail_sale
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) from retail_sale
where category ='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sale 
where total_sale >1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender,category , count(transactions_id) as total_transactions 
from retail_sale 
group by gender, category
order by gender desc ,category desc;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,SUM(total_sale) AS total_sales FROM retail_sale
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category, COUNT(DISTINCT customer_id) AS unique_customers
from retail_sales
group by category
order by unique_customers DESC;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
