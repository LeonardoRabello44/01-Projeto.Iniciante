SELECT MONTH(v.data_venda)         AS mes,
       COUNT(*)                    AS numero_de_vendas,
       SUM(v.quantidade * p.preco) AS faturamento
FROM vendas v
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY MONTH(v.data_venda)
ORDER BY mes;