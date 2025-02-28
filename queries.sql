-- sql_project_p1


CREATE TABLE IF NOT EXISTS retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
-- DATA EXPLORATION 
-- HOW MANY SALES 
SELECT COUNT(*) FROM retail_sales;
-- how many unique customers are there 
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
-- what unique categories are there
SELECT DISTINCT category FROM retail_sales;


-- Data Analysis  & Business key problem and answer 

-- P1. Write a sql query to retrieve all columns sales made on '2022-11-05'
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05'

-- P2 Write a sql query to retrieve all transactions where category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT category ,SUM(quantiy)
FROM  retail_sales
WHERE category = 'Clothing' 
	AND TO_CHAR(sale_date,'YYYY-MM')='2022-11'
	AND quantiy >=4
GROUP BY 1

-- P-3 Write a sql query to calculate totsl sales for each category
SELECT category, SUM(total_sale),COUNT(total_sale)
as net_sale
FROM retail_sales
GROUP BY 1

-- P-4 Write a sql query to find the avg age of customer who bought beauty products
SELECT ROUND(avg(age) )as avg_age
FROM retail_sales
where category = 'Beauty'

-- P-5 Write a sql query to find all the transactions where the total_sale is greater than 1000.
SELECT * 
FROM retail_sales 
where total_sale > 1000
-- P-6 Write a sql query to find total number of  transactions(transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(total_sale)
from retail_sales
GROUP BY 1,2
ORDER BY 1

-- P-7 Write a sql query to find total number of sales for each month.Find out the best selling month in each year
SELECT 
	EXTRACT(YEAR from sale_date) as year,
	EXTRACT(MONTH from sale_date) as MONTH,
	AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
from retail_Sales
group by 1,2
order by 1

-- P-8 Write a sql query to find the top 5 customers based on the highest total sales
SELECT customer_id , SUM(total_sale) as total_Sale
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- P-9 Write a sql query to find number of unique customers who purchased items for each category
SELECT category, COUNT()


