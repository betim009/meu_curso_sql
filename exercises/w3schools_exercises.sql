-- Sample data for W3Schools SQL exercises

-- Insert statements for Customers table
INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country)
VALUES
    (1, 'Alfreds Futterkiste', 'Maria Anders', 'Germany'),
    (2, 'Centro comercial Moctezuma', 'Francisco Chang', 'Mexico'),
    (3, 'Ernst Handel', 'Roland Mendel', 'Austria');

-- Insert statements for Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES
    (101, 1, '2024-01-10'),
    (102, 2, '2024-01-11'),
    (103, 3, '2024-01-12');

-- Insert statements for Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES
    (1001, 'Chai', 18),
    (1002, 'Chang', 19),
    (1003, 'Aniseed Syrup', 10);

-- TODO: Use the W3Schools SQL Tryit editor to execute the following questions
-- 1. Select all records from the Customers table.
-- 2. Retrieve the names of all customers from Germany.
-- 3. List the OrderID and OrderDate for orders made by customer 'Ernst Handel'.
-- 4. Show the ProductName and Price of all products priced over 15.
-- 5. Count the total number of orders placed by each customer.

-- More questions can be added below as needed

