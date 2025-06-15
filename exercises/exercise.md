
# 📚 Exercícios de SQL com o Banco de Dados W3Schools

## 📝 Parte 1 – Exercícios de Nível Fácil

---

### Exercício 1 – Listando todos os clientes  
Exiba todas as informações da tabela **Customers**.

---

### Exercício 2 – Filtrando por país  
Liste o nome e o país dos clientes que são do **Brazil**.

---

### Exercício 3 – Produtos com preço menor que 20  
Exiba o nome dos produtos e o preço apenas dos produtos com preço **menor que 20**.

---

### Exercício 4 – Ordenando os fornecedores  
Liste o nome dos fornecedores (**SupplierName**) e o país (**Country**), ordenados em ordem alfabética de país.

---

### Exercício 5 – Pedidos por um cliente específico  
Liste o **OrderID** e a **OrderDate** de todos os pedidos feitos pelo cliente com **CustomerID = 90**.

---

## 📝 Parte 2 – Exercícios de Nível Médio

---

### Exercício 6 – Produtos por categoria  
Liste o nome dos produtos (**ProductName**) e o nome da categoria (**CategoryName**), fazendo um **JOIN** entre as tabelas **Products** e **Categories**.

---

### Exercício 7 – Detalhes de pedidos  
Liste o **OrderID**, o **ProductID** e a **Quantity** de cada item na tabela **OrderDetails**, apenas para pedidos com **OrderID maior que 10250**.

---

### Exercício 8 – Contagem de clientes por país  
Mostre quantos clientes existem em cada país, listando o país e a quantidade de clientes.

---

### Exercício 9 – Funcionários por país  
Liste o nome completo dos funcionários (**FirstName** + **LastName**) e o país onde trabalham, ordenando o resultado por país.

---

### Exercício 10 – Pedidos com nome do cliente  
Liste o **OrderID**, a **OrderDate** e o **CustomerName**, fazendo um **JOIN** entre as tabelas **Orders** e **Customers**.

---

# ✅ Gabarito dos Exercícios

---

### Gabarito – Exercícios de Nível Fácil

**Exercício 1:**
```sql
SELECT * FROM Customers;
```

**Exercício 2:**
```sql
SELECT CustomerName, Country FROM Customers WHERE Country = 'Brazil';
```

**Exercício 3:**
```sql
SELECT ProductName, Price FROM Products WHERE Price < 20;
```

**Exercício 4:**
```sql
SELECT SupplierName, Country FROM Suppliers ORDER BY Country;
```

**Exercício 5:**
```sql
SELECT OrderID, OrderDate FROM Orders WHERE CustomerID = 90;
```

---

### Gabarito – Exercícios de Nível Médio

**Exercício 6:**
```sql
SELECT Products.ProductName, Categories.CategoryName
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;
```

**Exercício 7:**
```sql
SELECT OrderID, ProductID, Quantity FROM OrderDetails WHERE OrderID > 10250;
```

**Exercício 8:**
```sql
SELECT Country, COUNT(CustomerID) AS TotalClientes
FROM Customers
GROUP BY Country;
```

**Exercício 9:**
```sql
SELECT CONCAT(FirstName, ' ', LastName) AS NomeCompleto, Country
FROM Employees
ORDER BY Country;
```

**Exercício 10:**
```sql
SELECT Orders.OrderID, Orders.OrderDate, Customers.CustomerName
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
```
