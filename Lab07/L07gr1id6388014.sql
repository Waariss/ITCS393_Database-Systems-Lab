/* ---------------------------------------------- 
|	Student ID: 6388014							|
|	Name: Waris Damkham 						|
   ---------------------------------------------*/

USE classicmodels;

-- Q1: Find the list of products that are sold to customers in Japan only (Not to Singaporian Customers)
-- ANS of Q1:   XX products 
SELECT DISTINCT p.productCode,p.productName
FROM products p JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber JOIN customers c ON o.customerNumber = c.customerNumber 
WHERE c.country LIKE 'Japan' AND
p.productName NOT IN (
SELECT DISTINCT p.productName
FROM products p JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber JOIN customers c ON o.customerNumber = c.customerNumber 
WHERE c.country LIKE 'Singapore');




-- Q2: Find the list of products that are sold to customers in Singapore only (Not to Japanese customers
-- ANS of Q2:   XX products 
SELECT DISTINCT p.productCode,p.productName
FROM products p JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber JOIN customers c ON o.customerNumber = c.customerNumber 
WHERE c.country LIKE 'Singapore' AND
p.productName NOT IN (
SELECT DISTINCT p.productName
FROM products p JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber JOIN customers c ON o.customerNumber = c.customerNumber 
WHERE c.country LIKE 'Japan');

-- Q3: Find the list of products that are sold to both customers in Japan and Singapore
-- ANS of Q3:   XX products 
SELECT DISTINCT p.productCode,p.productName
FROM products p JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber JOIN customers c ON o.customerNumber = c.customerNumber 
WHERE c.country LIKE 'Singapore' AND
p.productName IN (
SELECT DISTINCT p.productName
FROM products p JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber JOIN customers c ON o.customerNumber = c.customerNumber 
WHERE c.country LIKE 'Japan')
order by productcode asc;


-- Q4: How many of products in total that are sold to customers in Japan and Singapore? 
-- ANS of Q4:   XX products 
SELECT DISTINCT p.productCode,p.productName
FROM products p JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber JOIN customers c ON o.customerNumber = c.customerNumber 
WHERE c.country IN ('Japan' , 'Singapore')
order by productcode asc;

-- Q5: List all contact names and phone numbers of both customers and the employess in one result
SELECT  CONCAT(contactFirstName,' ',contactLastName) AS contactName,phone AS 'Phone Number'
FROM customers 
UNION ALL 
SELECT CONCAT(firstName,' ',lastName) AS contactName, CONCAT(o.phone,'-',e.extension) AS 'Phone Number'
FROM employees e INNER JOIN offices o ON e.officeCode = o.officeCode 
ORDER BY contactName ASC ;




-- Q6: Select top 3 of the most sold product (judged by the total numbers of quantity ordered) in 
-- the following product lines: Motorcycles, Classic Cars, and Vintage Cars respectively.
(SELECT p.productCode,p.productName,p.productLine,SUM(od.quantityOrdered)
FROM products p INNER JOIN orderdetails od ON p.productCode = od.productCode
WHERE p.productLine LIKE 'Motorcycles'
GROUP BY p.productCode 
ORDER BY SUM(od.quantityOrdered) DESC 
LIMIT 3) UNION ALL
(SELECT p.productCode,p.productName,p.productLine,SUM(od.quantityOrdered)
FROM products p INNER JOIN orderdetails od ON p.productCode = od.productCode
WHERE p.productLine LIKE 'Classic Cars'
GROUP BY p.productCode 
ORDER BY SUM(od.quantityOrdered) DESC 
LIMIT 3) UNION ALL
(SELECT p.productCode,p.productName,p.productLine,SUM(od.quantityOrdered)
FROM products p INNER JOIN orderdetails od ON p.productCode = od.productCode
WHERE p.productLine LIKE 'Vintage Cars'
GROUP BY p.productCode 
ORDER BY SUM(od.quantityOrdered) DESC 
LIMIT 3)