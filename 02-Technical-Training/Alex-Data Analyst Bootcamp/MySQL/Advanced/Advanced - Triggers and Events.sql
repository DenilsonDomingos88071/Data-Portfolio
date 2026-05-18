-- =================================================================================
-- CONCEITO DE TRIGGERS (GATILHOS)
-- =================================================================================
-- Um Trigger é um bloco de código que é executado AUTOMATICAMENTE sempre que um 
-- evento específico (INSERT, UPDATE ou DELETE) ocorre em uma tabela.
--
-- Exemplo clássico: Quando um cliente faz um pagamento na tabela 'payments', um
-- trigger pode atualizar automaticamente o campo 'total_paid' na tabela 'invoice'.
-- =================================================================================

-- Visualizando as tabelas que serão afetadas:
SELECT * FROM employee_salary;
SELECT * FROM employee_demographics;

-- Cenário: Sempre que um novo funcionário for inserido na tabela 'employee_salary', 
-- queremos que o trigger insira automaticamente o ID, Nome e Sobrenome dele 
-- na tabela 'employee_demographics' para manter os dados sincronizados.

USE parks_and_recreation;

-- Alteramos o delimitador para $$ para que o MySQL não confunda os ponto-e-vírgula (;) 
-- do corpo do bloco com o fim da criação do trigger.
DELIMITER $$

CREATE TRIGGER employee_insert2
    -- Define o momento da execução. Pode ser BEFORE (Antes) ou AFTER (Depois).
	AFTER INSERT ON employee_salary
    
    -- FOR EACH ROW indica que o gatilho será ativado para CADA linha inserida.
    -- Nota: Bancos como o MSSQL possuem triggers a nível de tabela (batch), 
    -- mas o MySQL executa estritamente linha por linha.
    FOR EACH ROW
    
BEGIN
    -- O modificador 'NEW' refere-se aos dados da linha recém-inserida.
    -- (Existe também o 'OLD' para capturar dados que foram deletados ou alterados).
    INSERT INTO employee_demographics (employee_id, first_name, last_name) 
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$

-- Restauramos o delimitador padrão do SQL
DELIMITER ; 


-- Testando o Trigger na prática:
-- Ao inserir um novo registro na tabela de salários, o trigger deve povoar a tabela de demografia.
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);

-- Verifique as duas tabelas agora; os dados do Jean-Ralphio estarão em ambas.


-- Limpando o teste:
DELETE FROM employee_salary WHERE employee_id = 13;


-- =================================================================================
-- CONCEITO DE EVENTS (EVENTOS / AGENDAMENTOS)
-- =================================================================================
-- No MSSQL são chamados de "Jobs", mas no MySQL chamamos de Events.
-- Um Event é um bloco de código executado com base em um CRONOGRAMA de tempo (Schedule).
-- São excelentes para automação: importar dados diariamente, limpar logs antigos, 
-- gerar relatórios toda segunda-feira ou no primeiro dia do mês às 10h, etc.
-- =================================================================================

SELECT * FROM parks_and_recreation.employee_demographics;

-- Comando para listar os eventos ativos no banco de dados:
SHOW EVENTS;

-- Cenário: O departamento de Parques e Recreação tem uma política onde qualquer 
-- funcionário com 60 anos ou mais é aposentado imediatamente. 
-- Vamos criar um evento para remover essas pessoas de forma automatizada.

-- Remove o evento se ele já existir, evitando erros de duplicação:
DROP EVENT IF EXISTS delete_retirees;

DELIMITER $$

CREATE EVENT delete_retirees
-- Define a frequência do agendamento (neste exemplo, a cada 30 segundos)
ON SCHEDULE EVERY 30 SECOND
DO 
BEGIN
	DELETE
	FROM parks_and_recreation.employee_demographics
    WHERE age >= 60;
END $$

DELIMITER ;


-- Observação do caso: Se você rodar a consulta abaixo após o evento ser executado, 
-- verá que o Jerry foi "demitido"... quer dizer, aposentado com sucesso.
SELECT * FROM parks_and_recreation.employee_demographics;