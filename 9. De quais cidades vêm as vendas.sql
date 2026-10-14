SELECT c.cidade,
       COUNT(*)                    AS numero_de_vendas,
       SUM(v.quantidade * p.preco) AS faturamento
FROM vendas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY c.cidade
ORDER BY faturamento DESC;