-- EXEMPLOS ########################################################################

-- (Exemplo 1) Análise de recorrência dos leads
-- Calcule o volume de visitas por dia ao site separado por 1ª visita e demais visitas

WITH primeira_visita AS (

	SELECT	customer_id,
			MIN(visit_page_date) AS visita_1
	FROM sales.funnel
	GROUP BY customer_id
)

SELECT	visit_page_date,
		(fun.visit_page_date <> primeira_visita.visita_1) AS lead_recorrente,
		COUNT(*)
FROM sales.funnel AS fun
LEFT JOIN primeira_visita
	ON fun.custOmer_id = primeira_visita.customer_id
GROUP BY fun.visit_page_date, lead_recorrente 
ORDER BY fun.visit_page_date DESC, lead_recorrente 

-- (Exemplo 2) Análise do preço versus o preço médio
-- Calcule, para cada visita ao site, quanto o preço do um veículo visitado pelo cliente
-- estava acima ou abaixo do preço médio dos veículos daquela marca 
-- (levar em consideração o desconto dado no veículo)

WITH preco_medio AS (

	SELECT	brand,
			AVG(price) AS preco_medio_da_marca
	FROM sales.products
	GROUP BY brand
)

SELECT	fun.visit_id,
		fun.visit_page_date,
		pro.brand,
		(pro.price * (1+fun.discount)) AS preco_final,
		preco_medio.preco_medio_da_marca,
		((pro.price * (1+fun.discount)) - preco_medio.preco_medio_da_marca) AS preco_vs_media
FROM sales.funnel AS fun
LEFT JOIN sales.products AS pro
	ON fun.product_id = pro.product_id
LEFT JOIN preco_medio
	ON pro.brand = preco_medio.brand
	