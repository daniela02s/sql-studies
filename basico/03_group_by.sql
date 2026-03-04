-- CREATE DATABASE comunidade;
USE comunidade;

-- criando tabela de vendas
DROP TABLE IF EXISTS vendas;
CREATE TABLE vendas(
	id INT,
    cod_cliente INT,
    produto INT,
    qtd_vendidada INT,
    data_venda DATE
);

INSERT INTO vendas VALUES (1,1,1,2,'2024-01-01'),
						  (2,5,3,2, '2024-01-02'),
                          (3,1,3,1, '2024-01-01'),
                          (4,3,1,1, '2024-01-01'),
                          (5,4,2,1, '2024-01-01'),
                          (6,6,3,2, '2024-01-02'),
                          (7,2,2,3, '2024-01-02'),
                          (8,1,1,4, '2024-01-01'),
                          (9,2,2,1, '2024-01-01'),
                          (10,4,1,5, '2024-01-01');

-- criando tabela de clientes
DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
	id_cliente INT,
    nome VARCHAR(100),
    sobrenome VARCHAR(100),
    sexo CHAR(1),
    data_nascimento VARCHAR(10)
);

INSERT INTO clientes VALUES (1, 'Ricardo', 'Oliveira', 'M', '1982-05-14'),
							(2, 'Beatriz', 'Souza', 'F', '1991-08-22'),
                            (3, 'Thiago', 'Mendes', 'M', '1988-11-03'),
                            (4, 'Carolina', 'Arantes', 'F', '1997-01-15'),
                            (5, 'Caio', 'Castro', 'M', '1993-06-30'),
                            (6, 'Juliana', 'Paes', 'F', '1989-12-12'),
                            (7, 'Felipe', 'Neto', 'M', '2001-04-05'),
                            (8, 'Larissa', 'Manoela', 'F', '2000-10-28'),
                            (9, 'Renato', 'Garcia', 'M', '1995-02-17'),
                            (10, 'Mariana', 'Rios', 'F', '1987-09-09');

-- criando tabela de produtos
DROP TABLE IF EXISTS produtos;
CREATE TABLE produtos(
	cod_produto INT,
    nome_produto VARCHAR(100),
    marca VARCHAR(100),
    categoria VARCHAR(100),
    preco_unitario FLOAT(5)
);
						
INSERT INTO produtos VALUES (1, 'Monitor 27" 144Hz', 'Samsung', 'Tecnologia', 1850.00),
							(2, 'Teclado Mecânico', 'Logitech', 'Tecnologia', 540.90),
							(3, 'Cadeira Ergonômica', 'Flexform', 'Escritório', 1200.00),
							(4, 'Luminária Articulada', 'Pixar', 'Decoração', 89.90),
							(5, 'Máquina de Café', 'Nespresso', 'Eletrodomésticos', 650.00),
							(6, 'Smartphone S23', 'Samsung', 'Tecnologia', 4200.00),
							(7, 'Mesa de Jantar 6 Lugares', 'Tok&Stok', 'Casa', 2800.00),
							(8, 'Fone Noise Cancelling', 'Sony', 'Tecnologia', 1900.00),
							(9, 'Caderno Inteligente', 'Original', 'Papelaria', 120.00),
							(10, 'Ar Condicionado Inverter', 'Gree', 'Eletrodomésticos', 3100.50);

SELECT * FROM produtos;
SELECT * FROM clientes;
SELECT * FROM vendas;

-- verificar repetições
SELECT nome_produto, COUNT(*)
FROM produtos
GROUP BY nome_produto;

SELECT 
	v.id, v.cod_cliente, v.data_venda, v.produto,
    c.nome, c.sobrenome,
    p.nome_produto,
    COUNT(*) AS Repeticoes
FROM vendas v
LEFT JOIN clientes c
	ON v.cod_cliente = c.id_cliente
LEFT JOIN produtos p
	ON v.produto = p.cod_produto
