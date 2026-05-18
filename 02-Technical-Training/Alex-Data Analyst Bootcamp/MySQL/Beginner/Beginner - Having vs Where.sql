-- =========================================================================
-- A GRANDE BATALHA: WHERE VS. HAVING
-- =========================================================================

-- À primeira vista, ambos parecem fazer a mesma coisa: filtrar linhas. 
-- Mas eles atuam em momentos completamente diferentes no ciclo de vida da query:
-- 
-- WHERE  -> Filtra linhas baseadas em colunas puras (dados brutos, antes de qualquer soma/média).
-- HAVING -> Filtra linhas baseadas em colunas AGREGADAS (depois que o GROUP BY fez a mágica dele).

-- Para contextualizar, vamos ver a média de idade por gênero:
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;


-- =========================================================================
-- O ERRO CLÁSSICO: TENTAR USAR O WHERE COM AGREGAÇÃO
-- =========================================================================

-- Vamos tentar filtrar quem tem a média de idade maior que 40 usando o WHERE:
-- (Se você rodar o bloco abaixo, o MySQL vai te dar um erro!)
-- SELECT gender, AVG(age)
-- FROM employee_demographics
-- WHERE AVG(age) > 40
-- GROUP BY gender;

-- POR QUE ISSO NÃO FUNCIONA?
-- Por causa da ordem de execução (Order of Operations) do SQL. 
-- Por trás dos panos, o WHERE é executado ANTES do GROUP BY. 
-- Ou seja, você está tentando filtrar um dado agrupado que o banco de dados AINDA NÃO calculou!


-- =========================================================================
-- A SOLUÇÃO: ENTRA EM CENA O HAVING
-- =========================================================================

-- O HAVING foi criado especificamente para resolver isso. Ele roda DEPOIS do GROUP BY.
-- Agora o MySQL primeiro agrupa, calcula a média e, por fim, aplica o filtro do HAVING:
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;


-- DICA DE PREGUIÇA VALIOSA (E BOA PRÁTICA): Usando Aliases (Apelidos)
-- Em vez de reescrever a função de agregação dentro do HAVING, você pode dar um "apelido" 
-- para ela no SELECT usando o "AS" e chamar esse apelido direto no HAVING. Fica bem mais limpo!
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;


-- =========================================================================
-- EXEMPLO ADICIONAL: JUNTANDO O WHERE E O HAVING NA MESMA QUERY (MUNDO REAL)
-- =========================================================================

-- No dia a dia, você vai usar os dois juntos. Imagine o seguinte relatório:
-- "Quero ver o gasto total de salário por Departamento, mas APENAS dos funcionários 
-- que ganham mais de 15.000 (Filtro de linha pura = WHERE). Além disso, só quero exibir 
-- os departamentos cujo gasto total passe de 100.000 e que tenham mais de 1 funcionário (Filtro agregado = HAVING)."

SELECT department_id, 
       SUM(salary) AS total_gasto,
       COUNT(employee_id) AS total_funcionarios
FROM employee_salary
WHERE salary > 15000 -- 1º: O MySQL filtra e só pega os funcionários com salários altos
GROUP BY department_id -- 2º: O MySQL agrupa por departamento e soma/conta
HAVING total_gasto > 100000 AND total_funcionarios > 1; -- 3º: O HAVING filtra o resultado final agrupado

-- Repare como cada um fez o seu papel perfeitamente na linha do tempo da query!


-- -------------------------------------------------------------------------
-- Regra de bolso para nunca mais esquecer:
-- Pensou em SUM(), AVG(), COUNT(), MIN() ou MAX() no filtro? O lugar deles é no HAVING!