-- =========================================================================
-- DOMINANDO O COMANDO SELECT
-- =========================================================================

-- O comando SELECT é a nossa porta de entrada para o banco de dados. É com ele que 
-- escolhemos exatamente quais colunas queremos visualizar no nosso resultado.

-- O famoso "trazer tudo": Usamos o asterisco (*) para selecionar todas as colunas da tabela.
SELECT * 
FROM parks_and_recreation.employee_demographics;


-- Filtrando por coluna: Se não precisamos de tudo, chamamos apenas a coluna que interessa.
SELECT first_name
FROM employee_demographics;

-- Repare no painel de resultados: agora só temos a coluna 'first_name', limpando o visual.


-- Trazendo mais colunas: Para selecionar várias, basta separá-las por VÍRGULAS (,).
SELECT first_name, last_name
FROM employee_demographics;


-- A ordem importa? Na maioria das vezes, não! Você pode dispor as colunas como preferir.
-- (Veremos casos avançados mais para frente onde a ordem importa, mas por enquanto, sinta-se livre).
SELECT last_name, first_name, gender, age
FROM employee_demographics;


-- DICA DE OURO: Organização e Boa Prática!
-- No dia a dia, você verá muito código formatado quebrando linhas. Assim fica infinitamente 
-- mais fácil de ler, debugar e gerenciar quais colunas estão sendo chamadas.
SELECT last_name, 
       first_name, 
       gender, 
       age
FROM employee_demographics;


-- =========================================================================
-- REALIZANDO OPERAÇÕES MATEMÁTICAS NO SELECT
-- =========================================================================

-- Nós podemos criar colunas calculadas "em tempo de execução" (elas não alteram o banco).
-- Vamos ver um exemplo simulando uma tabela de clientes:
SELECT first_name,
       last_name,
       total_money_spent,
       total_money_spent + 100 -- Cria uma nova coluna somando 100 ao valor original
FROM customers;


-- ATENÇÃO À REGRA DA MATEMÁTICA (PEMDAS)
-- O SQL segue estritamente a ordem de operações: Parênteses, Expoentes, Multiplicação, 
-- Divisão, Adição e Subtração.

-- Cenário 1: O que acontece aqui?
SELECT first_name, 
       last_name,
       salary,
       salary + 100 * 10
FROM employee_salary;
-- Seguindo o PEMDAS: Primeiro o SQL faz 100 * 10 (= 1000) e SÓ DEPOIS soma ao salário.
-- Se o salário for 50000, o resultado será 51000.


-- Cenário 2: E se quisermos forçar a soma primeiro? Usamos os parênteses!
SELECT first_name, 
       last_name,
       salary,
       (salary + 100) * 10
FROM employee_salary;
-- Agora sim: Primeiro ele soma 100 ao salário e depois multiplica TODO o resultado por 10.


-- =========================================================================
-- O COMANDO DISTINCT: ELIMINANDO DUPLICADAS
-- =========================================================================

-- Às vezes você só quer saber as categorias existentes em uma coluna, sem repetições.

-- Se rodarmos normal, o ID de um departamento vai aparecer toda vez que um funcionário fizer parte dele:
SELECT department_id
FROM employee_salary;

-- Usando o DISTINCT, o SQL limpa o resultado e nos devolve apenas os valores ÚNICOS:
SELECT DISTINCT department_id
FROM employee_salary;


-- -------------------------------------------------------------------------
-- Nota mental: Isso aqui é só a pontinha do iceberg! O SELECT é extremamente poderoso 
-- e teremos módulos inteiros dedicados a explorar tudo o que ele é capaz de fazer.