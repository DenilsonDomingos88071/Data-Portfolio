-- =========================================================================
-- CONCEITO DE STORED PROCEDURES (PROCEDIMENTOS ARMAZENADOS)
-- =========================================================================
-- Uma Stored Procedure (SP) é um bloco de código SQL que fica salvo diretamente
-- no servidor do banco de dados. Ela funciona como uma função: você escreve uma 
-- rotina complexa uma única vez e pode chamá-la de qualquer lugar usando apenas 
-- o comando CALL, o que economiza tráfego de rede e centraliza as regras de negócio.
-- =========================================================================

-- Passo 1: Consulta simples preparatória
SELECT *
FROM employee_salary
WHERE salary >= 60000;


-- Passo 2: Criação de uma Stored Procedure básica
-- Nota: Esta sintaxe curta só funciona para conter uma ÚNICA query interna.
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 60000;

-- Observação: A execução deste comando apenas registra a SP no banco de dados.
-- Para visualizar a SP no painel lateral do MySQL Workbench, clique em "Refresh".


-- Passo 3: Executando a Stored Procedure criada
-- O comando CALL ativa a rotina guardada dentro do objeto.
CALL large_salaries();


-- =========================================================================
-- BLOCOS DE EXECUÇÃO E READEQUAÇÃO DE DELIMITADORES
-- =========================================================================
-- Rotinas reais exigem múltiplas linhas e operações encadeadas. No entanto, o 
-- caractere ponto e vírgula (;) faz o MySQL interpretar que o comando terminou.
-- Se tentarmos criar uma SP com múltiplos SELECTs usando o delimitador padrão, 
-- ocorrerá um erro de sintaxe, pois o compilador fechará o bloco antes do fim da SP.

-- Para resolver isso, alteramos temporariamente o delimitador padrão para "$$".
DELIMITER $$

CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000;
    
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
END $$

-- IMPORTANTE: É uma boa prática redefinir o delimitador de volta para o padrão (;)
DELIMITER ;

-- Ao chamar este procedimento, o MySQL retornará duas abas/painéis de resultados distintos:
CALL large_salaries2();


-- =========================================================================
-- GERENCIAMENTO VIA INTERFACE E IDEMPOTÊNCIA (DROP IF EXISTS)
-- =========================================================================
-- Ao automatizar scripts ou criar objetos via interface gráfica (GUI), é padrão 
-- incluir a cláusula DROP PROCEDURE IF EXISTS. Isso torna o script idempotente, 
-- ou seja, ele pode ser executado várias vezes sem quebrar por conflito de nome existente.

USE `parks_and_recreation`;
DROP PROCEDURE IF EXISTS `large_salaries3`;

DELIMITER $$
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000;
    
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
END $$

DELIMITER ;

-- Executando a validação:
CALL large_salaries3();


-- =========================================================================
-- PARAMETRIZAÇÃO DE STORED PROCEDURES (TORNANDO A ROTINA DINÂMICA)
-- =========================================================================
-- Para evitar valores rígidos (hardcoded), as Stored Procedures aceitam parâmetros de entrada.
-- Isso permite passar variáveis dinâmicas no momento em que realizamos a chamada do bloco.

USE `parks_and_recreation`;
DROP PROCEDURE IF EXISTS `large_salaries_params`;

DELIMITER $$
-- Definição do parâmetro: (nome_da_variavel TIPO_DE_DADO)
CREATE PROCEDURE large_salaries_params(employee_id_param INT)
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000
    -- O filtro WHERE associa a coluna da tabela com o parâmetro passado na chamada
    AND employee_id = employee_id_param; 
END $$

DELIMITER ;

-- Testando o dinamismo da SP: Passando o argumento numérico correspondente ao ID do funcionário.
CALL large_salaries_params(1);