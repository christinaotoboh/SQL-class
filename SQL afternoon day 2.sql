CREATE DATABASE pluralcode;
USE pluralcode;

SELECT * FROM transactions;

SELECT location FROM transactions;

SELECT location, quantity, orderstatus FROM transactions;

SELECT location FROM transactions;

SELECT DISTINCT location FROM transactions;

SELECT DISTINCT brand FROM transactions;

SELECT DISTINCT productname FROM transactions;

SELECT * FROM transactions;

SELECT * FROM transactions WHERE location = "Lagos";

SELECT * FROM transactions WHERE brand = "Contoso";


SELECT * FROM transactions WHERE orderstatus = "Delivered";

SELECT * FROM transactions;

SELECT * FROM transactions
WHERE location = "Lagos" AND orderstatus = "Delivered";

SELECT * FROM transactions
WHERE location = "Lagos" OR orderstatus = "Delivered";

SELECT * FROM transactions 
WHERE location IN("Lagos","Ondo","Osun");

SELECT * FROM transactions
WHERE quantity BETWEEN 50 AND 100;

SELECT * FROM transactions;

SELECT * FROM transactions 
WHERE total_price <> 18690;

-- How many delivered transactions are for
-- the contoso and fabrikam brand, 320

SELECT * FROM transactions
WHERE orderstatus = "Delivered"
AND brand IN("fabrikam","contoso"); 

SELECT * FROM transactions;

-- Wildcards LIKE 

SELECT * FROM transactions
WHERE productname LIKE "%Silver";

-- This is to return all the states starting with a K
SELECT * FROM transactions
WHERE location LIKE "K%";

SELECT * FROM transactions
WHERE productname LIKE "%MP3%";

SELECT * FROM transactions;

-- debugging









-- Comments - Single line or multiple line

-- This is a single line comment
#This is also a single line comment ggjhkjfygyfddtfghhhggtgttttttttttttttt5ttrr

/* This is a 
multiple line comment
it contunies until you
stop ithvyfcyuyuggytyty
gyf6ttrdtxdtrd6tyyuuuihyfvyugydftrh
rtdftyrder
fgxdffg */ 

-- Aggregate functions COUNT, AVERAGE, MIN, SUM, MAX

SELECT * FROM transactions;

SELECT COUNT(*) FROM transactions;

SELECT COUNT(brand) FROM transactions;

SELECT DISTINCT brand FROM transactions;

SELECT COUNT(DISTINCT brand) FROM transactions;

SELECT SUM(Total_price) FROM transactions;

SELECT AVG(quantity), MIN(Total_price), MAX(UnitCost) FROM transactions;


-- Aliase AS

SELECT SUM(Total_price) AS Total_revenue FROM transactions;

SELECT SUM(Total_price) AS grand_price FROM transactions;

SELECT * FROM transactions;

SELECT location AS state FROM transactions;

-- GROUP BY

SELECT brand, SUM(quantity) AS total_qty FROM transactions
GROUP BY brand;

SELECT location, AVG(total_price) AS Avg_price FROM transactions
GROUP BY location;

SELECT customerID, SUM(quantity) AS total_qty FROM transactions
GROUP BY CustomerID;

-- ORDER BY is used for sorting a table

SELECT * FROM transactions;

SELECT location, SUM(quantity) AS total_qty
FROM transactions
GROUP BY location;

-- ORDER BY

SELECT * FROM transactions
ORDER BY location DESC;


SELECT location, SUM(quantity) AS total_qty
FROM transactions
GROUP BY location
ORDER BY SUM(quantity) DESC;

-- Return a table showing brands and their total price, the table should have the highest price on top of the table

SELECT brand, SUM(total_price) AS Revenue FROM transactions
GROUP BY brand
ORDER BY SUM(total_price) DESC;


-- LIMIT 

SELECT * FROM transactions
LIMIT 2;

SELECT brand, SUM(total_price) AS Revenue 
FROM transactions
GROUP BY brand
ORDER BY SUM(total_price) DESC
LIMIT 5;

SELECT * FROM transactions;

SELECT customerID, COUNT(orderID) AS No_Of_orders_purchased
FROM transactions
GROUP BY customerID
ORDER BY COUNT(orderID) ASC
LIMIT 2;

-- Return the product with the highest unit cost

SELECT brand, productname, MAX(unitcost) AS highest_unitcost
FROM transactions
GROUP BY brand, productname
ORDER BY MAX(unitcost) DESC ;

-- Return the customerId with the highest total quantity
-- CustomerID 1896  with quantity  346, 

SELECT customerID, SUM(quantity) AS Total_qty
FROM transactions
GROUP BY customerID
ORDER BY SUM(quantity) DESC
LIMIT 1; 

