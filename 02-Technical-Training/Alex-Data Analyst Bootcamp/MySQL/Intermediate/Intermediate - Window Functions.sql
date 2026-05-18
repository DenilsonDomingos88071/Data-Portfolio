-- =================================================================================
-- CONCEITO DE WINDOW FUNCTIONS (FUNÇÕES DE JANELA)
-- =================================================================================
-- As Window Functions são extremamente poderosas e se assemelham ao GROUP BY, 
-- mas com uma diferença crucial: elas NÃO agrupam/reduzem o resultado a uma única linha.
-- Elas permitem realizar cálculos sobre um grupo de linhas (partição), mas mantêm a 
-- identidade e a individualidade de cada linha única na saída do relatório.
-- Também veremos funções de classificação como ROW_NUMBER, RANK e DENSE_RANK.
-- =================================================================================

-- Visualizando a tabela base de demografia:
SELECT * FROM employee_demographics;


-- =================================================================================
-- 1. COMPARAÇÃO: GROUP BY VS. WINDOW FUNCTION
-- =================================================================================

-- Cenário A: Agrupamento tradicional com GROUP BY
-- Reduz as linhas e traz apenas uma linha para cada gênero com sua respectiva média.
SELECT gender, ROUND(AVG(salary), 1)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;


-- Cenário B: Uso inicial de uma Window Function com OVER() vazio
-- O OVER() vazio calcula a média salarial global da empresa, mas repete esse valor 
-- em todas as linhas, permitindo exibir os dados individuais de cada funcionário.
SELECT dem.employee_id, dem.first_name, gender, salary,
AVG(salary) OVER() AS global_avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;


-- =================================================================================
-- 2. APERFEIÇOANDO COM 'PARTITION BY' E 'ORDER BY'
-- =================================================================================

-- PARTITION BY: Funciona como o GROUP BY, dividindo o cálculo por uma coluna (ex: gênero),
-- mas sem consolidar as linhas. Cada funcionário vê a média do seu próprio gênero.
SELECT dem.employee_id, dem.first_name, gender, salary,
AVG(salary) OVER(PARTITION BY gender) AS avg_salary_by_gender
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;


-- ORDER BY dentro do OVER(): Quando usado com funções de agregação como SUM, 
-- ele ativa o cálculo de um TOTAL ACUMULADO (Rolling Total) linha por linha.
SELECT dem.employee_id, dem.first_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS rolling_total_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;


-- =================================================================================
-- 3. FUNÇÕES DE CLASSIFICAÇÃO (ROW_NUMBER, RANK, DENSE_RANK)
-- =================================================================================

-- ROW_NUMBER(): Cria uma numeração sequencial simples e única para cada linha 
-- dentro de sua respectiva partição.
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender) AS row_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;


-- ROW_NUMBER() com ORDER BY: Ordena a numeração. Neste caso, serve para descobrir 
-- a ordem dos funcionários mais bem pagos dentro de cada gênero.
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;


-- Comparando ROW_NUMBER(), RANK() e DENSE_RANK():
-- Cada uma lida com empates (valores idênticos) de uma forma diferente.
SELECT dem.employee_id, dem.first_name, gender, salary,
-- ROW_NUMBER: Sempre sequencial (1, 2, 3, 4, 5, 6, 7...), ignora empates.
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,

-- RANK: Atribui a mesma posição em caso de empate, mas PULA as posições seguintes.
-- Observação do caso: Tom e Jerry empatam na posição 5. O próximo número da sequência é o 7 (pula o 6).
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_1, 

-- DENSE_RANK: Atribui a mesma posição em caso de empate, mas NÃO pula nenhuma posição.
-- A numeração é estritamente contínua (1, 2, 3, 4, 5, 5, 6...).
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_2
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;