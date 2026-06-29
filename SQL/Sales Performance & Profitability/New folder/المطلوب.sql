create schema Sales;

use Sales;

select * from Sales;

 -- Total Sales --
 select sum(Sales) as Total_Sales
 from sales;
 
-- Orders count--
select count(order_ID) As orders_count 
from sales;

-- Customers Count--
select count(distinct(customer_name)) as Customer_Count
from Sales;

-- Total Profit--
select sum(profit) as Total_Profit
from Sales;


 



