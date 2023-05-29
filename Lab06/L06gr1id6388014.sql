/* ---------------------------------------------- 
|	Student ID: 	U6388014					|
|	Name:			Waris Damhkam				|
   ---------------------------------------------*/

USE classicmodels;

-- Q1: Find the total numbers of quantity ordered per product line for the complete order, 
-- sorted the results from the highest numbers to the lowest ones. 
-- Note: the complete order is considered from the order with the status 'Shipped'.
SELECT p.productLine, sum(od.quantityOrdered) as quantityOrdered
FROM products p JOIN orderdetails od ON
p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
WHERE o.status = 'Shipped'
GROUP BY p.productLine
ORDER BY quantityOrdered DESC;




-- Q2: Calculate the amount of loss (cancelled) values per product of the 'Ships' product line for all 'Cancelled' orders. 
-- Note: the amount of values is calculated from the quantity ordered multiplied by its price)
SELECT p.productCode, productName, SUM(quantityOrdered*priceEach) AS 'Amount of Cancelled Values'
FROM products p JOIN orderdetails o ON p.productCode = o.productCode
JOIN orders od ON o.orderNumber = od.orderNumber WHERE p.productLine LIKE 'Ships' AND od.status LIKE 'Cancelled'
GROUP BY p.productCode, productName;

               


-- Q3: List the products (code and name) that have never been sold
SELECT p.productCode,productName
FROM products p LEFT OUTER JOIN orderdetails o ON p.productCode = o.productCode
WHERE o.productCode IS NULL;


-- Q4: List the customers who made the orders with the product line 'Classic Cars' more than 3 times in total, 
-- sorted the result by the number of times from the highest values to the lowest ones.
-- Hint: the number of times they ordered can be counted from the unique order numbers
SELECT c.customerName, COUNT(DISTINCT o.orderNumber) as totalOrders
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE p.productLine = 'Classic Cars'
GROUP BY c.customerName
HAVING COUNT(DISTINCT o.orderNumber) > 3
ORDER BY totalOrders DESC;




-- Q5: List the top 3 customers outside USA and their payment statistics (the total number of payment checks, 
-- the total amount of payments, and the average amount of payments)
SELECT customerName,country, COUNT(checkNumber)AS TotalNumCheck,SUM(amount) AS TotalAmtPaid, SUM(amount)/COUNT(checkNumber) AS AvgPaid
FROM customers c
LEFT OUTER JOIN payments p ON c.customerNumber = p.customerNumber
WHERE country NOT LIKE 'USA'
GROUP BY c.customerNumber
ORDER BY SUM(amount) DESC
LIMIT 3;

-- Q6: List the German customers who made the orders not more than 3 times in total, 
-- sorted the result by the customer's name alphabetically.
SELECT c.customerName, COUNT(o.orderNumber) AS numOrders
FROM customers c LEFT OUTER JOIN orders o ON c.customerNumber = o.customerNumber
WHERE c.country LIKE 'Germany'
GROUP BY c.customerNumber
HAVING COUNT(o.orderNumber) < 3
ORDER BY c.customerName ASC;



-- Q7: List the locations of US customers (city, state) of the employee and 
-- their corresponding sale representatives’ office location (city, state)

SELECT DISTINCT CONCAT(c.city,', ',c.state) AS "Customer's Location", CONCAT(o.city,', ',o.state) AS "Sale Rep's Location"
FROM customers c JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
				 JOIN offices o ON e.officeCode = o.officeCode
WHERE c.country LIKE 'USA'
ORDER BY CONCAT(c.city,', ',c.state) ASC;


-- Q8: List all combinations of the 'sales representative employees who work in USA office and all US customers
-- Hint: There are 36 US customers and 6 sales representatives located in USA

SELECT CONCAT(e.firstName,' ',e.lastName) AS SalesRep,
CONCAT(o.city,',' , o.state) AS SalesLocation,customerName,
CONCAT(c.city,',',c.state) AS "Customer's Location"
FROM employees e JOIN offices o ON e.officeCode = o.officeCode
CROSS JOIN customers c
WHERE c.country LIKE 'USA' AND o.country LIKE 'USA' AND jobTitle LIKE 'Sales Rep'









