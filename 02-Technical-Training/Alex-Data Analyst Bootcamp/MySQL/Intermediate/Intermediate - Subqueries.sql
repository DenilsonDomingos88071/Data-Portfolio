-- =================================================================================
-- CONCEITO DE SUBQUERIES (SUBCONSULTAS)
-- =================================================================================
-- Subqueries são, essencialmente, consultas dentro de outras consultas. 
-- Elas nos permitem realizar buscas mais complexas e dinâmicas dividindo a lógica.
-- Podem ser utilizadas nas cláusulas WHERE, SELECT e FROM.
-- =================================================================================

-- Visualizando a tabela base de demografia:
SELECT * FROM employee_demographics;


-- =================================================================================
-- 1. SUBQUERY NA CLÁUSULA 'WHERE'
-- =================================================================================
-- Suponha que queiramos filtrar os funcionários que trabalham especificamente no 
-- Departamento de Parques e Recreação (dept_id = 1). Podemos fazer isso com um JOIN 
-- ou utilizando uma Subquery para gerar uma lista de IDs permitidos.

-- Exemplo correto:
-- A subquery interna cria uma lista apenas com os 'employee_id' do departamento 1.
-- A consulta externa usa o operador 'IN' para filtrar a tabela com base nessa lista.
SELECT *
FROM employee_demographics
WHERE employee_id IN (
	SELECT employee_id
	FROM employee_salary
	WHERE dept_id = 1
);


-- EXEMPLO DE ERRO COMUM (Mais de uma coluna na Subquery):
-- Se tentarmos selecionar mais de uma coluna dentro de uma subquery usada com o 'IN',
-- o banco de dados retornará um erro: "Operand should contain 1 column(s)".
-- Isso ocorre porque o operador 'IN' espera receber apenas uma lista simples de valores.
SELECT *
FROM employee_demographics
WHERE employee_id IN (
	SELECT employee_id, salary -- O erro acontece aqui por causa da coluna 'salary'
	FROM employee_salary
	WHERE dept_id = 1
);


-- =================================================================================
-- 2. SUBQUERY NA CLÁUSULA 'SELECT'
-- =================================================================================
-- Cenário: Queremos listar o salário de cada funcionário e, ao mesmo tempo, 
-- comparar cada um deles com a MÉDIA SALARIAL GERAL da empresa.

-- Tentativa 1 (Incorreta):
-- Executar isso diretamente causará um erro ou trará dados inconsistentes, pois estamos 
-- misturando colunas individuais com uma função de agregação (AVG) sem um GROUP BY.
SELECT first_name, salary, AVG(salary)
FROM employee_salary;


-- Tentativa 2 (Não traz o resultado esperado):
-- Adicionar o GROUP BY resolve o erro de sintaxe, mas agora o AVG(salary) calculará a 
-- média agrupada por cada linha (por nome e salário), o que anula o propósito de 
-- comparar com a média geral.
SELECT first_name, salary, AVG(salary)
FROM employee_salary
GROUP BY first_name, salary;


--  Solução com Subquery:
-- Ao colocar a subquery diretamente no SELECT, ela calcula de forma isolada a média 
-- global de salários e repete esse mesmo valor estático para todas as linhas da consulta principal.
SELECT 
    first_name, 
    salary, 
    (SELECT AVG(salary) FROM employee_salary) AS overall_average
FROM employee_salary;


-- =================================================================================
-- 3. SUBQUERY NA CLÁUSULA 'FROM' (Tabelas Derivadas)
-- =================================================================================
-- Quando usamos uma subquery no FROM, é como se estivéssemos criando uma tabela 
-- temporária (ou sub-tabela) a partir da qual faremos uma nova consulta.

-- EXEMPLO DE ERRO COMUM (Falta de Alias/Apelido):
-- Esta consulta falhará no SQL porque toda tabela derivada do FROM PRECISA obrigatoriamente 
-- de um nome (alias/apelido) para que o banco consiga referenciá-la.
SELECT *
FROM (
	SELECT gender, MIN(age), MAX(age), COUNT(age), AVG(age)
	FROM employee_demographics
	GROUP BY gender
);


-- Solução com Alias e Agregação sobre Agregação:
-- Nomeamos a subquery como "AS Agg_Table". Agora que ela tem um nome, podemos tratá-la 
-- como uma tabela normal e até mesmo realizar novas agregações (como a média das idades mínimas).
SELECT 
    gender, 
    AVG(Min_age) AS avg_minimum_age
FROM (
	SELECT 
	    gender, 
	    MIN(age) AS Min_age, 
	    MAX(age) AS Max_age, 
	    COUNT(age) AS Count_age,
	    AVG(age) AS Avg_age
	FROM employee_demographics
	GROUP BY gender
) AS Agg_Table
GROUP BY gender;