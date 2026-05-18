-- =========================================================================
-- DESVENDANDO O GROUP BY (AGRUPAMENTO DE DADOS)
-- =========================================================================

-- O GROUP BY serve para juntar todas as linhas que têm o mesmo valor em uma coluna específica.
-- Pense nele como um "organizador de gavetas": ele junta tudo o que é igual e nos permite 
-- aplicar funções matemáticas (agregações) para resumir esses dados.

-- Visualizando a tabela original (dados brutos, linha por linha):
SELECT *
FROM employee_demographics;


-- REGRA DE OURO #1: As colunas do SELECT precisam bater com as do GROUP BY!
-- Se eu agrupo por gênero, o resultado vai me mostrar apenas os gêneros únicos existentes.
SELECT gender
FROM employee_demographics
GROUP BY gender;


-- O ERRO CLÁSSICO: O que acontece se tentarmos trazer o 'first_name' aqui?
-- (Se você rodar o bloco abaixo, o MySQL vai dar erro ou trazer um resultado incorreto)
-- SELECT first_name
-- FROM employee_demographics
-- GROUP BY gender;
-- POR QUE ISSO FALHA? Porque o banco não sabe qual 'first_name' exibir dentro do grupo de "Male" ou "Female".


-- Agrupando em outra tabela para ver os cargos existentes:
SELECT occupation
FROM employee_salary
GROUP BY occupation;
-- Repare que cargos repetidos (como Office Manager) agora aparecem uma única vez.


-- Agrupando por MULTIPLAS colunas:
-- O MySQL vai criar uma linha para cada COMBINAÇÃO ÚNICA de cargo + salário. 
-- Se dois Office Managers ganharem salários diferentes, eles aparecerão em linhas separadas.
SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;


-- O REAL PODER DO GROUP BY: Funções de Agregação (SUM, AVG, MIN, MAX, COUNT)
-- É aqui que o comando brilha. Vamos ver a média de idade separada por gênero:
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

-- Podemos colocar várias agregações juntas no mesmo relatório para um resumão completo:
SELECT gender, 
       MIN(age) AS idade_minima, 
       MAX(age) AS idade_maxima, 
       COUNT(age) AS total_pessoas,
       AVG(age) AS media_idade
FROM employee_demographics
GROUP BY gender;


-- =========================================================================
-- ORGANIZANDO TUDO COM O ORDER BY (ORDENAÇÃO)
-- =========================================================================

-- O ORDER BY serve para ordenar o resultado final. Ele não altera os dados, apenas a forma 
-- como eles são apresentados na tela (essencial para relatórios).
-- Por padrão (default), a ordenação é sempre ASCENDENTE (A-Z, do menor para o maior).

-- Exemplo 1: Ordenação padrão por nome (A-Z)
SELECT *
FROM employee_demographics
ORDER BY first_name;


-- Exemplo 2: Invertendo a ordem com o DESC (Z-A, do maior para o menor)
SELECT *
FROM employee_demographics
ORDER BY first_name DESC;


-- Exemplo 3: Ordenando por múltiplas colunas
-- O MySQL vai ordenar primeiro pelo gênero. Se houver empate (várias linhas 'Female'), 
-- ele usa a idade como critério de desempate.
SELECT *
FROM employee_demographics
ORDER BY gender, age;

-- Forçando o DESC em ambas as colunas:
SELECT *
FROM employee_demographics
ORDER BY gender DESC, age DESC;


-- =========================================================================
-- DICA DE BOA PRÁTICA: ORDENAR POR NOME VS. POR POSIÇÃO
-- =========================================================================

-- O SQL permite ordenar usando o número da posição da coluna na tabela.
-- No exemplo abaixo, o 5 representa a 5ª coluna e o 4 representa a 4ª coluna da tabela.
SELECT *
FROM employee_demographics
ORDER BY 5 DESC, 4 DESC;

-- CUIDADO: Embora funcione e economize digitação, usar números NÃO é uma boa prática de mercado!
-- Se alguém alterar a estrutura da tabela no futuro (adicionar ou remover uma coluna), 
-- a sua query vai começar a ordenar pela coluna errada sem você perceber. 
-- Sempre prefira escrever o nome explícito da coluna!


-- -------------------------------------------------------------------------
-- Nota mental: O ORDER BY costuma ser a última linha de quase todas as queries 
-- que escrevemos no dia a dia. É o toque final para entregar o dado limpo e legível.