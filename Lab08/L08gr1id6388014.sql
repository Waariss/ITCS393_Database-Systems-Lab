/* ---------------------------------------------- 
|	Student ID:6388014 							|
|	Name:Waris	Damkham							|
   ---------------------------------------------*/

USE classicmodels;


-- Q1: List the product coode and product name of the product line "Planes" and their total quantity of ordered
-- using subquery without JOIN
SELECT products.productCode, products.productName, 
(SELECT SUM(orderdetails.quantityOrdered) 
FROM orderdetails 
WHERE orderdetails.productCode = products.productCode) as totalQuantityOrdered 
FROM products
WHERE products.productLine = 'Planes';
-- Q2: List the customer info. (number, name, and number of times they made the orders) 
-- who order more frequent than the average.
-- Hint: On average, the number of times the customers ordered is 3.3265.
SELECT customers.customerNumber, customers.customerName, COUNT(orders.orderNumber) AS totalnumOrders
FROM customers INNER JOIN orders ON customers.customerNumber = orders.customerNumber
GROUP BY customers.customerNumber, customers.customerName
HAVING COUNT(orders.orderNumber) > 3.3265
ORDER BY totalnumOrders DESC;
-- Q3: If the company wants to have another new office to serve the customers, 
-- what country should be the next destination?
-- Hint: The location of the new office should be defined based on the highest numbers of customers of the
-- country and should not duplicate with the current location
-- ANS: 
SELECT customers.country, COUNT(DISTINCT customers.customerNumber) AS numCustomers
FROM customers LEFT JOIN offices ON customers.country = offices.country
WHERE offices.country IS NULL
GROUP BY customers.country
ORDER BY numCustomers DESC
LIMIT 1;
-- Q4: Using EXISTS, find the list of the employees, who work at the offices in the territory "EMEA", 
-- and their total number of customers if any
SELECT CONCAT(e.firstName, ' ', e.lastName) AS Name,e.jobTitle,COUNT(DISTINCT c.customerNumber) AS numCustomers
FROM employees e INNER JOIN offices o ON e.officeCode = o.officeCode LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber 
WHERE o.territory = 'EMEA'
GROUP BY e.employeeNumber, Name;
-- Q5: Modify Q4 to show the number of people each the same 'EMEA' employees needed to take care of
-- Hint: For all employees who have customers, calculate the total number of customers, and for ones who do not
-- have customers, show the total number of employees under his/her supervision
SELECT CONCAT(e.firstName, ' ', e.lastName) AS Name,e.jobTitle,IFNULL(COUNT(DISTINCT c.customerNumber) + COUNT(DISTINCT e2.employeeNumber), COUNT(DISTINCT e3.employeeNumber)) AS numPeopleToTakeCareOf
FROM 
    employees e
    INNER JOIN offices o ON e.officeCode = o.officeCode
    LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
    LEFT JOIN employees e2 ON e.employeeNumber = e2.reportsTo
    LEFT JOIN employees e3 ON e.employeeNumber = e3.employeeNumber AND e3.reportsTo = e.employeeNumber
WHERE o.territory = 'EMEA'
GROUP BY e.employeeNumber, Name;




