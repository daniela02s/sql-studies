-- criação da tabela Brazil_Data
CREATE TABLE company.Brazil_Data (
    UF VARCHAR(2),
    Minimum_Wage INT
);

-- salário minímo fictício para cada estado
INSERT INTO company.Brazil_Data (UF, Minimum_Wage) VALUES
('AC', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('AL', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('AP', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('AM', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('BA', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('CE', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('DF', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('ES', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('GO', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('MA', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('MT', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('MS', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('MG', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('PA', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('PB', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('PR', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('PE', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('PI', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('RJ', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('RN', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('RS', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('RO', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('RR', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('SC', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('SP', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('SE', FLOOR(1100 + (RAND() * (1500 - 1100)))),
('TO', FLOOR(1100 + (RAND() * (1500 - 1100))));

SELECT * FROM company.brazil_data;

SELECT * FROM company.rh;

-- média salarial das pessoas do departamento de vendas E que pediram demissão (em dólar)
SELECT AVG(MonthlyIncome) AS avg_income FROM company.rh 
WHERE Department = 'Sales' AND Attrition = 'Yes';

-- verificação de quantos estados brasileiros tem
-- média salarial MAIOR que a média salarial das pessoas que pediram demissão
SELECT COUNT(DISTINCT UF) AS Qtd_UF
FROM company.brazil_data
WHERE Minimum_Wage > 5908.4565/4.8;

-- outra maneira
SELECT 
    COUNT(DISTINCT UF) AS Qtd_UF
FROM
    company.Brazil_Data
WHERE
    Minimum_Wage > (SELECT 
            AVG(MonthlyIncome)/4.8 AS Avg_Income
        FROM
            company.rh
        WHERE
            Department = 'Sales'
                AND Attrition = 'Yes');
                
-- adicionar coluna Id na tabela brazil_data
-- é uma chave primária
ALTER TABLE company.Brazil_Data
ADD COLUMN Id INT AUTO_INCREMENT PRIMARY KEY;

-- adicionar coluna UF_Id na tabela brazil_data
ALTER TABLE company.rh
ADD COLUMN UF_Id INT;

SET SQL_SAFE_UPDATES = 0; -- Por conta do erro 1175

-- gera e altera valores para o número inteiro mais próximo entre 1 e 27
UPDATE company.rh
SET UF_Id = FLOOR(1 + (RAND() * 27));

SELECT * FROM company.rh;

-- filtrar pessoas que moram em estados que a média salarial é menor que 1400
SELECT * FROM company.rh
WHERE UF_Id In
(
SELECT Id FROM company.Brazil_Data 
WHERE Minimum_Wage < 1400
);

-- Nested Subquery
-- -- query interna não depende da query externa
-- selecionar pessoas que o salário é maior do que a média salarial de toda a empresa
SELECT * FROM company.rh
WHERE MonthlyIncome > (SELECT AVG(MonthlyIncome) FROM company.rh);

-- Correlated Subquery
-- query interna depende da query externa
-- pessoas que recebem mais do que a média salarial do próprio departamento
SELECT rh_ext.ï»¿Age, rh_ext.Attrition, rh_ext.BusinessTravel, rh_ext.Department
FROM company.rh AS rh_ext
WHERE rh_ext.MonthlyIncome >
(
SELECT AVG(rh_int.MonthlyIncome) 
FROM company.rh AS rh_int
WHERE rh_int.Department = rh_ext.Department
);

SELECT rh_ext.ï»¿Age, rh_ext.Attrition, rh_ext.BusinessTravel, rh_ext.Department
	,  (
		SELECT AVG(rh_int.MonthlyIncome) 
        FROM company.rh AS rh_int
        WHERE rh_int.Department = rh_ext.Department
    ) AS Inc_per_Department
FROM company.rh AS rh_ext;