-- EXERCÍCIOS ########################################################################

-- (Exemplo 1) Identifique qual é o status profissional mais frequente nos clientes 
-- que compraram automóveis no site

SELECT	cus.professional_status,
		COUNT(fun.paid_date) AS pagamentos
FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
	ON fun.customer_id = cus.customer_id
GROUP BY cus.professional_status
ORDER BY pagamentos DESC

-- (Exemplo 2) Identifique qual é o gênero mais frequente nos clientes que compraram
-- automóveis no site. Obs: Utilizar a tabela temp_tables.ibge_genders

select * from temp_tables.ibge_genders limit 10

SELECT	ibge.gender,
		COUNT(fun.paid_date)
FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
	ON fun.customer_id = cus.customer_id
LEFT JOIN temp_tables.ibge_genders AS ibge
	ON LOWER(cus.first_name) = ibge.first_name
GROUP BY ibge.gender

-- (Exemplo 3) Identifique de quais regiões são os clientes que mais visitam o site
-- Obs: Utilizar a tabela temp_tables.regions
select * from sales.customers limit 10
select * from temp_tables.regions limit 

SELECT	regions.region,
		COUNT(fun.visit_id) AS visitas
FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
	ON fun.customer_id = cus.customer_id
LEFT JOIN temp_tables.regions AS regions
	ON LOWER(cus.state) = LOWER(regions.state)
	AND LOWER(cus.city) = LOWER(regions.city)
GROUP BY regions.region
ORDER BY visitas DESC