GROUP BY v.id, v.cod_cliente, v.data_venda, v.produto, c.nome, c.sobrenome, p.nome_produto;

-- duplicando apenas um dos produtos
INSERT INTO produtos VALUES (11, 'Monitor 27" 144Hz', 'Samsung', 'Tecnologia', 1850.00);

/*
	UPDATE <tabela>
	SET coluna = valor
	FROM <tabela>
*/

SELECT * FROM produtos;

UPDATE produtos
SET marca = 'LG'
WHERE cod_produto = 11;

-- todas as linhas foram modificadas 
START TRANSACTION;

UPDATE produtos
SET marca = 'LG';

SELECT * FROM produtos;

-- retorna a base de dados anterior 
-- START TRANSACTION + ROLLBACK
ROLLBACK;

SELECT * FROM produtos;

UPDATE produtos
SET marca = 'LG'
WHERE cod_produto = 11;

-- sem START TRANSACTION os dados não são afetados
SELECT * FROM produtos;

ROLLBACK;

-- apagar dados
-- TRUNCATE produtos;

/* 
START TRANSACTION;

UPDATE vendas
SET produto = 1;

ROLLBACK;
*/
 -- deletar linha específica
DELETE FROM produtos
WHERE cod_produto = 11;

SELECT * FROM produtos;






-- identificar e categorizar produtos 
-- retornar apenas os itens duplicados no banco de dados
SELECT a.nome_produto, a.marca, a.categoria, a.Duplicado
	, CASE WHEN a.Duplicado > 1 THEN 'Sim'
		   WHEN a.Duplicado = 1 THEN 'Não'
	  END AS Duplicado
FROM 
(
	SELECT 
		nome_produto, marca, categoria, 
		COUNT(*) AS Duplicado
	FROM produtos
	GROUP BY nome_produto, marca, categoria
) a
WHERE Duplicado > 1
GROUP BY a.Duplicado, a.nome_produto, a.marca, a.categoria;

SELECT 
	 nome_produto
    , marca
    , categoria
    , COUNT(*) AS Duplicado
FROM produtos
GROUP BY nome_produto, marca, categoria
-- HAVING determina regra depois do agrupamento 
HAVING	
	COUNT(*) > 1;

SELECT nome_produto,
	   COUNT(*) AS Registros_Totais
FROM produtos
GROUP BY nome_produto;

SELECT 
	   nome_produto
	,  COUNT(DISTINCT preco_unitario) AS Registros_Totais
FROM produtos
GROUP BY nome_produto;

-- limpeza dos dados

SELECT 
	id_cliente, 
    CONCAT(nome , ' ', sobrenome) AS Nome_Completo, -- única coluna
    CASE 
		WHEN sexo = 'M' THEN 'Masculino'
        WHEN sexo = 'F' THEN 'Feminino'
	END AS sexo,
    EXTRACT(YEAR FROM data_nascimento) AS Ano_Nascimento,
    EXTRACT(MONTH FROM data_nascimento) AS Mes_Nascimento,
    EXTRACT(YEAR from CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento) AS Idade
FROM clientes;


-- 
SELECT
	v.data_venda AS Data_Venda
    
    , SUM(CASE WHEN p.categoria LIKE 'Tecnologia' THEN p.preco_unitario
		  ELSE 0
          END) AS TEC_AMOUNT
          
	, SUM(CASE WHEN p.categoria LIKE 'Escritório' THEN p.preco_unitario
		  ELSE 0
          END) AS PAPER_AMOUNT
          
	, SUM(CASE WHEN p.categoria LIKE 'Eletrodomésticos' THEN p.preco_unitario
		  ELSE 0
          END) AS HOME_AMOUNT
FROM vendas v
LEFT JOIN produtos p
	ON v.produto = p.cod_produto
-- fazer um JOIN que traga as informações dos clientes.
GROUP BY v.data_venda, p.nome_produto, p.preco_unitario
ORDER BY v.data_venda






