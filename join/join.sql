-- Sintaxe:
-- SELECT colunas
-- FROM TabelaA AS a
-- INNER JOIN TabelaB AS b
--   ON a.chave = b.chave

-- INNER é opcional: "JOIN" já é INNER JOIN

-- Selecionamos as colunas.
-- Depois conectamos elas.
-- Relacionamos as colunas iguais.

USE sakila;

-- Ex: 1 country com city
SELECT a.country, b.city
FROM country AS a
    INNER JOIN city AS b ON a.country_id = b.country_id
ORDER BY a.country, b.city;

-- Ex: 2 adress com city
SELECT ad.address, ad.district, ci.city
FROM address AS ad
    JOIN city AS ci ON ci.city_id = ad.city_id;

-- Ex: 3 adrres com city e contry
SELECT ad.address, ad.district, ci.city, co.country
FROM
    address AS ad
    JOIN city AS ci ON ci.city_id = ad.city_id
    JOIN country AS co ON co.country_id = ci.country_id;