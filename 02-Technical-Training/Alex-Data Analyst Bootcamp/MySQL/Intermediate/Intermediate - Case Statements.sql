-- =================================================================================
-- CONCEITO DE CASE STATEMENTS
-- =================================================================================
-- O CASE permite adicionar lógica condicional diretamente à sua cláusula SELECT.
-- Ele funciona exatamente como uma estrutura "IF-THEN-ELSE" (SE-ENTÃO-SENÃO) presente 
-- em outras linguagens de programação ou até mesmo funções condicionais do Excel.
-- =================================================================================

-- Visualizando a tabela base de demografia:
SELECT * FROM employee_demographics;


-- =================================================================================
-- 1. CLASSIFICAÇÃO COMPOSTA (RÓTULOS SIMPLES)
-- =================================================================================

-- Exemplo 1: Condicional simples (Apenas uma validação)
-- Nota: Se a condição não for atendida, o SQL retorna NULL por padrão (a menos que haja um ELSE).
SELECT first_name, 
       last_name, 
       CASE
           WHEN age <= 30 THEN 'Jovem'
       END AS classificacao_idade
FROM employee_demographics;


-- Exemplo 2: Condicional múltipla (Múltiplos WHEN)
-- Observação do caso: Coitado do Jerry... caiu na última categoria!
SELECT first_name, 
       last_name, 
       CASE
           WHEN age <= 30 THEN 'Jovem'
           WHEN age BETWEEN 31 AND 50 THEN 'Adulto/Velho'
           WHEN age > 50 THEN 'Na Porta da Morte'
       END AS status_idade
FROM employee_demographics;


-- =================================================================================
-- 2. CÁLCULOS MATEMÁTICOS COM CASE (AUMENTOS E BÔNUS)
-- =================================================================================
-- O CASE não serve apenas para criar rótulos de texto; podemos usá-lo para realizar
-- cálculos matemáticos dinâmicos baseados nas condições de cada linha.

-- Visualizando a tabela base de salários:
SELECT * FROM employee_salary;

-- Contexto do caso:
-- O Conselho de Pawnee enviou um memorando com a nova estrutura de aumentos e bônus:
-- 1. Se o funcionário ganha MAIS de 45.000, receberá um aumento de 5%.
-- 2. Se o funcionário ganha MENOS de 45.000, receberá um aumento de 7% (bem generoso!).
-- 3. Funcionários do Departamento de Finanças (dept_id = 6) receberão um bônus extra de 10%.


-- Passo 1: Calculando apenas o Novo Salário com base nas faixas salariais
-- Observação do caso: Infelizmente, o Conselho de Pawnee foi extremamente específico 
-- nas regras e o Jerry acabou ficando de fora dos aumentos de salário. Quem sabe no próximo ano!
SELECT first_name, 
       last_name, 
       salary,
       CASE
           WHEN salary > 45000 THEN salary + (salary * 0.05)
           WHEN salary <= 45000 THEN salary + (salary * 0.07)
       END AS new_salary
FROM employee_salary;


-- Passo 2: Adicionando uma segunda coluna condicional para calcular o Bônus
-- Observação do caso: Como podemos ver no resultado, o Ben Wyatt é o único que 
-- realmente recebe o bônus, pois ele é o único que trabalha no Departamento de Finanças (dept_id = 6).
SELECT first_name, 
       last_name, 
       salary,
       -- Coluna 1: Novo Salário recalculado
       CASE
           WHEN salary > 45000 THEN salary + (salary * 0.05)
           WHEN salary <= 45000 THEN salary + (salary * 0.07)
       END AS new_salary,
       -- Coluna 2: Valor do Bônus (Se não for do departamento 6, o bônus será NULL)
       CASE
           WHEN dept_id = 6 THEN salary * 0.10
       END AS bonus
FROM employee_salary;