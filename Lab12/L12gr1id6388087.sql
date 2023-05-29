-- Chanisara Kotrachai 6388087
use PremierProducts;
-- Q1 Create a stored procedure, named “ sp_Customer_Order ”
-- that takes as inputs two parameters: an order date (@date) and a minimum amount of orders (@orderCount)
DELIMITER //
CREATE PROCEDURE sp_Customer_Order (
  IN dateParam DATE,
  IN orderCountParam INT
)
BEGIN
  SELECT o.OrderNum, o.OrderDate, SUM(oi.NumOrdered) AS TotalOrdered, SUM(oi.QuotedPrice * oi.NumOrdered) AS TotalPrice, c.CustomerNum
  FROM Orders o
  INNER JOIN Customer c ON o.CustomerNum = c.CustomerNum
  INNER JOIN OrderLine oi ON o.OrderNum = oi.OrderNum
  WHERE o.OrderDate = dateParam
  GROUP BY o.OrderNum, o.OrderDate, c.CustomerNum
  HAVING SUM(oi.NumOrdered) >= orderCountParam;
END //
DELIMITER ;

CALL sp_Customer_Order('2010-10-21', 1);
DROP PROCEDURE IF EXISTS sp_Customer_Order;
-- Q2 Create a stored procedure named sp _Orders_By_Customer “ that takes a customer number (@customerNum) as input and returns a list of orders for that customer.
DELIMITER //
CREATE PROCEDURE sp_Orders_By_Customer (
  IN customerNumParam INT
)
BEGIN
  SELECT o.OrderNum, o.OrderDate, SUM(oi.NumOrdered) AS NumOrdered ,SUM(oi.QuotedPrice * oi.NumOrdered) AS TotalPrice
  FROM Orders o
  INNER JOIN OrderLine oi ON o.OrderNum = oi.OrderNum
  WHERE o.CustomerNum = customerNumParam
  GROUP BY o.OrderNum, o.OrderDate;
END //
DELIMITER ;

CALL sp_Orders_By_Customer(148);
DROP PROCEDURE IF EXISTS sp_Orders_By_Customer;

-- Q3 
DELIMITER //
CREATE FUNCTION update_rep(old_rep_num INT, new_rep_num INT) RETURNS int deterministic
BEGIN
  Declare result Int;
  set result = 0;
  set foreign_key_checks = 0;
  -- Disable SQL_SAFE_UPDATES
  SET @old_sql_safe_updates := @@sql_safe_updates;
  SET sql_safe_updates = 0;
  -- Check if old_rep_num exists in Rep table
  IF EXISTS (SELECT * FROM Rep WHERE RepNum = old_rep_num) THEN
      -- Re-enable SQL_SAFE_UPDATES
	  SET sql_safe_updates := @old_sql_safe_updates;
	  -- Update CurrentOrders table
	  UPDATE CurrentOrders SET RepNum = new_rep_num WHERE RepNum = old_rep_num;
	  -- Update Rep table
	  UPDATE Rep SET RepNum = new_rep_num WHERE RepNum = old_rep_num;
	  -- Update Customer table
	  UPDATE Customer SET RepNum = new_rep_num WHERE RepNum = old_rep_num;
	  -- Re-enable SQL_SAFE_UPDATES
	  SET sql_safe_updates := @old_sql_safe_updates;
	  -- Return true
      set result = true;
   END if;
   set foreign_key_checks = 1;
   return result;
END //
DELIMITER ;
    
select update_rep(20,999);