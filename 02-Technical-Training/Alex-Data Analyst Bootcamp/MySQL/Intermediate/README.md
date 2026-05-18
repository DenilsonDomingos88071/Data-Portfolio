1\. Joins (Junções)

Utilizados para combinar colunas de duas ou mais tabelas com base em uma relação lógica entre elas.



INNER JOIN: Retorna apenas as linhas que possuem correspondência em ambas as tabelas.



LEFT JOIN: Retorna todas as linhas da tabela à esquerda e as linhas correspondentes da tabela à direita (linhas sem correspondência retornam NULL).



RIGHT JOIN: Retorna todas as linhas da tabela à direita e as linhas correspondentes da tabela à esquerda.



SELF JOIN: Uma tabela que se junta com ela mesma, útil para comparar linhas na mesma tabela.



2\. String Functions (Funções de Texto)

Funções para manipular e limpar dados textuais.



Tamanho e Caixa: LENGTH (comprimento), UPPER (maiúsculas) e LOWER (minúsculas).



Limpeza de Espaços: TRIM (remove espaços das pontas), LTRIM (apenas esquerda) e RTRIM (apenas direita).



Extração: LEFT (caracteres da esquerda), RIGHT (caracteres da direita) e SUBSTRING (extrai de qualquer posição).



Busca e Modificação: REPLACE (substitui texto) e LOCATE (encontra a posição de um caractere).



Combinação: CONCAT (une dois ou mais textos).



3\. Subqueries (Subconsultas)

Consultas aninhadas dentro de uma consulta maior para isolar ou dinamizar cálculos.



No WHERE: Funciona como um filtro dinâmico (geralmente retornando uma única coluna para operadores como IN).



No SELECT: Calcula valores isolados (como médias globais) para exibir ao lado de dados individuais.



No FROM: Cria uma tabela temporária/derivada que exige obrigatoriamente um alias (apelido).



4\. Case Statements (Estruturas Condicionais)

Permite aplicar a lógica "SE-ENTÃO-SENÃO" (IF-THEN-ELSE) diretamente na consulta.



Utiliza as cláusulas CASE, WHEN, THEN, ELSE e END.



Serve tanto para criar rótulos textuais baseados em condições quanto para realizar cálculos matemáticos dinâmicos por linha.



5\. Window Functions (Funções de Janela)

Realizam cálculos em um conjunto de linhas (partição) sem agrupar ou reduzir o resultado final a uma única linha.



PARTITION BY: Define o grupo sobre o qual o cálculo será feito.



ORDER BY: Define a ordem e permite criar totais acumulados.



Classificação: ROW\_NUMBER (numeração sequencial), RANK (numeração com saltos em empates) e DENSE\_RANK (numeração contínua em empates).



6\. Unions (Uniões)

Combinam o resultado de duas ou mais consultas empilhando as linhas.



UNION (ou UNION DISTINCT): Combina as linhas eliminando registros duplicados.



UNION ALL: Combina as linhas mantendo todos os registros duplicados.



Regra: Exige o mesmo número de colunas e tipos de dados compatíveis entre as consultas.

