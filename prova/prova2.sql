-- Desenvolva uma stored procedure que receba como parâmetro o idFornecedor, utilizando cursor, controle de transação e controle de erros, para calcular e atualizar o valor total de compras realizadas com o fornecedor informado no campo fornecedor.ValorTotalCompras. -- 

DELIMITER $$

CREATE PROCEDURE AtualizarValorTotalComprasFornecedor(IN p_idFornecedor INT)
BEGIN
    -- Variáveis de controle
    DECLARE v_fim INT DEFAULT 0;
    DECLARE v_valorCompra DECIMAL(18,2);
    DECLARE v_totalCompras DECIMAL(18,2) DEFAULT 0.00;

    -- Cursor para buscar os valores dos pedidos de compra do fornecedor
    DECLARE cur_compras CURSOR FOR
        SELECT Valor
        FROM pedidocompra
        WHERE idFornecedor = p_idFornecedor;

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

    -- Inicializa o total
    SET v_totalCompras = 0.00;

    -- Abre o cursor
    OPEN cur_compras;

    leitura: LOOP
        FETCH cur_compras INTO v_valorCompra;

        IF v_fim = 1 THEN
            LEAVE leitura;
        END IF;

        SET v_totalCompras = v_totalCompras + v_valorCompra;
    END LOOP;

    CLOSE cur_compras;

    -- Atualiza a tabela fornecedor
    UPDATE fornecedor
    SET ValorTotalCompras = v_totalCompras
    WHERE idFornecedor = p_idFornecedor;

    COMMIT;

    SELECT 'Valor total de compras atualizado com sucesso.' AS Mensagem,
           p_idFornecedor AS idFornecedor,
           v_totalCompras AS ValorTotalCompras;
END$$

DELIMITER ;