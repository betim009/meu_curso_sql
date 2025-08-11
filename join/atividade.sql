-- =============================================================
-- Banco fictício: loja_cafe
-- Objetivo: criar DB, tabelas (cafes, vendedores, vendas) e seed
-- MySQL/InnoDB/UTF8MB4
-- =============================================================

-- 1) (Re)cria o banco
DROP DATABASE IF EXISTS loja_cafe;

CREATE DATABASE loja_cafe CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE loja_cafe;

-- 2) Tabelas
-- 2.1) cafes
CREATE TABLE cafes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

-- 2.2) vendedores
CREATE TABLE vendedores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade TINYINT UNSIGNED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

-- 2.3) vendas
-- Observação: seguindo seu padrão de nomes, usamos idcafe e idvendedor
CREATE TABLE vendas (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    idcafe INT UNSIGNED NOT NULL,
    idvendedor INT UNSIGNED NOT NULL,
    data_venda DATE NOT NULL,
    quantidade INT UNSIGNED NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_vendas_cafe FOREIGN KEY (idcafe) REFERENCES cafes (id),
    CONSTRAINT fk_vendas_vendedor FOREIGN KEY (idvendedor) REFERENCES vendedores (id),
    INDEX idx_vendas_cafe (idcafe),
    INDEX idx_vendas_vendedor (idvendedor),
    INDEX idx_vendas_data (data_venda)
) ENGINE = InnoDB;

-- 3) Seed (dados iniciais)
START TRANSACTION;

-- 3.1) cafes (2 produtos)
INSERT INTO
    cafes (nome, preco)
VALUES ('Café tipo A', 15.90),
    ('Café tipo B', 19.50);

-- 3.2) vendedores
INSERT INTO
    vendedores (nome, idade)
VALUES ('Ana', 25),
    ('Bruno', 31),
    ('Carla', 22);

-- 3.3) vendas (exemplos variados)
INSERT INTO
    vendas (
        idcafe,
        idvendedor,
        data_venda,
        quantidade,
        valor_unitario
    )
VALUES (1, 1, '2025-08-01', 2, 15.90),
    (1, 2, '2025-08-02', 1, 15.90),
    (2, 1, '2025-08-02', 3, 19.50),
    (2, 3, '2025-08-03', 1, 19.50),
    (1, 3, '2025-08-03', 5, 15.90),
    (2, 2, '2025-08-04', 2, 19.50);

COMMIT;

-- 4) Atividades (bem simples):
-- 1. Liste todos os cafés (id, nome).
-- 2. Liste todos os vendedores (id, nome).
-- 3. Liste todas as vendas (id, data_venda, idcafe, idvendedor, quantidade, valor_unitario).
-- 4. Faça um INNER JOIN de vendas com cafes para mostrar o nome do café.
-- 5. Faça um INNER JOIN de vendas com vendedores para mostrar o nome do vendedor.
-- 6. Faça um INNER JOIN de vendas com cafes e vendedores (sem cálculo).

-- 5) Gabarito (respostas simples)

-- 1. Todos os cafés
SELECT id, nome FROM cafes;

-- 2. Todos os vendedores
SELECT id, nome FROM vendedores;

-- 3. Todas as vendas
SELECT
    id,
    data_venda,
    idcafe,
    idvendedor,
    quantidade,
    valor_unitario
FROM vendas;

-- 4. INNER JOIN: vendas + cafes
SELECT v.id, v.data_venda, c.nome AS cafe, v.quantidade, v.valor_unitario
FROM vendas AS v
    INNER JOIN cafes AS c ON c.id = v.idcafe;

-- 5. INNER JOIN: vendas + vendedores
SELECT v.id, v.data_venda, ve.nome AS vendedor, v.quantidade, v.valor_unitario
FROM vendas AS v
    INNER JOIN vendedores AS ve ON ve.id = v.idvendedor;

-- 6. INNER JOIN: vendas + cafes + vendedores
SELECT v.id, v.data_venda, c.nome AS cafe, ve.nome AS vendedor, v.quantidade, v.valor_unitario
FROM
    vendas AS v
    INNER JOIN cafes AS c ON c.id = v.idcafe
    INNER JOIN vendedores AS ve ON ve.id = v.idvendedor;