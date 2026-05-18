-- =========================================================================
-- FILTRANDO DADOS COM A CLÁUSULA WHERE
-- =========================================================================

-- O WHERE é o nosso grande filtro de linhas (registros). 
-- Enquanto o SELECT escolhe as colunas que queremos ver, o WHERE decide quais linhas entram no resultado.
-- Se dissermos "WHERE name = 'Alex'", o MySQL ignora todo o resto e só traz as linhas do Alex.

-- Cenário 1: Filtrando com "Maior que" (>)
SELECT *
FROM employee_salary
WHERE salary > 50000;


-- Cenário 2: Filtrando com "Maior ou Igual" (>=)
SELECT *
FROM employee_salary
WHERE salary >= 50000;


-- Cenário 3: Filtrando texto (Sempre use aspas simples para strings!)
SELECT *
FROM employee_demographics
WHERE gender = 'Female';


-- Cenário 4: O operador de "Diferente" (!= ou <>)
-- Se quisermos todo mundo, EXCETO as mulheres:
SELECT *
FROM employee_demographics
WHERE gender != 'Female';


-- Cenário 5: Filtrando por Datas
-- O MySQL usa o formato padrão 'AAAA-MM-DD' (Ano-Mês-Dia).
-- Vamos buscar quem nasceu DEPOIS de 1º de janeiro de 1985:
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';


-- =========================================================================
-- BUSCAS AVANÇADAS COM O OPERADOR LIKE
-- =========================================================================

-- O LIKE é perfeito para quando não sabemos o termo exato. Ele usa dois "caracteres coringa":
-- % (Percentual): Representa QUALQUER quantidade de caracteres (zero, um ou vários).
-- _ (Underline): Representa exatamente UM caractere genérico (específico para posições).

-- Exemplo 1: Usando o %
-- Busca nomes que começam com a letra "A" (não importa o que vem depois).
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%';


-- Exemplo 2: Usando o _ para limitar o tamanho
-- Busca nomes que começam com "A" e têm exatamente mais 2 letras (Total de 3 caracteres. Ex: "Ann", "Amy").
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';


-- Exemplo 3: Misturando os dois coringas!
-- Busca nomes que começam com "A", têm pelo menos mais 3 letras obrigatórias (_) e, depois disso, qualquer coisa (%).
-- Ou seja, o nome precisa ter no mínimo 4 letras no total.
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%';


-- -------------------------------------------------------------------------
-- Nota mental: O WHERE é a base para relatórios precisos. Dominar o LIKE e os coringas 
-- poupa horas de trabalho na hora de caçar registros perdidos no banco!