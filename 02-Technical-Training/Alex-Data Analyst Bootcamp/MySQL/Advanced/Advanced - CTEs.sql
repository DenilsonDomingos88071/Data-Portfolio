-- =================================================================================
-- CONCEITO DE CTE (COMMON TABLE EXPRESSIONS - EXPRESSÕES DE TABELA COMUM)
-- =================================================================================
-- Uma CTE permite definir um bloco de subconsulta temporário que pode ser referenciado
-- dentro da consulta principal (SELECT, INSERT, UPDATE ou DELETE).
--
-- Vantagens principais: Melhora drasticamente a legibilidade do código em comparação 
-- a subconsultas tradicionais e permite a criação de consultas recursivas (que 
-- referenciam a si mesmas), algo que será explorado em lições avançadas.
-- =================================================================================

-- ---------------------------------------------------------------------------------
-- Estrutura Básica de uma CTE
-- Toda CTE inicia obrigatoriamente com a palavra-chave 'WITH', seguida pelo nome 
-- que você deseja dar a ela, a palavra-chave 'AS' e os parênteses com a query interna.
-- ---------------------------------------------------------------------------------

WITH CTE_Example AS (
	SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary), AVG(salary)
	FROM employee_demographics dem
	JOIN employee_salary sal
		ON dem.employee_id = sal.employee_id
	GROUP BY gender
)
-- A consulta principal deve vir IMEDIATAMENTE após o fechamento da CTE:
SELECT *
FROM CTE_Example;


-- REGRA DE ESCOPO CRUCIAL:
-- Se tentarmos executar uma consulta isolada na CTE linhas abaixo, o código falhará.
-- A CTE existe estritamente no escopo da execução da query que vem logo após sua definição.
-- SELECT * FROM CTE_Example; -- Descomentar esta linha gerará erro de tabela não encontrada.


-- ---------------------------------------------------------------------------------
-- Realizando Cálculos Avançados sobre Dados Agregados
-- As CTEs permitem fazer agregações sobre dados que já foram agregados na subconsulta.
-- ---------------------------------------------------------------------------------

WITH CTE_Example AS (
	SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
	FROM employee_demographics dem
	JOIN employee_salary sal
		ON dem.employee_id = sal.employee_id
	GROUP BY gender
)
-- Nota técnica: Como as colunas calculadas na CTE não possuem apelidos (aliases), 
-- somos obrigados a usar crases (` `) para referenciar os nomes exatos das funções.
SELECT gender, ROUND(AVG(`SUM(salary)` / `COUNT(salary)`), 2) AS avg_calculated
FROM CTE_Example
GROUP BY gender;


-- ---------------------------------------------------------------------------------
-- Criando Múltiplas CTEs com uma Única Cláusula WITH
-- Para encadear mais de uma CTE, basta separá-las por uma vírgula ( , ) e omitir 
-- a palavra-chave 'WITH' nas definições seguintes.
-- ---------------------------------------------------------------------------------

WITH CTE_Example AS (
	SELECT employee_id, gender, birth_date
	FROM employee_demographics
	WHERE birth_date > '1985-01-01'
), -- Separação obrigatória por vírgula para iniciar a próxima estrutura
CTE_Example2 AS (
	SELECT employee_id, salary
	FROM employee_salary
	WHERE salary >= 50000
)
-- Cruzando os dados das duas CTEs criadas por meio de um LEFT JOIN:
SELECT *
FROM CTE_Example cte1
LEFT JOIN CTE_Example2 cte2
	ON cte1.employee_id = cte2.employee_id;


-- ---------------------------------------------------------------------------------
-- Boas Práticas: Aliasing Direto na Definição da CTE
-- Uma forma elegante de evitar o uso de crases ou redefinir apelidos dentro da subquery
-- é passar os novos nomes das colunas diretamente ao lado do nome da CTE.
-- ---------------------------------------------------------------------------------

-- Definindo os nomes das colunas de saída entre parênteses: (gender, sum_salary, ...)
WITH CTE_Example (gender, sum_salary, min_salary, max_salary, count_salary) AS (
	SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
	FROM employee_demographics dem
	JOIN employee_salary sal
		ON dem.employee_id = sal.employee_id
	GROUP BY gender
)
-- Agora a consulta fica muito mais limpa e legível, sem a necessidade de caracteres especiais:
SELECT gender, ROUND(AVG(sum_salary / count_salary), 2) AS clean_average
FROM CTE_Example
GROUP BY gender;