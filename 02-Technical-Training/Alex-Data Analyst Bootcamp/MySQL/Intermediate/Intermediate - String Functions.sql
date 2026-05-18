-- =================================================================================
-- CONCEITO DE STRING FUNCTIONS (FUNÇÕES DE TEXTO)
-- =================================================================================
-- Essas funções nos ajudam a manipular, modificar e analisar textos (strings) 
-- de formas diferentes dentro do banco de dados.
-- =================================================================================

-- Visualizando a tabela base da padaria para os exemplos:
SELECT * FROM bakery.customers;


-- =================================================================================
-- 1. TAMANHO E CAIXA DO TEXTO (LENGTH, UPPER, LOWER)
-- =================================================================================

-- LENGTH(): Retorna a quantidade de caracteres (comprimento) de um texto.
SELECT LENGTH('sky');

-- Exemplo prático: Vendo o tamanho de cada primeiro nome dos funcionários.
SELECT first_name, LENGTH(first_name) 
FROM employee_demographics;


-- UPPER(): Converte todos os caracteres do texto para LETRAS MAIÚSCULAS.
SELECT UPPER('sky');

-- Exemplo prático:
SELECT first_name, UPPER(first_name) 
FROM employee_demographics;


-- LOWER(): Converte todos os caracteres do texto para letras minúsculas.
SELECT LOWER('sky');

-- Exemplo prático:
SELECT first_name, LOWER(first_name) 
FROM employee_demographics;


-- =================================================================================
-- 2. REMOÇÃO DE ESPAÇOS EM BRANCO (TRIM, LTRIM, RTRIM)
-- =================================================================================

-- TRIM(): Remove os espaços em branco tanto do início quanto do fim do texto.
SELECT TRIM('   sky   ');

-- Nota: O TRIM não remove espaços em branco que estão no MEIO do texto.
SELECT TRIM('      I           love           SQL');


-- LTRIM(): Remove os espaços em branco APENAS do lado ESQUERDO (início do texto).
SELECT LTRIM('     I love SQL');


-- RTRIM(): Remove os espaços em branco APENAS do lado DIREITO (fim do texto).
SELECT RTRIM('I love SQL    ');


-- =================================================================================
-- 3. EXTRAÇÃO DE TRECHOS DE TEXTO (LEFT, RIGHT, SUBSTRING)
-- =================================================================================

-- LEFT(): Extrai uma quantidade específica de caracteres a partir do lado ESQUERDO.
-- Exemplo: Pega os 4 primeiros caracteres de 'Alexander' -> 'Alex'
SELECT LEFT('Alexander', 4);

-- Exemplo prático: Pega as 4 primeiras letras do nome de cada funcionário.
SELECT first_name, LEFT(first_name, 4) 
FROM employee_demographics;


-- RIGHT(): O oposto do LEFT. Extrai caracteres a partir do lado DIREITO (fim do texto).
-- Exemplo: Pega os 6 últimos caracteres de 'Alexander' -> 'ander'
SELECT RIGHT('Alexander', 6);

-- Exemplo prático: Pega as 4 últimas letras do nome de cada funcionário.
SELECT first_name, RIGHT(first_name, 4) 
FROM employee_demographics;


-- SUBSTRING(): Permite extrair texto de QUALQUER posição. 
-- Argumentos: (texto, posição_inicial, quantidade_de_caracteres)
-- Exemplo: Começa na posição 2 e pega 3 caracteres de 'Alexander' -> 'lex'
SELECT SUBSTRING('Alexander', 2, 3);

-- Exemplo prático: Extraindo apenas o ano de nascimento (os 4 primeiros dígitos) da data.
SELECT birth_date, SUBSTRING(birth_date, 1, 4) AS birth_year
FROM employee_demographics;


-- =================================================================================
-- 4. MODIFICAÇÃO E BUSCA (REPLACE, LOCATE, CONCAT)
-- =================================================================================

-- REPLACE(): Substitui um caractere ou trecho de texto por outro.
-- Argumentos: (coluna/texto, o_que_procurar, o_que_colocar_no_lugar)
-- Exemplo prático: Substituindo todas as letras 'a' (ou 'A') por 'z' nos nomes.
SELECT REPLACE(first_name, 'a', 'z')
FROM employee_demographics;


-- LOCATE(): Procura a posição de um caractere ou termo dentro de um texto.
-- Argumentos: (o_que_procurar, onde_procurar)
-- Retorna o número da posição (índice baseado em 1).
SELECT LOCATE('x', 'Alexander');

-- 💡 OBSERVAÇÃO IMPORTANTE:
-- O nome 'Alexander' possui duas letras 'e'. O que acontece se tentarmos localizá-la?
SELECT LOCATE('e', 'Alexander');
-- O SQL retornará a posição apenas da PRIMEIRA ocorrência que ele encontrar.

-- Exemplo prático 1: Localizando a letra 'a' nos nomes dos funcionários.
SELECT first_name, LOCATE('a', first_name) 
FROM employee_demographics;

-- Exemplo prático 2: Você também pode localizar pedaços maiores de texto (substrings).
SELECT first_name, LOCATE('Mic', first_name) 
FROM employee_demographics;


-- CONCAT(): Junta (concatena) dois ou mais textos em uma única string.
SELECT CONCAT('Alex', 'Freberg');

-- Exemplo prático: Juntando o nome e o sobrenome com um espaço no meio para criar o nome completo.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;