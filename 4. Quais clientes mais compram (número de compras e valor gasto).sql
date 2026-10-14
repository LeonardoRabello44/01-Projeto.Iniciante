SELECT c.nome,
       COUNT(*)                    AS numero_de_compras,
       SUM(v.quantidade * p.preco) AS total_gasto
FROM vendas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY c.id_cliente, c.nome
ORDER BY total_gasto DESC
LIMIT 5;