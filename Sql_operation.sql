create database final;
use final;

-- select * from ecommerce;

-- Project Tasks
-- SQL: Perform sql querys

-- Retrieve the top 5 highest-selling products.

select Product_Id, Product_Name, sum(Quantity) as Total_Units_Sold
from ecommerce where Order_Status = 'Completed'
group by Product_Id, Product_Name order by Total_Units_Sold desc limit 5;


-- Calculate monthly revenue over time.

select date_format(Order_Date, '%Y-%m') as month, SUM(Total_Amount) as Monthly_Revenue
from ecommerce where Order_Status = 'Completed'
group by month order by month;


-- Find the average order value per customer.

select Customer_Id, Customer_Name, avg(Total_Amount) as Avg_Order_Value
from ecommerce where Order_Status = 'Completed'
group by Customer_Id, Customer_Name order by Avg_Order_Value desc;



-- Identify best-performing categories based on revenue.

select Category, sum(Total_Amount) as Total_Revenue from ecommerce where Order_Status = 'Completed'
group by Category order by Total_Revenue desc;


-- Find repeat customers and their total contribution to sales.

select customer_id,customer_name,count(order_id) as order_count,sum(total_amount) as total_revenue
from ecommerce where lower(order_status) = 'completed' group by customer_id, customer_name
having count(order_id) > 1 order by total_revenue desc;


-- Determine peak order days/times (day of week, hour).

select dayname(Order_Date) as Day_Of_Week, hour(Order_Date) as Order_Hour, count(Order_Id) as Orders_Count
from ecommerce where Order_Status = 'Completed' 
group by Day_Of_Week, Order_Hour order by Orders_Count desc limit 10;


-- Rank products by total sales and total units sold.

select product_id, product_name, sum(total_amount) as total_sales,
sum(quantity) as total_units_sold, rank() over (order by sum(total_amount) desc) as sales_rank,
rank() over (order by sum(quantity) desc) as units_rank from ecommerce
where order_status = 'completed' group by product_id, product_name;



