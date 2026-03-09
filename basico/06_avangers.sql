SELECT * FROM pop_culture.avengers;

-- quantas edições estão neste dataset?
SELECT COUNT(*) AS Count_Heroes FROM pop_culture.avengers;

SELECT COUNT(DISTINCT URL) AS URL_Distinct FROM pop_culture.avengers;

-- média de aparições
SELECT AVG(appearances) AS AVG_Appearances FROM pop_culture.avengers;

-- máximo de aparições
SELECT MAX(appearances) AS MAX_Appearances FROM pop_culture.avengers;

-- quem mais apareceu?
SELECT * FROM pop_culture.avengers 
WHERE appearances = (SELECT MAX(appearances) AS MAX_Appearances FROM pop_culture.avengers);

-- quem menos apareceu?
SELECT * FROM pop_culture.avengers 
WHERE appearances = (SELECT MIN(appearances) AS MAX_Appearances FROM pop_culture.avengers);

-- quantos personagens temos de cada gênero?
SELECT Gender, COUNT(*) AS Amt_Heroes
FROM pop_culture.avengers
GROUP BY Gender;

-- e a média de aparições por genero?
SELECT Gender, AVG(Appearances) AS AVG_Appearances FROM pop_culture.avengers
GROUP BY Gender;

-- quantos personagens morreram:
SELECT COUNT(*) AS Death_Heroes FROM pop_culture.avengers
WHERE Death1 = 'YES';

-- quantos personagens morreram de cada gênero?
SELECT Gender, COUNT(*) FROM pop_culture.avengers
WHERE UPPER(Death1) = 'YES'
GROUP BY Gender;

-- qual percentual de mortes por gênero?
-- primeiro, entenda o CASE WHEN
SELECT *, CASE WHEN Death1 ='Yes' THEN 1 ELSE 0 END AS Death
FROM 
    pop_culture.avengers;

-- somando CASE WHEN
SELECT Gender, 
		AVG(Appearances) AS AVG_Appearances,
		COUNT(*) AS Amt_Heroes,
		SUM(CASE WHEN Death1 = 'YES' THEN 1 ELSE 0 END) AS Death_Heroes,
        Death_Heroes / Amt_Heroes AS Perc_Death
FROM pop_culture.avengers
GROUP BY Gender;

-- gerando diversas estatísticas 
SELECT Gender, 
		AVG(Appearances) AS AVG_Appearances,
        MAX(Appearances) AS MAX_Appearances,
        MIN(Appearances) AS MIN_Appearances,
		COUNT(*) AS Amt_Heroes,
		SUM(CASE WHEN Death1 = 'YES' THEN 1 ELSE 0 END) AS Total_Deaths,
        SUM(CASE WHEN Death1 = 'YES' THEN 1 ELSE 0 END)/COUNT(*) AS Perc_Deaths
FROM pop_culture.avengers
GROUP BY Gender;

SELECT Gender, Year,
		AVG(Appearances) AS AVG_Appearances,
        MAX(Appearances) AS MAX_Appearances,
        MIN(Appearances) AS MIN_Appearances,
		COUNT(*) AS Amt_Heroes,
		SUM(CASE WHEN Death1 = 'YES' THEN 1 ELSE 0 END) AS Total_Deaths,
        SUM(CASE WHEN Death1 = 'YES' THEN 1 ELSE 0 END)/COUNT(*) AS Perc_Deaths
FROM pop_culture.avengers
GROUP BY Gender, Year;

-- filtrando agrupamentos
SELECT Year,
	   AVG(Appearances) AVG_Appearances,
       COUNT(*) AS Amt_Heroes
FROM pop_culture.avengers 
GROUP BY Year
HAVING Amt_Heroes > 2
ORDER BY Amt_Heroes DESC;
