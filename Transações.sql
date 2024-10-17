-- Desabilitar autocommit
SET autocommit = 0;

-- Iniciar a transação
START TRANSACTION;

-- Inserir nova ordem de serviço
INSERT INTO OrdemServico (Cliente_ID, Veiculo_ID, DataEmissao, StatusPedido, ValorTotal) 
VALUES (1, 2, NOW(), 'Em Progresso', 1000.00);

-- Atualizar status do veículo
UPDATE Veiculo 
SET Status = 'Em Manutenção' 
WHERE CódigoVeículo = 2;

-- Atualizar saldo devedor do cliente
INSERT INTO Fatura (IDCliente, DataEmissao, ValorTotal, StatusPagamento)
VALUES (1, NOW(), 1000.00, 'Pendente');

-- Finalizar a transação se tudo correr bem
COMMIT;

-- Em caso de erro, usar ROLLBACK para desfazer todas as alterações
ROLLBACK;