-- What is the total no of orders that were cancelled --389|

SELECT orderstatus, COUNT(orderid) AS no_of_orders
FROM transactions
GROUP BY orderstatus;

SELECT COUNT(orderid) AS purchased_orders FROM transactions
WHERE orderstatus = "cancelled";

-- HAVING 
SELECT orderstatus, COUNT(orderid) AS purchased_orders
FROM transactions
GROUP BY orderstatus;
-- HAVING orderstatus IN("Cancelled", "RTO");

SELECT location, orderstatus, COUNT(orderid) AS No_of_orders
FROM transactions
WHERE location = "Lagos"
GROUP BY location,orderstatus
HAVING orderstatus = "cancelled";

SELECT location, SUM(quantity) AS qty
FROM transactions
GROUP BY 1
ORDER BY 2 DESC; 

SELECT SUM(total_price), customerid 
FROM transactions
Group by 2 
order by 1 desc;

-- Return customers with total transactions values greater than 500,000

-- 113|

SELECT customerID, SUM(total_price) AS Revenue
FROM transactions
GROUP BY 1
HAVING SUM(total_price) > 500000;


-- CASE WHEN

SELECT * FROM transactions;

-- Classify the transactions as delivered or not delivered, if orderstatus is delviered 
-- then it will be classified as delivered orders, otherwise it will be classified as not delivered.
 
SELECT *,
CASE 
WHEN orderstatus = "delivered" THEN "Order Delivered" 
ELSE "Not Delivered"
END AS Delivery_status
FROM transactions;
SELECT * FROM transactions;

SELECT DISTINCT orderstatus FROM transactions;

SELECT * ,
CASE
WHEN orderstatus = "Delivered" THEN "Transactions Successful"
WHEN orderstatus = 'pending' THEN 'Transaction in progress'
ELSE 'Transaction Not Successful'
END AS Transaction_status
FROM transactions;

-- Create a new column that classifies transactions as "Discount applied" if the discount is high, medium or low
-- and if the discount applied is none, classify it as "No discount applied"


SELECT * FROM transactions;




SELECT *,
CASE
WHEN `Discount Band Applied` = 'None' THEN 'No discount applied'
ELSE 'Discount applied'
END AS Transaction_status
FROM transactions;

SELECT *, 
CASE WHEN `Discount Band Applied` IN("Low", "Medium", "High") THEN "Discount Applied"
ELSE "Discount Not applied"
END AS Discount_Status
FROM transactions;

SELECT * FROM transactions;

-- qty less than 20 will be classified as small volume orders
-- qty between 20 and 50 will be classified as average volume orders
-- others will be classified as high volume orders

SELECT orderid, quantity, 
CASE 
WHEN quantity < 20 THEN "Small Volume Orders"
WHEN quantity BETWEEN 20 AND 50 THEN "Medium Volume Orders"
ELSE "High Volume Orders"
END AS Order_volume
FROM transactions;

SELECT * FROM transactions; 

-- Classify each brand based on the total quantity sold, below 500 will be 'Low seller'
-- above or equal 500 will be 'high sellers'

SELECT brand, SUM(Quantity) AS qty,
CASE
WHEN SUM(quantity) < 10000 THEN "Low Seller"
ELSE "Higher Sellers"
END AS Brand_class
FROM transactions
GROUP BY 1;


-- JOINS 

SELECT * FROM salesTb;
SELECT * FROM customersTb;
SELECT * FROM productstb;

SELECT ID, CustomerName FROM
salestb -- left table
JOIN
customerstb -- right table
ON salestb.CustomerID = customerstb.CustomerID;


SELECT salestb.id, salestb.OrderDate, customerstb.CustomerID FROM 
customerstb -- left
JOIN
salestb -- right
ON salestb.CustomerID = customerstb.CustomerID;

SELECT s.id, s.orderDAte, c.customerID, c.CustomerName
FROM 
salestb s
JOIN
customerstb c  
ON s.CustomerID = c.CustomerID;

SELECT * FROM
productstb p  
LEFT JOIN
salestb s
ON s.product_id = p.product_id;

SELECT s.id, s.OrderDate, s.OrderStatus, c.CustomerName, p.product_name FROM 
salestb s 
JOIN
customerstb c 
ON s.CustomerID = c.CustomerID
JOIN 
productstb p 
ON s.product_id = p.product_id;
 
-- The customers name and the total items they purchased
-- customers table, salestb

SELECT c.customerName, SUM(quantity) AS total_item
FROM salestb s 
JOIN
customerstb c
ON s.CustomerID = c.CustomerID
GROUP BY 1;

