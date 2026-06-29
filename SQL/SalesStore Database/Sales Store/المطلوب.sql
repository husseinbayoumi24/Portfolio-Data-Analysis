use salesstore;


select * from customers;
select * from orders;
select * from order_items;
select * from products;
select * from payments;

 -- استخدام index
 create INDEX idx_order_id_total_amount
 on orders(order_id,total_amount);

 -- مجموع المبيعات 
select sum(total_amount) as Total_Sales
from orders;
 -- عدد الاوردرات ---
 select count(order_id) as Total_Orders
 from Orders;
  -- متوسط قيمة الطلب ---
 select avg(total_amount) as avg_order_value
 from orders;
 -- عدد الطلبات لكل عميل---
 select customer_id , count(order_id) as orders_count
 from orders
 group by customer_id;
  -- العملاء المتكررين---
  SELECT customer_id,
       COUNT(order_id) AS orders_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) = 1 ;

 -- قائمة العملاء: أسماء العملاء، الإيميل، الهاتف، المدينة، الدولة---
 select full_name, email, phone, city, country
 from customers
 
 -- عدد العملاء: إجمالي عدد العملاء، وعد د هم حسب الدولة أو المدينة---
select country, count(customer_id) as count_customer
from customers
group by country
order by count_customer DESC;

 -- الطلبات: قائمة الطلبات، رقم الطلب، العميل، التاريخ، الإجمالي---
 SELECT O.order_id, C.full_name, O.order_date, O.total_amount
FROM orders O
INNER JOIN customers C
ON O.customer_id = C.customer_id
ORDER BY O.order_date DESC;

 -- استخدام VIEW لتسهيل الاستعلام---
 CREATE VIEW vs_join_orders_customers as
 select O.order_id, C.full_name, O.order_date, O.total_amount
 from orders O
 inner join customers C
 on O.customer_id = C.customer_id
 ORDER by O.order_date DESC;
 
 select * from vs_join_orders_customers;
 
  -- المنتجات: قائمة المنتجات، الكمية، السعر، التصنيف---
 select product_name, category, stock_quantity, price
 FROM products
 ORDER by category deSC;
 
  -- المخزون---
  SELECT product_id, product_name, stock_quantity
FROM products;

 -- عدد الطلبات لكل عميل---
 SELECT c.customer_id, c.full_name, count(o.order_id) as Total_order
 FROM customers c
 LEFT JOIN orders o on c.customer_id = o.customer_id
 GROUP by c.customer_id , c.full_name
 ORDER by Total_order desc;
 
 -- استخدام view---
 CREATE VIEW vs_total_order_per_customer as
 SELECT c.customer_id, c.full_name, count(o.order_id) as Total_order
 FROM customers c
 LEFT JOIN orders o on c.customer_id = o.customer_id
 GROUP by c.customer_id , c.full_name
 ORDER by Total_order desc;
 
 select * from vs_Total_order_per_customer;
 
 -- إجمالي المبيعات لكل عميل---
 select c.customer_id, c.full_name, sum(o.total_amount) as Total_spent
 from customers c
 inner join orders o on c.customer_id = o.order_id
 GROUP by c.customer_id, c.full_name
 ORDER  by Total_spent desc;
 
  -- استخدام VIEW---
  
  CREATE VIEW vs_Total_spent_per_customer AS
    SELECT 
        c.customer_id,
        c.full_name,
        SUM(o.total_amount) AS Total_spent
    FROM
        customers c
            INNER JOIN
        orders o ON c.customer_id = o.order_id
    GROUP BY c.customer_id , c.full_name
    ORDER BY Total_spent DESC;
 
 select * from vs_total_spent_per_customer;
 
 -- المبيعات حسب المنتج --
 SELECT p.product_name, sum(oi.quantity) as Total_quantity_sold , 
 sum(oi.price * oi.quantity) as Total_Revenue
 from order_items oi
 INNER JOIN products p on oi.product_id = p.product_id
 GROUP by p.product_name
 ORDER by Total_Revenue desc;
 
  -- استخدامview---
 CREATE VIEW vs_Sales_According_to_product AS
    SELECT 
        P.product_name,
        SUM(OI.quantity) AS total_quantity_sold,
        SUM(OI.quantity * OI.price) AS total_revenue
    FROM
        order_items OI
            INNER JOIN
        products P ON OI.product_id = P.product_id
    GROUP BY P.product_name
    ORDER BY total_revenue DESC;

 select * from vs_Sales_According_to_product;
 
 -- المبيعات حسب المدينة---
 SELECT 
    c.city, SUM(o.total_amount) AS Total_Revenue
FROM
    orders o
        INNER JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC; 

-- الطلبات المفتوحة أو المتأخرة---
 SELECT 
    *
FROM
    payments
WHERE
    payment_status = 'pending';
