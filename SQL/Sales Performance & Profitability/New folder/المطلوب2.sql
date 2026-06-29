use sales;

select * from sales;


 -- indexing --
 create index idx_Sales_Profit on 
 sales(sales, Profit);

-- Total Sales and Total Profit--
SELECT 
    SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM
    Sales;

-- Total Orders --
SELECT 
    COUNT(DISTINCT (order_id)) AS Total_Orders
FROM
    Sales;

-- Total Customers --
SELECT 
    COUNT(DISTINCT (customer_id)) AS Total_customers
FROM
    Sales;

-- Total Customers By Region --
SELECT 
    region, COUNT(DISTINCT (Customer_Id)) AS Total_customers
FROM
    sales
GROUP BY Region;

  -- Total Sales By Region --
SELECT 
    Region, SUM(Sales) AS Total_Sales
FROM
    sales
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Total Sales And Profit By Category --
SELECT 
    category,
    SUM(Sales) AS Total_Sales,
    SUM(profit) AS Total_Profit
FROM
    sales
GROUP BY category;


 -- The Products You Lose --
SELECT 
    Product_name, SUM(Profit) AS total_Profit
FROM
    sales
GROUP BY Product_name
ORDER BY Total_Profit ASC
LIMIT 10;

 -- Top Customers --
SELECT 
    Customer_Name, SUM(sales) AS Total_Sales
FROM
    sales
GROUP BY customer_name
ORDER BY Total_Sales DESC
LIMIT 10;
 
 -- Total Sales By Month --
 select Month(Order_Date) As month , sum(Sales) as Total_Sales
 from sales
 group by month;
 
 
 
 
 select order_date, str_to_Date(order_date, '%Y-%M-%d') as Order_Date
 from sales
 limit 10;
 
 update sales set order_date = str_to_date(order_date, '%Y-%M-%d');
 
 alter table sales
 modify order_date Date;
 
 
 select order_date, length(order_date)
 from sales
 limit 10;
 
 update sales
 set order_date = trim(order_date);
 
 
 
 select order_date, str_to_Date(Trim(lower(order_date, '%Y-%M-%d'))) as Date
 from sales
 limit 10;
 