-- Total items sold for each product
-- productname and the total_qty

SELECT p.product_name, SUM(quantity) AS item_sold
FROM 
salestb s 
RIGHT JOIN
productstb p 
ON s.product_id = p.product_id
GROUP BY 1;

SELECT * FROM salesTb;
SELECT * FROM customersTb;
SELECT * FROM productstb;

-- * - Multiplication, + - Addition, - Subtraction, /- Division

SELECT *, s.Quantity * p.UnitPrice AS Total_Amount FROM
salestb s
JOIN
productstb p 
ON s.product_id = p.product_id; 

-- Show the individual product category and their total revenue

SELECT p.category, SUM(s.quantity * p.Unitprice) AS Total_Revenue
FROM salestb s 
JOIN 
productstb p 
ON s.product_id = p.product_id 
GROUP BY 1;

SELECT ROUND(unitprice) FROM productstb;

-- Top 3 Customers with the highest revenue 

SELECT c.customername, SUM(ROUND(s.quantity * p.unitprice)) AS total_revenue
FROM salestb s 
JOIN
customerstb c
ON s.CustomerID = c.CustomerID 
JOIN 
productstb p 
ON s.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

-- Return the customer who has purchased the highest no of units
-- Sarah Moore

SELECT c.customername, SUM(s.quantity) AS units
FROM salestb s 
JOIN 
customerstb c 
ON s.CustomerID = c.CustomerID 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

Select c.customerName, Sum(s.quantity) AS Total_units_purchased
From Salestb s
Join customerstb c
On s.customerID = C.customerID
Group by 1
Order by 2 DESC
Limit 1;

-- Clasify customers based on their revenue: 
-- for customers with revenue > 20000 as High Value Customers
-- For customers with revenue between 15000 and 20000 as Average value customers
-- Others will be classified as Low value customers

Select c.customerName,
SUM(Round(p.unitprice * s.quantity)) AS Revenue,
Case when SUM(Round(p.unitprice * s.quantity)) > 20000
Then "High Value Customers"
When SUM(Round(p.unitprice * s.quantity)) between 15000 and 20000
Then "Average value customers" 
Else "Low value customers"
End As Customer_category
From
salestb s 
Join
productstb p
ON s.product_id = p.product_id 
JOIN 
customerstb c
ON s.customerid = c.CustomerID
GROUP BY 1;


-- current_date

SELECT current_date() AS today;
SELECT current_time() AS time;
SELECT current_timestamp() AS timestamp;

-- Datediff 

SELECT datediff(current_date(),"2025-05-01") AS days_difference;

SELECT * FROM salestb;

SELECT *, datediff(shipdate, Orderdate) AS Order_processing_time
FROM salestb;

-- YEAR

SELECT YEAR("2025-05-05") AS The_year;

SELECT *, YEAR(Orderdate) AS Order_year
FROM salestb;

SELECT MONTH("2025-05-05") AS The_month;

SELECT DAY("2025-05-31") AS The_month;

SELECT *, YEAR(Orderdate) AS order_year, 
MONTH(orderdate) AS Order_Mnt,
DAY(orderdate) AS Order__day, Monthname(OrderDate) AS Month_name 
FROM salestb;

SELECT monthname("2025-10-03") AS Month_name;

-- Date_format used to convert dates to different date "2025-10-03"
 SELECT date_format("2025-10-03","%y-%d-%m") AS new_formt;

SELECT * FROM salestb;

-- Trim, removes excess space from a text

SELECT * FROM customerstb;

SELECT * FROM customerstb
WHERE CustomerName = "    Allison Hill";

SELECT *, LENGTH(CustomerName) AS Count_customername,
LENGTH(TRIM(CustomerName)) AS Count_oftrimedcustomername
FROM customerstb;

-- Length, return the count of character

SELECT LENGTH("Chiamaka") AS count;

-- CONCAT is to combine multiple values 
SELECT CONCAT("Mavis", " ", "Onye", " ", "Enu") AS full_name; 

SELECT *, CONCAT(customerID, "-", TRIM(customername)) AS custname_id
FROM customerstb;

SELECT UPPER("christy") AS Uppercase;
SELECT LOWER("CHINENYE") AS lower_case;

-- Replace function

SELECT REPLACE("Mariam", "Mariam","Maryann"); 

SELECT * FROM customerstb;

SELECT * FROM customerstb;

SELECT Customername, 
REPLACE("Noah Rhodes","R"," ")
FROM customerstb
WHERE customername = "Noah Rhodes";

SELECT RIGHT("Opeoluwa" , 3),LEFT("Opeoluwa" , 5);

SELECT * FROM salestb;






















