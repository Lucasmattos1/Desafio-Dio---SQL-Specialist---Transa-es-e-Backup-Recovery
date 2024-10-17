DELIMITER $$

CREATE PROCEDURE registrar_ordem_servico(
    IN p_id_cliente INT,
    IN p_id_veiculo INT,
    IN p_valor_total DECIMAL(10, 2)
)
BEGIN
    DECLARE exit handler FOR SQLEXCEPTION
    BEGIN
        -- Se houver erro, realiza o rollback e sai da procedure
        ROLLBACK;
        SELECT 'Erro na transação. Operação abortada.';
    END;

    -- Iniciar a transação
    START TRANSACTION;

    -- Criar um savepoint para rollback parcial
    SAVEPOINT ponto_inicial;

    -- 1. Inserir uma nova ordem de serviço
    INSERT INTO OrdemDeServico (Cliente_ID, Veiculo_ID, DataEmissao, StatusPedido, ValorTotal)
    VALUES (p_id_cliente, p_id_veiculo, NOW(), 'Em Progresso', p_valor_total);

    -- Verificação: Se ocorrer erro, rollback para o savepoint
    IF ROW_COUNT() = 0 THEN
        ROLLBACK TO ponto_inicial;
        SELECT 'Falha ao inserir a ordem de serviço. Rolback para ponto inicial.';
        LEAVE;
    END IF;

    -- 2. Atualizar o status do veículo para "em manutenção"
    UPDATE Veiculo 
    SET Status = 'Em Manutenção' 
    WHERE CódigoVeículo = p_id_veiculo;

    -- Verificação: Se a atualização falhar, rollback para o savepoint
    IF ROW_COUNT() = 0 THEN
        ROLLBACK TO ponto_inicial;
        SELECT 'Falha ao atualizar o status do veículo. Rolback para ponto inicial.';
        LEAVE;
    END IF;

    -- Se tudo der certo, confirmar a transação
    COMMIT;
    SELECT 'Ordem de serviço registrada com sucesso!';
END$$

DELIMITER ;


-- Chamando a Procedure
-- Você pode chamar a procedure para registrar uma nova ordem de serviço e atualizar o status do veículo:
CALL registrar_ordem_servico(1, 2, 1500.00);
