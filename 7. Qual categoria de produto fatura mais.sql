SELECT p.categoria,
       SUM(v.quantidade)           AS unidades,
       SUM(v.quantidade * p.preco) AS faturamento
FROM vendas v
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY p.categoria
ORDER BY faturamento DESC;