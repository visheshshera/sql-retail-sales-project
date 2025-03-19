-- — Data Analysis & Business

-- My Analysis & Findings

-- Key Problems

-- Q. 1 Write a SQL query to retrieve all columns for sales made on 2022-11-05.
-- Q. 2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of nov-2022
-- Q. 3 Write a sql query to calculate the total sales (total_sale) for each category.
-- Q. 4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q. 5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q. 6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q. 7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q. 8 Write a SQL query to find the top 5 customers based on the highest total sales
-- Q. 9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17).

-- Ans 1
select * from retail_sales
where sale_date="2022-11-05";

-- Ans 2

select * from retail_sales
where category='clothing' 
and quantity>4
and sale_date like '2022-11%';

-- Ans 3
select category,sum(total_sale) as sales_per_category from retail_sales
group by category;

-- Ans 4
select category,avg(age) avg_age from retail_sales
group by category
having category="beauty";

-- Ans 5 
select * from retail_sales
where total_sale>1000;

-- Ans 6 
select category,gender,count(*)
from retail_sales
group by category,gender
order by 1;

-- Ans 7
select year(sale_date) as yr,month(sale_date) as mnth,avg(total_sale) avg_monthly_sale,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as best_selling_month_rank
from retail_sales
group by yr,mnth;
-- february and july are most profitable in 2023 amd 2022 respectively


-- Ans 8
select customer_id,sum(total_sale)
from retail_sales
group by customer_id
order by 2 desc
limit 5;

-- Ans 9
select category,count(distinct customer_id) as customer_per_category
from retail_sales
group by category;

-- Ans 10
select distinct
case 
when hour(sale_time)<=12 then "Morning"
when hour(sale_time)>12 and hour(sale_time)<17 then "afternoon"
when hour(sale_time)>=17 then "night"
end as shift,count(*) as orders_per_shift
from retail_sales
group by shift;

