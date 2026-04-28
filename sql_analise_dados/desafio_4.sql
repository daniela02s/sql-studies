-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Identifique quais as marcas de veículo mais visitada na tabela sales.funnel

SELECT	pro.brand,
		COUNT(fun.visit_id) AS visitas
FROM sales.products AS pro
LEFT JOIN sales.funnel AS fun
	ON pro.product_id = fun.product_id
GROUP BY pro.brand
ORDER BY visitas DESC 

-- (Exercício 2) Identifique quais as lojas de veículo mais visitadas na tabela sales.funnel

SELECT	stores.store_name,
		COUNT(fun.visit_id) AS visitas
FROM sales.stores AS stores
LEFT JOIN sales.funnel AS fun
	ON stores.store_id = fun.store_id
GROUP BY stores.store_name
ORDER BY visitas DESC

-- (Exercício 3) Identifique quantos clientes moram em cada tamanho de cidade (o porte da cidade
-- consta na coluna "size" da tabela temp_tables.regions)

SELECT	regions.size,
		COUNT(*) AS porte
FROM sales.customers AS cus
LEFT JOIN temp_tables.regions AS regions
	ON LOWER(cus.city) = LOWER(regions.city)
	AND LOWER(cus.state) = LOWER(regions.state)
GROUP BY regions.size
ORDER BY porte DESC
