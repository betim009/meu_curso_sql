-- Soluções de exemplo para os exercícios de SQL da W3Schools

-- 1. Selecionar todos os registros da tabela Customers
SELECT * FROM Customers;

-- 2. Buscar os nomes de todos os clientes da Alemanha
SELECT CustomerName FROM Customers WHERE Country = 'Germany';

-- 3. Listar o OrderID e OrderDate dos pedidos feitos pelo cliente 'Ernst Handel'
SELECT o.OrderID, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.CustomerName = 'Ernst Handel';

-- 4. Mostrar o ProductName e Price de todos os produtos com preço acima de 15
SELECT ProductName, Price FROM Products WHERE Price > 15;

-- 5. Contar o total de pedidos realizados por cada cliente
SELECT CustomerID, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY CustomerID;

-- 6. Selecionar o nome e o preço do produto mais caro
SELECT ProductName, Price
FROM Products
ORDER BY Price DESC
LIMIT 1;

-- 7. Exibir todos os pedidos realizados no ano de 2024
SELECT * FROM Orders
WHERE OrderDate >= '2024-01-01' AND OrderDate < '2025-01-01';

-- 8. Mostrar o total de pedidos por país
SELECT c.Country, COUNT(*) AS TotalPedidos
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Country;

-- 9. Listar os produtos cujo nome começa com 'C'
SELECT ProductName
FROM Products
WHERE ProductName LIKE 'C%';

-- 10. Calcular a média de preços dos produtos
SELECT AVG(Price) AS MediaPreco
FROM Products;

