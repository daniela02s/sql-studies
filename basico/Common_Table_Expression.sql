-- Estrutura do CTE
/*
WITH consulta AS (
...
),
consulta_2 AS (
...
),
...
*/

/*
WITH consulta_1 AS (
	SELECT * FROM company.rh
),
consulta_2 AS (
	SELECT * FROM cunsulta_1
    LEFT JOIN ...
),
...
SELECT * FROM culsulta_n
*/

-- Exemplo introdutório  
-- Primeira consulta se chama get_male e filtra todos os funcionários Male
-- Segunda consulta se chama get_avg_distance e pega a média de DistanceFromHome de TODOS funcionários
-- Terceira consulta se chama join_information e junta as informações (CROSS JOIN)
-- Finalize pegando os funcionários Male com DistanceFromHome menor que a média

WITH get_male AS (
	SELECT * FROM company.rh
    WHERE Gender = 'Male'
),
get_avg_distance AS (
	SELECT AVG(DistanceFromHome) AS AvgDistance
    FROM company.rh
),
join_information AS (
	SELECT gm.*, gad.AvgDistance
    FROM get_male AS gm
    CROSS JOIN get_avg_distance AS gad
)
SELECT * FROM join_information
WHERE DistanceFromHome < AvgDistance;


-- Exemplo um pouco mais trabalhado
-- Primeiro, crie uma consulta get_female_att para filtrar funcionárias mulheres com Attrition = Yes
-- Depois, crie add_UF onde para Education = 1, a UF_Id será 10. Para Education = 2, será 15, para Education = 3, será 20.
-- Para as demais será 22. (CASE WHEN)
-- Na terceira consulta, crie get_minimum_wage onde você seleciona as colunas UF_ID e MinimumWage de company.brazil_data
-- e o  será o menor valor entre Minimum_Wage e 1250 (LEAST)
-- Depois, traga a informação de MinimumWage com o nome UFMinimumWage
-- Por fim, faça uma contagem por cada salário mínimo

WITH get_female AS (
	SELECT * FROM company.rh
    WHERE UPPER(Gender) = 'FEMALE' AND UPPER(Attrition) = 'YES'
),
add_UF AS (
	SELECT *,
		CASE
			WHEN Education = 1 THEN 10
			WHEN Education = 2 THEN 15
			WHEN Education = 3 THEN 20
			ELSE 22
		END AS NEW_UF_Id
	FROM get_female
),
get_minimum_wage AS (
	SELECT Id, LEAST(1250, Minimum_Wage) AS MinimumWage
    FROM company.brazil_data
),
join_information AS (
	SELECT au.*, gmw.MinimumWage
    FROM add_UF AS au
    LEFT JOIN get_minimum_wage AS gmw
    ON au.NEW_UF_Id = gmw.Id
)
SELECT MinimumWage, COUNT(*) AS QtdFuncionarios
FROM join_information
GROUP BY MinimumWage
ORDER BY MinimumWage;
