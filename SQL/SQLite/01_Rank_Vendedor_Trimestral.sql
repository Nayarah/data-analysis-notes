/*Query: Análise de Desempenho por Trimestre e Vendedor
Objetivo: Ranqueamento Particionado de Vendedores por Receita Trimestral.*/
SELECT
-- Aplicando o benchmark e o ranqueamento trimestral no SELECT externo
	t2.trimestre,
	t2.vendedor,
	t2.clientes_unicos,
	t2.total_trimestre,
	-- Benchmark: Média histórica de vendas do vendedor (em todos os trimestres)
	AVG(t2.total_trimestre)OVER(PARTITION BY t2.vendedor)AS benchmark_vendedor,
	-- Ranqueamento Trimestral: Ranqueia o vendedor APENAS dentro do seu trimestre
	DENSE_RANK() OVER (PARTITION BY t2.trimestre ORDER BY t2.total_trimestre DESC)AS rank_vendedor
FROM(
	SELECT 
	-- Nível 1: Agregação da Receita e Clientes por Vendedor e Trimestre
		-- Fórmula para extrair o trimestre (resolvendo limitação do SQLite)
		CAST((CAST(STRFTIME('%m', i.InvoiceDate)AS INTEGER)+2)/3 AS INTEGER) AS trimestre,
		CONCAT(e.FirstName, ' ' ,e.LastName)AS vendedor, 
		COUNT(DISTINCT i.CustomerId )AS clientes_unicos,
		SUM(i.Total)AS total_trimestre	
	FROM Employee e 
	INNER JOIN Customer c ON e.EmployeeId = c.SupportRepId
	INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
	GROUP BY 1,2
) AS t2
ORDER BY t2.trimestre, rank_vendedor 