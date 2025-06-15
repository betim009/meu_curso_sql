-- Dados de exemplo para os exercícios de SQL da W3Schools

-- Inserções para a tabela Customers
INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country)
VALUES
    (1, 'Alfreds Futterkiste', 'Maria Anders', 'Germany'),
    (2, 'Centro comercial Moctezuma', 'Francisco Chang', 'Mexico'),
    (3, 'Ernst Handel', 'Roland Mendel', 'Austria');

-- Inserções para a tabela Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES
    (101, 1, '2024-01-10'),
    (102, 2, '2024-01-11'),
    (103, 3, '2024-01-12');

-- Inserções para a tabela Products
INSERT INTO Products (ProductID, ProductName, Price)
VALUES
    (1001, 'Chai', 18),
    (1002, 'Chang', 19),
    (1003, 'Aniseed Syrup', 10);

-- Utilize o editor Try SQL da W3Schools para executar as questões abaixo
-- 1. Selecionar todos os registros da tabela Customers.
-- 2. Buscar os nomes de todos os clientes da Alemanha.
-- 3. Listar o OrderID e OrderDate dos pedidos feitos pelo cliente 'Ernst Handel'.
-- 4. Mostrar o ProductName e Price de todos os produtos com preço acima de 15.
-- 5. Contar o total de pedidos realizados por cada cliente.
-- 6. Selecionar o nome e o preço do produto mais caro.
-- 7. Exibir todos os pedidos realizados no ano de 2024.
-- 8. Mostrar o total de pedidos por país.
-- 9. Listar os produtos cujo nome começa com 'C'.
-- 10. Calcular a média de preços dos produtos.

-- Mais questões podem ser adicionadas abaixo conforme necessário

