DELIMITER $$

CREATE PROCEDURE AtualizarValorTotalPedidoCliente(IN p_IDCliente INT)
BEGIN
    -- Variáveis de controle
    DECLARE v_fim INT DEFAULT 0;
    DECLARE v_valorPedido DECIMAL(18,2);
    DECLARE v_total DECIMAL(18,2) DEFAULT 0.00;

    -- Cursor para buscar os valores dos pedidos do cliente
    DECLARE cur_pedidos CURSOR FOR
        SELECT Valor
        FROM PedidoVenda
        WHERE idCliente = p_IDCliente;

    -- Handler para fim do cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_fim = 1;

    -- Handler para erro SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro na transação. Operação desfeita.' AS Mensagem;
    END;

    START TRANSACTION;

    -- Zera o acumulador
    SET v_total = 0.00;

    -- Abre o cursor
    OPEN cur_pedidos;

    leitura: LOOP
        FETCH cur_pedidos INTO v_valorPedido;

        IF v_fim = 1 THEN
            LEAVE leitura;
        END IF;

        SET v_total = v_total + v_valorPedido;
    END LOOP;

    CLOSE cur_pedidos;

    -- Atualiza o total no cliente
    UPDATE Cliente
    SET ValorTotalPedido = v_total
    WHERE idCliente = p_IDCliente;

    COMMIT;

    SELECT 'Valor total atualizado com sucesso.' AS Mensagem,
           p_IDCliente AS IDCliente,
           v_total AS ValorTotalPedido;
END$$

DELIMITER ;