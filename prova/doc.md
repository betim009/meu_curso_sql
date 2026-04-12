# Explicação Detalhada do Resultado da Stored Procedure

## Contexto da questão

A questão pede uma **stored procedure** que:

- receba como parâmetro o `IDCliente`
- use **cursor**
- use **controle de erros**
- use **controle de transação**
- calcule a soma dos pedidos do cliente
- atualize o campo `Cliente.ValorTotalPedido`

A ideia principal é:

1. buscar todos os pedidos de um cliente
2. somar os valores desses pedidos
3. salvar esse total dentro da tabela `Cliente`

---

## Procedure resolvida

```sql
DELIMITER $$

CREATE PROCEDURE AtualizarValorTotalPedidoCliente(IN p_IDCliente INT)
BEGIN
    DECLARE v_fim INT DEFAULT 0;
    DECLARE v_valorPedido DECIMAL(18,2);
    DECLARE v_total DECIMAL(18,2) DEFAULT 0.00;

    DECLARE cur_pedidos CURSOR FOR
        SELECT Valor
        FROM PedidoVenda
        WHERE idCliente = p_IDCliente;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_fim = 1;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro na transação. Operação desfeita.' AS Mensagem;
    END;

    START TRANSACTION;

    SET v_total = 0.00;

    OPEN cur_pedidos;

    leitura: LOOP
        FETCH cur_pedidos INTO v_valorPedido;

        IF v_fim = 1 THEN
            LEAVE leitura;
        END IF;

        SET v_total = v_total + v_valorPedido;
    END LOOP;

    CLOSE cur_pedidos;

    UPDATE Cliente
    SET ValorTotalPedido = v_total
    WHERE idCliente = p_IDCliente;

    COMMIT;

    SELECT 'Valor total atualizado com sucesso.' AS Mensagem,
           p_IDCliente AS IDCliente,
           v_total AS ValorTotalPedido;
END$$

DELIMITER ;
```

---

# O que acontece quando a procedure é executada

Quando você executa:

```sql
CALL AtualizarValorTotalPedidoCliente(1);
```

o banco começa a seguir uma sequência de passos.

---

## 1. A procedure recebe o ID do cliente

Neste exemplo, o valor enviado foi:

```sql
1
```

Isso significa que a procedure vai trabalhar apenas com o cliente de ID `1`.

---

## 2. O cursor é preparado

O cursor foi declarado assim:

```sql
DECLARE cur_pedidos CURSOR FOR
    SELECT Valor
    FROM PedidoVenda
    WHERE idCliente = p_IDCliente;
```

### O que isso significa na prática?

O cursor vai guardar o resultado desta consulta:

```sql
SELECT Valor
FROM PedidoVenda
WHERE idCliente = 1;
```

Suponha que a tabela `PedidoVenda` tenha estes dados para esse cliente:

| idPedido | idCliente | Valor |
|---------|-----------|-------|
| 10      | 1         | 100.00 |
| 11      | 1         | 200.00 |
| 12      | 1         | 50.00 |

Então o resultado da consulta será:

| Valor |
|------|
| 100.00 |
| 200.00 |
| 50.00 |

Esse conjunto de linhas é o que o cursor vai percorrer.

---

## 3. A transação é iniciada

A linha:

```sql
START TRANSACTION;
```

abre uma transação.

### O que isso quer dizer?

Significa que o banco começa uma operação controlada.

Se tudo der certo, a alteração será confirmada com:

```sql
COMMIT;
```

Se acontecer algum erro, tudo volta ao estado anterior com:

```sql
ROLLBACK;
```

Isso é importante porque evita salvar dados errados pela metade.

---

## 4. O acumulador começa com zero

A variável usada para somar os pedidos é:

```sql
DECLARE v_total DECIMAL(18,2) DEFAULT 0.00;
```

Depois ela é reforçada com:

```sql
SET v_total = 0.00;
```

### Qual é a ideia?

Antes de começar a somar, o total precisa começar em zero.

Então, no início da leitura:

```text
v_total = 0.00
```

---

## 5. O cursor é aberto

A linha:

```sql
OPEN cur_pedidos;
```

faz o cursor começar a funcionar.

### O que isso significa?

Significa que agora o banco está pronto para ler, linha por linha, os valores encontrados no `SELECT`.

---

## 6. O loop começa a percorrer os pedidos

A parte principal da lógica é esta:

```sql
leitura: LOOP
    FETCH cur_pedidos INTO v_valorPedido;

    IF v_fim = 1 THEN
        LEAVE leitura;
    END IF;

    SET v_total = v_total + v_valorPedido;
END LOOP;
```

Aqui acontece a leitura dos pedidos um por um.

---

## 7. O `FETCH` pega uma linha por vez

A linha:

```sql
FETCH cur_pedidos INTO v_valorPedido;
```

faz o seguinte:

- pega a próxima linha do cursor
- coloca o valor encontrado dentro da variável `v_valorPedido`

### Exemplo prático

Na primeira leitura:

```text
v_valorPedido = 100.00
```

Na segunda leitura:

```text
v_valorPedido = 200.00
```

Na terceira leitura:

```text
v_valorPedido = 50.00
```

---

## 8. A soma vai sendo construída aos poucos

Depois de cada `FETCH`, a procedure faz:

```sql
SET v_total = v_total + v_valorPedido;
```

