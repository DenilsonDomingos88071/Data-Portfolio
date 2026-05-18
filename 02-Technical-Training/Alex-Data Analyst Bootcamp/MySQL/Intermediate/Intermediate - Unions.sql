-- =================================================================================
-- CONCEITO DE UNIONS
-- =================================================================================
-- O UNION permite combinar LINHAS de dados vindas de tabelas diferentes. 
-- Diferente dos JOINS (que colocam colunas lado a lado), o UNION empilha os dados, 
-- colocando os resultados de uma consulta embaixo dos resultados de outra.
--
-- REGRAS ESSENCIAIS:
-- 1. As consultas devem ter o mesmo número de colunas.
-- 2. As colunas correspondentes devem ter tipos de dados compatíveis.
-- =================================================================================

-- EXEMPLO DE MÁ PRÁTICA (Mas tecnicamente possível):
-- Misturar tipos de dados diferentes (como nomes com salários) funciona no SQL, 
-- mas gera um resultado confuso e sem sentido lógico para análise.
SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT occupation, salary
FROM employee_salary;


-- =================================================================================
-- 1. UNION (DISTINCT) VS. UNION ALL
-- =================================================================================

-- UNION (ou UNION DISTINCT):
-- Combina as linhas e remove automaticamente todos os registros duplicados.
-- Se uma pessoa aparecer em ambas as tabelas com o mesmo nome e sobrenome, ela só será exibida uma vez.
SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary;


-- UNION DISTINCT (Sintaxe explícita):
-- Tem exatamente o mesmo comportamento do exemplo acima, pois o "Distinct" já é o padrão.
SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary;


-- UNION ALL:
-- Combina as linhas, mas MANTÉM todas as duplicadas. Se o mesmo funcionário 
-- estiver cadastrado nas duas tabelas, ele aparecerá duas vezes no resultado final.
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;


-- =================================================================================
-- 2. CASO DE USO REAL (SEGMENTAÇÃO E ANÁLISE DE DADOS)
-- =================================================================================
-- Cenário: O departamento de Parques e Recreação precisa cortar custos no orçamento.
-- Eles querem identificar funcionários mais velhos para planos de aposentadoria e
-- funcionários com salários muito altos para possíveis reduções ou desligamentos.

-- Passo 1: Consulta simples para identificar pessoas acima de 50 anos
SELECT first_name, last_name, 'Old' AS Label
FROM employee_demographics
WHERE age > 50;


-- Passo 2: Combinando múltiplos filtros e tabelas com UNION para gerar uma lista unificada
-- Nota: O ORDER BY só pode ser aplicado uma vez, no final de toda a estrutura do UNION.
SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'

UNION

SELECT first_name, last_name, 'Old Man' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'

UNION

SELECT first_name, last_name, 'Highly Paid Employee' AS Label
FROM employee_salary
WHERE salary >= 70000

ORDER BY first_name;