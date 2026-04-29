-- TIPOS DE CONVERSÃO ##############################################################
-- Operador ::
-- CAST

-- EXEMPLOS ########################################################################

-- (Exemplo 1) Conversão de texto em data
-- Corrija a query abaixo utilizando o operador ::

SELECT '2021-10-01'::date - '2021-02-01'::date


-- (Exemplo 2) Conversão de texto em número
-- Corrija a query abaixo utilizando o operador ::

SELECT '100'::numeric - '10'::numeric


-- (Exemplo 3) Conversão de número em texto
-- Corrija a query abaixo utilizando o operador ::

SELECT REPLACE(112122::text,'1','A')


-- (Exemplo 4) Conversão de texto em data
-- Corrija a query abaixo utilizando a função CAST

SELECT CAST('2021-10-01' AS date) - CAST('2021-02-01' AS date)


-- RESUMO ##########################################################################
-- (1) O operador :: e o CAST() são funções utilizadas para converter um dado para 
-- a unidade desejada. 
-- (2) O operador :: é mais "clean", porém, em algumas ocasiões não funciona, sendo
-- necessário utilizar a função CAST()
-- (3) Use o Guia de comandos para consultar a lista de unidades mais utilizadas