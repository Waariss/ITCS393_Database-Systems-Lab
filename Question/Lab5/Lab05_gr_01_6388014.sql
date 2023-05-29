/* ---------------------------------------------- 
|	Student ID:6388014 							|
|	Name:Waris Damkham							|
   ---------------------------------------------*/

USE classicmodels;

-- Q1: How many customers are located in NYC?
SELECT COUNT(*) AS "Customer_in_NYC" FROM customers WHERE city = 'NYC';

-- Q2: What is the average amount of the payment and the standard deviation of 
-- the payments occurred in the third quarter of the year?
-- Note: Third quarter of every year is from 1 July – 30 September
SELECT AVG(amount) AS avg_payment, STD(amount) AS std_payment
FROM payments
WHERE paymentDate >= '2003-07-01' AND paymentDate <= '2003-09-30';

-- Q3: How many limited company customers that are under the responsibility of 
-- the sale representative named, 'Leslie Jennings'
-- Note: 'Ltd.' used in the name of a company indicates a limited company
SELECT COUNT(*) AS num_customers
FROM customers
WHERE customerName LIKE '%Ltd.' AND salesRepEmployeeNumber = (
  SELECT employeeNumber
  FROM employees
  WHERE lastName = 'Jennings' AND firstName = 'Leslie'
);

-- Q4: Show the number of offices located in each country, ordered by country names
SELECT country, COUNT(*) AS num_offices
FROM offices
GROUP BY country
ORDER BY country;

-- Q5: List all sale managers (employee number, full name, job title) and their subordinate sale representatives under their supervision.
-- Note: The attribute 'reportsTo' shows the recursive relationship. 
-- The value indicates the employee number of their manager that he/she reports to.
SELECT e.employeeNumber, CONCAT(e.lastName, ' ', e.firstName) AS fullname, e.jobTitle, COUNT(e2.employeeNumber)
FROM employees e
INNER JOIN employees e2 ON e.employeeNumber = e2.reportsTo
WHERE e.jobTitle LIKE '%Manager%'
GROUP BY employeeNumber;

-- Q6: Calculate the average of the price difference between 'MSRP' and 'buyPrice' of each product line
-- The result must include the name of the product line and its average difference price, sorted from the highest to lowest difference value.
SELECT 
    productLine, 
    FORMAT(AVG(MSRP - buyPrice),2) AS avg_price_diff
FROM 
    products
GROUP BY 
    productLine
ORDER BY 
    avg_price_diff DESC;

-- Q7: Show the list of the product lines that have the number of the products at least 10 but not more than 20 products. 
-- The result must include the name of the product line, the total numbers of the products and the range of MSRP per product line,
-- sorted by the name of product line
-- Note: The range of MSRP is calculated from the difference of the maximum and the minimum MSRP value
SELECT productLine, COUNT(*) AS numProd, MAX(MSRP)-MIN(MSRP) AS rangeMSRP
FROM products
GROUP BY productLine
HAVING numProd <= 20 AND numProd >= 10;

-- Q8: Show the top 3 most sold product (judged by the total number of quantity ordered) of the 'Ships' product line.
-- The result must include the product code, the product name, the total number of quantity ordered and the total amount of sales
-- (calculated by the quantity ordered multiplied by the price)
SELECT p.productCode, p.productName, SUM(od.quantityOrdered) AS totalQuantity, SUM(od.quantityOrdered*od.priceEach) AS totalSales
FROM products p
INNER JOIN orderdetails od ON p.productCode = od.productCode
WHERE p.productLine = 'Ships'
GROUP BY p.productCode
ORDER BY totalQuantity DESC
LIMIT 3;







