-- =================================================================================
-- CONCEITO DE JOINS
-- =================================================================================
-- Os JOINS permitem combinar duas ou mais tabelas se elas tiverem uma coluna em comum.
-- Isso não significa que os nomes das colunas precisam ser idênticos, mas sim que os
-- dados contidos nelas devem ser correspondentes para fazer a união.
--
-- Tipos que veremos hoje: INNER JOIN, OUTER JOINS (LEFT/RIGHT) e SELF JOIN.
-- =================================================================================

-- Visualizando as duas tabelas base para entender as colunas comuns que podemos usar:
SELECT * FROM employee_demographics;
SELECT * FROM employee_salary;


-- =================================================================================
-- 1. INNER JOIN (Junção Interna)
-- =================================================================================
-- Retorna apenas as linhas que possuem correspondência exata em AMBAS as colunas.

-- Exemplo 1: Sem o uso de aliases (especificando o nome completo das tabelas)
-- Nota: Como ambas as tabelas têm a coluna 'employee_id', precisamos especificar de onde ela vem.
SELECT *
FROM employee_demographics
JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id;

-- 💡 OBSERVAÇÃO DO CASO:
-- Percebeu que o Ron Swanson não apareceu nos resultados? Isso acontece porque ele não tem 
-- um ID de funcionário na tabela de demografia. Ele simplesmente se recusou a fornecer 
-- sua data de nascimento, idade ou gênero!


-- Exemplo 2: Utilizando ALIASING (Apelidos para as tabelas)
-- Uma prática muito recomendada para deixar o código mais limpo e legível.
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;


-- =================================================================================
-- 2. OUTER JOINS (Junções Externas)
-- =================================================================================
-- LEFT JOIN: Pega tudo da tabela da ESQUERDA (mesmo sem match), e apenas os matches da direita.
-- RIGHT JOIN: Pega tudo da tabela da DIREITA (mesmo sem match), e apenas os matches da esquerda.

-- Exemplo de LEFT JOIN:
-- Aqui trazemos tudo da tabela da esquerda (employee_salary). Mesmo não havendo correspondência
-- para o Ron Swanson na tabela da direita (demographics), ele aparece, e os dados dele vêm como NULL.
SELECT *
FROM employee_salary sal
LEFT JOIN employee_demographics dem
	ON dem.employee_id = sal.employee_id;


-- Exemplo de RIGHT JOIN:
-- Se mudarmos para RIGHT JOIN, o resultado neste caso específico se parecerá com um INNER JOIN.
-- Isso ocorre porque estamos pegando tudo da tabela da direita (demographics) e apenas os matches
-- da esquerda (salary) — e como a tabela demographics possui correspondência para quase todos, 
-- o resultado final muda de formato.
SELECT *
FROM employee_salary sal
RIGHT JOIN employee_demographics dem
	ON dem.employee_id = sal.dept_id; 


-- =================================================================================
-- 3. SELF JOIN (Junção Consigo Mesmo)
-- =================================================================================
-- Um SELF JOIN ocorre quando você vincula uma tabela a ela mesma.
--
-- Cenário Prático: Vamos criar um "Amigo Secreto" (Secret Santa) onde a pessoa com o 
-- ID imediatamente superior (ID + 1) será o Amigo Secreto do funcionário atual.

-- Passo 1: Apenas visualizando a tabela base novamente
SELECT * FROM employee_salary;


-- Passo 2: Fazendo o espelhamento simples da tabela
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id = emp2.employee_id;


-- Passo 3: Aplicando a lógica do Amigo Secreto (ID + 1)
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id;


-- Passo 4: Selecionando colunas específicas e aplicando aliases legíveis
SELECT 
    emp1.employee_id     AS emp_santa, 
    emp1.first_name      AS santa_first_name, 
    emp1.last_name       AS santa_last_name, 
    emp2.employee_id     AS emp_recipient, 
    emp2.first_name      AS recipient_first_name, 
    emp2.last_name       AS recipient_last_name
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id;

-- 💡 OBSERVAÇÃO DO CASO:
-- Assim, descobrimos que a Leslie é a Amiga Secreta do Ron, e assim por diante.
-- O Mark Brandanowitz acabou ficando sem amigo secreto... mas ele também não merecia 
-- nenhum, já que partiu o coração da Ann, então está tudo certo!


-- =================================================================================
-- 4. JUNÇÃO DE MÚLTIPLAS TABELAS
-- =================================================================================
-- Podemos encadear quantos JOINs forem necessários para buscar dados de tabelas diferentes.

-- Visualizando a terceira tabela que iremos incluir:
SELECT * FROM parks_and_recreation.parks_departments;


-- Cenário A: Combinando tudo com INNER JOIN
-- Nota: Como usamos INNER JOIN no final, o Andy foi completamente removido dos resultados,
-- pois ele não está associado a nenhum ID de departamento válido na tabela 'parks_departments'.
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
JOIN parks_departments dept
	ON dept.department_id = sal.dept_id;


-- Cenário B: Mudando a última junção para LEFT JOIN
-- Nota: Ao mudar para LEFT JOIN, nós garantimos que o Andy continue aparecendo na lista,
-- já que estamos priorizando tudo da tabela da esquerda (que neste ponto acumulou os dados de salary),
-- mesmo que o departamento correspondente na tabela da direita seja nulo.
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept
	ON dept.department_id = sal.dept_id;