/* ---------------------------------------------- 
|	Student ID:6388014 							|
|	Name:Waris	Damkham							|
   ---------------------------------------------*/
use PremierProducts;
-- Q1: Create a new view named "vwCustomerRep"
-- This view contains 5 columns: Customer Number, Customer Name, Zip code, 
-- firstnameand lastname of the sale representative who supports that customer.
CREATE VIEW vwCustomerRep AS
SELECT c.CustomerNum, c.CustomerName, c.Zip , r.FirstName, r.LastName
FROM Customer c
left join rep r on c.RepNum = r.RepNum;
SELECT*FROM vwCustomerRep;
-- drop view vwCustomerRep;
-- Q2: Alter the view named "vwCustomerRep"
-- Alter the view named "vwCustomerRep"
Alter view vwCustomerRep AS
select c.CustomerNum, c.CustomerName, c.Zip , r.FirstName, r.LastName, r.Commision, r.Rate
from Customer C
left join rep r on c.RepNum = r.RepNum;
SELECT*FROM vwCustomerRep;
-- Q3: Create a new view named "vwTotalOrder_Customer"
-- This view count the total number of orders each customer made
Create View vwTotalOrder_Customer AS
Select c.CustomerNum, c.CustomerName, count(o.OrderNum) as TotalOrder
from Customer c
inner join Orders o on c.CustomerNum = o.CustomerNum
group by c.CustomerNum;
Select*from vwTotalOrder_Customer;