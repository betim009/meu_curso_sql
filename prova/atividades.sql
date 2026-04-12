-- EXERCÍCIO 2
DELIMITER $$

CREATE PROCEDURE BuscarProdutosSemEstoque()
BEGIN
    SELECT idProduto, NomeProduto, Preco, QtdEstoque
    FROM produto
    WHERE QtdEstoque = 0;
END$$

DELIMITER ;

-- EXERCÍCIO 3
DELIMITER $$

CREATE PROCEDURE ExcluirClienteSeNaoTiverPedido(IN p_idCliente INT)
BEGIN
    DECLARE v_qtdPedidos INT DEFAULT 0;

    SELECT COUNT(*)
    INTO v_qtdPedidos
    FROM pedidovenda
    WHERE idCliente = p_idCliente;

    IF v_qtdPedidos = 0 THEN
        DELETE FROM cliente
        WHERE idCliente = p_idCliente;

        SELECT 'Cliente excluído com sucesso.' AS Mensagem;
    ELSE
        SELECT 'Cliente não pode ser excluído, pois possui pedidos.' AS Mensagem;
    END IF;
END$$

DELIMITER ;

-- EXERCÍCIO 4
DELIMITER $$

CREATE PROCEDURE QuantidadeVendidaPorProdutoEAno(
    IN p_idProduto INT,
    IN p_ano INT,
    OUT p_quantidadeVendida INT
)
BEGIN
    SELECT COALESCE(SUM(CAST(ipv.Qtd AS UNSIGNED)), 0)
    INTO p_quantidadeVendida
    FROM itempedidovenda ipv
    INNER JOIN pedidovenda pv
        ON ipv.idPedidoVenda = pv.idPedidoVenda
    WHERE ipv.idProduto = p_idProduto
      AND YEAR(pv.DataPedido) = p_ano;
END$$

DELIMITER ;