
# ✅ Gabarito Explicado – Exercícios de SQL com o Banco de Dados W3Schools

## Gabarito – Exercícios de Nível Fácil

---

### Exercício 1: Listando todos os clientes

**Comando SQL:**
```sql
SELECT * FROM Customers;
```

**Explicação:**  
- O comando `SELECT *` significa: **"Selecione todas as colunas"** da tabela.
- A tabela usada é a **Customers**, que contém informações dos clientes.
- Este comando retorna todas as informações de todos os clientes cadastrados.

---

### Exercício 2: Filtrando por país

**Comando SQL:**
```sql
SELECT CustomerName, Country FROM Customers WHERE Country = 'Brazil';
```

**Explicação:**  
- `SELECT CustomerName, Country`: seleciona apenas o nome do cliente e o país.
- `FROM Customers`: indica que os dados estão na tabela de clientes.
- `WHERE Country = 'Brazil'`: **filtro** para mostrar apenas clientes cujo país é **Brazil**.

---

### Exercício 3: Produtos com preço menor que 20

**Comando SQL:**
```sql
SELECT ProductName, Price FROM Products WHERE Price < 20;
```

**Explicação:**  
- `SELECT ProductName, Price`: exibe o nome e o preço dos produtos.
- `FROM Products`: busca os dados da tabela de produtos.
- `WHERE Price < 20`: mostra apenas os produtos com preço menor que 20.

---

### Exercício 4: Ordenando os fornecedores

**Comando SQL:**
```sql
SELECT SupplierName, Country FROM Suppliers ORDER BY Country;
```

**Explicação:**  
- `SELECT SupplierName, Country`: exibe o nome do fornecedor e o país.
- `FROM Suppliers`: os dados estão na tabela de fornecedores.
- `ORDER BY Country`: organiza o resultado em **ordem alfabética de país**.

---

### Exercício 5: Pedidos por um cliente específico

**Comando SQL:**
```sql
SELECT OrderID, OrderDate FROM Orders WHERE CustomerID = 1;
```

**Explicação:**  
- `SELECT OrderID, OrderDate`: mostra o código e a data dos pedidos.
- `FROM Orders`: a consulta é feita na tabela de pedidos.
- `WHERE CustomerID = 1`: mostra apenas os pedidos feitos pelo cliente de ID 1.

---

## Gabarito – Exercícios de Nível Médio

---

### Exercício 6: Produtos por categoria

**Comando SQL:**
```sql
SELECT Products.ProductName, Categories.CategoryName
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;
```

**Explicação:**  
- Fazemos um **JOIN (junção de tabelas)** entre **Products** e **Categories**.
- `Products.ProductName`: mostra o nome do produto.
- `Categories.CategoryName`: mostra o nome da categoria do produto.
- O **INNER JOIN** conecta os registros onde o `CategoryID` é igual nas duas tabelas.

---

### Exercício 7: Detalhes de pedidos

**Comando SQL:**
```sql
SELECT OrderID, ProductID, Quantity FROM OrderDetails WHERE OrderID > 10250;
```

**Explicação:**  
- `SELECT OrderID, ProductID, Quantity`: exibe o código do pedido, do produto e a quantidade comprada.
- `FROM OrderDetails`: consulta feita na tabela de detalhes de pedidos.
- `WHERE OrderID > 10250`: filtra para mostrar apenas pedidos com ID acima de 10250.

---

### Exercício 8: Contagem de clientes por país

**Comando SQL:**
```sql
SELECT Country, COUNT(CustomerID) AS TotalClientes
FROM Customers
GROUP BY Country;
```

**Explicação:**  
- `SELECT Country, COUNT(CustomerID) AS TotalClientes`: exibe o país e a quantidade de clientes naquele país.
- `FROM Customers`: consulta feita na tabela de clientes.
- `GROUP BY Country`: agrupa os resultados por país, contando os clientes de cada um.

---

### Exercício 9: Funcionários por país

**Comando SQL:**
```sql
SELECT CONCAT(FirstName, ' ', LastName) AS NomeCompleto, Country
FROM Employees
ORDER BY Country;
```

**Explicação:**  
- `CONCAT(FirstName, ' ', LastName) AS NomeCompleto`: junta o nome e o sobrenome em uma única coluna chamada "NomeCompleto".
- `FROM Employees`: busca os dados na tabela de funcionários.
- `ORDER BY Country`: organiza a lista por país.

---

### Exercício 10: Pedidos com nome do cliente

**Comando SQL:**
```sql
SELECT Orders.OrderID, Orders.OrderDate, Customers.CustomerName
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
```

**Explicação:**  
- Fazemos um **INNER JOIN** para combinar as tabelas **Orders** e **Customers**.
- Assim conseguimos ver o **OrderID**, a **OrderDate** e o **CustomerName** de quem fez cada pedido.
- O **JOIN** conecta os pedidos com seus respectivos clientes.

---

## ✅ Dicas Finais

✔️ Sempre leia bem o enunciado para escolher a tabela certa.  
✔️ Se o exercício pede **filtro**, use `WHERE`.  
✔️ Se pede **junção**, use `JOIN`.  
✔️ Se pede **contagem**, use `COUNT` com `GROUP BY`.  
✔️ Ordenações? Use `ORDER BY`.  
