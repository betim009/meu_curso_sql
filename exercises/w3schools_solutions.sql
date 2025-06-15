-- Sample solutions for W3Schools SQL exercises

-- 1. Select all records from the Customers table
SELECT * FROM Customers;

-- 2. Retrieve the names of all customers from Germany
SELECT CustomerName FROM Customers WHERE Country = 'Germany';

-- 3. List the OrderID and OrderDate for orders made by customer 'Ernst Handel'
SELECT o.OrderID, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.CustomerName = 'Ernst Handel';

-- 4. Show the ProductName and Price of all products priced over 15
SELECT ProductName, Price FROM Products WHERE Price > 15;

-- 5. Count the total number of orders placed by each customer
SELECT CustomerID, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY CustomerID;

