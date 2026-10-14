SELECT p.nome_produto,
       SUM(v.quantidade * p.preco) AS receita
FROM vendas v
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY receita DESC;