# 📌 CURSOR

## 👉 O que é:
Um cursor serve para **percorrer linha por linha** o resultado de um SELECT.

## 👉 Tradução simples:
“pega uma lista de dados e vai lendo 1 por 1”

## 👉 Exemplo mental:

SELECT id FROM tabela;

Retorno:
1  
2  
3  

Com cursor você faz:

pega 1 → faz algo  
pega 2 → faz algo  
pega 3 → faz algo  

---

# 📌 ERROR HANDLER (ERROS)

## 👉 O que é:
Um handler é usado para **capturar erros e controlar o que acontece quando algo dá errado**

## 👉 Tradução simples:
“se der erro, faça isso”

## 👉 Tipos mais usados:

NOT FOUND     → quando não tem mais dados (fim do cursor)  
SQLEXCEPTION  → erro geral (update falhou, etc)  

## 👉 Exemplo mental:

Se der erro → ativa uma variável (erro = TRUE)

---

# 📌 TRANSACTION

## 👉 O que é:
Um bloco de operações que só é confirmado se tudo der certo

## 👉 Tradução simples:
“ou faz tudo, ou não faz nada”

## 👉 Estrutura:

START TRANSACTION;

-- várias operações

COMMIT;   → salva tudo  
ROLLBACK; → desfaz tudo  

## 👉 Exemplo mental:

Atualiza 10 registros  

Se um falhar → desfaz tudo (ROLLBACK)  
Se todos derem certo → salva (COMMIT)  

---

# 🧠 RESUMO PRA DECORAR

- **CURSOR** → percorre linha por linha  
- **ERROR HANDLER** → trata erro  
- **TRANSACTION** → garante tudo ou nada  

### Primeira etapa para decorar
```sql
DELIMITER $$

CREATE PROCEDURE nome_procedure (parametros)
BEGIN

    -- código SQL aqui

END $$

DELIMITER ;
```

### Exemplo real
```sql
DELIMITER $$

CREATE PROCEDURE listar_alunos()
BEGIN

    SELECT * FROM alunos;

END $$

DELIMITER ;
```

### Exemplo com parametro
```sql
DELIMITER $$

CREATE PROCEDURE buscar_aluno(IN p_id INT)
BEGIN

    SELECT * FROM alunos
    WHERE id = p_id;

END $$

DELIMITER ;
```

### Segunda etapa
```sql
DELIMITER $$

CREATE PROCEDURE exemplo_cursor()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;

    DECLARE cursor_exemplo CURSOR FOR
        SELECT id FROM tabela;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cursor_exemplo;

    read_loop: LOOP

        FETCH cursor_exemplo INTO v_id;

        IF done THEN
            LEAVE read_loop;
        END IF;

        -- ação aqui

    END LOOP;

    CLOSE cursor_exemplo;

END $$

DELIMITER ;
```

### Exemplo real
```sql
DELIMITER $$

CREATE PROCEDURE exemplo_cursor()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_nome VARCHAR(100);

    DECLARE cursor_exemplo CURSOR FOR
        SELECT id, nome FROM tabela;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cursor_exemplo;

    read_loop: LOOP

        FETCH cursor_exemplo INTO v_id, v_nome;

        IF done THEN
            LEAVE read_loop;
        END IF;

        -- ação aqui

    END LOOP;

    CLOSE cursor_exemplo;

END $$

DELIMITER ;
```

### Exemplo 3
```sql
DELIMITER $$

CREATE PROCEDURE exemplo_cursor()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE erro INT DEFAULT FALSE;

    DECLARE v_id INT;

    DECLARE cursor_exemplo CURSOR FOR
        SELECT id FROM tabela;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro = TRUE;

    OPEN cursor_exemplo;

    read_loop: LOOP

        FETCH cursor_exemplo INTO v_id;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF erro THEN
            LEAVE read_loop;
        END IF;

        -- ação aqui

    END LOOP;

    CLOSE cursor_exemplo;

END $$

DELIMITER ;
```

```sql
DELIMITER $$

CREATE PROCEDURE exemplo_cursor()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE erro INT DEFAULT FALSE;

    DECLARE v_id INT;

    DECLARE cursor_exemplo CURSOR FOR
        SELECT id FROM tabela;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro = TRUE;

    START TRANSACTION;

    OPEN cursor_exemplo;

    read_loop: LOOP

        FETCH cursor_exemplo INTO v_id;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF erro THEN
            ROLLBACK;
            LEAVE read_loop;
        END IF;

        -- ação aqui
        -- exemplo:
        -- UPDATE tabela SET campo = valor WHERE id = v_id;

        IF erro THEN
            ROLLBACK;
            LEAVE read_loop;
        END IF;

    END LOOP;

    CLOSE cursor_exemplo;

    IF erro THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;

END $$

DELIMITER ;
```