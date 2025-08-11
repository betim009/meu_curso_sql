# INNER JOIN (SQL) — explicação simples

## O que é
**INNER JOIN** junta linhas de **duas (ou mais) tabelas** e retorna
**apenas as que têm correspondência em ambas**. Pense como a
**interseção** de dois conjuntos.

## Sintaxe básica
```sql
SELECT colunas
FROM TabelaA AS a
INNER JOIN TabelaB AS b
  ON a.chave = b.chave
-- Dica: "INNER" é opcional; apenas "JOIN" já faz INNER JOIN
```

## Exemplo prático (tema hospital)
### Tabelas
**pacientes**
| id | nome  |
|---:|-------|
|  1 | Ana   |
|  2 | Bruno |
|  3 | Carla |
|  4 | Diego |

**consultas**
| id | paciente_id | data       | medico_id |
|---:|-------------|------------|-----------|
|  1 | 1           | 2025-08-01 | 10        |
|  2 | 1           | 2025-08-05 | 20        |
|  3 | 3           | 2025-08-03 | 10        |
|  4 | 5           | 2025-08-04 | 30        |  
*linha sem paciente correspondente*

**medicos**
| id | nome       |
|---:|------------|
| 10 | Dr. João   |
| 20 | Dra. Luana |
| 30 | Dr. Pedro  |

### Juntando 2 tabelas
```sql
SELECT p.nome, c.data, c.medico_id
FROM pacientes AS p
JOIN consultas AS c
  ON c.paciente_id = p.id
ORDER BY p.nome, c.data;
```
**Resultado esperado:**
- Ana — 2025-08-01 — 10  
- Ana — 2025-08-05 — 20  
- Carla — 2025-08-03 — 10  

> Não aparecem: Diego (sem consulta) e a consulta com `paciente_id = 5`
> (não tem paciente correspondente).

### Encadeando 3 tabelas
```sql
SELECT p.nome   AS paciente,
       c.data   AS data_consulta,
       m.nome   AS medico
FROM pacientes AS p
JOIN consultas AS c
  ON c.paciente_id = p.id
JOIN medicos AS m
  ON m.id = c.medico_id
ORDER BY c.data;
```

## Quando usar
- Para relatórios que dependem da **relação** entre tabelas
  (pacientes ↔ consultas, pedidos ↔ clientes, itens ↔ produtos).
- Quando você **não quer linhas “soltas”** de nenhum dos lados.

## Dicas e variações úteis
- `INNER` é **opcional**: `JOIN` = `INNER JOIN`.
- Dá para juntar por **várias colunas**:
  ```sql
  ON a.cod = b.cod AND a.ano = b.ano
  ```
- Evite a sintaxe antiga com vírgulas e condição no `WHERE`:
  ```sql
  -- NÃO recomendado
  FROM a, b WHERE a.id = b.id
  ```

## Erros comuns (e como evitar)
1. **Esquecer o `ON`** → vira `CROSS JOIN` (produto cartesiano).
2. **Condição errada** no `ON` → linhas duplicadas ou faltando.
3. **Filtrar no lugar errado**: em `INNER JOIN`, filtrar no `ON` ou no
   `WHERE` costuma dar o mesmo para a tabela juntada, mas em `LEFT JOIN`
   **muda** o resultado.
4. **Nulos**: `NULL` não é igual a nada; chaves nulas não casam.
5. **Falta de índice** nas chaves de junção → consulta lenta. Crie
   índices em `p.id`, `c.paciente_id`, `c.medico_id`, etc.

## Regra de ouro
**INNER JOIN** retorna **somente** o que existe **nas duas** tabelas. Se
precisar trazer **tudo de um lado, mesmo sem par**, use `LEFT JOIN`.
