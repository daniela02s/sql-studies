USE comunidade;

-- SQL SERVER VS MYSQL
 
-- No MYSQL funciona:
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Valor
FROM Compras
GROUP BY 1, 2;


-- No SQL Server não funciona
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Valor
FROM Compras
GROUP BY 1, 2;


-- A ORDEM DO WHERE
-- Group by vem depois do Where, olha isso:

-- Funciona ok:
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
GROUP BY Id, Primeiro_Nome;

-- Não funciona:
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
GROUP BY Id, Primeiro_Nome
WHERE avg_compra > 55;

-- Não funciona:
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
WHERE avg_compra > 55
GROUP BY Id, Primeiro_Nome
;

-- Funciona ok:
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
WHERE Idade > 40
GROUP BY Id, Primeiro_Nome
;

-- Funciona Ok
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
WHERE Valor_Compra * 2 < 50
GROUP BY Id, Primeiro_Nome
;

-- Funciona ok:

SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
WHERE 2*Valor_Compra > 40
GROUP BY 1,2
HAVING AVG_Compra > 40
ORDER BY AVG_Compra ASC
;