--EDA: 

--Average Age by Marital Status
SELECT marital_status, AVG(age) AS average_age
FROM customer
GROUP BY marital_status;

--Total Sales by Gender
SELECT c.gender, SUM(t.totalamount) AS total_sales
FROM transaction t
JOIN customer c ON t.customerid = c.customerid
GROUP BY c.gender;

--Top 3 Store by Total Quantity Sold
SELECT s.store_name, SUM(t.quantity) AS total_quantity
FROM transaction t
JOIN store s ON t.storeid = s.storeid
GROUP BY s.store_name
ORDER BY total_quantity DESC
LIMIT 3;

--Top 3 Product by Total Sales Amount
SELECT p.product_name, SUM(t.totalamount) AS total_sales
FROM transaction t
JOIN product p ON t.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 3;

--Monthly Sales Trend
SELECT TO_CHAR(date::date, 'YYYY-MM') AS month, SUM(totalamount) AS monthly_sales
FROM transaction
GROUP BY TO_CHAR(date::date, 'YYYY-MM')
ORDER BY month;

--Revenue by Product Category
SELECT 
    p.category, 
    p.product_name, 
    SUM(t.totalamount) AS total_revenue
FROM transaction t
JOIN product p ON t.product_id = p.product_id
GROUP BY p.category, p.product_name
ORDER BY p.category, total_revenue DESC;


--Customer Distribution by Age Group
SELECT 
  CASE 
    WHEN age < 20 THEN 'Under 20'
    WHEN age BETWEEN 20 AND 29 THEN '20s'
    WHEN age BETWEEN 30 AND 39 THEN '30s'
    WHEN age BETWEEN 40 AND 49 THEN '40s'
    ELSE '50+' 
  END AS age_group,
  COUNT(*) AS customer_count
FROM customer
GROUP BY age_group
ORDER BY age_group;

--Top 3 active customer
SELECT c.customerid, COUNT(t.transaction_id) AS total_transactions, SUM(t.totalamount) AS total_spent
FROM transaction t
JOIN customer c ON t.customerid = c.customerid
GROUP BY c.customerid
ORDER BY total_spent DESC
LIMIT 3;

--Data preparation
SELECT
    t.transaction_id,
    t.date,
    t.quantity,
    t.price,
    
    -- Customer
    c.customerid,
    c.age,
    c.gender,
    c.marital_status,
    c.income,
    
    -- Product
    p.product_id,
    p.product_name,
    p.category,
    
    -- Store
    s.storeid,
    s.store_name,
    s.groupstore,
    s.type,
    s.latitude,
    s.longitude

FROM transaction t
LEFT JOIN customer c ON t.customerid = c.customerid
LEFT JOIN product p ON t.product_id = p.product_id
LEFT JOIN store s ON t.storeid = s.storeid;



