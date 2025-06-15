
# 📚 Banco de Dados de Exemplo do W3Schools (SQL)

## 🎯 Objetivo deste Material

Antes de começarmos a aprender comandos SQL, é fundamental conhecer o banco de dados que vamos usar como exemplo. Assim, você entende o **contexto dos exercícios** e consegue visualizar como os dados estão organizados.

O site **W3Schools** disponibiliza um **banco de dados de amostra (Sample Database)** que é usado em quase todos os exemplos práticos de SQL deles.

---

## 🗂️ Nome do Banco de Dados

**W3Schools Sample Database**

Este banco de dados é pequeno, fácil de entender, e contém informações comerciais simples, como:  
clientes, pedidos, produtos, funcionários e transportadoras.

Ele segue um modelo muito usado no mundo real: o de uma **loja ou empresa de vendas online**.

---

## 📌 Principais Tabelas do Banco

| Nome da Tabela     | O que representa?                            | Campos principais                           |
|--------------------|----------------------------------------------|--------------------------------------------|
| **Customers**      | Dados dos clientes                           | `CustomerID`, `CustomerName`, `ContactName`, `Country`, etc |
| **Suppliers**      | Dados dos fornecedores de produtos           | `SupplierID`, `SupplierName`, `ContactName`, `Country`, etc |
| **Products**       | Lista dos produtos vendidos                  | `ProductID`, `ProductName`, `SupplierID`, `CategoryID`, `Price`, etc |
| **Categories**     | Tipos ou categorias de produtos              | `CategoryID`, `CategoryName`, `Description` |
| **Employees**      | Informações sobre os funcionários            | `EmployeeID`, `LastName`, `FirstName`, `Country`, etc |
| **Orders**         | Os pedidos feitos pelos clientes             | `OrderID`, `CustomerID`, `EmployeeID`, `OrderDate`, etc |
| **OrderDetails**   | Itens de cada pedido (detalhes do pedido)    | `OrderDetailID`, `OrderID`, `ProductID`, `Quantity` |
| **Shippers**       | Empresas responsáveis pela entrega dos pedidos | `ShipperID`, `ShipperName`, `Phone` |

---

## 🔎 Resumo de cada tabela (com linguagem simples)

### 🧑‍💼 Customers (Clientes)
- Contém informações dos clientes que fizeram pedidos.
- Exemplo de dados:
  - Nome do cliente
  - Nome do contato
  - País
  - Código do cliente

---

### 🚚 Suppliers (Fornecedores)
- Guarda os dados dos fornecedores que vendem os produtos.
- Exemplo de dados:
  - Nome da empresa fornecedora
  - Nome da pessoa de contato
  - País do fornecedor

---

### 📦 Products (Produtos)
- Lista de todos os produtos disponíveis na loja.
- Cada produto tem um fornecedor e pertence a uma categoria.
- Exemplo de dados:
  - Nome do produto
  - Preço
  - Código do fornecedor
  - Código da categoria

---

### 🏷️ Categories (Categorias)
- Aqui ficam as categorias dos produtos.
- Exemplo de categorias:
  - Bebidas
  - Doces
  - Frutas

---

### 👨‍💻 Employees (Funcionários)
- Lista de funcionários que trabalham na empresa.
- Exemplo de dados:
  - Nome
  - Sobrenome
  - País onde trabalha

---

### 📝 Orders (Pedidos)
- Cada linha representa um pedido feito por um cliente.
- Exemplo de dados:
  - Código do pedido
  - Código do cliente
  - Código do funcionário que atendeu o pedido
  - Data do pedido

---

### 📄 OrderDetails (Detalhes dos pedidos)
- Tabela de ligação que mostra **quais produtos fazem parte de cada pedido**.
- Exemplo de dados:
  - Código do pedido
  - Código do produto
  - Quantidade de itens comprados

---

### 🚛 Shippers (Transportadoras)
- Lista das empresas que fazem a entrega dos pedidos.
- Exemplo de dados:
  - Nome da transportadora
  - Telefone de contato

---

## 📌 Por que é importante conhecer essas tabelas?

✅ Para saber **onde estão os dados** que vamos consultar.  
✅ Para entender como fazer **JOINs** entre as tabelas no futuro.  
✅ Para evitar confusões ao escrever comandos SQL.  
✅ Para acompanhar melhor os exemplos do próprio W3Schools.

---

## 🧭 Próximo passo no material:

👉 O próximo módulo será:  
**"Consultando dados com SELECT no SQL"**,  
usando a tabela **Customers**.
