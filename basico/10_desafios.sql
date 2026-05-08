/*
DESAFIO 1: ​Escreva uma consulta para identificar o gerente com o maior tamanho de equipe. Você pode assumir que existe apenas um gerente com o maior tamanho de equipe.

ENTRADA:
tabela de funcionários 
Coluna Tipo 
id INTEGER 
nome VARCHAR 
manager_id INTEGER 

tabela de gerentes 
Coluna Tipo 
id INTEGER 
nome VARCHAR 
equipe VARCHAR 

SAÍDA: 
Coluna Tipo 
gerente VARCHAR 
tamanho_da_equipe INTEGER
*/

SELECT m.nome AS gerente, COUNT(f.id) AS tamanho_da_equipe
FROM funcionarios AS f
JOIN gerentes AS m
ON f.manager_id = m.id
GROUP BY m.nome
ORDER BY tamanho_da_equipe DESC
LIMIT 1;

/*
DESAFIO 2: Nós temos duas tabelas, uma tabela de cadastro de nossos consumidores com diversas informações, dentre elas, a cidade nas quais eles moram;
e uma contendo diversas cidades onde nossos produtos estão disponíveis.
Primeiro, escreva uma consulta que retorne todas as cidades que têm mais de 5 consumidores dos nossos produtos.
E uma segunda que retorne as cidades e as respectivas idades médias de seus consumidores.
Utilize 1 de janeiro de 2024 como data para o cálculo da idade e retorne a consulta em ordem decrescente.

ENTRADA:
tabela de consumidores
Colunas Tipo
id INTEIRO
primeiro_nome VARCHAR
ultimo_nome VARCHAR
data_nascimento DATETIME
telefone INTEGER
cidade_id INTEIRO
data_criacao DATETIME

tabela de cidades
Colunas Tipo
id INTEIRO
nome VARCHAR
estado_id INTEIRO

SAÍDA 1:
Colunas Tipo
nome VARCHAR

SAÍDA 2:
Colunas Tipo
nome VARCHAR
idade_media FLOAT
*/

-- Consulta 1 
SELECT c.nome 
FROM cidades as c
JOIN consumidores cons ON c.id = cons.cidade_id
GROUP BY c.id
HAVING COUNT(cons.id) > 5;

-- Consulta 2
SELECT c.nome,
AVG(YEAR('2024-01-01') - YEAR(cons.data_nascimento) - (DATE_FORMAT('2024-01-01', '%m%d') < DATE_FORMAT(cons.data_nascimento, '%m%d'))) AS idade_media
FROM cidades c
JOIN consumidores cons ON c.id = cons.cidade_id
GROUP BY c.id
ORDER BY idade_media DESC;

/*
DESAFIO 3: Escreva uma query que encontre linhas duplicadas numa tabela chamada pedidos e que contém as colunas cpf, nome, cidade e numero_pedido.
*/

SELECT cpf, nome, cidade, numero_pedido, COUNT(*)
FROM pedidos
GROUP BY cpf, nome, cidade, numero_pedido
HAVING COUNT(*) > 1;

/*
​DESAFIO 4: ​Na tabela 'pedidos' do DESAFIO 3, encontre os top 5 maiores compradores.
*/

SELECT cpf, COUNT(*) AS numero_de_pedidos
FROM pedidos
GROUP BY cpf
ORDER BY numero_de_pedidos DESC
LIMIT 5;

/*
DESAFIO 5: ​Você trabalha em um delivery de comida e precisa obter a receita dos motoqueiros cadastrados na plataforma.
Você possui uma tabela chamada CADASTRO com as informações demográficas dos motoqueiros, uma chamada PRECO com o valor por quilômetro da corrida
de acordo com o bairro e uma chamada VIAGENS com informações das viagens feitas por cada motoqueiro.
Construa uma tabela com os 100 motoqueiros mais bem remunerados da plataforma no mês de Janeiro de 2024.

ENTRADA:

tabela CADASTRO
Colunas Tipo
id INTEIRO
primeiro_nome VARCHAR
ultimo_nome VARCHAR
data_nascimento DATETIME
telefone INTEGER

tabela PRECO
Colunas Tipo
id INTEIRO
nome VARCHAR
preco FLOAT

​tabela ​VIAGEM​
id_motoqueiro INTEIRO
percurso_em_km FLOAT
data DATETIME

SAÍDA :
Colunas Tipo
id_motoqueiro INTEIRO
primeiro_nome VARCHAR
ultimo_nome VARCHAR
receita FLOAT


*/

SELECT	v.id_motoqueiro,
		c.primeiro_nome,
        c.ultimo_nome,
        SUM(v.percurso_em_km * p.preco) AS receita
FROM VIAGEM v
JOIN CADASTRO c
ON v.id_motoqueiro = c.id
JOIN PRECO p
ON p.id = v.id_motoqueiro
WHERE MONTH(v.data) = 1 AND YEAR(v.data) = 2024
GROUP BY v.id_motoqueiro, c.primeiro_nome, c.ultimo_nome
ORDER BY receita DESC
LIMIT 100;

/*
DESAFIO 6: ​Você possui uma tabela chamada attendance com as colunas id, date e present.

id: id do funcionário.
date: data de presença.
present: Esta coluna tem o valor de 1 ou 0, onde 1 representa presente, e 0 representa ausente.

Agora, escreva uma consulta SQL para encontrar o ID do funcionário que veio ao escritório por mais dias consecutivos.
*/

WITH 
	grouped_attendance AS (
    SELECT	id,
			date,
			present,
			SUM(is_new_streak) OVER (PARTITION BY id ORDER BY date) AS streak_group
    FROM attendance_groups
    WHERE present = 1
),
streak_lengths AS (
    SELECT	id,
			streak_group,
			COUNT(*) AS consecutive_days
    FROM grouped_attendance
    GROUP BY id, streak_group
)
SELECT	id
FROM streak_lengths
ORDER BY consecutive_days DESC
LIMIT 1;