use classicmodels;

-- 1
select p.productLine, sum(o.quantityOrdered) as "quantityOrdered" 
from products p  join orderdetails o on p.productCode = o.productCode
join orders ord on o.orderNumber = ord.orderNumber
where ord.status = "Shipped"
group by p.productLine
order by quantityOrdered desc;

-- 2
select p.productCode, p.productName, sum(o.quantityOrdered * priceEach) as "Amount of Cancelled Values"
from products p  join orderdetails o on p.productCode = o.productCode
join orders ord on o.orderNumber = ord.orderNumber
where p.productLine LIKE 'Ships' and ord.status LIKE "Cancelled"
GROUP BY p.productCode, productName;

-- 3

SELECT p.productCode,productName
FROM products p LEFT OUTER JOIN orderdetails o ON p.productCode = o.productCode
WHERE o.productCode IS NULL;

-- 4
SELECT c.customerName, COUNT(DISTINCT o.orderNumber) as totalOrders
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE p.productLine = 'Classic Cars'
GROUP BY c.customerName
HAVING COUNT(DISTINCT o.orderNumber) > 3
ORDER BY totalOrders DESC;

-- 5
SELECT customerName,country, COUNT(checkNumber)AS TotalNumCheck,SUM(amount) AS TotalAmtPaid, SUM(amount)/COUNT(checkNumber) AS AvgPaid
FROM customers c
LEFT OUTER JOIN payments p ON c.customerNumber = p.customerNumber
WHERE country NOT LIKE 'USA'
GROUP BY c.customerNumber
ORDER BY SUM(amount) DESC
LIMIT 3;

-- 6
SELECT c.customerName, COUNT(o.orderNumber) AS numOrders
FROM customers c LEFT OUTER JOIN orders o ON c.customerNumber = o.customerNumber
WHERE c.country LIKE 'Germany'
GROUP BY c.customerNumber
HAVING COUNT(o.orderNumber) < 3
ORDER BY c.customerName ASC;

-- 7

SELECT DISTINCT CONCAT(c.city,', ',c.state) AS "Customer's Location", CONCAT(o.city,', ',o.state) AS "Sale Rep's Location"
FROM customers c JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
				 JOIN offices o ON e.officeCode = o.officeCode
WHERE c.country LIKE 'USA'
ORDER BY CONCAT(c.city,', ',c.state) ASC;


-- 8
SELECT CONCAT(e.firstName,' ',e.lastName) AS SalesRep,
CONCAT(o.city,',' , o.state) AS SalesLocation,customerName,
CONCAT(c.city,',',c.state) AS "Customer's Location"
FROM employees e JOIN offices o ON e.officeCode = o.officeCode
CROSS JOIN customers c
WHERE c.country LIKE 'USA' AND o.country LIKE 'USA' AND jobTitle LIKE 'Sales Rep'