SELECT p.nome_produto, SUM(v.quantidade) AS unidades_vendidas
FROM vendas v
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY unidades_vendidas DESC
LIMIT 5;