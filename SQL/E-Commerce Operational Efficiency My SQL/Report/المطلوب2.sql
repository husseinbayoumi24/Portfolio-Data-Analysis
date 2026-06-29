 -- عرض المنتجات الاكثر مبيعا
 select top 10
 p.productname, c.categoryname, p.price, p.stockQuantity
 from products p
 join categories c on p.CategoryID = c.CategoryID
 order by p.price
 ;
 
 -- العملاء التى لم يقومون بأى طلب
 select firstname, lastname, email, city
 from customers
 where CustomerID not in(select CustomerID from orders);
 
 -- ملخص الطلبات لكل مدينة
 select city, count(customerid) as Total_Customers
 from customers
 group by city
 order by total_customers desc;
 
 
 -- Total Sales By city
 create view Total_Sales_By_City 
 select c.city, sum(o.totalamount) As Total_Sales
 from customers c
 join orders o on c.CustomerID = o.CustomerID
 group by c.city 
 order by Total_Sales ;
 
 select * from Total_Sales_By_city;
 
 
 -- Monthly Revenue
 create view Monthly_Revenue as
 select 
 format(orderdate, 'yyy-mm') as Month,
 count(orderid) as TotalOrders,
 sum(totalamount) as MonthlyRevenue
 from orders
 group by format(orderdate, 'yyy-mm')
 order by month desc;
 
 select * from Monthly_Revenue;
 
 
 -- Sales By category
 create view SalesByCategory as
 select 
 c.categoryname,
 sum(od.Quantity) as UnitsSold,
 sum(od.quantity * od.unitprice) as CategoryRevenue
 from orderdetails od
 join products p on od.ProductID = p.ProductID
 join categories c on p.CategoryID = c.CategoryID
 group by c.CategoryName
 order by CategoryRevenue desc;
 
 
 select * from SalesByCategory;
 
 -- حالة الشحن والطلبات المتاخرة
 select ShippingStatus,
 count(shippingid) As TotalPackets,
 Carrier
 from shipping
 group by ShippingStatus, Carrier;
 
 -- تصنيف العملاء على حسب الانفاق
 with customerSpending As (
 select 
 (c.firstname +''+ c.lastname) AS CustomerName,
 sum(o.TotalAmount) AS TotalSpent
 from customers c 
 join orders o on c.CustomerID = o.CustomerID
 group by c.FirstName, c.LastName
 )
 select
 CustomerName, 
 TotalSpent,
 Case
 when TotalSpent > 2000 Then 'VIP Cuatomer'
 when TotalSpent between 1000 and 2000 Then 'Loyal Customer'
 Else 'Regular Customer'
 End As CustomerSegment
 From CustomerSpending
 order by TotalSpent desc ;
 
 