# Descrição do Projeto
Este projeto é um sistema de controle e gerenciamento de ordens de serviço em uma oficina mecânica, focado na manipulação de dados por meio de transações, procedures, triggers e views. O sistema permite o controle de clientes, veículos, ordens de serviço, mecânicos e faturas, com o objetivo de garantir a integridade dos dados e otimizar o gerenciamento das operações da oficina.

# Funcionalidades Principais
Mecanismos de Transação: Utilização de transações para garantir que as operações realizadas no banco de dados sejam atômicas, consistentes, isoladas e duráveis (ACID).
Transações Atômicas: As operações de inserção de ordens de serviço e atualizações de status de veículos são realizadas dentro de uma transação. Caso ocorra algum erro, todas as operações são revertidas para garantir a integridade dos dados.
Rollback com Savepoints: A aplicação de savepoints permite o rollback parcial de operações, garantindo que falhas em uma parte do processo não afetem outras operações realizadas com sucesso.
Procedures Automatizadas: Procedures gerenciam as transações de forma eficiente, facilitando a manutenção do sistema e otimizando as operações relacionadas a ordens de serviço, veículos e clientes.