SELECT ROUND(AVG(v.quantidade * p.preco), 2) AS ticket_medio
FROM vendas v
INNER JOIN produtos p ON v.id_produto = p.id_produto;