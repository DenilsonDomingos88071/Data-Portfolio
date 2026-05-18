-- =================================================================================
-- CONCEITO DE TEMPORARY TABLES (TABELAS TEMPORÁRIAS)
-- =================================================================================
-- Tabelas temporárias são tabelas que existem apenas durante a sessão atual do banco 
-- de dados. Elas são visíveis exclusivamente para o usuário que as criou e são 
-- excluídas automaticamente assim que a conexão com o banco de dados é fechada.
--
-- Aplicações principais: Armazenar resultados intermediários de consultas complexas,
-- isolar dados para manipulação pesada ou organizar dados antes de inseri-los 
-- em uma tabela permanente.
-- =================================================================================

-- ---------------------------------------------------------------------------------
-- MÉTODO 1: Criação Estruturada (Menos comum no dia a dia)
-- Consiste em definir explicitamente as colunas e os tipos de dados, exatamente 
-- como se faz na criação de uma tabela permanente física.
-- ---------------------------------------------------------------------------------

CREATE TEMPORARY TABLE temp_table (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    favorite_movie VARCHAR(100)
);

-- Executando a consulta na tabela temporária recém-criada:
SELECT * FROM temp_table;

-- Observação técnica: Se você atualizar (Refresh) o painel de tabelas do seu
-- gerenciador (como o MySQL Workbench), você notará que ela não aparece listada. 
-- Ela não é uma tabela física persistente no disco; ela reside na memória da sessão.

-- Como a tabela inicia vazia, é necessário realizar a inserção manual de registros:
INSERT INTO temp_table
VALUES ('Dennis', 'Freberg', 'Lord of the Rings: The Twin Towers');

-- Visualizando os dados inseridos:
SELECT * FROM temp_table;


-- ---------------------------------------------------------------------------------
-- MÉTODO 2: Criação via Subconsulta/Seleção (Mais rápido e preferido no mercado)
-- Cria a tabela temporária e, simultaneamente, define sua estrutura e popula os dados
-- com base no resultado de uma instrução SELECT.
-- ---------------------------------------------------------------------------------

CREATE TEMPORARY TABLE salary_over_50k AS
SELECT *
FROM employee_salary
WHERE salary > 50000;

-- Nota de correção do script original: O exemplo original tentava consultar 
-- 'temp_table_2', mas o nome correto da tabela criada neste método é 'salary_over_50k'.
SELECT *
FROM salary_over_50k;


-- =================================================================================
-- UTILIDADE NO MERCADO E ANÁLISE DE DADOS
-- =================================================================================
-- Este segundo método é amplamente utilizado em rotinas analíticas. Quando lidamos 
-- com lógica de dados complexa ou volumes muito altos, quebrar a query em "caixas" 
-- menores (as tabelas temporárias) ajuda a organizar o raciocínio, otimizar a 
-- performance e reaproveitar subconjuntos de dados sem precisar reexecutar filtros 
-- pesados na tabela principal múltiplas vezes.
-- =================================================================================