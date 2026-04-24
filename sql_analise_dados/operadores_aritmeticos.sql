-- PARA QUE SERVE ##################################################################
-- Servem para executar operações matemáticas
-- Muito utilizados para criar colunas calculadas


-- TIPOS ###########################################################################
-- +
-- -
-- *
-- /
-- ^
-- %
-- || --> não é um operador aritmético


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Criação de coluna calculada
-- Crie uma coluna contendo a idade do cliente da tabela sales.customers

SELECT	email,
		birth_date,
		(current_date - birth_date) / 365 AS "idade do cliente"
FROM sales.customers
ORDER BY "idade do cliente"

-- (Exemplo 2) Utilização da coluna calculada nas queries
-- Liste os 10 clientes mais novos da tabela customers


-- (Exemplo 3) Criação de coluna calculada com strings 
-- Crie a coluna "nome_completo" contendo o nome completo do cliente

SELECT	first_name || ' ' || last_name AS nome_completo
FROM sales.customers
ORDER BY nome_completo

-- RESUMO ##########################################################################
-- (1) Servem para executar operações matemáticas
-- (2) Muito utilizado para criar colunas calculadas
-- (3) Alias (pseudônimos) são muito utilizados para dar nome as colunas calculadas.
-- (4) Para criar pseudônimos que contém espaços no nome são utilizadas aspas duplas
-- (5) No caso de strings o operador de adição (||) irá concatenar as strings
-- (6) Utilize o Guia de comandos para consultar os operadores utilizados no SQL
