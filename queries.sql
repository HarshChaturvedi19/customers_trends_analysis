CREATE DATABASE customer_analysis
USE customer_analysis


SHOW DATABASES;
SELECT DATABASE();

SHOW TABLES;
DESCRIBE customer_shopping;

ALTER TABLE customer_shopping
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE customer_shopping
RENAME COLUMN `Purchase Amount (USD)` TO `Purchase_Amount`;

select * from customer_shopping
select count(*) from customer_shopping

SHOW COLUMNS FROM customer_shopping;

-- Q1 what is the totla revenue generated gender wise.
select Gender ,sum(Purchase_Amount) as revenue
from customer_shopping
group by Gender

-- Q2) Customers who used a discount but spent more than the average purchase amount
SELECT Customer_ID, Purchase_Amount, Discount_Applied
FROM customer_shopping
WHERE Discount_Applied = 'Yes'
  AND Purchase_Amount > (SELECT AVG(Purchase_Amount) FROM customer_shopping);


-- Q3) . Top 5 products with the highest average review rating
SELECT Product_ID, AVG(Review_Rating) AS avg_rating
FROM customer_shopping
GROUP BY Product_ID
ORDER BY avg_rating DESC
LIMIT 5;

-- Q4) Compare average Purchase Amount between Standard and Express Shipping
SELECT Shipping_Method, AVG(Purchase_Amount) AS avg_purchase
FROM customer_shopping
GROUP BY Shipping_Method;


-- Q5) Do subscribed customers spend more? Compare average spend and total revenue
SELECT Subscription_Status,
       AVG(Purchase_Amount) AS avg_purchase,
       SUM(Purchase_Amount) AS total_revenue
FROM customer_shopping
GROUP BY Subscription_Status;

-- Q6) Top 5 products with the highest percentage of purchases with discounts applied

SELECT Product_ID,
       (SUM(CASE WHEN Discount_Applied = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS discount_percentage
FROM customer_shopping
GROUP BY Product_ID
ORDER BY discount_percentage DESC
LIMIT 5;
-- Q7) Segment customers into New, Returning, and Loyal based on total number of previous purchases
SELECT Customer_ID,
       CASE 
           WHEN Total_Purchases = 1 THEN 'New'
           WHEN Total_Purchases BETWEEN 2 AND 5 THEN 'Returning'
           ELSE 'Loyal'
       END AS customer_segment
FROM customer_shopping;


-- Q8) Top 3 most purchased products within each category
SELECT Category, Product_ID, COUNT(*) AS purchase_count
FROM customer_shopping
GROUP BY Category, Product_ID
ORDER BY Category, purchase_count DESC;