### Evolução da soma

Começo:

```text
v_total = 0.00
```

Primeiro pedido:

```text
v_total = 0.00 + 100.00
v_total = 100.00
```

Segundo pedido:

```text
v_total = 100.00 + 200.00
v_total = 300.00
```

Terceiro pedido:

```text
v_total = 300.00 + 50.00
v_total = 350.00
```

### Resultado final da soma

No fim do loop:

```text
v_total = 350.00
```

---

## 9. O handler identifica quando acabaram as linhas

Foi declarado este handler:

```sql
DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET v_fim = 1;
```

### O que ele faz?

Quando o `FETCH` tenta ler uma próxima linha e não encontra mais nenhuma, o MySQL dispara a condição `NOT FOUND`.

Nesse momento:

```text
v_fim = 1
```

Então a procedure entende que terminou de percorrer todos os pedidos.

Por isso ela executa:

```sql
LEAVE leitura;
```

e sai do loop.

---

## 10. O cursor é fechado

Depois que termina a leitura, a procedure executa:

```sql
CLOSE cur_pedidos;
```

### Por que isso é importante?

Porque o cursor não deve ficar aberto depois do uso.

Abrir e fechar corretamente faz parte da estrutura esperada de uso de cursor.

---

## 11. A tabela `Cliente` é atualizada

Depois de terminar a soma, a procedure executa:

```sql
UPDATE Cliente
SET ValorTotalPedido = v_total
WHERE idCliente = p_IDCliente;
```

Como `v_total` chegou ao valor `350.00`, na prática isso vira:

```sql
UPDATE Cliente
SET ValorTotalPedido = 350.00
WHERE idCliente = 1;
```

---

## 12. Como fica o resultado na tabela

### Antes da procedure

| idCliente | Nome | ValorTotalPedido |
|----------|------|------------------|
| 1        | Ana  | 0.00 |

### Depois da procedure

| idCliente | Nome | ValorTotalPedido |
|----------|------|------------------|
| 1        | Ana  | 350.00 |

Então o campo `ValorTotalPedido` do cliente passa a guardar a soma de todos os pedidos dele.

---

## 13. A transação é confirmada

Se tudo aconteceu corretamente, a procedure executa:

```sql
COMMIT;
```

### Resultado disso

A atualização passa a valer de forma definitiva no banco.

Ou seja:

- o valor calculado fica salvo
- a alteração não será desfeita automaticamente
- o cliente agora possui o total atualizado em `ValorTotalPedido`

---

## 14. A procedure retorna uma mensagem final

No final, ela executa:

```sql
SELECT 'Valor total atualizado com sucesso.' AS Mensagem,
       p_IDCliente AS IDCliente,
       v_total AS ValorTotalPedido;
```

### Exemplo de retorno

| Mensagem                              | IDCliente | ValorTotalPedido |
|---------------------------------------|----------:|-----------------:|
| Valor total atualizado com sucesso.   | 1         | 350.00           |

### O que esse retorno significa?

Significa apenas uma confirmação para quem executou a procedure.

Esse `SELECT` final não cria tabela nova nem altera estrutura do banco.

Ele só mostra um resultado informando:

- que deu certo
- qual cliente foi processado
- qual foi o total calculado

---

# O que acontece se der erro

A procedure possui este controle de erro:

```sql
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    ROLLBACK;
    SELECT 'Erro na transação. Operação desfeita.' AS Mensagem;
END;
```

### O que isso quer dizer?

Se acontecer qualquer erro SQL durante a execução:

- a transação é cancelada com `ROLLBACK`
- a alteração não é salva
- o banco volta ao estado anterior
- uma mensagem de erro é retornada

---

## Exemplo de efeito do erro

Imagine que aconteceu um problema antes do `COMMIT`.

### Antes

| idCliente | Nome | ValorTotalPedido |
|----------|------|------------------|
| 1        | Ana  | 0.00 |

A procedure até poderia ter calculado o total internamente, mas se houver erro:

```sql
ROLLBACK;
```

### Depois do rollback

| idCliente | Nome | ValorTotalPedido |
|----------|------|------------------|
| 1        | Ana  | 0.00 |

Ou seja, nada muda no banco.

---

# Resumindo a lógica completa

A procedure funciona assim:

1. recebe o `IDCliente`
2. abre uma transação
3. busca todos os valores de pedidos daquele cliente
4. usa cursor para ler pedido por pedido
5. soma os valores em `v_total`
6. atualiza `Cliente.ValorTotalPedido`
7. confirma com `COMMIT` se tudo der certo
8. desfaz com `ROLLBACK` se ocorrer erro

---

# Resumo final para prova

Você pode explicar o resultado da procedure assim:

> A procedure recebe o ID de um cliente e busca todos os pedidos desse cliente na tabela `PedidoVenda`.  
> Utilizando um cursor, ela percorre os valores linha por linha e soma tudo em uma variável acumuladora.  
> Ao final, o total calculado é salvo no campo `ValorTotalPedido` da tabela `Cliente`.  
> Se toda a execução ocorrer corretamente, a transação é confirmada com `COMMIT`.  
> Se acontecer qualquer erro, a transação é desfeita com `ROLLBACK`, garantindo que nenhum dado incorreto seja salvo.

---

# Ideia central em uma frase

O resultado final da procedure é atualizar o cliente com a soma de todos os pedidos dele.

